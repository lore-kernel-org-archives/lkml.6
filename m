Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA41C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9294C20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9294C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbeGZATg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:19:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:9640 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731437AbeGZATg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:19:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 16:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,402,1526367600"; 
   d="scan'208";a="59829809"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.117.43])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2018 16:05:42 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI: Equalize hotplug memory for non/occupied slots
Date:   Wed, 25 Jul 2018 17:02:59 -0600
Message-Id: <1532559779-3542-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a hotplug bridge will be given hpmemsize additional memory if
available, in order to satisfy any future hotplug allocation
requirements.

These calculations don't consider the current memory size of the hotplug
bridge/slot, so hotplug bridges/slots which have downstream devices will
get their current allocation in addition to the hpmemsize value.

This makes for possibly undesirable results with a mix of unoccupied and
occupied slots (ex, with hpmemsize=2M):

02:03.0 PCI bridge: <-- Occupied
	Memory behind bridge: d6200000-d64fffff [size=3M]
02:04.0 PCI bridge: <-- Unoccupied
	Memory behind bridge: d6500000-d66fffff [size=2M]

This change considers the current allocation size when using the
hpmemsize parameter to make the reservations predictable for the mix of
unoccupied and occupied slots:

02:03.0 PCI bridge: <-- Occupied
	Memory behind bridge: d6200000-d63fffff [size=2M]
02:04.0 PCI bridge: <-- Unoccupied
	Memory behind bridge: d6400000-d65fffff [size=2M]

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
Original RFC here:
https://patchwork.ozlabs.org/patch/945374/

I split this bit out from the RFC while awaiting the pci string handling
enhancements to handle per-device settings

Changed from RFC is a simpler algo

 drivers/pci/setup-bus.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1824..5ae39e6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -831,7 +831,8 @@ static resource_size_t calculate_iosize(resource_size_t size,
 
 static resource_size_t calculate_memsize(resource_size_t size,
 		resource_size_t min_size,
-		resource_size_t size1,
+		resource_size_t add_size,
+		resource_size_t children_add_size,
 		resource_size_t old_size,
 		resource_size_t align)
 {
@@ -841,7 +842,7 @@ static resource_size_t calculate_memsize(resource_size_t size,
 		old_size = 0;
 	if (size < old_size)
 		size = old_size;
-	size = ALIGN(size + size1, align);
+	size = ALIGN(max(size, add_size) + children_add_size, align);
 	return size;
 }
 
@@ -1079,12 +1080,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	min_align = calculate_mem_align(aligns, max_order);
 	min_align = max(min_align, window_alignment(bus, b_res->flags));
-	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
+	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
 	add_align = max(min_align, add_align);
-	if (children_add_size > add_size)
-		add_size = children_add_size;
-	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
-		calculate_memsize(size, min_size, add_size,
+	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
+		calculate_memsize(size, min_size, add_size, children_add_size,
 				resource_size(b_res), add_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
-- 
1.8.3.1

