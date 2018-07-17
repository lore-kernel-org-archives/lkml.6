Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E491D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzzXGz/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E491D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbeGQXuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:50:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42446 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731293AbeGQXuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:50:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so767319ljc.9;
        Tue, 17 Jul 2018 16:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nmcWxWoikEbDNaZCRKo/J0Uz6KG1YNRlldic6QUC8aI=;
        b=DzzXGz/+lWgmg/ZjOA7s/vKhkMP9WJXhYwRk4+xTVpyumBTMcZUu839mbmu8RFPJ22
         LTBwTQF9ysUnZjbjrRmpq4LDVDf8dY4fA1bWa5QhxdEb1iGT7lYy8yARWLlD5kaR+Y6D
         uFXzSowAI8VEGomKyYn5o9NwNtIK+Pj//1rb8BieTFFxpJYmX1swA1b3jCNoBFzb8Xfk
         BrO9CpnqNSa1td83Emp0ok4BCdWQffPIdQKivA9jrzXBSw+8jxkmDOeCsaXW1zajEXfj
         iK81e55WHTyZ2mc2HV0ZuQzp5wwXEE9oKINW7AsXzFyNrzlBi5rzHoJ5wzk4f7hlKlY8
         DvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nmcWxWoikEbDNaZCRKo/J0Uz6KG1YNRlldic6QUC8aI=;
        b=c8A95NJLr/TIIw6Z1GrnjX5FOTvlNNbnwucZubn3lOcgennEEMiA7drzFKD7ow9fre
         XKvTYju22jemtpyKK8iiFu6v1VEEjgsfYAW72TmsHBm5Ii+NsDvOB/HClJ4ymiJ3iYIA
         b8JshkzLaU+NBSBTHnqSDbW3JJ9xrrcsXUCxoGb2b+I3mtVZLfTwufBWTa+yW/ekgaZn
         KfdLVfP/236ayQTuM/FYzwhZ2/6gGYQvms4ySWuE1YSOfudUSfxjAYhWo34WUKzIMMTx
         qZr2qkDHbMJ0tRexApVWhSp4xigcoAXixD0qtwrJgt85q550v+JcGzk3J51EpLZGsqAt
         Donw==
X-Gm-Message-State: AOUpUlGch0mWZovNdA5gWQNwRs+st7aq09hkKYJzVx77BZx0g9Jw2Qz/
        go0ZEQNlESAXHqTjgxBqFbE=
X-Google-Smtp-Source: AAOMgpcBlcxGy/IRZla1uI8xVWzF90aO2wceNXs5IOIkAT/e3TTQcBOR0f4LXpGBSA5BRgy/ttE1Dw==
X-Received: by 2002:a2e:4e02:: with SMTP id c2-v6mr2645900ljb.108.1531869315815;
        Tue, 17 Jul 2018 16:15:15 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id n24-v6sm350827ljc.7.2018.07.17.16.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 16:15:15 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 3/3] ARM: OMAP1: ams-delta: make board header file local to mach-omap1
Date:   Wed, 18 Jul 2018 01:14:48 +0200
Message-Id: <20180717231448.14958-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180717231448.14958-1-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180717231448.14958-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now as board header file is no longer included by drivers, move it to
the root directory of mach-omap1.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Depends on patches 1/3 and 2/3 of the series.

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

