Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7955EC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F7A2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F7A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeJFN4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:56:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:23257 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbeJFN4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:56:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 23:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,347,1534834800"; 
   d="scan'208";a="79200390"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga008.jf.intel.com with ESMTP; 05 Oct 2018 23:52:48 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Matt Turner <matt.turner@intel.com>,
        Len Brown <len.brown@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>
Subject: [PATCH v2 4/4] platform/x86: intel_telemetry: report debugfs failure
Date:   Sat,  6 Oct 2018 12:21:13 +0530
Message-Id: <20181006065113.669-4-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Goldmont based systems such as ASRock J3455M the BIOS may not
enable the IPC1 device that provides access to the PMC and PUNIT. In
such scenarios, the IOSS and PSS resources from the platform device can
not be obtained and result in a invalid telemetry_plt_config which is an
internal data structure that holds platform config and is maintained by
the telemetry platform driver.

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
Changes in v2:
 * Removed print and out label both as suggested by Andy.
 * changed to pr_info.
 * Other minor style fixes.


 drivers/platform/x86/intel_telemetry_debugfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index ffd0474b0531..1423fa8710fd 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -951,12 +951,16 @@ static int __init telemetry_debugfs_init(void)
 	debugfs_conf = (struct telemetry_debugfs_conf *)id->driver_data;
 
 	err = telemetry_pltconfig_valid();
-	if (err < 0)
+	if (err < 0) {
+		pr_info("Invalid pltconfig, ensure IPC1 device is enabled in BIOS\n");
 		return -ENODEV;
+	}
 
 	err = telemetry_debugfs_check_evts();
-	if (err < 0)
+	if (err < 0) {
+		pr_info("telemetry_debugfs_check_evts failed\n");
 		return -EINVAL;
+	}
 
 	register_pm_notifier(&pm_notifier);
 
-- 
2.17.1

