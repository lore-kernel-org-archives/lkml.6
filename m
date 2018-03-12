Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeCLLTI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:19:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:41259 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750794AbeCLLTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:19:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="23759459"
From: Anshuman Gupta <anshuman.gupta@intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, anshuman.gupta@intel.com
Subject: [PATCH] [sound] hdac-codec runtime suspended at PM:Suspend.
Date: Mon, 12 Mar 2018 16:47:47 +0530
Message-Id: <1520853467-31653-1-git-send-email-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep hdac-codec to be in runtime suspended while entering to suspend.
If hdac-codec is already in runtime suspend state skip its power down
sequence in prepare, power up sequence in complete phase.

Avoid resuming hdac controller PCI device 00:1f.3 from runtime suspend
state in case  hdac-codec already in runtime-suspend state, this is
unnecessary and block the direct complete even for hdac controller
PCI device 00:1f.3.

This enabled direct complete path for hdac-codec and PCI device 00:1f.3.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index f3b4f4d..810a8a6 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1852,6 +1852,8 @@ static int hdmi_codec_prepare(struct device *dev)
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdac = &edev->hdac;
 
+	if (pm_runtime_status_suspended(dev))
+		return 1;
 	pm_runtime_get_sync(&edev->hdac.dev);
 
 	/*
@@ -1873,6 +1875,8 @@ static void hdmi_codec_complete(struct device *dev)
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_device *hdac = &edev->hdac;
 
+	if (pm_runtime_status_suspended(dev))
+		return;
 	/* Power up afg */
 	snd_hdac_codec_read(hdac, hdac->afg, 0,	AC_VERB_SET_POWER_STATE,
 							AC_PWRST_D0);
-- 
2.7.4
