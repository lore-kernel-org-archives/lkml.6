Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0252C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D809206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D809206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeJBUHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:07:07 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:48222 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeJBUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:07:07 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994586AbeJBNXpLcvTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Tue, 2 Oct 2018 15:23:45 +0200
Date:   Tue, 2 Oct 2018 14:23:45 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     netdev@vger.kernel.org
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] declance: Fix continuation with the adapter identification
 message
Message-ID: <alpine.LFD.2.21.1810021401530.5483@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a commit 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing
continuation lines") regression with the `declance' driver, which caused
the adapter identification message to be split between two lines, e.g.:

declance.c: v0.011 by Linux MIPS DECstation task force
tc6: PMAD-AA
, addr = 08:00:2b:1b:2a:6a, irq = 14
tc6: registered as eth0.

Address that properly, by printing identification with a single call,
making the messages now look like:

declance.c: v0.011 by Linux MIPS DECstation task force
tc6: PMAD-AA, addr = 08:00:2b:1b:2a:6a, irq = 14
tc6: registered as eth0.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 4bcc595ccd80 ("printk: reinstate KERN_CONT for printing continuation lines")
---
Hi,

 Not requesting a backport as the impact of this issue is purely cosmetic.  
Deferring driver review to use `netdev_info', etc. in place of `printk' to 
another time.  Please apply.

  Maciej
---
 drivers/net/ethernet/amd/declance.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

linux-net-declance-pr-cont.patch
Index: linux-20180930-4maxp64/drivers/net/ethernet/amd/declance.c
===================================================================
--- linux-20180930-4maxp64.orig/drivers/net/ethernet/amd/declance.c
+++ linux-20180930-4maxp64/drivers/net/ethernet/amd/declance.c
@@ -1031,6 +1031,7 @@ static int dec_lance_probe(struct device
 	int i, ret;
 	unsigned long esar_base;
 	unsigned char *esar;
+	const char *desc;
 
 	if (dec_lance_debug && version_printed++ == 0)
 		printk(version);
@@ -1216,19 +1217,20 @@ static int dec_lance_probe(struct device
 	 */
 	switch (type) {
 	case ASIC_LANCE:
-		printk("%s: IOASIC onboard LANCE", name);
+		desc = "IOASIC onboard LANCE";
 		break;
 	case PMAD_LANCE:
-		printk("%s: PMAD-AA", name);
+		desc = "PMAD-AA";
 		break;
 	case PMAX_LANCE:
-		printk("%s: PMAX onboard LANCE", name);
+		desc = "PMAX onboard LANCE";
 		break;
 	}
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = esar[i * 4];
 
-	printk(", addr = %pM, irq = %d\n", dev->dev_addr, dev->irq);
+	printk("%s: %s, addr = %pM, irq = %d\n",
+	       name, desc, dev->dev_addr, dev->irq);
 
 	dev->netdev_ops = &lance_netdev_ops;
 	dev->watchdog_timeo = 5*HZ;
