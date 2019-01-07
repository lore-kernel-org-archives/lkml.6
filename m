Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB0AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D6C2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865009;
	bh=i/owExtCXc/77X1oOjaoeB7WrfmUIRej7RTnkbvAvco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aGlwM2oE1Op3ZjEnegxyb+tKSM7I1yOrsqihEw6nd22h1pjmIT1B0ltR4+pjiaNaa
	 pQV9x9ZEpBljxpW5EVWqNcxyJJD613bQM08aObLP7sygijrUNsFR9AJTz6/vDXjJGP
	 3H671UDnEH9od3vW3yT1J0KlMMJaeJCeZH5yBa3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfAGMn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfAGMnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1382147C;
        Mon,  7 Jan 2019 12:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865004;
        bh=i/owExtCXc/77X1oOjaoeB7WrfmUIRej7RTnkbvAvco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdUld/YSHOZbl5D7sQQdIi8kUuYXQRg3+5aQVo8gZC1/CJFnLTdli1VDzfg3OfmD6
         OjKQtOGNS+W1L6VIfMSAbSpqm2Uixtu1GbQgGZol1/yloCElgl7gFDvhDqfeY+z0GB
         MWpmdevcuVBjKPo13VMmQDunHIiB7Rq5BaImnXSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+69780d144754b8071f4b@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 115/145] media: vim2m: use cancel_delayed_work_sync instead of flush_schedule_work
Date:   Mon,  7 Jan 2019 13:32:32 +0100
Message-Id: <20190107104452.239483759@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 52117be68b82ee05c96da0a7beec319906ccf6cc upstream.

The use of flush_schedule_work() made no sense and caused a syzkaller error.
Replace with the correct cancel_delayed_work_sync().

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: syzbot+69780d144754b8071f4b@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>      # for v4.20 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vim2m.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@ -805,10 +805,11 @@ static int vim2m_start_streaming(struct
 static void vim2m_stop_streaming(struct vb2_queue *q)
 {
 	struct vim2m_ctx *ctx = vb2_get_drv_priv(q);
+	struct vim2m_dev *dev = ctx->dev;
 	struct vb2_v4l2_buffer *vbuf;
 	unsigned long flags;
 
-	flush_scheduled_work();
+	cancel_delayed_work_sync(&dev->work_run);
 	for (;;) {
 		if (V4L2_TYPE_IS_OUTPUT(q->type))
 			vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);


