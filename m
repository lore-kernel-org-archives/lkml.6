Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFCCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953E120843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TWJrvu16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953E120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeICXyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:54:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41816 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeICXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GPJKwL9o8SnsfEPUsZRC7NJzfe+zKXMFlISAXDvWV9Q=; b=TWJrvu163aowdxHUD/dwP7HIUQ
        4LtAPeqDxGIsitRp4AZisziNe5Z4mYQpFG4Zn4oLsFAu6deuJGwlnqt1Wnb2hn3G9UIvvEeRl6izt
        3dPk1aHaic+1KbIHNwha3Y7RMKbT/dFBGsZqMkU/DgyQRBYLOp59Yv54Iz3AGFZr65jel0NxI0mXW
        EF1JPdo5a+ddwm8a7grkNTkW4gFU2r8oElBf3W+r+KbxM5gL0vMxEacfqf7yjdv3RiJ6lFCsCYpeq
        PI8fbnlJ+isT9Bx8zw1S5Lf+x3vCJVS5atP5EDHl3MlzdXT5DqhGRasmOzzVuyNxj1e6ASp5Ol4YQ
        VQtrHd5g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwuZz-0001tV-QW; Mon, 03 Sep 2018 19:32:09 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Adrian Bunk <bunk@kernel.org>, Adrian Bunk <bunk@debian.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mtd: onenand: fix parameter list build warning
Message-ID: <03e45afe-c4f8-e69b-9cba-6a8863296ad4@infradead.org>
Date:   Mon, 3 Sep 2018 12:32:04 -0700
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

Fix build warning in <linux/mtd/onenand.h> by adding a "stub" struct
for mtd_oob_ops:

include/linux/mtd/onenand.h: warning: 'struct mtd_oob_ops' declared inside parameter list [enabled by default]
include/linux/mtd/onenand.h: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

Fixes: 607d1cb10426 ("[MTD] [OneNAND] proper onenand_bbt_read_oob() prototype")

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Adrian Bunk <bunk@kernel.org>
Cc: Adrian Bunk <bunk@debian.org>
---
 include/linux/mtd/onenand.h |    1 +
 1 file changed, 1 insertion(+)

--- lnx-419-rc2.orig/include/linux/mtd/onenand.h
+++ lnx-419-rc2/include/linux/mtd/onenand.h
@@ -221,6 +221,7 @@ struct onenand_manufacturers {
         char *name;
 };
 
+struct mtd_oob_ops;
 int onenand_bbt_read_oob(struct mtd_info *mtd, loff_t from,
 			 struct mtd_oob_ops *ops);
 unsigned onenand_block(struct onenand_chip *this, loff_t addr);


