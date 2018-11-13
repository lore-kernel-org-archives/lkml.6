Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC01C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D86223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vmkn45Jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D86223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732955AbeKMPtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732910AbeKMPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:49:04 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FF062251E;
        Tue, 13 Nov 2018 05:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088356;
        bh=l4mGo940ZT0rdnHY5ik6cipUoNEw2RSPwQ/kBwquwRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vmkn45Jg5EFOmtLt9A9NWwux4x/+0G3dCjWMU5XJa8tjK+jQlRa6Gi9UsL61kndzm
         XSIysBrgYJDmJeyx5EVGwwNrjnVZBLiAu/8Qo9qajQH+ZM/1DMPkiVoRCt5paF0vVT
         FqC5mFUfjGhRG6hmlN939rcCR3bX2tWZscTDzwYU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Matt Turner <matt.turner@intel.com>,
        Len Brown <len.brown@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/17] platform/x86: intel_telemetry: report debugfs failure
Date:   Tue, 13 Nov 2018 00:52:15 -0500
Message-Id: <20181113055223.79060-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055223.79060-1-sashal@kernel.org>
References: <20181113055223.79060-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

[ Upstream commit 8d98b1ef368feeb7720b8b9b6f3bd93f2ad892bc ]

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
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_telemetry_debugfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index ef29f18b1951..4069433a0ec6 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -953,12 +953,16 @@ static int __init telemetry_debugfs_init(void)
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
 
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.17.1

