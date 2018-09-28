Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED5BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AF52173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AF52173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbeI1PS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:18:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:10517 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbeI1PS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:18:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 01:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,314,1534834800"; 
   d="scan'208";a="94246005"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2018 01:55:39 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, rajneesh.bhardwaj@intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI / LPIT: Register attributes based on FADT
Date:   Fri, 28 Sep 2018 14:24:02 +0530
Message-Id: <20180928085402.9108-1-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI Low Power S0 Idle capabilities are announced via FADT table and can
be used to inform the kernel about the presence of one or more Low Power
Idle (LPI) entries as descried in LPIT table. LPIT table can exist
independently even if the FADT S0 Idle flag is not set and thus it could
confuse user since the following cpuidle attributes are created.

/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us

Presence or absence of above attributes could mean that the given
platform supports S0ix state or not.

This change allows to create the above cpuidle attributes only if
FADT table supports Low Power S0 Idle.

Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/acpi/acpi_lpit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index cf4fc0161164..e43cb71b6972 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -117,11 +117,17 @@ static void lpit_update_residency(struct lpit_residency_info *info,
 		if (!info->iomem_addr)
 			return;
 
+		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+			return;
+
 		/* Silently fail, if cpuidle attribute group is not present */
 		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
 					&dev_attr_low_power_idle_system_residency_us.attr,
 					"cpuidle");
 	} else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
+		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+			return;
+
 		/* Silently fail, if cpuidle attribute group is not present */
 		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
 					&dev_attr_low_power_idle_cpu_residency_us.attr,
-- 
2.17.1

