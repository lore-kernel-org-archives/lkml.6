Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3EBC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F52146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 03:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBHDRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 22:17:53 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.228]:28471 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfBHDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 22:17:52 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D2F701FB4A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Feb 2019 21:16:49 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rwengn11b4FKprweng8cGM; Thu, 07 Feb 2019 21:16:49 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=49134 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1grwen-001Ty4-4V; Thu, 07 Feb 2019 21:16:49 -0600
Date:   Thu, 7 Feb 2019 21:16:48 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Krzysztof Halasa <khc@pm.waw.pl>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] wan: wanxl: use struct_size() in kzalloc()
Message-ID: <20190208031648.GA3022@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1grwen-001Ty4-4V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:49134
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = alloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = alloc(struct_size(instance, entry, count), GFP_KERNEL)

Notice that, in this case, variable alloc_size is not necessary, hence
it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wan/wanxl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
index d573a57bc301..459ce52a0a4d 100644
--- a/drivers/net/wan/wanxl.c
+++ b/drivers/net/wan/wanxl.c
@@ -565,7 +565,7 @@ static int wanxl_pci_init_one(struct pci_dev *pdev,
 	u32 plx_phy;		/* PLX PCI base address */
 	u32 mem_phy;		/* memory PCI base addr */
 	u8 __iomem *mem;	/* memory virtual base addr */
-	int i, ports, alloc_size;
+	int i, ports;
 
 #ifndef MODULE
 	pr_info_once("%s\n", version);
@@ -601,8 +601,7 @@ static int wanxl_pci_init_one(struct pci_dev *pdev,
 	default: ports = 4;
 	}
 
-	alloc_size = sizeof(struct card) + ports * sizeof(struct port);
-	card = kzalloc(alloc_size, GFP_KERNEL);
+	card = kzalloc(struct_size(card, ports, ports), GFP_KERNEL);
 	if (card == NULL) {
 		pci_release_regions(pdev);
 		pci_disable_device(pdev);
-- 
2.20.1

