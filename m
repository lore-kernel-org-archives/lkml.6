Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A664C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2989208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2989208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbeHWMiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:38:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbeHWMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:38:16 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E2C57CA6;
        Thu, 23 Aug 2018 09:09:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 285/324] PCI: faraday: Fix I/O space page leak
Date:   Thu, 23 Aug 2018 09:55:51 +0200
Message-Id: <20180823075010.298079140@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit e30609454b39139a91faf631685f503b7ea3f27d ]

When testing the R-Car PCIe driver on the Condor board, if
the PCIe PHY driver was left disabled, the kernel crashed with this BUG:

  kernel BUG at lib/ioremap.c:72!
  Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 PID: 39 Comm: kworker/0:1 Not tainted 4.17.0-dirty #1092
  Hardware name: Renesas Condor board based on r8a77980 (DT)
  Workqueue: events deferred_probe_work_func
  pstate: 80000005 (Nzcv daif -PAN -UAO)
  pc : ioremap_page_range+0x370/0x3c8
  lr : ioremap_page_range+0x40/0x3c8
  sp : ffff000008da39e0
  x29: ffff000008da39e0 x28: 00e8000000000f07
  x27: ffff7dfffee00000 x26: 0140000000000000
  x25: ffff7dfffef00000 x24: 00000000000fe100
  x23: ffff80007b906000 x22: ffff000008ab8000
  x21: ffff000008bb1d58 x20: ffff7dfffef00000
  x19: ffff800009c30fb8 x18: 0000000000000001
  x17: 00000000000152d0 x16: 00000000014012d0
  x15: 0000000000000000 x14: 0720072007200720
  x13: 0720072007200720 x12: 0720072007200720
  x11: 0720072007300730 x10: 00000000000000ae
  x9 : 0000000000000000 x8 : ffff7dffff000000
  x7 : 0000000000000000 x6 : 0000000000000100
  x5 : 0000000000000000 x4 : 000000007b906000
  x3 : ffff80007c61a880 x2 : ffff7dfffeefffff
  x1 : 0000000040000000 x0 : 00e80000fe100f07
  Process kworker/0:1 (pid: 39, stack limit = 0x        (ptrval))
  Call trace:
   ioremap_page_range+0x370/0x3c8
   pci_remap_iospace+0x7c/0xac
   pci_parse_request_of_pci_ranges+0x13c/0x190
   rcar_pcie_probe+0x4c/0xb04
   platform_drv_probe+0x50/0xbc
   driver_probe_device+0x21c/0x308
   __device_attach_driver+0x98/0xc8
   bus_for_each_drv+0x54/0x94
   __device_attach+0xc4/0x12c
   device_initial_probe+0x10/0x18
   bus_probe_device+0x90/0x98
   deferred_probe_work_func+0xb0/0x150
   process_one_work+0x12c/0x29c
   worker_thread+0x200/0x3fc
   kthread+0x108/0x134
   ret_from_fork+0x10/0x18
  Code: f9004ba2 54000080 aa0003fb 17ffff48 (d4210000)

It turned out that pci_remap_iospace() wasn't undone when the driver's
probe failed, and since devm_phy_optional_get() returned -EPROBE_DEFER,
the probe was retried, finally causing the BUG due to trying to remap
already remapped pages.

The Faraday PCI driver has the same issue. Replace pci_remap_iospace()
with its devm_ managed version to fix the bug.

Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[lorenzo.pieralisi@arm.com: updated the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/host/pci-ftpci100.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -501,7 +501,7 @@ static int faraday_pci_probe(struct plat
 				dev_err(dev, "illegal IO mem size\n");
 				return -EINVAL;
 			}
-			ret = pci_remap_iospace(io, io_base);
+			ret = devm_pci_remap_iospace(dev, io, io_base);
 			if (ret) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 ret, io);


