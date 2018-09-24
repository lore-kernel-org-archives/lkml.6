Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753EDC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394EC214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394EC214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbeIXSQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:16:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbeIXSQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:16:49 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A428109C;
        Mon, 24 Sep 2018 12:14:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 050/173] staging: bcm2835-camera: handle wait_for_completion_timeout return properly
Date:   Mon, 24 Sep 2018 13:51:24 +0200
Message-Id: <20180924113119.666419383@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 5b70084f6cbcd53f615433f9d216e01bd71de0bb ]

wait_for_completion_timeout returns unsigned long not int so a variable of
proper type is introduced. Further the check for <= 0 is ambiguous and
should be == 0 here indicating timeout.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -580,6 +580,7 @@ static int start_streaming(struct vb2_qu
 static void stop_streaming(struct vb2_queue *vq)
 {
 	int ret;
+	unsigned long timeout;
 	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vq);
 
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p\n",
@@ -605,10 +606,10 @@ static void stop_streaming(struct vb2_qu
 				      sizeof(dev->capture.frame_count));
 
 	/* wait for last frame to complete */
-	ret = wait_for_completion_timeout(&dev->capture.frame_cmplt, HZ);
-	if (ret <= 0)
+	timeout = wait_for_completion_timeout(&dev->capture.frame_cmplt, HZ);
+	if (timeout == 0)
 		v4l2_err(&dev->v4l2_dev,
-			 "error %d waiting for frame completion\n", ret);
+			 "timed out waiting for frame completion\n");
 
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 		 "disabling connection\n");


