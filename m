Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71F2C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B695620836
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfAFCqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:46:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:52179 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfAFCqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:46:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2019 18:46:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,445,1539673200"; 
   d="scan'208";a="264736108"
Received: from saranya-h97m-d3h.iind.intel.com ([10.66.245.63])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2019 18:46:50 -0800
From:   saranya.gopal@intel.com
To:     kernel@kolivas.org
Cc:     gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, tiwai@suse.de,
        felipe.balbi@linux.intel.com,
        Saranya Gopal <saranya.gopal@intel.com>
Subject: [PATCH V3] usbcore: Select only first configuration for non-UAC3 compliant devices
Date:   Sun,  6 Jan 2019 08:14:02 +0530
Message-Id: <1546742642-29269-1-git-send-email-saranya.gopal@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
References: <CABqErrHKFshAMBPHJp2vmGFE6k1GL1oDMSMbDRcBJNfUSxt9KQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saranya Gopal <saranya.gopal@intel.com>

In most of the UAC1 and UAC2 audio devices, the first
configuration is most often the best configuration.
However, with recent patch to support UAC3 configuration,
second configuration was unintentionally chosen for
some of the UAC1/2 devices that had more than one
configuration. This was because of the existing check
after the audio config check which selected any config
which had a non-vendor class. This patch fixes this issue.

Fixes: f13912d3f014 ("usbcore: Select UAC3 configuration for audio if present")
Reported-by: Con Kolivas <kernel@kolivas.org>
Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
Tested-by: Con Kolivas <kernel@kolivas.org>
---
Changes from V2: Added Tested-by tag
Changes from V1: Added full commit name and more SHA1 numbers in Fixes tag

 drivers/usb/core/generic.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 356b05c..f713cec 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -143,9 +143,12 @@ int usb_choose_configuration(struct usb_device *udev)
 			continue;
 		}
 
-		if (i > 0 && desc && is_audio(desc) && is_uac3_config(desc)) {
-			best = c;
-			break;
+		if (i > 0 && desc && is_audio(desc)) {
+			if (is_uac3_config(desc)) {
+				best = c;
+				break;
+			}
+			continue;
 		}
 
 		/* From the remaining configs, choose the first one whose
-- 
1.9.1

