Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB49ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DD720864
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DD720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbeGUOSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:18:50 -0400
Received: from www.osadl.org ([62.245.132.105]:57440 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbeGUOSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:18:50 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6LDLLgg030144;
        Sat, 21 Jul 2018 15:21:22 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Eric Anholt <eric@anholt.net>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Genki Sky <sky@genki.is>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] staging: bcm2835-camera: fix timeout handling in wait_for_completion_timeout
Date:   Sat, 21 Jul 2018 15:20:28 +0200
Message-Id: <1532179228-30347-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout returns unsigned long not int so a variable of
proper type is introduced. Further the check for <= 0 is ambiguous and should
be == 0 here indicating timeout which is the only error case so no additional
check needed here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
---

Patch found by experimental coccinell API conformance checker

Patch was compile tested with: bcm2835_defconfig + CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_CAMERA_SUPPORT=y, CONFIG_VIDEO_BCM2835=m

Patch is against 4.18-rc5 (localversion-next is next-20180720)

 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index f5b5ead..51e5b04 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -630,6 +630,7 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
 {
 	struct mmal_msg_context *msg_context;
 	int ret;
+	unsigned long timeout;
 
 	/* payload size must not cause message to exceed max size */
 	if (payload_len >
@@ -668,11 +669,11 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
 		return ret;
 	}
 
-	ret = wait_for_completion_timeout(&msg_context->u.sync.cmplt, 3 * HZ);
-	if (ret <= 0) {
-		pr_err("error %d waiting for sync completion\n", ret);
-		if (ret == 0)
-			ret = -ETIME;
+	timeout = wait_for_completion_timeout(&msg_context->u.sync.cmplt,
+					      3 * HZ);
+	if (timeout == 0) {
+		pr_err("timed out waiting for sync completion\n");
+		ret = -ETIME;
 		/* todo: what happens if the message arrives after aborting */
 		release_msg_context(msg_context);
 		return ret;
-- 
2.1.4

