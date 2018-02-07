Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeBGUQh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:16:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754002AbeBGUQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:16:35 -0500
From: wenxiong@linux.vnet.ibm.com
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, axboe@fb.com, linux-kernel@vger.kernel.org,
        wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.vnet.ibm.com>
Subject: [PATCH V2]nvme-pci: Fixes EEH failure on ppc
Date: Wed,  7 Feb 2018 14:09:38 -0600
X-Mailer: git-send-email 1.7.1
X-TM-AS-GCONF: 00
x-cbid: 18020720-0044-0000-0000-000003DD10ED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008492; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000249; SDB=6.00986386; UDB=6.00500582; IPR=6.00765750;
 BA=6.00005819; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019428; XFM=3.00000015;
 UTC=2018-02-07 20:16:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020720-0045-0000-0000-0000080C815D
Message-Id: <1518034178-26176-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

With b2a0eb1a0ac72869c910a79d935a0b049ec78ad9(nvme-pci: Remove watchdog
timer), EEH recovery stops working on ppc.

After removing whatdog timer routine, when trigger EEH on ppc, we hit
EEH in nvme_timeout(). We would like to check if pci channel is offline
or not at the beginning of nvme_timeout(), if it is already offline,
we don't need to do future nvme timeout process.

With the patch, EEH recovery works successfuly on ppc.

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>

[  232.585495] EEH: PHB#3 failure detected, location: N/A
[  232.585545] CPU: 8 PID: 4873 Comm: kworker/8:1H Not tainted
4.14.0-6.el7a.ppc64le #1
[  232.585646] Workqueue: kblockd blk_mq_timeout_work
[  232.585705] Call Trace:
[  232.585743] [c000003f7a533940] [c000000000c3556c]
dump_stack+0xb0/0xf4 (unreliable)
[  232.585823] [c000003f7a533980] [c000000000043eb0]
eeh_check_failure+0x290/0x630
[  232.585924] [c000003f7a533a30] [c008000011063f30]
nvme_timeout+0x1f0/0x410 [nvme]
[  232.586038] [c000003f7a533b00] [c000000000637fc8]
blk_mq_check_expired+0x118/0x1a0
[  232.586134] [c000003f7a533b80] [c00000000063e65c]
bt_for_each+0x11c/0x200
[  232.586191] [c000003f7a533be0] [c00000000063f1f8]
blk_mq_queue_tag_busy_iter+0x78/0x110
[  232.586272] [c000003f7a533c30] [c0000000006367b8]
blk_mq_timeout_work+0xa8/0x1c0
[  232.586351] [c000003f7a533c80] [c00000000015d5ec]
process_one_work+0x1bc/0x5f0
[  232.586431] [c000003f7a533d20] [c00000000016060c]
worker_thread+0xac/0x6b0
[  232.586485] [c000003f7a533dc0] [c00000000016a528] kthread+0x168/0x1b0
[  232.586539] [c000003f7a533e30] [c00000000000b4e8]
ret_from_kernel_thread+0x5c/0x74
[  232.586640] nvme nvme0: I/O 10 QID 0 timeout, reset controller
[  232.586640] EEH: Detected error on PHB#3
[  232.586642] EEH: This PCI device has failed 1 times in the last hour
[  232.586642] EEH: Notify device drivers to shutdown
[  232.586645] nvme nvme0: frozen state error detected, reset controller
[  234.098667] EEH: Collect temporary log
[  234.098694] PHB4 PHB#3 Diag-data (Version: 1)
[  234.098728] brdgCtl:    00000002
[  234.098748] RootSts:    00070020 00402000 c1010008 00100107 00000000
[  234.098807] RootErrSts: 00000000 00000020 00000001
[  234.098878] nFir:       0000800000000000 0030001c00000000
0000800000000000
[  234.098937] PhbSts:     0000001800000000 0000001800000000
[  234.098990] Lem:        0000000100000100 0000000000000000
0000000100000000
[  234.099067] PhbErr:     000004a000000000 0000008000000000
2148000098000240 a008400000000000
[  234.099140] RxeMrgErr:  0000000000000001 0000000000000001
0000000000000000 0000000000000000
[  234.099250] PcieDlp:    0000000000000000 0000000000000000
8000000000000000
[  234.099326] RegbErr:    00d0000010000000 0000000010000000
8800005800000000 0000000007011000
[  234.099418] EEH: Reset without hotplug activity
[  237.317675] nvme 0003:01:00.0: Refused to change power state,
currently in D3
[  237.317740] nvme 0003:01:00.0: Using 64-bit DMA iommu bypass
[  237.317797] nvme nvme0: Removing after probe failure status: -19
[  361.139047689,3] PHB#0003[0:3]: Escalating freeze to fence
PESTA[0]=a440002a01000000
[  237.617706] EEH: Notify device drivers the completion of reset
[  237.617754] nvme nvme0: restart after slot reset
[  237.617834] EEH: Notify device driver to resume
[  238.777746] nvme0n1: detected capacity change from 24576000000 to 0
[  238.777841] nvme0n2: detected capacity change from 24576000000 to 0
[  238.777944] nvme0n3: detected capacity change from 24576000000 to 0
[  238.778019] nvme0n4: detected capacity change from 24576000000 to 0
[  238.778132] nvme0n5: detected capacity change from 24576000000 to 0
[  238.778222] nvme0n6: detected capacity change from 24576000000 to 0
[  238.778314] nvme0n7: detected capacity change from 24576000000 to 0
[  238.778416] nvme0n8: detected capacity change from 24576000000 to 0
---
 drivers/nvme/host/pci.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6fe7af0..4809f3d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1153,12 +1153,6 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 	if (!(csts & NVME_CSTS_CFS) && !nssro)
 		return false;
 
-	/* If PCI error recovery process is happening, we cannot reset or
-	 * the recovery mechanism will surely fail.
-	 */
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
-		return false;
-
 	return true;
 }
 
@@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_command cmd;
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
+	/* If PCI error recovery process is happening, we cannot reset or
+	 * the recovery mechanism will surely fail.
+	 */
+	if (pci_channel_offline(to_pci_dev(dev->dev)))
+		return BLK_EH_RESET_TIMER;
+
 	/*
 	 * Reset immediately if the controller is failed
 	 */
-- 
1.7.1
