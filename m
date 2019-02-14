Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9221B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mhZWfRU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395159AbfBNUpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:45:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38518 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBNUpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:45:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so3676541pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNS9jOHE65j1orTMurXb7fxroV+5e1Igqg3keBWoKCg=;
        b=mhZWfRU/vk2OJTUkVgBAUfMV8Mp+E2WKcowbYk2x9/Nd4Z9fkX5jtcOZGOct/fEUe6
         uykPkifEL20VSr7UTIFXdwJt6PYarwXH7uwgTxQD10e3gvVYYVScNNkv7QISsYGSmk0C
         SBMcdRp0f8W3kcEsSyQH5DdNUWkADM7Ya+hms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNS9jOHE65j1orTMurXb7fxroV+5e1Igqg3keBWoKCg=;
        b=GpVL+ZcorIx/r7oHisqzx364CiKCOw/psUAZ0oqdNScqIdmaZPjqbvRpAuumkSHxWL
         0dZArelMWu6oMtA7nXdIZdIUYmmbQf5tgDfo35thLwd3p1fwfbylcwOugpHJSW1OBkyo
         jg7g4+awN/9svPeXsn5gChvh7xu2YUVngrsNFVIXtJUhEoYd0k07Pl+b8j7JQ/3PndjO
         ureYjpc2rAFS2Ghqk0pEccS/9n2eBpmceBep+8dUyDCim0xle65N8rIHVQ6FSU1TVumR
         FNzRyo6hncYQcbpq4gYzZVMa1ozNPdQJUsQeHErTXEhZ5e02THMka5o8oL6lqwsnmQHx
         8eRA==
X-Gm-Message-State: AHQUAubq52KbJiQ9c0wVBrCjczYO8HpoVbj4lk/3gTStmg66/V7KArnT
        fEyS4NHZJk/h6E3hGrm4O4bvsw==
X-Google-Smtp-Source: AHgI3IYik4Oyp0I6WkFmgypJKgUBGMBGdGWsO/aOvikZNTnFQu/lVVcfaGwNFTN+4K3uXSnn53TvHg==
X-Received: by 2002:a63:2ccb:: with SMTP id s194mr1761303pgs.214.1550177105959;
        Thu, 14 Feb 2019 12:45:05 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j5sm4074783pfe.84.2019.02.14.12.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 12:45:05 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        evgreen@chromium.org, tfiga@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
Date:   Thu, 14 Feb 2019 12:44:33 -0800
Message-Id: <20190214204433.155715-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the only way to disable the iommu bypass for the ARM SMMU is
with the kernel command line parameter 'arm-smmu.disable_bypass'.

In general kernel command line parameters make sense for things that
someone would like to tweak without rebuilding the kernel or for very
basic communication between the bootloader and the kernel, but are
awkward for other things.  Specifically:
* Human parsing of the kernel command line can be difficult since it's
  just a big runon space separated line of text.
* If every bit of the system was configured via the kernel command
  line the kernel command line would get very large and even more
  unwieldly.
* Typically there are not easy ways in build systems to adjust the
  kernel command line for config-like options.

Let's introduce a new config option that allows us to disable the
iommu bypass without affecting the existing default nor the existing
ability to adjust the configuration via kernel command line.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/iommu/Kconfig    | 22 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 46fcd75d4364..c614beab08f8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -359,6 +359,28 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
 
+config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
+	bool "Default to disabling bypass on ARM SMMU v1 and v2"
+	depends on ARM_SMMU
+	default n
+	help
+	  Say Y here to (by default) disable bypass streams such that
+	  incoming transactions from devices that are not attached to
+	  an iommu domain will report an abort back to the device and
+	  will not be allowed to pass through the SMMU.
+
+	  Historically the ARM SMMU v1 and v2 driver has defaulted
+	  to allow bypass by default but it could be disabled with
+	  the parameter 'arm-smmu.disable_bypass'.  The parameter is
+	  still present and can be used to override this config
+	  option, but this config option allows you to disable bypass
+	  without bloating the kernel command line.
+
+	  Disabling bypass is more secure but presumably will break
+	  old systems.
+
+	  Say N if unsure.
+
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..930c07635956 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -110,7 +110,8 @@ static int force_stage;
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
-static bool disable_bypass;
+static bool disable_bypass =
+	IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT);
 module_param(disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
-- 
2.21.0.rc0.258.g878e2cd30e-goog

