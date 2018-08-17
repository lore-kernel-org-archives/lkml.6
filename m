Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE0EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D262124D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D262124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeHQNfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:35:31 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52961 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeHQNfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:35:31 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LgHVU-1gBMPa1mGS-00ngPB; Fri, 17 Aug 2018 12:27:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 08/15] x86: PCI: clean up pcibios_scan_root()
Date:   Fri, 17 Aug 2018 12:26:38 +0200
Message-Id: <20180817102645.3839621-9-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
References: <20180817102645.3839621-1-arnd@arndb.de>
X-Provags-ID: V03:K1:tlcedIIbu3wiz3zsxlYn2+G+v0etxI3PP6TAmZreLsijFeYR04M
 h/VODDtc+5SUwz1uyxw71Eq8VwF/rrPeX4Mi73yyRzW86zhOmQypatEJjTmy5UJ8/VTs3si
 Or6SucrdTdcrzJKrTR3QI43wWqbF1ZN69gr+AUCaoNRbF51vgqmBAbIdS99XUNw57/qq4KP
 6/LoQH+SxPzNn6+AMM4rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:weQ6RTKTUsY=:XbEL7s+SkjRfvaO/OBnUBt
 ht0iALf7RLwZ+Pg4PqsRtLWIZH4P1cYoeJV2Ihh0UQD1qouQ1J3OdYGV47+3L395N4n9voRlw
 IH4kXgIGHDHCQojbrS3ViJndFx6PJGDA8jk0NkZUSTLdBLzcbHAXrOjmUbSx6xv3rPr1Y86YB
 OJXCDPtboW5sf4qcQm0weWm/5Knr32PPYh5RgJrZ96UyNL/oNUnxMttcHcBswPlYdETa8AAXh
 jikLLMG11oGfgI10VBT2eShT/ILBVvB+eQSbge2txFONEJ66ESQjUnT38uBXBC4XvkO3kd+zl
 k+bscHpGd3QyNeWxs8XZyzPmhNKsXNjOdqUU+7yfMAp0UgSwH7Fn/a9JkbkN21WNBAOLUx6lE
 u+g4OrVQFBzvcwkmwHY4WKdpYQv3pKzYkKDCNmHQptwy7ynQkXmd2n5dq9hyDTsnkE63eTbWG
 zCHFSRlEIpUfEdU/YuNCSJJIFcyGYt08H+qwfW9+OxsHZo5qCQSOEqq47OtnyIJANhMhiD+pP
 YeLmH89ATYf2Ug1E9TPiz3qcV3UGNuP3s3iW7iJjJChA5hN+Hg52TgED0fTWiH/i+nPQ8oUde
 eSO38j3Y3kkOt93/38VBYsVKkPRXM0J5QLiplQndvAB9Xr3l9hshp9Dopw2tthNxH4X3CDbPP
 jXxyPaG7Fw9HHSQZMuplcmXPAS09LGPqYRYwgkvq7V313AabwV/yRxpFa3DBpIdTwt+U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcibios_scan_root() is now just a wrapper around pci_scan_root_bus(),
and merging the two into one makes it shorter and more readable.

We can also take advantage of pci_alloc_host_bridge() doing the
allocation of the sysdata for us, which helps if we ever want to
allow hot-unplugging the host bridge itself.

We might be able to simplify it further using pci_host_probe(),
but I wasn't sure about the resource registration there.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/pci/common.c | 53 ++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index e740d9aa4024..920d0885434c 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -453,54 +453,35 @@ void __init dmi_check_pciprobe(void)
 	dmi_check_system(pciprobe_dmi_table);
 }
 
-static struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+void pcibios_scan_root(int busnum)
 {
+	struct pci_sysdata *sd;
 	struct pci_host_bridge *bridge;
 	int error;
 
-	bridge = pci_alloc_host_bridge(0);
-	if (!bridge)
-		return NULL;
+	bridge = pci_alloc_host_bridge(sizeof(sd));
+	if (!bridge) {
+		printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
+		return;
+	}
+	sd = pci_host_bridge_priv(bridge);
 
-	list_splice_init(resources, &bridge->windows);
-	bridge->dev.parent = parent;
-	bridge->sysdata = sysdata;
-	bridge->busnr = bus;
-	bridge->ops = ops;
+	sd->node = x86_pci_root_bus_node(busnum);
+	x86_pci_root_bus_resources(busnum, &bridge->windows);
+	bridge->sysdata = sd;
+	bridge->busnr = busnum;
+	bridge->ops = &pci_root_ops;
 
+	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
 	error = pci_scan_root_bus_bridge(bridge);
 	if (error < 0)
 		goto err_out;
 
-	return bridge->bus;
+	pci_bus_add_devices(bridge->bus);
+	return;
 
 err_out:
-	kfree(bridge);
-	return NULL;
-}
-
-void pcibios_scan_root(int busnum)
-{
-	struct pci_bus *bus;
-	struct pci_sysdata *sd;
-	LIST_HEAD(resources);
-
-	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
-	if (!sd) {
-		printk(KERN_ERR "PCI: OOM, skipping PCI bus %02x\n", busnum);
-		return;
-	}
-	sd->node = x86_pci_root_bus_node(busnum);
-	x86_pci_root_bus_resources(busnum, &resources);
-	printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\n", busnum);
-	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd, &resources);
-	if (!bus) {
-		pci_free_resource_list(&resources);
-		kfree(sd);
-		return;
-	}
-	pci_bus_add_devices(bus);
+	pci_free_host_bridge(bridge);
 }
 
 void __init pcibios_set_cache_line_size(void)
-- 
2.18.0

