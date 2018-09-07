Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA3DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD6C20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD6C20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeIHCPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:15:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIHCPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:15:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5C179D6B;
        Fri,  7 Sep 2018 21:32:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 11/63] powerpc/powernv/pci: Work around races in PCI bridge enabling
Date:   Fri,  7 Sep 2018 23:09:42 +0200
Message-Id: <20180907211013.616200930@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit db2173198b9513f7add8009f225afa1f1c79bcc6 upstream.

The generic code is racy when multiple children of a PCI bridge try to
enable it simultaneously.

This leads to drivers trying to access a device through a
not-yet-enabled bridge, and this EEH errors under various
circumstances when using parallel driver probing.

There is work going on to fix that properly in the PCI core but it
will take some time.

x86 gets away with it because (outside of hotplug), the BIOS enables
all the bridges at boot time.

This patch does the same thing on powernv by enabling all bridges that
have child devices at boot time, thus avoiding subsequent races. It's
suitable for backporting to stable and distros, while the proper PCI
fix will probably be significantly more invasive.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/pci-ioda.c |   37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3124,12 +3124,49 @@ static void pnv_pci_ioda_create_dbgfs(vo
 #endif /* CONFIG_DEBUG_FS */
 }
 
+static void pnv_pci_enable_bridge(struct pci_bus *bus)
+{
+	struct pci_dev *dev = bus->self;
+	struct pci_bus *child;
+
+	/* Empty bus ? bail */
+	if (list_empty(&bus->devices))
+		return;
+
+	/*
+	 * If there's a bridge associated with that bus enable it. This works
+	 * around races in the generic code if the enabling is done during
+	 * parallel probing. This can be removed once those races have been
+	 * fixed.
+	 */
+	if (dev) {
+		int rc = pci_enable_device(dev);
+		if (rc)
+			pci_err(dev, "Error enabling bridge (%d)\n", rc);
+		pci_set_master(dev);
+	}
+
+	/* Perform the same to child busses */
+	list_for_each_entry(child, &bus->children, node)
+		pnv_pci_enable_bridge(child);
+}
+
+static void pnv_pci_enable_bridges(void)
+{
+	struct pci_controller *hose;
+
+	list_for_each_entry(hose, &hose_list, list_node)
+		pnv_pci_enable_bridge(hose->bus);
+}
+
 static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
 	pnv_pci_ioda_setup_iommu_api();
 	pnv_pci_ioda_create_dbgfs();
 
+	pnv_pci_enable_bridges();
+
 #ifdef CONFIG_EEH
 	eeh_init();
 	eeh_addr_cache_build();


