Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E876C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50A021CF8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dX3nhYSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50A021CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbeGDR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:28:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37329 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeGDR2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:28:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id h20-v6so3152446pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=XznfKr7ZDO9o+PxvAu34GxzDSU595c/V/idhMlKj4vo=;
        b=dX3nhYSjpZHJEqEjFTvCtgZRcMV/VVQOsiyVGdelUeMfSkckdwDaOSX7W34PQh29tJ
         W0KefOqn73Eud5kQI/7ZRGCXVq3nGFNFTW90ej+j/rBq1wuSw0sxk5C9hn2a5hirFygw
         QRoHx3XWsrxyDQ1S+h6Fpn641Z2UxkZJ6aQ5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XznfKr7ZDO9o+PxvAu34GxzDSU595c/V/idhMlKj4vo=;
        b=BFlJdqm+ZODp1bApPHP06YLI/Iu3xbc/fC+ItkAxTsoqXI9HBEoAQpbf6cMfsevcyD
         Rkt9+gekOdQ1Fx8jbIZ3NPftsHJWRePDVh93ls+mKSeCW8avMcmoFL//66hzmydyOfHH
         Lz0bco1xPsWoxxnd1LxV/4dDOI0NhCLwgOMFll2ngS7q8dy/y4OH73EMW6tENeyMlnvs
         QUmXtnlW6IMqxTG7vjL8dZNAm4vF2/aHYGkI9c/zQ2Vui/N8Z1PWZciUzAFVtzuD9eTT
         k3UfRyNSkhZ/omRyw1XDRIrZFZNwlBDzyyWy58YxVYqpkLzl+X8McYXdNjmA3vZeQeMD
         nDKQ==
X-Gm-Message-State: APt69E1mNlKMlGCwXNJQBw7PbFS1PyxE8gJdCTlw5osNWa8YrpaXQg4K
        +fb3QEuP9T04wd8Bt29d04w5Pw==
X-Google-Smtp-Source: AAOMgpdKEiYSTFZ7fOGGmjZNFbpagjUtacZDvA8qo1u/HKhAr4sf/rzlfPJVmwcXP2GcOS8h9zDJWQ==
X-Received: by 2002:a63:4f63:: with SMTP id p35-v6mr2692796pgl.167.1530725281568;
        Wed, 04 Jul 2018 10:28:01 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c72-v6sm10705013pga.69.2018.07.04.10.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 10:28:00 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:27:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Peter Pan <peterpandong@micron.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spinand: Use 2-factor allocator calls
Message-ID: <20180704172759.GA33591@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already done treewide, switch from open-coded multiplication to using
2-factor allocator helpers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/mtd/nand/spi/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 17d207a49cb9..fed9211c6f19 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -159,9 +159,9 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
+	spinand->cfg_cache = devm_kcalloc(dev,
 					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
 					  GFP_KERNEL);
 	if (!spinand->cfg_cache)
 		return -ENOMEM;
-- 
2.17.1


-- 
Kees Cook
Pixel Security
