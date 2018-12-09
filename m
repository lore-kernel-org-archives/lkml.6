Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E41C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E922081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E922081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeLIWIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:08:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37300 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728022AbeLIWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:08:07 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73C-0002il-AA; Sun, 09 Dec 2018 21:55:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72d-0003PM-U4; Sun, 09 Dec 2018 21:55:11 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael Ellerman" <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.133023113@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 149/328] powerpc/powernv/pci: Work around races in
 PCI bridge enabling
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16:
 - Use dev_err() instead of pci_err()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1132,6 +1132,41 @@ static void pnv_pci_ioda_create_dbgfs(vo
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
+			dev_err(&dev->dev, "Error enabling bridge (%d)\n", rc);
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
@@ -1140,6 +1175,8 @@ static void pnv_pci_ioda_fixup(void)
 
 	pnv_pci_ioda_create_dbgfs();
 
+	pnv_pci_enable_bridges();
+
 #ifdef CONFIG_EEH
 	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
 	eeh_addr_cache_build();

