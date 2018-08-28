Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B343EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775262086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775262086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeH1S5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:57:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40020 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1S5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:57:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27F68ED1;
        Tue, 28 Aug 2018 08:05:37 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C09E13F557;
        Tue, 28 Aug 2018 08:05:36 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     bhelgaas@google.com
Cc:     Punit Agrawal <punit.agrawal@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        will.deacon@arm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 1/2] arm64: PCI: Remove node-local allocations when initialising host controller
Date:   Tue, 28 Aug 2018 16:05:12 +0100
Message-Id: <20180828150513.32458-2-punit.agrawal@arm.com>
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
behaviour since support for ACPI was added in
commit 0cb0786bac15 ("ARM64: PCI: Support ACPI-based PCI host controller").

Drop the node local allocation as there is no benefit from doing so -
the usage of these structures is independent from where the controller
is located.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 0e2ea1c78542..bb85e2f4603f 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -165,16 +165,15 @@ static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
 /* Interface called from ACPI code to setup PCI host controller */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 {
-	int node = acpi_get_node(root->device->handle);
 	struct acpi_pci_generic_root_info *ri;
 	struct pci_bus *bus, *child;
 	struct acpi_pci_root_ops *root_ops;
 
-	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
+	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
 	if (!ri)
 		return NULL;
 
-	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
+	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
 	if (!root_ops) {
 		kfree(ri);
 		return NULL;
-- 
2.18.0

