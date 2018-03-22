Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeCVUYI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:24:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37902 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752103AbeCVUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:20:51 -0400
X-Google-Smtp-Source: AG47ELs3AC5PoMo9c6IAgSo4ZC+8/6huh4yK24FaADxxTnAyXWtJElcxr1Y5HDtylRdoP75il7zHeQ==
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 07/19] powerpc/powermac: Make some functions static
Date: Thu, 22 Mar 2018 21:19:53 +0100
Message-Id: <20180322202007.23088-8-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
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

Also add gcc attribute unused to fix a warning treated as error with W=1:

  arch/powerpc/platforms/powermac/pci.c:784:19: error: variable ‘has_address’ set but not used [-Werror=unused-but-set-variable]
  arch/powerpc/platforms/powermac/pci.c:907:22: error: variable ‘ht’ set but not used [-Werror=unused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/powermac/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 0b8174a79993..d3b9818dd880 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -781,7 +781,7 @@ static int __init pmac_add_bridge(struct device_node *dev)
 	struct resource rsrc;
 	char *disp_name;
 	const int *bus_range;
-	int primary = 1, has_address = 0;
+	int primary = 1, has_address __maybe_unused = 0;
 
 	DBG("Adding PCI host bridge %pOF\n", dev);
 
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
