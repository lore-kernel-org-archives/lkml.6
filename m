Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE1AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB93222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ieKkc0Mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439485AbfBNOws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:52:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37818 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439459AbfBNOwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:52:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so6327191wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
        b=ieKkc0Mnxet5iCwBWminNdy4Nn2hXtoOzFqjEhIH6Thmpw6l+nRcAhLWaKI29CIaaa
         ObznPZ0b7EN6P/s4jleBeLumohVMhD/BJPZCZkiHgDlImKFV0HDiRtsbmYY2BLv3P6L/
         FcZfI+SFmFLdErUC6BMyzoqMEZftoiN2s0ZTAdjp1YNTMWcbuzzDymfOI8TOADyUwWfb
         l8+TsW8kN2nJM8EaJKTEqWyuesuEsc6V5ITpXpVhimjIIMo9s974Rq5IZ1by7DCBTxxn
         gx3YxySGFe+6SXE2GqyvC30bLv1dDidXqrzc+zyL3wm6CuXqtLuSO3f0RuFcjWm96vI5
         PwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQpTYNOFF/xBKJ0FliQbJ6ZdH9bqB2OMp9FtFZp2/A0=;
        b=EGM4d8SKFCfViWgNwCcVav53v8oQFjSSYUlk7epxKwBdB+H9jhjG6QNtyigHw5F/tD
         XHh4j4VySRt+TArOFCTxEGnA8J3gvyqvB9+adGqhOuitilkj9JOxNugORGkgdWSxqgUy
         qpCOSaltpgiDxrbMXy4pn/jFp3lTN8CCW1PTL8etlDqH9eTE/pYdpvuxMa0AwXovZdit
         GI0YYdzTddt93KLJWGIaX4gXJ08jrKNS7eFBObOAxWb+K3aX1uGbEgK+6hDT0bO7+SnV
         zfuwikSSMGb/JGZSs8zOf5VJOJRWqMNNQH0HAoY34mxb+78wfKt17OkYy8Rc/+D6Hg/V
         ov0Q==
X-Gm-Message-State: AHQUAuaHf8EHmMjzagJke2Tgdh38W3nR9+5o6txb4t18f1QLU75Xkzo0
        71fX9OAKYKZQ0QRLrPCJsygzA1g+S1E=
X-Google-Smtp-Source: AHgI3IZMoWnH8YrM2IYFL1w/iZIhYKC9gwErjBprWEuhbgAkvpogJI6slVcXPIoCNPG74uADWOkrvw==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr996937wmg.144.1550155964651;
        Thu, 14 Feb 2019 06:52:44 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:52:43 -0800 (PST)
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
Subject: [PATCH v4 02/37] ARM: davinci: remove intc_host_map from davinci_soc_info struct
Date:   Thu, 14 Feb 2019 15:51:56 +0100
Message-Id: <20190214145231.8750-3-brgl@bgdev.pl>
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

The intc_host_map field in struct davinci_soc_info is not used by any
board. Remove it as part of the interrupt support cleanup.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 5 -----
 arch/arm/mach-davinci/include/mach/common.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 94085d21018e..67805ca74ff8 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -117,7 +117,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
-	u32 *host_map		= davinci_soc_info.intc_host_map;
 	unsigned num_reg	= BITS_TO_LONGS(num_irq);
 	int i, irq_base;
 
@@ -182,10 +181,6 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 			cp_intc_write(0x0f0f0f0f, CP_INTC_CHAN_MAP(i));
 	}
 
-	if (host_map)
-		for (i = 0; host_map[i] != -1; i++)
-			cp_intc_write(host_map[i], CP_INTC_HOST_MAP(i));
-
 	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index b577e13a9c23..944afd57ee38 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -61,7 +61,6 @@ struct davinci_soc_info {
 	int				intc_type;
 	u8				*intc_irq_prios;
 	unsigned long			intc_irq_num;
-	u32				*intc_host_map;
 	struct davinci_timer_info	*timer_info;
 	int				gpio_type;
 	u32				gpio_base;
-- 
2.20.1

