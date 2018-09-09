Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ACCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7514320866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYszDmk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7514320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeIJHkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:40:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44294 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIJHkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:40:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so16535375ljq.11;
        Sun, 09 Sep 2018 19:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xW2XF0TCmP47kVJFv5etl9djcdcCMkcGG8atr2Hz/P0=;
        b=UYszDmk7F6LdpYxaVvG44X9QraigSGyx+hPMg3Mt56ueBwJhuwc6JPkTuU3aJjQe5M
         I+hI85ZgmeDRDhJt9Pj7LrQoVhhc8i4qvAVyqP9+QN17JAapd7IJoO8BfEUZhyYdzarP
         V/mgZ3hAypIlYUDqKyVQrrwGiARHChz0xkgEyU5ZL7WnkVTqyFeiR/8TdbRwixMmmddp
         SlEJ/po6IySNDC+NP1Z/fZWb19YmIRKfgdfRPv9OzoR+Xtd++KtAeux8X51pyb6MkVg/
         HCRfi5xMKFcnRGMdHevBhTMaQrFnBRs0DyO2h6kasPpZKGqv/x8Lx50lQHG/QazpoDLn
         3KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xW2XF0TCmP47kVJFv5etl9djcdcCMkcGG8atr2Hz/P0=;
        b=l7Sp8k8l3X7dyRGJCrNvfyszmqlAJBd5DOu0GteHOsXruJEP5AQntNNkTZSr+B7Dfl
         gWLSSpuLBiaivJj4w7GFRPlbW1d6/5r7TULONGWZC4nP3s2PUQzldmVr++aKcxNCTD9/
         nC9xBdBexczjjc/3hVKoabOV9CHRAQn+uYe75jUKXEKGMHjkxsRY6CjNBG5WamICfvoU
         Se7R5ilD98e/VQ0tV+3PUPAxFqb+MLHgp51pyWVNzeAfSgY5giGCiXhafWzF2YnnvMEr
         F3aGicxyjsUuunYTX13AXmRFSo9igxnPK2WsW+ykPmk4tRWey9G4j6yc9+C6B72kbFTw
         HjAA==
X-Gm-Message-State: APzg51ACEIXkIbIaEt8vnDLqrnAojIz6dCdmMWZQLZ319dSjcPZg/ULy
        nBvN0cJ8pluIvYjgzUoko4AahVnmFuw=
X-Google-Smtp-Source: ANB0Vda/t0MDaWSIFwx1izKqB45uPqJndbhA82JW3DvnZLS/F55g+4rxzWPkn1uSEn4L8l0SJrEinw==
X-Received: by 2002:a2e:2d2:: with SMTP id y79-v6mr10452509lje.100.1536533710384;
        Sun, 09 Sep 2018 15:55:10 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id v10-v6sm2401574ljg.12.2018.09.09.15.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 15:55:09 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ARM: OMAP1: ams-delta: make board header file local to mach-omap1
Date:   Mon, 10 Sep 2018 00:56:05 +0200
Message-Id: <20180909225605.16463-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180909225605.16463-1-jmkrzyszt@gmail.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as board header file is no longer included by drivers, move it to
the root directory of mach-omap1.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq-handler.S              | 2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                      | 3 +--
 arch/arm/mach-omap1/board-ams-delta.c                    | 2 +-
 arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h (98%)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index ddc27638ba2a..2e2a17364dc9 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -17,9 +17,9 @@
 #include <linux/platform_data/ams-delta-fiq.h>
 
 #include <asm/assembler.h>
-#include <mach/board-ams-delta.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index b0dc7ddf5877..14c3d3f5255e 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -22,11 +22,10 @@
 #include <linux/platform_data/ams-delta-fiq.h>
 #include <linux/platform_device.h>
 
-#include <mach/board-ams-delta.h>
-
 #include <asm/fiq.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 
 static struct fiq_handler fh = {
 	.name	= "ams-delta-fiq"
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index dd28d2614d7f..34cb63ff45b3 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -36,7 +36,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-ams-delta.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <mach/mux.h>
 
@@ -45,6 +44,7 @@
 #include <mach/usb.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/include/mach/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
similarity index 98%
rename from arch/arm/mach-omap1/include/mach/board-ams-delta.h
rename to arch/arm/mach-omap1/board-ams-delta.h
index ad6f865d1f16..1fbada29431a 100644
--- a/arch/arm/mach-omap1/include/mach/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/board-ams-delta.h
+ * arch/arm/mach-omap1/board-ams-delta.h
  *
  * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
  *
-- 
2.16.4

