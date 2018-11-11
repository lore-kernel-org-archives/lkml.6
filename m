Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E847EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEB42084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHNypKnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEB42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbeKLKER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:04:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730449AbeKLIRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:15 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F612216FD;
        Sun, 11 Nov 2018 22:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975239;
        bh=MKNlVbY8SbYzelYhnr+S7P9TwXFdWZNdRq/vH1W5Ass=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHNypKnE3Np1t0KY989cwQcyEi4QIJ7xp8LtmoiENVHwUSSZdsBzhjfOE+uc3nLpM
         dGmap+RebJ5jEZx5zlIXEaqUBLe1b7rb7BzTE0XkbOiqkQZUVNzxtd+SCwVv/1DZau
         mV4Qak98J6V6xin8TNWG2b7vYLEuEvgLOcbQas/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 080/361] ACPI / PM: LPIT: Register sysfs attributes based on FADT
Date:   Sun, 11 Nov 2018 14:17:07 -0800
Message-Id: <20181111221631.153788673@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_lpit.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -117,11 +117,17 @@ static void lpit_update_residency(struct
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


