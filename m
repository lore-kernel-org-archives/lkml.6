Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71240C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AAF2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AAF2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbeHWLrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:47:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeHWLrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:47:05 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5C093C7B;
        Thu, 23 Aug 2018 08:18:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 019/217] ACPI / EC: Use ec_no_wakeup on Thinkpad X1 Carbon 6th
Date:   Thu, 23 Aug 2018 09:52:12 +0200
Message-Id: <20180823075506.414091305@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 8195a655e5ce09550aff81b2573d9b015d520cb9 ]

On this system EC interrupt triggers constantly kicking devices out of
low power states and thus blocking power management. The system also has
a PCIe root port hosting Alpine Ridge Thunderbolt controller and it
never gets a chance to go to D3cold because of this.

Since the power button works the same regardless if EC interrupt is
enabled or not during s2idle, add a quirk for this machine that sets
ec_no_wakeup=true preventing spurious wakeups.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/ec.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2029,6 +2029,17 @@ static inline void acpi_ec_query_exit(vo
 	}
 }
 
+static const struct dmi_system_id acpi_ec_no_wakeup[] = {
+	{
+		.ident = "Thinkpad X1 Carbon 6th",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20KGS3JF01"),
+		},
+	},
+	{ },
+};
+
 int __init acpi_ec_init(void)
 {
 	int result;
@@ -2039,6 +2050,15 @@ int __init acpi_ec_init(void)
 	if (result)
 		return result;
 
+	/*
+	 * Disable EC wakeup on following systems to prevent periodic
+	 * wakeup from EC GPE.
+	 */
+	if (dmi_check_system(acpi_ec_no_wakeup)) {
+		ec_no_wakeup = true;
+		pr_debug("Disabling EC wakeup on suspend-to-idle\n");
+	}
+
 	/* Drivers must be started after acpi_ec_query_init() */
 	dsdt_fail = acpi_bus_register_driver(&acpi_ec_driver);
 	/*


