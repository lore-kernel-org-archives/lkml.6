Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703CBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35157213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35157213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeHPXps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:45:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:28061 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeHPXpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:45:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 13:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,248,1531810800"; 
   d="scan'208";a="66771492"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2018 13:45:10 -0700
Date:   Thu, 16 Aug 2018 13:45:07 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Jayachandran C <jchandra@broadcom.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: how to fix acpi_pci_root_remap_iospace?
Message-ID: <20180816204506.GA21144@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

Back in commit:

  0a70abb38062 ("PCI/ACPI: Support I/O resources when parsing host bridge resources")

we added acpi_pci_root_remap_iospace().  On ia64 this was a no-op because ia64
didn't define PCI_IOBASE, so the entire body of the function was skipped.

But in the current merge window commit:

  0bbf47eab469 ("ia64: use asm-generic/io.h")

ended up defining PCI_IOBASE for us, and now we die horribly
in early boot with:

  kernel BUG at lib/ioremap.c:72!


Is PCI_IOBASE the right thing to check for to decide whether
acpi_pci_root_remap_iospace() needs to do anything?

The ugly fix would be:


diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7433035ded95..de06377de13b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -741,7 +741,7 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
 			struct resource_entry *entry)
 {
-#ifdef PCI_IOBASE
+#if defined(PCI_IOBASE) && !defined(CONFIG_IA64)
 	struct resource *res = entry->res;
 	resource_size_t cpu_addr = res->start;
 	resource_size_t pci_addr = cpu_addr - entry->offset;

or we can do some other juggling with defines to get the
same outcome.

-Tony
