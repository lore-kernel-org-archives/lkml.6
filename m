Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeDDPLY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:11:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751413AbeDDPLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:11:23 -0400
From: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com
Subject: [PATCH, RESEND, pci, v2] pci: Delete PCI disabling informational messages
Date: Wed,  4 Apr 2018 12:10:35 -0300
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18040415-0008-0000-0000-000002F11BB1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008801; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01013031; UDB=6.00516334; IPR=6.00792296;
 MB=3.00020414; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-04 15:11:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040415-0009-0000-0000-000038C8A28B
Message-Id: <20180404151035.12140-1-desnesn@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804040153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The disabling informational messages on the PCI subsystem should be deleted
since they do not represent any real value for the system logs.

These messages are either not presented, or presented for all PCI devices
(e.g., powerpc now realigns all PCI devices to its page size). Thus, they
are flooding system logs and can be interpreted as a false positive for
total PCI failure on the system.

[root@system user]# dmesg | grep -i disabling
[    0.692270] pci 0000:00:00.0: Disabling memory decoding and releasing memory resources
[    0.692324] pci 0000:00:00.0: disabling bridge mem windows
[    0.729134] pci 0001:00:00.0: Disabling memory decoding and releasing memory resources
[    0.737352] pci 0001:00:00.0: disabling bridge mem windows
[    0.776295] pci 0002:00:00.0: Disabling memory decoding and releasing memory resources
[    0.784509] pci 0002:00:00.0: disabling bridge mem windows
... and goes on for all PCI devices on the system ...

Fixes: 38274637699 ("powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
---
 drivers/pci/pci.c       | 1 -
 drivers/pci/setup-res.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8c71d1a66cdd..1563ce1ee091 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5505,7 +5505,6 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 	}
 
-	pci_info(dev, "Disabling memory decoding and releasing memory resources\n");
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 369d48d6c6f1..6bd35e8e7cde 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -172,8 +172,6 @@ EXPORT_SYMBOL(pci_claim_resource);
 
 void pci_disable_bridge_window(struct pci_dev *dev)
 {
-	pci_info(dev, "disabling bridge mem windows\n");
-
 	/* MMIO Base/Limit */
 	pci_write_config_dword(dev, PCI_MEMORY_BASE, 0x0000fff0);
 
-- 
2.14.3
