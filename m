Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410FF2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410FF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeH1S5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:57:48 -0400
Received: from foss.arm.com ([217.140.101.70]:40038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1S5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:57:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C19018A;
        Tue, 28 Aug 2018 08:05:42 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E43233F557;
        Tue, 28 Aug 2018 08:05:41 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     bhelgaas@google.com
Cc:     Punit Agrawal <punit.agrawal@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        will.deacon@arm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/PCI: Remove node-local allocation when initialising host controller
Date:   Tue, 28 Aug 2018 16:05:13 +0100
Message-Id: <20180828150513.32458-3-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828150513.32458-1-punit.agrawal@arm.com>
References: <20180828150513.32458-1-punit.agrawal@arm.com>
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory for host controller data structures is allocated local to the
node to which the controller is associated with. This has been the
behaviour since 965cd0e4a5e5 ("x86, PCI, ACPI: Use kmalloc_node() to
optimize for performance") where the node local allocation was added
without additional context.

Drop the node local allocation as there is no benefit from doing so -
the usage of these structures is independent from where the controller
is located.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/pci/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 5559dcaddd5e..948656069cdd 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -356,7 +356,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	} else {
 		struct pci_root_info *info;
 
-		info = kzalloc_node(sizeof(*info), GFP_KERNEL, node);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
 			dev_err(&root->device->dev,
 				"pci_bus %04x:%02x: ignored (out of memory)\n",
-- 
2.18.0

