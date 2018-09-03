Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54B2C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FAE20873
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FAE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeICW0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:26:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:31017 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbeICW0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:26:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 11:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,326,1531810800"; 
   d="scan'208";a="88629547"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2018 11:05:02 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@intel.com,
        souvik.k.chakravarty@intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Matt Turner <matt.turner@intel.com>,
        Len Brown <len.brown@intel.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>
Subject: [PATCH 4/4] platform/x86: intel_telemetry: report debugfs failure
Date:   Mon,  3 Sep 2018 23:34:15 +0530
Message-Id: <20180903180415.31575-4-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Goldmont based systems such as ASRock J3455M the BIOS may not
enable the IPC1 device that provides access to the PMC and PUNIT. In
such scenarios, the ioss and pss resources from the platform device can
not be obtained and result in a invalid telemetry_plt_config.
This is also applicable to the platforms where the BIOS supports IPC1
device under debug configurations but IPC1 is disabled by user or the
policy.

This change allows user to know the reason for not seeing entries under
/sys/kernel/debug/telemetry/* when there is no apparent failure at boot.

Cc: Matt Turner <matt.turner@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198779

Acked-by: Matt Turner <matt.turner@intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_telemetry_debugfs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index ffd0474b0531..77212e9b22d6 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -951,12 +951,16 @@ static int __init telemetry_debugfs_init(void)
 	debugfs_conf = (struct telemetry_debugfs_conf *)id->driver_data;
 
 	err = telemetry_pltconfig_valid();
-	if (err < 0)
-		return -ENODEV;
+	if (err < 0) {
+		pr_debug("Invalid pltconfig, ensure IPC1 device is enabled in BIOS\n");
+		goto exit;
+	}
 
 	err = telemetry_debugfs_check_evts();
-	if (err < 0)
-		return -EINVAL;
+	if (err < 0) {
+		pr_debug("telemetry_debugfs_check_evts failed\n");
+		goto exit;
+	}
 
 	register_pm_notifier(&pm_notifier);
 
@@ -1020,6 +1024,8 @@ static int __init telemetry_debugfs_init(void)
 	debugfs_conf->telemetry_dbg_dir = NULL;
 out_pm:
 	unregister_pm_notifier(&pm_notifier);
+exit:
+	pr_debug(pr_fmt(DRIVER_NAME) " Failed\n");
 
 	return err;
 }
-- 
2.17.1

