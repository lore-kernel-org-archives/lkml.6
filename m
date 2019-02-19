Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40530C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBEB21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys6BnvJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfBSK7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:59:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33450 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSK73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:59:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so21740316wrw.0;
        Tue, 19 Feb 2019 02:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Aj3OwHFXh3vHhP2e/NU23hGqOlhc3DlhyNrwCMzf4o=;
        b=Ys6BnvJNGIN5ssCTtt8gZMoVHcrNv5gQkDJWO8u+Av/7U91esLtkrmdnS2QTZ1ZjhH
         TnSkWo8bzyb+tVwA/xTEbbtXrQHBKmWjSyVPDawrQ0h4Iux0pib38JUzig5QkQCQl0yX
         hsxaIXkQikzc/EpeptFb2cezOur+FPbFHvy64+tbJS4GsOvMCVzmeaYhxT8xys4jGEq9
         DYNQib6r9Y0UWjfvUWWEUtqHMGmAR6qjWni7MbO9yyopfUiskmjIi+xVIEP0fnV5IVF7
         ahVCep8LeXeN+wiJtJuJ1xWFT9Dd+u1Fad1s7PrBOKEl9oqRcY3oFefn03/gGKnigk0k
         zbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Aj3OwHFXh3vHhP2e/NU23hGqOlhc3DlhyNrwCMzf4o=;
        b=Q9EqHIMjE8Rvgr/nsVBlpy5nc2lIQK4b33Bq4H/xtksnnf7ndC9SsXZVzqrvmjqZKt
         KtLVL7E6CDnft5dWq0BvYCWi9rygeKN42z5pYneJK5TiYHeV1uDHi3Rp0+YFNBFXATfK
         aLUXxgoO+juYastyoQQNcuIfYTG2BDil5XHGw+uW8QCYbXQ8VwEjM7cgl7AnWlD02KKn
         e8tV9qc+EM3ZIi9Mqv1bkiIs0mRQPp9MTYxoE7jGSOasUuHhT9E09tYPUyrjz0WZP3XN
         LIDBd6jUHMm1RVYjpWr2FK3YxIbCi0MR6sUqWY2f4uz0rV00lWJZj+YhFIOqhQwCr+Yd
         bnPQ==
X-Gm-Message-State: AHQUAubvGiiGk0br9Nn2slx3Yje64dj/l5cGXlo55K/a0vGMqWcVSWOr
        e168326hsLT9QrqP6q4woPw=
X-Google-Smtp-Source: AHgI3IYi/Lofch2D/2VM4qXM5QGt3WFdrI/x5aGz7wgLBaTtJXXMwRXJGWFUVXMbUfSM0F6SFVIwow==
X-Received: by 2002:adf:fdcd:: with SMTP id i13mr1637897wrs.212.1550573967496;
        Tue, 19 Feb 2019 02:59:27 -0800 (PST)
Received: from localhost.localdomain ([85.204.4.237])
        by smtp.gmail.com with ESMTPSA id s127sm2066851wmf.39.2019.02.19.02.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:59:26 -0800 (PST)
From:   Leonard Crestez <cdleonard@gmail.com>
To:     Daniel Kurtz <djkurtz@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        Nitesh Kumar Agrawal <Nitesh-kumar.Agrawal@amd.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RFC] pinctrl/amd: Clear interrupt enable bits on probe
Date:   Tue, 19 Feb 2019 12:59:15 +0200
Message-Id: <2155095e66a8b6329fa6b316b0e9ecd4b6d0c9bb.1550573871.git.cdleonard@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Acer Nitro 5 AN515-42 laptop with a Ryzen 2700U hangs on boot because
of spurious interrupts from pinctrl-amd.

This seems to happen because the touchpad interrupt is enabled on boot
in "level" mode and there is no way to clear it until a touchpad driver
probes.

Fix by disabling all gpio interrupts at probe time until they are
explicitly requested by drivers.

Signed-off-by: Leonard Crestez <cdleonard@gmail.com>

---

It's strange that nobody else has run into this problem, AMD hardware is
relatively common. Maybe firmware generally disables GPIO interrupts
itself?

This patch fixes boot but this same laptop has other issues:

 * Suspend is broken
 * Ethernet is broken (only sometimes)
 * The CPU freq gets stuck at 400 Mhz (sometimes)

Those issues happen on maybe 80% of boots without a clear pattern. It
seems that inserting/removing the ethernet jack during boot helps
cpufreq? It's possible that these problems are also caused by pin
misconfiguration so this fix might be incomplete.

When the cpufreq issue happens `rdmsr 0xc0010061 -a` shows 0x22 for all
cpus; maybe this is some broken thermal throttling?

Also, perhaps amd_gpio_irq_disable_all should enumerate in a nicer less
verbose way?

Previously: https://lore.kernel.org/patchwork/patch/1028047/

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 2a7d638978d8..3cb7ea46f32c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -592,10 +592,53 @@ static irqreturn_t amd_gpio_irq_handler(int irq, void *dev_id)
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 
 	return ret;
 }
 
+static void amd_gpio_irq_disable_all(struct amd_gpio *gpio_dev)
+{
+	unsigned int bank, i, pin_num;
+	u32 regval;
+
+	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
+		switch (bank) {
+		case 0:
+			i = 0;
+			pin_num = AMD_GPIO_PINS_BANK0;
+			break;
+		case 1:
+			i = 64;
+			pin_num = AMD_GPIO_PINS_BANK1 + i;
+			break;
+		case 2:
+			i = 128;
+			pin_num = AMD_GPIO_PINS_BANK2 + i;
+			break;
+		case 3:
+			i = 192;
+			pin_num = AMD_GPIO_PINS_BANK3 + i;
+			break;
+		default:
+			/* Illegal bank number, ignore */
+			continue;
+		}
+
+		for (; i < pin_num; i++) {
+			unsigned long flags;
+			raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+			regval = readl(gpio_dev->base + i * 4);
+			if (regval & BIT(INTERRUPT_ENABLE_OFF)) {
+				dev_info(&gpio_dev->pdev->dev,
+						"Pin %d interrupt enabled on boot: disable\n", i);
+				regval &= ~BIT(INTERRUPT_ENABLE_OFF);
+				writel(regval, gpio_dev->base + i * 4);
+			}
+			raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+		}
+	}
+}
+
 static int amd_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct amd_gpio *gpio_dev = pinctrl_dev_get_drvdata(pctldev);
 
 	return gpio_dev->ngroups;
@@ -910,10 +953,12 @@ static int amd_gpio_probe(struct platform_device *pdev)
 
 	ret = gpiochip_add_data(&gpio_dev->gc, gpio_dev);
 	if (ret)
 		return ret;
 
+	amd_gpio_irq_disable_all(gpio_dev);
+
 	ret = gpiochip_add_pin_range(&gpio_dev->gc, dev_name(&pdev->dev),
 				0, 0, gpio_dev->gc.ngpio);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add pin range\n");
 		goto out2;
-- 
2.20.1

