Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF2EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6297C20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gJ4tB1lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6297C20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeKCBVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:21:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35760 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeKCBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=11TOd3whKUGdYfwECPP0Gbi25PRrhS/XQ7psCJle1Zc=; b=gJ4tB1lkiufiAu8HeBMfShtRIW
        8e7DUmrYbySF1P8abjTWxyBiZFrM+gweEHJ6GrTAG8lIHt4ByerzJLInoqnYmVkNsSwBFbh5U++sO
        kzzP1YxWNN2ewVqZbzy0/c2yhCeMXeREbB90oIlZs/opse+ZQllQ7hy9aqoiTv3zhneW+qUuVIE+m
        9DgWFMryGYIUGDCDg/Xn+7qGzPkUYPwT9tTNibFwfmm9fGqcE9L04+RkWstbKBWWZi3Q/BFE0UF0g
        s0J0AdTwQUcRyqLrFquQbXduj6o/F2bYxxXU2ZmcLu9JM7IwzRaShe8aw6Nu5RL6OkyoWevjP2o57
        5XHiOjOw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIc5N-0003le-Um; Fri, 02 Nov 2018 16:14:14 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] arch/sh: mach-kfr2r09: fix struct mtd_oob_ops build
 warning
Message-ID: <99e03339-5fab-bcdf-902d-962084db86e8@infradead.org>
Date:   Fri, 2 Nov 2018 09:14:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

arch/sh/boards/mach-kfr2r09/setup.c does not need to #include
<mtd/onenand.h>, and doing so causes a build warning, so drop
that header file.

In file included from ../arch/sh/boards/mach-kfr2r09/setup.c:28:
../include/linux/mtd/onenand.h:225:12: warning: 'struct mtd_oob_ops' declared inside parameter list will not be visible outside of this definition or declaration
     struct mtd_oob_ops *ops);

Fixes: 33893d7aa000 ("sh: kfr2r09 board support - NAND flash")

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jacopo Mondi <jacopo@jmondi.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org
---
v2: fix the Fixes commit ID and add Ack from Jacopo.

 arch/sh/boards/mach-kfr2r09/setup.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20181101.orig/arch/sh/boards/mach-kfr2r09/setup.c
+++ linux-next-20181101/arch/sh/boards/mach-kfr2r09/setup.c
@@ -25,7 +25,6 @@
 #include <linux/memblock.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
-#include <linux/mtd/onenand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_data/lv5207lp.h>
 #include <linux/platform_device.h>


