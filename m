Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965301AbeBMQ7y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:59:54 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.4]:14408 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964794AbeBMQ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:59:51 -0500
Date: Tue, 13 Feb 2018 10:59:49 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] PCI/ASPM: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20180213165948.GA14035@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1eldvq-001IoH-B2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.4.238]:35086
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix ULL to constant 1000 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
u64 (64 bits, unsigned).

The expression threshold_us * 1000 is currently being evaluated
using 32-bit arithmetic.

Addresses-Coverity-ID: 1462501
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 57feef2..684d326 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -322,7 +322,7 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 
 static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 {
-	u64 threshold_ns = threshold_us * 1000;
+	u64 threshold_ns = threshold_us * 1000ULL;
 
 	/* See PCIe r3.1, sec 7.33.3 and sec 6.18 */
 	if (threshold_ns < 32) {
-- 
2.7.4
