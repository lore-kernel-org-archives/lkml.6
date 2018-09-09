Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F20C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1AA206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK2PipI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1AA206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeIJHga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:36:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46387 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeIJHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:36:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so16511940ljj.13;
        Sun, 09 Sep 2018 19:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M/QBgS5czV0iRAtflFDT2zvaSpvt1iMlKHvBYDahNH0=;
        b=BK2PipI63jK7bS8duqrxQsgUHGioMSIyS5BZ8q/FtzxBqKAzTQPvA4fibDXK3RAXm0
         kdGJRtV/g5EO5ghMNB2VciyH765nIMOZYu936OMMptNgnWc96jJJc4Y3tt4s+qtA8yOp
         pfuI0Gl9T/bIikxE9K6BuXk8Y0ipRdSo6WT9qorVXH/hWFY2cfvYSNDrX4Evu0XFQje3
         OUcdWzQYC0M5AdqkLxpVHls/XKGBxc3t8GpGuMaDWt/4NxwBPXbm/Pb2jNFfHQh/a7/f
         zVCe+5UZRlcGg8hRjI76+Ig81ROc0/tA8NZwwXL2V1cw+3s0GB5Qs880PRpEWDXjuvW1
         bfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M/QBgS5czV0iRAtflFDT2zvaSpvt1iMlKHvBYDahNH0=;
        b=cUTi9LipbmEryBDYZSyesfwMJWw3F0cEDU6xSP4sidGUq3hl5fuvTeh7uYNACR9r3Z
         SZ+zeo5pWZcJmp6IA7eNApm6Yie2sWvHXEndULTdjTnew4Blec47xDEkLiKcZ7in9tTX
         jrm0c7Dma5TIA2ICcfiwNZWvW83ARfPoPOFzfaLWM2Jb+jTYyePDIVh9MQe96EYftAub
         96kK+xGfHKlWJcUstOCwEHOs/iiHsVkS9bRBpTb1nojahRSSi+54uG6HoMMoexs9s/3V
         TwbY5u+hJFLy6xuk3aDBDatYx62+FQ4b8+Owgi6vwY45rAaSyHXLYhae3J8U9qEE/bTx
         s6jw==
X-Gm-Message-State: APzg51BwAT3pbft8pW2JKPv32jWMyOrein1ju+jC120nTu+QJ74olCQk
        7ui8oh0i9HfZ9loIlHPYNhiVeOhk
X-Google-Smtp-Source: ANB0VdY3f3wsbkPs3gtwWf8Md/cAGRxnWXEJm8I/n4LqgKo1aIoA6FcNO92NYvaicD02CVItQbaibg==
X-Received: by 2002:a2e:6a04:: with SMTP id f4-v6mr11225686ljc.109.1536536597340;
        Sun, 09 Sep 2018 16:43:17 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h4-v6sm2355373lfj.69.2018.09.09.16.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 16:43:16 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: OMAP1: ams-delta: register MODEM device earlier
Date:   Mon, 10 Sep 2018 01:44:19 +0200
Message-Id: <20180909234419.31261-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180909234419.31261-1-jmkrzyszt@gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
 <20180909234419.31261-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amstrad Delta MODEM device used to be initialized at arch_initcall
before it was once moved to late_initcall by commit f7519d8c8290 ("ARM:
OMAP1: ams-delta: register latch dependent devices later"). The purpose
of that change was to postpone initialization of devices which depended
on latch2 pins until latch2 converted to GPIO device was ready.

After recent fixes to GPIO handling, it was possible to moove
registration of most of those device back to where they were before.
The same can be safely done with the MODEM device as initialization
of GPIO pins it depends on was moved to machine_init by preceding
patch.

Move registration of the MODEM device to arch_initcall_sync, not to
arch_initcall, so it is never exposed to potential conflict in
registration order hazard against OMAP serial ports.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 1d451142248c..667c3c1f05f5 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -896,11 +896,28 @@ static int __init modem_nreset_init(void)
 /*
  * This function expects MODEM IRQ number already assigned to the port
  * and fails if it's not.
+ * The MODEM device requires its RESET# pin kept high during probe.
+ * That requirement can be fulfilled in several ways:
+ * - with a descriptor of already functional modem_nreset regulator
+ *   assigned to the MODEM private data,
+ * - with the regulator not yet controlled by modem_pm function but
+ *   already enabled by default on probe,
+ * - before the modem_nreset regulator is probed, with the pin already
+ *   set high explicitly.
+ * The last one is already guaranteed by ams_delta_latch2_init() called
+ * from machine_init.
+ * In order to avoid taking over ttyS0 device slot, the MODEM device
+ * should be registered after OMAP serial ports.  Since those ports
+ * are registered at arch_initcall, this function can be called safely
+ * at arch_initcall_sync earliest.
  */
 static int __init ams_delta_modem_init(void)
 {
 	int err;
 
+	if (!machine_is_ams_delta())
+		return -ENODEV;
+
 	if (ams_delta_modem_ports[0].irq < 0)
 		return ams_delta_modem_ports[0].irq;
 
@@ -913,6 +930,7 @@ static int __init ams_delta_modem_init(void)
 
 	return err;
 }
+arch_initcall_sync(ams_delta_modem_init);
 
 static int __init late_init(void)
 {
@@ -922,10 +940,6 @@ static int __init late_init(void)
 	if (err)
 		return err;
 
-	err = ams_delta_modem_init();
-	if (err)
-		return err;
-
 	/*
 	 * Once the modem device is registered, the modem_nreset
 	 * regulator can be requested on behalf of that device.
-- 
2.16.4

