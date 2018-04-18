Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeDRNtn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:49:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753114AbeDRNtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:49:41 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-m68k@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] m68k: fix return value check in mcf_pci_init()
Date: Wed, 18 Apr 2018 13:57:22 +0000
Message-ID: <1524059842-22099-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function ioremap() returns NULL pointer not
ERR_PTR(). The IS_ERR() test in the return value check should be
replaced with NULL test.

Fixes: bf114d773167 ("m68k: force use of __raw_read/__raw_write address to be iomem")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/m68k/coldfire/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
index 9d6342c..a7c2332 100644
--- a/arch/m68k/coldfire/pci.c
+++ b/arch/m68k/coldfire/pci.c
@@ -218,7 +218,7 @@ static int __init mcf_pci_init(void)
 
 	/* Keep a virtual mapping to IO/config space active */
 	iospace = ioremap(PCI_IO_PA, PCI_IO_SIZE);
-	if (IS_ERR(iospace))
+	if (!iospace)
 		return -ENODEV;
 	pr_info("Coldfire: PCI IO/config window mapped to 0x%p\n", iospace);
