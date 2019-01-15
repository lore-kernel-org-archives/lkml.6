Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67203C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354CC2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJNovvbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390864AbfAOXHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:07:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36774 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390541AbfAOXHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:07:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so3972190edb.3;
        Tue, 15 Jan 2019 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1h9d9A95Fr5hAd0WXvQzD83nIGqZQnGK3nipgpZF0Kw=;
        b=jJNovvbt1uZsPOb/cQuvDRQ42pCBFWyGb/Cm188BfcTgsor9rwdZHm7jElTl2SDRqm
         NB/Ve4H+LlflNHnvYSz0Y+vSOPSCXcJZ1xljxqvyaAfN/lN8IoUsdnEfPVfyonVwfYUo
         fsI3UI2rrJ3zOeftN+EsZc0eEyoqsmkjAwLYVchS33OmsIOBzkmR4bZvUoZyNZnvNVHP
         btEe30buHizz8k54le5a3+PgfS8AcfmdorqsiqhkdPH4o/dzIo0GCr5XgOCbjHOXDrqN
         b7bbzKjgSBu9r/nOuAyesddWm6n06t4h+xWasY/967HDamQQsIhoUgqi//i8ao7JB7Ms
         P7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1h9d9A95Fr5hAd0WXvQzD83nIGqZQnGK3nipgpZF0Kw=;
        b=JMiZZt+8gMZ7Wc7VZS1CwiccuGh+jPLvt7mfSDcntPQGkv3oOrt7GPUYpH6IcEhYeQ
         J+4N6p0sLmRHoHz+yXd3PFUKDEXvWG7jC+YYsVvxJnrgDEpSPYezwwFENaOxmY6NvVk3
         HhJDVIdWjO4mZ/yTH/YZgNxVbKciidYXw+oF9B0Bu8mKcWKDiSnzn3L5MXOfkmn72hjW
         bSOFD/s3Ye7+t/b9Qw8flaIa+vj/cZcKDXta5PcXWTWcTOv9CsLMw+xnacKy88T7gKD6
         QIoBTAyJn7t8LCt6YFA74ZO8GEdBSCz6JNeBHVI1/6bXSkpd3RSzspwzr4DaCmNvyhCW
         O1gQ==
X-Gm-Message-State: AJcUukeewYoX+nawE5IyZ0/0JEqU8dVjcfM0hIOjZ6/rc1fky7nSr8/C
        eXLtKL7Qrx1Eg6oiU95U/6GYjcVo
X-Google-Smtp-Source: ALg8bN4CoK9QUQYQICNKjAvjY9JDX2Ax8MEFLndlp9aNBrzwQwpFcK5zg6qJOe0wteenxoHSWo2fyA==
X-Received: by 2002:a50:8f44:: with SMTP id 62mr5050087edy.264.1547593620497;
        Tue, 15 Jan 2019 15:07:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v14sm4872324edq.74.2019.01.15.15.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:06:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Marvell
        Dove/MV78xx0/Orion SOC support)
Subject: [PATCH net-next 2/3] ARM: orion5x: Include platform_data/dsa.h
Date:   Tue, 15 Jan 2019 15:06:12 -0800
Message-Id: <20190115230613.28334-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115230613.28334-1-f.fainelli@gmail.com>
References: <20190115230613.28334-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have split the DSA platform data structures from the main
net/dsa.h header file, include only the relevant header file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-orion5x/common.c               | 2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c | 2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c  | 2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c | 2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c        | 2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c     | 2 +-
 arch/arm/plat-orion/common.c                 | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 83a7ec4c16d0..c67f92bfa30e 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -20,7 +20,7 @@
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
 #include <linux/cpu.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/page.h>
 #include <asm/setup.h>
 #include <asm/system_misc.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index a3c1336d30c9..c65ab7db36ad 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -16,7 +16,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index 252efe29bd1a..76b8138d9d79 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -17,7 +17,7 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
 #include <linux/i2c.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index f4f1dbe1d91d..5f388a1ed1e4 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -18,7 +18,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/ethtool.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index d162d4c7f85d..83589a28a491 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -15,7 +15,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ethtool.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 9250bb2e429c..cea08d4a2597 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -18,7 +18,7 @@
 #include <linux/leds.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index a2399fd66e97..a6c81ce00f52 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -18,7 +18,7 @@
 #include <linux/clkdev.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/mv643xx_i2c.h>
-#include <net/dsa.h>
+#include <linux/platform_data/dsa.h>
 #include <linux/platform_data/dma-mv_xor.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <plat/common.h>
-- 
2.17.1

