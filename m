Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E3C10F09
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC11218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLDsfNsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfBRATr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:19:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36389 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfBRATq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:19:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so7612156pfa.3;
        Sun, 17 Feb 2019 16:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfjyKjJ4BPDlX5QQ+sFj1fRVuO9lVs7F3NH6shrTHtY=;
        b=cLDsfNsx13o5jVbpfVJM1rGKKUV/63W8NmOQz/8GkyEPs8GYLjJarohBh8aVUh5J+s
         qYaKYdoDeAymcZqFK7Y2dulSPWNelR3dY4eFhyXHpuWH+aSiaqP60pcyGK2DdCNEoe0R
         L6fb153r6bLrAUThs5k0InFu+iTYQPUwjffXXTIeZZJKSUqrrWPRsEfYYNvEuI/HBGFk
         020PIrw/pRWhdmcz51jjErVI7JZ640M5LPgWyvUQkeyFH4hre7sQm/EMNdhPixoeYh/l
         HO94JHYUQbAcnZhW40fwFiQmgym35S6ynrmeuLGf2d3pvs7IUxNb1YuHgnA3vCPyd56v
         W6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfjyKjJ4BPDlX5QQ+sFj1fRVuO9lVs7F3NH6shrTHtY=;
        b=oNJf/xmANyV/B4rwkKKxRObM4D3mcWWZ1VSlvKBOi1qNXhN0RrpaEi05XDjki61Gga
         ZsKEM4xnJsx6dRwuBdnj+zv8j/haOhEPdSo0/32HEnEKlz/ipOSntSwm+eYv4YOI1zNH
         79rbfQluB8FvBpm+zlnMjVoJkwS2Rmi1Obg2/PBByueVOGLrsaP/0+uhyo6pixvXCd7O
         1u6tgLb7xVbczuxF80kxhtEIeNH/pitQ8O6IqGop9A2k7QIY7LRKRlLgItP8cGb1AzeQ
         fDGOmKhNEybXHMRITcISgg4yUlmKrUHOw3d8EQqNpsZBOkdsBvaeEQOBcAvT+S5io3DE
         7I0w==
X-Gm-Message-State: AHQUAub0CnTWzTN5lZ1Jt9mtqiZ+rVFBSMOoBYbY2djOvLkkMYppcz4G
        urfrvxInyQHwaYVFfG/SljU=
X-Google-Smtp-Source: AHgI3IZaCtIC5CyA4/pgD49BKesPmkzS/NPioMK8YCwl06w0fhCsm3mqwWP81/cedYiGA1P3nOfozw==
X-Received: by 2002:a63:8441:: with SMTP id k62mr15388177pgd.219.1550449185279;
        Sun, 17 Feb 2019 16:19:45 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 16:19:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] ARM: tegra: Set up L2 cache using Trusted Foundations firmware
Date:   Mon, 18 Feb 2019 03:17:22 +0300
Message-Id: <20190218001726.16785-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra30 L2 cache should be initialized using firmware call if CPU is
running in insecure mode. Initialize L2 cache and set up the outer-cache
callbacks early during boot using the firmware API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..67d8ae60ac67 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -38,6 +38,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -70,9 +71,18 @@ u32 tegra_uart_config[3] = {
 	0,
 };
 
+static void __init tegra_trusted_foundations_l2x0_cache_init(void)
+{
+	if (IS_ENABLED(CONFIG_CACHE_L2X0) &&
+	    IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra30"))
+		call_firmware_op(l2x0_init);
+}
+
 static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
+	tegra_trusted_foundations_l2x0_cache_init();
 	tegra_cpu_reset_handler_init();
 }
 
-- 
2.20.1

