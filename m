Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeCNQfk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:35:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752482AbeCNQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:35:37 -0400
From: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, ruscur@russell.cc, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, fbarrat@linux.vnet.ibm.com,
        brking@linux.vnet.ibm.com
Subject: [PATCH 2/2, powerpc/powernv] powerpc/powernv: Tweak PCI_DEV_FLAGS_QUIET_PCI_REALIGN on/off during boot
Date: Wed, 14 Mar 2018 13:34:55 -0300
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031416-0020-0000-0000-00000D972FBD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008673; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002988; UDB=6.00510401; IPR=6.00782318;
 MB=3.00020033; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 16:35:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031416-0021-0000-0000-0000607E46D6
Message-Id: <20180314163455.15854-3-desnesn@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140187
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn on PCI_DEV_FLAGS_QUIET_PCI_REALIGN flag on powernv's pci driver
to silent PCI realignment messages through a early stage hook, and turn
it off right before the pci device is enabled with a final stage hook.

Fixes: 38274637699 ("powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 69d102cbf48f..d28ce0899487 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -1108,6 +1108,20 @@ static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
 
+/* Fixup that disables PCI realignment menssages for all PCI devices */
+static void disable_realign_menssages(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_QUIET_PCI_REALIGN;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, disable_realign_menssages);
+
+/* Fixup that enables PCI realignment messages for all PCI devices */
+static void enable_realign_menssages(struct pci_dev *dev)
+{
+	dev->dev_flags ^= PCI_DEV_FLAGS_QUIET_PCI_REALIGN;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, enable_realign_menssages);
+
 void __init pnv_pci_init(void)
 {
 	struct device_node *np;
-- 
2.14.3
