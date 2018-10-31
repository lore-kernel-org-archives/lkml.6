Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F76ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA372054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U00klvfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA372054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeKAIGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbeKAIGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA4C22087A;
        Wed, 31 Oct 2018 23:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027173;
        bh=PHDIRm6hp2QCsYTEK/cuqnxSlQuwnnP/wqY9JYN4K/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U00klvfpCu9vwKH8fLaHtgT3+3i5gRIr0C6vuRUwCjDFYVMotd503CzaTsMHFKVGy
         cTvEGNRj41dn4ei66crAbM28bqi68dWTGza0fb01R8nYdl85MABxFaaed+R1BGIsIS
         QqJF4ifKom9w9i+GMnDkXltBvNZofMRoRxpwZsTU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 034/146] ACPI / PM: LPIT: Register sysfs attributes based on FADT
Date:   Wed, 31 Oct 2018 19:03:49 -0400
Message-Id: <20181031230541.28822-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

[ Upstream commit 1cdda9486f5103fb133f88e662e48c504adbb779 ]

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

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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

