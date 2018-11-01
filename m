Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E50C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A9B22522
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2ibINdkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A9B22522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeKBInt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:43:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57726 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeKBInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kpcWE+zbht9Tn69VGclKa+3YkXkZpIudfI0ZgNQobfQ=; b=2ibINdkWB0IQHTWNQRy9ELwLk0
        me+E30n0uEHkTdwUmmN+vXAn5nlobJrTDLVd+5BVZX1TzStY1VUzVSDJ85tMC5citvD/cxzDzi1SJ
        ur25CAwBcHVsNcxfdhPavzgN4dIfJfSUSJOUmIamnl9EuH9WiXWrqalB23oqDqp6Klq7u06fxRmH8
        /x+hVV8Yzq/MT9/5B4kpY6MSuRFfGoOpPWZ+acHXmLKVcAE0iRVQ/08KzMPPHo5hKCyG5IV/+Y2/2
        F0t5j0JblYCeUGeFJlGp+pZbPzlxV4gRN4GXH/Z30LtGKyOYN/oZgyX/pQmOOPcB0tqATFmS13/mI
        kZFmYwcA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIMXs-0000jt-JR; Thu, 01 Nov 2018 23:38:36 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH resend] arch/sh: mach-kfr2r09: fix struct mtd_oob_ops build
 warning
Message-ID: <702f0a25-c63e-6912-4640-6ab0f00afbc7@infradead.org>
Date:   Thu, 1 Nov 2018 16:38:30 -0700
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

Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org
---
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


