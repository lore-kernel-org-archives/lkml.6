Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1ADC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED17A20449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pcvIFAkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfBLKjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:39:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43078 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfBLKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id r2so2063799wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMy9rdFNcyWXXu44/4C8YruieLUK6NzC/y/3EwozU68=;
        b=pcvIFAkbzD6aLfI1zGuv8vmUHhLTIM6okbBOEb/cE2xXmhgJej0a97vmKnWgPsXNO/
         Z/uQ8rngSoMdD9CJH/dXBIhF/A/PsFuooj1Qp3dKesj0PiGibAmL4bjekuPa7eAPpQIa
         el62fM/Y/+xd3BC7fXdfdb/LZR8k7zAacDbKlNJ/1pMezjGu2ZPvcG9UYHzbHzHmG6I/
         B9q9I/GfljSyN2u4d3pc8ZbPxCn2WcKsQuu07izrtAuC6E4KoTRkjF+O23qXrULJm5tZ
         rLfuekc3kcuqa1ImRD3OKXoSPEjfxyxaXXMgYPxsnAfa/0bb4ykrNvIn4dbxQjZXhwte
         n6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMy9rdFNcyWXXu44/4C8YruieLUK6NzC/y/3EwozU68=;
        b=uaP2NzlUAfuAqzjx0U5aPcwnc0+ZwNt3USGl6eCA9epzj8iyN+n2Og7IIW7H700iLd
         zqrQZV6ad0dnNxFrbmwzTSyOiwVXRpljj+5G/+ZtDJQ1P+JAtWnmK8TgdZMrqyrd+c72
         SmeOEtoh5/tQ7+yZvD70tCsXQLybbJ8+L/p4wundKChNe0tDvDm+XOkBaIg8+bStwn/Q
         4W69NwsNCtnv7Kke5xDSi3eSdYx2ngg/FNlO6GSCjwBP4PGpGfYvOltjx9HmSU4gGuCh
         kJldNS6yzE6o2AZk7+1oT2Cptl/xw3XNV4NOqEb+mkqUaDX1iBLNuG+fj16achjdoJVL
         wZgA==
X-Gm-Message-State: AHQUAua02f7NWEZY5CUTbqmNZNyr0edxu/lu0q4Gcbw+Jtv2//VRMZxv
        VFBK55ZwsEBsXNhn7oJotqiZoQ==
X-Google-Smtp-Source: AHgI3IbOWiDWvI4UHOaOolrfv/BhYR63s/ALtCYeB2CrWQ3jlciMTnzRne5VZGW9zqQ7diEuIsSSXw==
X-Received: by 2002:adf:e30f:: with SMTP id b15mr2319862wrj.0.1549967976928;
        Tue, 12 Feb 2019 02:39:36 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:36 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 35/37] ARM: davinci: cp-intc: remove redundant comments
Date:   Tue, 12 Feb 2019 11:38:33 +0100
Message-Id: <20190212103835.7768-36-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We don't need comments explaining what functions with obvious names do.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index eeb3351016f0..276da2772e7f 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -57,7 +57,6 @@ static void davinci_cp_intc_ack_irq(struct irq_data *d)
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_STAT_IDX_CLR);
 }
 
-/* Disable interrupt */
 static void davinci_cp_intc_mask_irq(struct irq_data *d)
 {
 	/* XXX don't know why we need to disable nIRQ here... */
@@ -66,7 +65,6 @@ static void davinci_cp_intc_mask_irq(struct irq_data *d)
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 }
 
-/* Enable interrupt */
 static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 {
 	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET);
@@ -215,7 +213,6 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 		return irq_base;
 	}
 
-	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
 					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
-- 
2.20.1

