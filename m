Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D38C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36212145D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36212145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeKUIIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:08:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:35018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbeKUIIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 13:36:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="281632607"
Received: from pmvancle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.10.84])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2018 13:36:56 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 1/6] ASoC: Intel: Skylake: Add CFL-S support
Date:   Tue, 20 Nov 2018 15:36:39 -0600
Message-Id: <20181120213644.19103-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

It's with CNP, supposed to be equivalent with CNL entry.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 8 ++++++++
 sound/soc/intel/skylake/skl.c          | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 8bfb8b0fa3d5..b0e6fb93eaf8 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -247,6 +247,14 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.init_fw = cnl_sst_init_fw,
 		.cleanup = cnl_sst_dsp_cleanup
 	},
+	{
+		.id = 0xa348,
+		.num_cores = 4,
+		.loader_ops = bxt_get_loader_ops,
+		.init = cnl_sst_dsp_init,
+		.init_fw = cnl_sst_init_fw,
+		.cleanup = cnl_sst_dsp_cleanup
+	},
 };
 
 const struct skl_dsp_ops *skl_get_dsp_ops(int pci_id)
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 3f0ac1312982..df36b8fe6d5e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1121,6 +1121,9 @@ static const struct pci_device_id skl_ids[] = {
 	/* CNL */
 	{ PCI_DEVICE(0x8086, 0x9dc8),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+	/* CFL */
+	{ PCI_DEVICE(0x8086, 0xa348),
+		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.17.1

