Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3634921902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499807;
	bh=//QdVfhA7GhxsLR9evg4d/HfDj2hBp7bxZWxceDHNvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E4TXs440kBEohYldvZHMXMJ3KGKSoMSUp+1B7NCIxCcemXXDyzLWn7g3YAHIrVYy+
	 2QoXyrqaUSTUf71lpxlNvOtDBOU08yUzzyUgpdh4k4oVZJp/4eRI386XmKSshiOxlT
	 Uf4VyksIqhRJ+r8b/7E58ZDih0RJa9Jmxdn7/O0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbfBROEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:04:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389944AbfBROEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:04:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B175B204FD;
        Mon, 18 Feb 2019 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498675;
        bh=//QdVfhA7GhxsLR9evg4d/HfDj2hBp7bxZWxceDHNvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xZ7adezptLryJ4k8OvV8Lwo3/TltgEGI5auJb9d3FJ3tw4DMwfbBGUdKfE/z9fSWK
         SPcTAsepim+qnGwmfmrct4ohuGWaWh+zLZmHzVqRFx+6A4MtOmJVrN8sfGYzLxT/c8
         ZRuWtNLlp1MxGAjGMpuY+9H+/h00S+0mzKddS3AI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 085/143] fuse: call pipe_buf_release() under pipe lock
Date:   Mon, 18 Feb 2019 14:43:33 +0100
Message-Id: <20190218133532.174605970@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 fs/fuse/dev.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2074,10 +2074,13 @@ static ssize_t fuse_dev_splice_write(str
 
 	ret = fuse_dev_do_write(fud, &cs, len);
 
+	pipe_lock(pipe);
 	for (idx = 0; idx < nbuf; idx++) {
 		struct pipe_buffer *buf = &bufs[idx];
 		buf->ops->release(pipe, buf);
 	}
+	pipe_unlock(pipe);
+
 out:
 	kfree(bufs);
 	return ret;


