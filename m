Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD2220700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895783;
	bh=rVtTk+QgayrDc/Y4Ab27N6xeerm92OxOwW39Rf67HSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ubh77uy/uXt9W/IpfEVgc9sH10qDrbIn5ZRXYHz9wDa9dflokFATBLIAlfL9F3+Kg
	 IKb0kCOd3rcOSzSTxnVVFn/YPk1LXamRWGFUfVtn5Gjxn2z102wSTDwfdhJLjDnSZj
	 oKL0dHRQnfQBtPyliDHrqodTrOnQXX5TfQaOBIO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfBKOgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:36:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730857AbfBKOgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:36:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 464C220818;
        Mon, 11 Feb 2019 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895778;
        bh=rVtTk+QgayrDc/Y4Ab27N6xeerm92OxOwW39Rf67HSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wij3z/S2Ef4zED+m6dKxyFhoK8ZIX0t6AUidajXj9g8YtE9jNrgHt0pO/tByB+tWp
         v2j/kkHtX/2pTmBVIGXnWigRJIAXUaDzkV1UoIXHyiTusdaFMsp75Uf4riY2y6s+NS
         zLMtNkk/62zZV3334Bp85sAj3mPnMXsub9JNcvYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.20 320/352] fuse: call pipe_buf_release() under pipe lock
Date:   Mon, 11 Feb 2019 15:19:07 +0100
Message-Id: <20190211141907.183129349@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2077,8 +2077,10 @@ static ssize_t fuse_dev_splice_write(str
 
 	ret = fuse_dev_do_write(fud, &cs, len);
 
+	pipe_lock(pipe);
 	for (idx = 0; idx < nbuf; idx++)
 		pipe_buf_release(pipe, &bufs[idx]);
+	pipe_unlock(pipe);
 
 out:
 	kvfree(bufs);


