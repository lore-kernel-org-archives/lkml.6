Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B3FECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 23:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D36D2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 23:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pihzemn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D36D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbeGWA1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 20:27:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbeGWA1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 20:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aJyV7KSLyt2ZX6T+ESPq2IO2rm2jOiTeyZVa/ZtxfxI=; b=pihzemn+qT57L9XFFcax9JwOw
        8+8NKxmG2eKw/OBAb7qSvXAaPJTyz0zBiVAeJ80kDgRPW3DOa2U3aB2dQ7h6t3vf5Nq+noOGs784u
        45E2pn/sqVXK+CV5p7pB4D3PEHkqj7fBJMIiN0mldBk9/VWK3rgOD5XeFc+CIPs2lq0viOG24xJDO
        Mh9qOJtha7w7Ogktq4qpMkK6mypYcbXIaITnnXYBbhDrONsawMJ5m+YxgBAaPRri6YAxGVQhzN1ZM
        7cVQhcssdOyc+mDXnrYn3wtSwfezFc5bqh29DSGy8C4cOotgk0Ihtr2Gb+7/2FlDE1Od31OefoWPY
        Pkbs+sQ3g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhNmX-0002na-V1; Sun, 22 Jul 2018 23:28:54 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] mtd/maps: fix solutionengine.c printk format warnings
Message-ID: <0ca72308-0551-97dc-dc74-11e1d8dac5b1@infradead.org>
Date:   Sun, 22 Jul 2018 16:28:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix 2 printk format warnings (this driver is currently only used by
arch/sh/) by using "%pap" instead of "%lx".
(or we could just cast the physical addresses to unsigned int)

Fixes these build warnings:

../drivers/mtd/maps/solutionengine.c: In function 'init_soleng_maps':
../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
../drivers/mtd/maps/solutionengine.c:62:54: note: format string is defined here
  printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
                                                  ~~~~^
                                                  %08x
../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
../drivers/mtd/maps/solutionengine.c:62:72: note: format string is defined here
  printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
                                                                    ~~~~^
                                                                    %08x

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: indent all lines inside the new block

 drivers/mtd/maps/solutionengine.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- linux-next-20180717.orig/drivers/mtd/maps/solutionengine.c
+++ linux-next-20180717/drivers/mtd/maps/solutionengine.c
@@ -59,9 +59,14 @@ static int __init init_soleng_maps(void)
 			return -ENXIO;
 		}
 	}
-	printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
-	       soleng_flash_map.phys & 0x1fffffff,
-	       soleng_eprom_map.phys & 0x1fffffff);
+	{
+		resource_size_t fl_phys = soleng_flash_map.phys & 0x1fffffff;
+		resource_size_t ep_phys = soleng_eprom_map.phys & 0x1fffffff;
+
+		printk(KERN_NOTICE
+		       "Solution Engine: Flash at 0x%pap, EPROM at 0x%pap\n",
+	       	       &fl_phys, &ep_phys);
+	}
 	flash_mtd->owner = THIS_MODULE;
 
 	eprom_mtd = do_map_probe("map_rom", &soleng_eprom_map);


