Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C4C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C065B2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079007;
	bh=NE2DN20tuV4Spv9SNNBhi3nKpFMqyUqDqtT1I3OK74s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LQvLSIbXSAkWADL5prOiCQGOL45oFXfW5YG1Vu39KOL3ayDoSzyMtfTAFEMYCHHG8
	 QwhJm/CB+2omeJlQupidvZjbSO7bDH2mOqNJV8c7vMnZA5/HUtA4lc/KF6Xg89QqI2
	 8gq/tN2oh+WQyUT7LhQrScKk5ByHsS5O5KTQrMto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbfAUN4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbfAUN4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:56:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0022087F;
        Mon, 21 Jan 2019 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079003;
        bh=NE2DN20tuV4Spv9SNNBhi3nKpFMqyUqDqtT1I3OK74s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkrI990+m8r1f93SKhfLe2ffJb7yOCHw5m560s+4Ju/RZqKTId5W7Fyaj7QSsXhHi
         n0LmLbZzoaF2ALlsbW8B7hUV7UUSw9SuCoTPOEYs9T4BNm2t9KeUYfz5yUY6+IjQ7o
         fcFPGCRmJ7lbbChadVBzC47yysdHL9hqyuL6BViU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+53d5b2df0d9744411e2e@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.9 32/51] media: vivid: fix error handling of kthread_run
Date:   Mon, 21 Jan 2019 14:44:28 +0100
Message-Id: <20190121122456.707494327@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 701f49bc028edb19ffccd101997dd84f0d71e279 upstream.

kthread_run returns an error pointer, but elsewhere in the code
dev->kthread_vid_cap/out is checked against NULL.

If kthread_run returns an error, then set the pointer to NULL.

I chose this method over changing all kthread_vid_cap/out tests
elsewhere since this is more robust.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: syzbot+53d5b2df0d9744411e2e@syzkaller.appspotmail.com
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-kthread-cap.c |    5 ++++-
 drivers/media/platform/vivid/vivid-kthread-out.c |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/vivid/vivid-kthread-cap.c
+++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
@@ -877,8 +877,11 @@ int vivid_start_generating_vid_cap(struc
 			"%s-vid-cap", dev->v4l2_dev.name);
 
 	if (IS_ERR(dev->kthread_vid_cap)) {
+		int err = PTR_ERR(dev->kthread_vid_cap);
+
+		dev->kthread_vid_cap = NULL;
 		v4l2_err(&dev->v4l2_dev, "kernel_thread() failed\n");
-		return PTR_ERR(dev->kthread_vid_cap);
+		return err;
 	}
 	*pstreaming = true;
 	vivid_grab_controls(dev, true);
--- a/drivers/media/platform/vivid/vivid-kthread-out.c
+++ b/drivers/media/platform/vivid/vivid-kthread-out.c
@@ -248,8 +248,11 @@ int vivid_start_generating_vid_out(struc
 			"%s-vid-out", dev->v4l2_dev.name);
 
 	if (IS_ERR(dev->kthread_vid_out)) {
+		int err = PTR_ERR(dev->kthread_vid_out);
+
+		dev->kthread_vid_out = NULL;
 		v4l2_err(&dev->v4l2_dev, "kernel_thread() failed\n");
-		return PTR_ERR(dev->kthread_vid_out);
+		return err;
 	}
 	*pstreaming = true;
 	vivid_grab_controls(dev, true);


