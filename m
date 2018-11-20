Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F05C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C6D2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C6D2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeKUIJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:09:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:35018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeKUIIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 13:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="281632612"
Received: from pmvancle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.10.84])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2018 13:36:58 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 3/6] ASoC: Intel: Skylake: remove useless tests on DSP presence
Date:   Tue, 20 Nov 2018 15:36:41 -0600
Message-Id: <20181120213644.19103-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus->ppcap is now tested upfront, there is no need to re-check if the
DSP is present. Remove tests and remove indentation.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl.c | 40 ++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 1d7146773d19..0bdb1f7fdd4a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -826,12 +826,10 @@ static void skl_probe_work(struct work_struct *work)
 		return;
 	}
 
-	if (bus->ppcap) {
-		err = skl_machine_device_register(skl);
-		if (err < 0) {
-			dev_err(bus->dev, "machine register failed: %d\n", err);
-			goto out_err;
-		}
+	err = skl_machine_device_register(skl);
+	if (err < 0) {
+		dev_err(bus->dev, "machine register failed: %d\n", err);
+		goto out_err;
 	}
 
 	/*
@@ -1019,25 +1017,23 @@ static int skl_probe(struct pci_dev *pci,
 
 	pci_set_drvdata(skl->pci, bus);
 
-	/* check if dsp is there */
-	if (bus->ppcap) {
-		/* create device for dsp clk */
-		err = skl_clock_device_register(skl);
-		if (err < 0)
-			goto out_clk_free;
+	/* create device for dsp clk */
+	err = skl_clock_device_register(skl);
+	if (err < 0)
+		goto out_clk_free;
 
-		err = skl_find_machine(skl, (void *)pci_id->driver_data);
-		if (err < 0)
-			goto out_nhlt_free;
+	err = skl_find_machine(skl, (void *)pci_id->driver_data);
+	if (err < 0)
+		goto out_nhlt_free;
 
-		err = skl_init_dsp(skl);
-		if (err < 0) {
-			dev_dbg(bus->dev, "error failed to register dsp\n");
-			goto out_nhlt_free;
-		}
-		skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
-		skl->skl_sst->clock_power_gating = skl_clock_power_gating;
+	err = skl_init_dsp(skl);
+	if (err < 0) {
+		dev_dbg(bus->dev, "error failed to register dsp\n");
+		goto out_nhlt_free;
 	}
+	skl->skl_sst->enable_miscbdcge = skl_enable_miscbdcge;
+	skl->skl_sst->clock_power_gating = skl_clock_power_gating;
+
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(bus);
 
-- 
2.17.1

