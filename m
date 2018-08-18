Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF985C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEC821746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEC821746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeHRVYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:24:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:31121 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeHRVYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:24:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2018 11:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,257,1531810800"; 
   d="scan'208";a="81415605"
Received: from anshuma1-pnp-server.iind.intel.com ([10.223.107.119])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2018 11:14:11 -0700
From:   Anshuman Gupta <anshuman.gupta@intel.com>
To:     puneethx.prabhu@intel.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, rafael@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, anshuman.gupta@intel.com
Subject: [PATCH v2 1/1] hdac-codec runtime suspended at PM:Suspend.
Date:   Sat, 18 Aug 2018 23:42:03 +0530
Message-Id: <1534615923-8541-2-git-send-email-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534615923-8541-1-git-send-email-anshuman.gupta@intel.com>
References: <CAJZ5v0hyk=jto8Wt0er==YmKEsgvfvZhO2wDbGOhxZaWWCNgBg@mail.gmail.com>
 <1534615923-8541-1-git-send-email-anshuman.gupta@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep hdac hdmi codec to be in runtime suspended while entering to
system wide suspend. Currently hdac hdmi codec driver using its
suspend and resume operation in prepare and complete PM callbacks,
and it resumes the hd audio controller (parent of self) from runtime
suspend and blocks the direct complete for hd audio controller.

If hdac-codec is already in runtime suspend state skip its power down
sequence in prepare, power up sequence in complete phase. It enables
direct complete path for hdac-codec and hd audio controller
PCI device.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
Changes in v2
- Changed the commit message.
- Using pm_runtime_suspended instead of pm_runtime_status_suspended
  in order to handle any race condition. 
 
sound/soc/codecs/hdac_hdmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 84f7a7a..e965338 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1859,6 +1859,9 @@ static int hdmi_codec_prepare(struct device *dev)
 	struct hdac_ext_device *edev = to_hda_ext_device(dev);
 	struct hdac_device *hdev = &edev->hdev;
 
+	if (pm_runtime_suspended(dev))
+		return 1;
+
 	pm_runtime_get_sync(&edev->hdev.dev);
 
 	/*
@@ -1880,6 +1883,9 @@ static void hdmi_codec_complete(struct device *dev)
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
 	struct hdac_device *hdev = &edev->hdev;
 
+	if (pm_runtime_suspended(dev))
+		return;
+
 	/* Power up afg */
 	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
 							AC_PWRST_D0);
-- 
2.7.4

