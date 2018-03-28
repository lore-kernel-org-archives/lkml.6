Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeC1Tjn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:39:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40171 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeC1Tjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:39:39 -0400
X-Google-Smtp-Source: AIpwx484YmJWU/y1wdaTVKw57WFjY1P6WrZtPSj9e9nECTv/lmXMCw43usWgnL9TSsLGeUuC4ATQHA==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/19] powerpc/powermac: Make some functions static
Date: Wed, 28 Mar 2018 21:39:35 +0200
Message-Id: <20180328193935.1338-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-8-malat@debian.org>
References: <20180322202007.23088-8-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/platforms/powermac/pci.c:1022:6: error: no previous prototype for ‘pmac_pci_fixup_ohci’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/pci.c:1057:6: error: no previous prototype for ‘pmac_pci_fixup_cardbus’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/powermac/pci.c:1094:6: error: no previous prototype for ‘pmac_pci_fixup_pciata’ [-Werror=missing-prototypes]

Remove has_address declaration and assignment since not used. Also add gcc
attribute unused to fix a warning treated as error with W=1:

  arch/powerpc/platforms/powermac/pci.c:784:19: error: variable ‘has_address’ set but not used [-Werror=unused-but-set-variable]
  arch/powerpc/platforms/powermac/pci.c:907:22: error: variable ‘ht’ set but not used [-Werror=unused-but-set-variable]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: remove has_address variable since not used
 arch/powerpc/platforms/powermac/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 0b8174a79993..67c497093e0a 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -781,12 +781,12 @@ static int __init pmac_add_bridge(struct device_node *dev)
 	struct resource rsrc;
 	char *disp_name;
 	const int *bus_range;
-	int primary = 1, has_address = 0;
+	int primary = 1;
 
 	DBG("Adding PCI host bridge %pOF\n", dev);
 
 	/* Fetch host bridge registers address */
-	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+	of_address_to_resource(dev, 0, &rsrc);
 
 	/* Get bus range if any */
 	bus_range = of_get_property(dev, "bus-range", &len);
@@ -904,7 +904,7 @@ static int pmac_pci_root_bridge_prepare(struct pci_host_bridge *bridge)
 void __init pmac_pci_init(void)
 {
 	struct device_node *np, *root;
-	struct device_node *ht = NULL;
+	struct device_node *ht __maybe_unused = NULL;
 
 	pci_set_flags(PCI_CAN_SKIP_ISA_ALIGN);
 
@@ -1019,7 +1019,7 @@ static bool pmac_pci_enable_device_hook(struct pci_dev *dev)
 	return true;
 }
 
-void pmac_pci_fixup_ohci(struct pci_dev *dev)
+static void pmac_pci_fixup_ohci(struct pci_dev *dev)
 {
 	struct device_node *node = pci_device_to_OF_node(dev);
 
@@ -1054,7 +1054,7 @@ void __init pmac_pcibios_after_init(void)
 	}
 }
 
-void pmac_pci_fixup_cardbus(struct pci_dev* dev)
+static void pmac_pci_fixup_cardbus(struct pci_dev *dev)
 {
 	if (!machine_is(powermac))
 		return;
@@ -1091,7 +1091,7 @@ void pmac_pci_fixup_cardbus(struct pci_dev* dev)
 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, PCI_ANY_ID, pmac_pci_fixup_cardbus);
 
-void pmac_pci_fixup_pciata(struct pci_dev* dev)
+static void pmac_pci_fixup_pciata(struct pci_dev *dev)
 {
        u8 progif = 0;
 
-- 
2.11.0
