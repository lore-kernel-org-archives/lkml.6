Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E569C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F5E222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="N6LgMgUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501900AbfBNOxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:53:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38896 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439643AbfBNOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:53:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so6384659wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwmA55py1DDIb9fQ+5X5dpksNWX0bjdVZC1l1Y9UfNg=;
        b=N6LgMgUTg+IZYFt1oItzJT+GVnkquYSUpsRiAzEskKWsnn9GKKLqkfTnLEYL55NRvt
         nZLAORkcFV6pE5JPEOqswH6+C4rn32KNWjBR02E8bag/gNt1JkL5DuyJ8T32Wz/L29fJ
         XKPbrErYXUQSpj6vJIQN8g+0wqfhvzlmBdd933MsuyYMqK7++/pPyK1TcFuO4bKuxshm
         tp9UO+h3u9EovUU6bzJWzLuXEnDyl3mTeOPzzbJ8yuZ0hPjWB73r/7aZFyWS/Ia/FfYI
         0mDDzWVdwiGaOLHAFRPJPmXudu6r69OpjBDi9jHMh4sut43DVc3OstmqZs0RneJGQ0VT
         Sv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwmA55py1DDIb9fQ+5X5dpksNWX0bjdVZC1l1Y9UfNg=;
        b=PxQwdiE1orqt8PyPZ7wFO0xA6/pCZoY/v30Unhxbgk6XhaxPVzDsN4rw0fD+scKMBF
         PaqNxzbeYtaK6L9mSEdsceXU6p5az1/OFa3/KITBCyf8w5HlDBTyUk8uftmiTKpW1pHL
         wwxMUCWaEEpTDKVBESbVrDSoJptzW13fiAn8/nprfZjUqOtXleKcmdwaLj+6W2678oYq
         tw0UbQRo8rgcJGUB+eItkGcuXMZ3L8PU4M0KS4pesU+yoGbD1MBnWg3t2YBJ2lIquQJq
         tYNFBl0A7myo+SG0bwX2GiapGVz/E7QjUB3bIbA0xXpyGUbK4qGSWRT93DmotffSN5pV
         rOTg==
X-Gm-Message-State: AHQUAuZ4V8iNCxD/8N9+wjFyk0kna7vAbxelDVFrMbPiefrzXqkLSMOp
        qN/dPTamfpObkEKGQB0XNBeSzic6FeU=
X-Google-Smtp-Source: AHgI3IYYKY32gqWw7jHi8P2zRTLmHHDukiDKhcI8CUc4XNefmXsaDTt25Daz2M+QWuSENJPiLXvSKQ==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr3157487wmf.38.1550155998500;
        Thu, 14 Feb 2019 06:53:18 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:53:17 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 30/37] ARM: davinci: cp-intc: request the memory region before remapping it
Date:   Thu, 14 Feb 2019 15:52:24 +0100
Message-Id: <20190214145231.8750-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a missing call to request_mem_region() before calling ioremap() to
make sure it's not been requested by another user.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index f56a4275083f..6ab56af3be6b 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -164,6 +164,15 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 {
 	unsigned int num_regs = BITS_TO_LONGS(config->num_irqs);
 	int offset, irq_base;
+	void __iomem *req;
+
+	req = request_mem_region(config->reg.start,
+				 resource_size(&config->reg),
+				 "davinci-cp-intc");
+	if (!req) {
+		pr_err("%s: register range busy\n", __func__);
+		return -EBUSY;
+	}
 
 	davinci_cp_intc_base = ioremap(config->reg.start,
 				       resource_size(&config->reg));
-- 
2.20.1

