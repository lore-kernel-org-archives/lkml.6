Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D743C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09EB20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078516;
	bh=isJkATP3SMeMWgxgsMnqADB2Ji1BP6PSW0gFqdoEeQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0KyunUK0phZomEKv8YsNErV9TKait2isW8nuWLS3eVCvcS4jL+EKNyIazX1YXpwA8
	 CLZgwuBpbyzRDVnkCdlSy94RqlDRnTQGBo85Tk1TN/kx/uBwAnZ53gefNc+qYIuA7T
	 +Sg320V3cd9iaJ0Ge7I62Wxm9FigRBDbB6YZOKhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfAUNse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbfAUNs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667792087F;
        Mon, 21 Jan 2019 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078507;
        bh=isJkATP3SMeMWgxgsMnqADB2Ji1BP6PSW0gFqdoEeQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihjFIwn++dLNFebiD1XTvtok7dRtSq37BIK7uFlmBA8WzXGF5gOWVkb89BSGuUMGD
         4iASeNciU//BNplnbgny+AGftp3ArHDIVH3+I7SuBhi/OpD0WLZouHee8EBbHWIS+w
         ZHzldaIwoBcUP5ecGtMGE0E8XbiQfZFYGNE2iFvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 057/111] media: vim2m: only cancel work if it is for right context
Date:   Mon, 21 Jan 2019 14:42:51 +0100
Message-Id: <20190121122502.138942878@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil@xs4all.nl>

commit 240809ef6630a4ce57c273c2d79ffb657cd361eb upstream.

cancel_delayed_work_sync() was called for any queue, but it should only
be called for the queue that is associated with the currently running job.

Otherwise, if two filehandles are streaming at the same time, then closing the
first will cancel the work which might still be running for a job from the
second filehandle. As a result the second filehandle will never be able to
finish the job and an attempt to stop streaming on that second filehandle will
stall.

Fixes: 52117be68b82 ("media: vim2m: use cancel_delayed_work_sync instead of flush_schedule_work")

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: <stable@vger.kernel.org>      # for v4.20 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vim2m.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@ -809,7 +809,9 @@ static void vim2m_stop_streaming(struct
 	struct vb2_v4l2_buffer *vbuf;
 	unsigned long flags;
 
-	cancel_delayed_work_sync(&dev->work_run);
+	if (v4l2_m2m_get_curr_priv(dev->m2m_dev) == ctx)
+		cancel_delayed_work_sync(&dev->work_run);
+
 	for (;;) {
 		if (V4L2_TYPE_IS_OUTPUT(q->type))
 			vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);


