Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BA1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22692147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Lxqk8665"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfBSQHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:07:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36946 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfBSQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:06:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so22588925wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/8pB33KMIJ5zXoSB9u9TfOpy7x+4rvO5Vd6nd9n/qY=;
        b=Lxqk8665bM0VzvGAQ62nwsFElvlMyPDJd627oEUO9Ezqk0SUdrdorFJizWOp4759m3
         66tgLbF8MUYmGCXP7DNMEjcXNhFxIk+5v4EUQW7R0LQ7FVyWJXH6kV2kgvFcnymq1hDM
         gwTO2/18WStArOROg1MbvIl4UKNwaw5f8ML84/HvXixPRfoQfj3g9c+G4uJpqy1HsJnK
         9KTpxG2q0lBohR+rvWa6rexsoVcr1sjKH4vCt0wGeS3PAex871DKKexM/jklKH8N8Ef4
         jkS4tzr2QChPfZfxS3Ljl6ynwpJBG26+49Hqms+Fl+1UcFCgmA0f0IVRPl/89AvTby3G
         NwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/8pB33KMIJ5zXoSB9u9TfOpy7x+4rvO5Vd6nd9n/qY=;
        b=olow3nI85dLwK0Bpi2y6Q1qaLbbQqfwV0ad6KMF1uABAPlGS2wz36fNQtnP9NmEjcb
         4wT3+UjOfMLl2Akg8+rZCaydTB+x6qW1jOAFeyQzcI9o7pGl7FqvRRl5IVhnNdP0bEXC
         ZZXI9oxQO+VeikcVG/99d/ZOblLZThwJZY868x1TLoQ6+w7U4N3HU5y+z4McvBTt6XlZ
         8qA5PBDg4pK6yiu+2xokau0lxkKqoTcV7GHC9T3m0H3+KEvLUKWhHlLVPyrqplhyQgTP
         sI34PUgPbLHBPH1aZegJmlJLhPUPFWTIL/jaE5M6z/K2qqve+NFeu39tj10W/VVhdTPt
         /Aqg==
X-Gm-Message-State: AHQUAuZbeGMKok0sUD39Mjit2IKqDCx83z8nxDCyYwdemZlAdZMJarzg
        X0RU+06bwJ29tUoQNnH6JCN7Iw==
X-Google-Smtp-Source: AHgI3IZBdUvC2jfzpcSkpdA7/RXbHqOvqiUkHCs3JINhn5uytsWY7FcAipkREv1DHgyu2igeeqwyGg==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr6977237wrq.305.1550592416959;
        Tue, 19 Feb 2019 08:06:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id h17sm12161381wrq.17.2019.02.19.08.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 08:06:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 1/7] irq/irq_sim: add irq_set_type() callback
Date:   Tue, 19 Feb 2019 17:06:44 +0100
Message-Id: <20190219160650.9614-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219160650.9614-1-brgl@bgdev.pl>
References: <20190219160650.9614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement the irq_set_type() callback and call irqd_set_trigger_type()
internally so that users interested in the configured trigger type can
later retrieve it using irqd_get_trigger_type(). We only support edge
trigger types.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 kernel/irq/irq_sim.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 98a20e1594ce..b992f88c5613 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -25,10 +25,22 @@ static void irq_sim_irqunmask(struct irq_data *data)
 	irq_ctx->enabled = true;
 }
 
+static int irq_sim_set_type(struct irq_data *data, unsigned int type)
+{
+	/* We only support rising and falling edge trigger types. */
+	if (type & ~IRQ_TYPE_EDGE_BOTH)
+		return -EINVAL;
+
+	irqd_set_trigger_type(data, type);
+
+	return 0;
+}
+
 static struct irq_chip irq_sim_irqchip = {
 	.name		= "irq_sim",
 	.irq_mask	= irq_sim_irqmask,
 	.irq_unmask	= irq_sim_irqunmask,
+	.irq_set_type	= irq_sim_set_type,
 };
 
 static void irq_sim_handle_irq(struct irq_work *work)
-- 
2.20.1

