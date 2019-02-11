Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91371C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572BD222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899315;
	bh=/wwMOPi9SmtowaX9WKfDRUT6BwEPBJdJnB0CJIEIR5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vM+hIuJK9EqeipB/FVZKjHcmYRlojNWRbLZq/bPYmT5ZjyCY2hA74t0B9E9bQzhW+
	 P62s9fjr1WRG3y2dPawo4YIwrQ4ws6YEa5SS+uZkfORQV99PP9McuaqLT1WX8R8Oyn
	 OczIIVbyUSijFEZrJRtd1MYWTcHlsni1rvlEZvrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbfBKOwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:52:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388481AbfBKOwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:52:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DEE2081B;
        Mon, 11 Feb 2019 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896758;
        bh=/wwMOPi9SmtowaX9WKfDRUT6BwEPBJdJnB0CJIEIR5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xvrHPY9GetKJuoAeY8rRcm0+W8+qaixfI3XrF4T9xbgIAN9vo0deIO8ytEAjphoq2
         N8nWDcm5+lMH2k3Hoqs4/2AnCwfnmjfCR8CqjxT7OeYNcnrSYR5gpLNuM+INJR4V2+
         Q0R1N2zDMnxysVmABvIczLXEg2ZhberTQyr7B3l8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.19 284/313] fuse: call pipe_buf_release() under pipe lock
Date:   Mon, 11 Feb 2019 15:19:24 +0100
Message-Id: <20190211141912.176375425@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 9509941e9c534920ccc4771ae70bd6cbbe79df1c upstream.

Some of the pipe_buf_release() handlers seem to assume that the pipe is
locked - in particular, anon_pipe_buf_release() accesses pipe->tmp_page
without taking any extra locks. From a glance through the callers of
pipe_buf_release(), it looks like FUSE is the only one that calls
pipe_buf_release() without having the pipe locked.

This bug should only lead to a memory leak, nothing terrible.

Fixes: dd3bb14f44a6 ("fuse: support splice() writing to fuse device")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2032,8 +2032,10 @@ static ssize_t fuse_dev_splice_write(str
 
 	ret = fuse_dev_do_write(fud, &cs, len);
 
+	pipe_lock(pipe);
 	for (idx = 0; idx < nbuf; idx++)
 		pipe_buf_release(pipe, &bufs[idx]);
+	pipe_unlock(pipe);
 
 out:
 	kvfree(bufs);


