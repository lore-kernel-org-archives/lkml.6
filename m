Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1775C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F54720837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQss+GGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F54720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeH3W7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:59:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35160 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeH3W7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:59:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so8147091ljg.2;
        Thu, 30 Aug 2018 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BrF6WcV23+vrlKSDi7Wjv+JCrDPaKdChRRpZISs+7No=;
        b=BQss+GGH3ZI2eMWouFwvIFbDIHw/hhZdcf4J6yLHM2LN8GGa5ZSkDz79xcPOEs2Oeg
         BqH72sWv7kLVATf+KPSGf8y9rskxRtWe5juvCE8HEMHewcRW9bZ6iRNspbfEi01fx92Q
         866pMQZCQuxyjzFuQ695idiXCuRE60bS0s/lnj242giL4AnZq8uwLMGX7dh/wpIr42zT
         B48+J6bCBWRGsvHGVLJPurutXvJaDuA85N6vZ12dqDLxLapLYCxN5tw4WZEnSyfaIBEa
         SBNYtkQ3ftV0+oxsUHC4x1Nj5YT9cqqCOY1XH8KH6NXhqb/J1/BM9Nt9d+swQhH/2Y6M
         +y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BrF6WcV23+vrlKSDi7Wjv+JCrDPaKdChRRpZISs+7No=;
        b=XNvDmJvmNe6Au/LfvUXcl8cqVAamiEmOO4lRtkDAlJl/5egEZXKmEjC1PcaYpg7wzo
         7pOGI3FsHXN3/8eY7oqKQBU9A0RgUTgn4w7VJXrUIlhxyTzSzdgOGoUVQfJUpKwT9ZCj
         EkzdhEJYQOMewfcN/I3I84MOOGfNGH9eKirIy7il27zup9cn4Rovx+YsbTJ+ks5XQIB3
         Ur2yYm065Kx4ZeUHRKkPnwwiR9zKhJUVOUrUMPLpSJJKI4wjFf9hjETe7yjeEEnTf3uN
         hpj1aOSCz0hLX0Bzuwxyd0Niq0CYVG5JbfkPxlJC6AMCnQMrTm1QovLoQPpXWPgqvSbG
         Affw==
X-Gm-Message-State: APzg51CaGy0uUn95U8xSaxyezLaNlFOb3yunsGArWJHWBr2/dylfzVCR
        fKpvuLRGaCdVjLcwGXduYR8=
X-Google-Smtp-Source: ANB0VdZS3MHwkjzy/fMNvDTod4CpXROLpAdNJHpBKOAedkkO5dvAV56AOtVG+Mm0zZHE4B6hQ52nbQ==
X-Received: by 2002:a2e:1517:: with SMTP id s23-v6mr8538412ljd.73.1535655336523;
        Thu, 30 Aug 2018 11:55:36 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1373087ljd.61.2018.08.30.11.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:55:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] ARM: tegra: Clear EMC interrupts on resume from LP1 on Tegra30+
Date:   Thu, 30 Aug 2018 21:54:04 +0300
Message-Id: <20180830185404.7224-5-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830185404.7224-1-digetx@gmail.com>
References: <20180830185404.7224-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two interrupts are raised on resume from LP1 on Tegra30+: first is the
clock change completed interrupt which is set after updating timing
configuration, second is DLL alarm interrupt which is set when DLL
starts re-calibration after being reset. Clear these two interrupts
in the end of exiting from the self-refresh mode for consistency, that
will also allow to not receive spurious interrupts in the EMC driver
after resume from suspend.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 828f6c37afde..78c6e9fb56e7 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -26,6 +26,7 @@
 #include "irammap.h"
 #include "sleep.h"
 
+#define EMC_INTSTATUS			0x0
 #define EMC_CFG				0xc
 #define EMC_ADR_CFG			0x10
 #define EMC_TIMING_CONTROL		0x28
@@ -44,6 +45,9 @@
 #define EMC_XM2VTTGENPADCTRL		0x310
 #define EMC_XM2VTTGENPADCTRL2		0x314
 
+#define EMC_CLKCHANGE_COMPLETE_INT	(1 << 4)
+#define EMC_DLL_ALARM_INT		(1 << 7)
+
 #define MC_EMEM_ARB_CFG			0x90
 
 #define PMC_CTRL			0x0
@@ -539,6 +543,9 @@ zcal_done:
 
 	emc_timing_update r1, r0
 
+	mov	r1, #(EMC_CLKCHANGE_COMPLETE_INT | EMC_DLL_ALARM_INT)
+	str	r1, [r0, #EMC_INTSTATUS]	@ clear interrupts
+
 	/* Tegra114 had dual EMC channel, now config the other one */
 	cmp	r10, #TEGRA114
 	bne	__no_dual_emc_chanl
-- 
2.18.0

