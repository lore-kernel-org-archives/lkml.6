Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeCNQfa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:35:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751289AbeCNQf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:35:27 -0400
From: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, ruscur@russell.cc, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, fbarrat@linux.vnet.ibm.com,
        brking@linux.vnet.ibm.com
Subject: [PATCH 0/2] Silent PCI realignment messages during boot
Date: Wed, 14 Mar 2018 13:34:53 -0300
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18031416-0016-0000-0000-000008642E50
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008673; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002988; UDB=6.00510401; IPR=6.00782318;
 MB=3.00020033; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 16:35:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031416-0017-0000-0000-00003DD75132
Message-Id: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
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

This patchset introduces PCI_DEV_FLAGS_QUIET_PCI_REALIGN attribute in
pci_dev_flags which informs the pci subsystem to suppress all realignment
messages.

Powerpc has aligned all of its PCI resources to its PAGE_SIZE, and this
feature can be easily used on any other arch through the __weak
pcibios_default_alignment() interface.

However, since all PCI resources will be now realigned during boot, the
following messages will not only flood the system logs, but can be inter-
preted as a false positive for total PCI failure on the system.

[root@system user]# dmesg | grep -i disabling
[    0.692270] pci 0000:00:00.0: Disabling memory decoding and releasing memory resources
[    0.692324] pci 0000:00:00.0: disabling bridge mem windows
[    0.729134] pci 0001:00:00.0: Disabling memory decoding and releasing memory resources
[    0.737352] pci 0001:00:00.0: disabling bridge mem windows
[    0.776295] pci 0002:00:00.0: Disabling memory decoding and releasing memory resources
[    0.784509] pci 0002:00:00.0: disabling bridge mem windows
... and goes on for all PCI devices ...

Thus, this patchset provides a way for drivers to silent these messages if
the PCI_DEV_FLAGS_QUIET_PCI_REALIGN is turned on. Moreover, it also
tweaks this flag during boot on powerpc.

Fixes: 38274637699 ("powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>

Desnes A. Nunes do Rosario (2):
  pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN attribute to the PCI
    subsystem
  powerpc/powernv: Tweak PCI_DEV_FLAGS_QUIET_PCI_REALIGN on/off during
    boot

 arch/powerpc/platforms/powernv/pci.c | 14 ++++++++++++++
 drivers/pci/pci.c                    |  3 ++-
 drivers/pci/setup-res.c              |  3 ++-
 include/linux/pci.h                  |  2 ++
 4 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.14.3
