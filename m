Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163632AbeE1KuH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163598AbeE1Kt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 196/496] nvme-pci: Fix EEH failure on ppc
Date: Mon, 28 May 2018 11:59:41 +0200
Message-Id: <20180528100328.186085304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

[ Upstream commit 651438bb0af5213f1f70d66e75bf11d08cb5537a ]

Triggering PPC EEH detection and handling requires a memory mapped read
failure. The NVMe driver removed the periodic health check MMIO, so
there's no early detection mechanism to trigger the recovery. Instead,
the detection now happens when the nvme driver handles an IO timeout
event. This takes the pci channel offline, so we do not want the driver
to proceed with escalating its own recovery efforts that may conflict
with the EEH handler.

This patch ensures the driver will observe the channel was set to offline
after a failed MMIO read and resets the IO timer so the EEH handler has
a chance to recover the device.

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
[updated change log]
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1013,12 +1013,6 @@ static bool nvme_should_reset(struct nvm
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
 
@@ -1049,6 +1043,13 @@ static enum blk_eh_timer_return nvme_tim
 	struct nvme_command cmd;
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
+	/* If PCI error recovery process is happening, we cannot reset or
+	 * the recovery mechanism will surely fail.
+	 */
+	mb();
+	if (pci_channel_offline(to_pci_dev(dev->dev)))
+		return BLK_EH_RESET_TIMER;
+
 	/*
 	 * Reset immediately if the controller is failed
 	 */
