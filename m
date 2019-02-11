Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6571C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8760A2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lt697TZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfBKM1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:27:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40902 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfBKM0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so17010221wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=;
        b=lt697TZfEgnHkZco7R52pJxInRwx3u59akt81q+jrdp6EBmdAu7AZQzbq+b0/jUHNp
         j5xVuf/8lFcTxvgJGNFNx5e+hux7201Xya4xawCjvt7sZWxZQkLhloX8jxEzBgiR6xVo
         mK8mVEA8MxNNXxzXE7olDOXM3DV/FAmzAyjyet9slncWfcFhyyzEndUUwlO6vp2DA8QD
         TD213OjgmdVBincVwp+PO0Ph9N4fhQ2Z+86wesb9Ze389kxYI7FJvJlWdVoPAXFTufLt
         y5bjMBmZSJONrnDE3B591cs5QtcyHfxEMh2leWM/EfKGh3MA3jjGBD+v0S1MOsecJ79k
         RpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H6mmX1T1Rw0VrOeRhK3Cni5+zNNC71FKpECFu89Vdzs=;
        b=dO4Fy1gaqLpum+PUYT68SR60sX9dxn+GOaksCQEJqQxNEFVaTpBf2WvvPxlhzlKPO2
         cIjau1E4MqSd2w5403lkvTXAPCgz+xB/lLFvUQg/7F1Jtn36VaB2EkWNMYep6fWS4DTe
         qrNszY7rrs3sqT9akAI5X4C2+PSFQ8IoQ0bnJRBDmscT0Z4+xAnxnBovw4cs1BAQVh82
         QwLPO8BMqe0Uyzfu/OoHGpmiEpzgGh14AfhblUsx4yq0MqOoCE9C81ouq0QEVLJiEDNn
         EyKDjtmnrZXFR4cG4evEzhh32xGO2cBM2hLNymOB/Ww+hO/NV6ySF/arGGXl2SAi2yHs
         SpBw==
X-Gm-Message-State: AHQUAuZtrF2t9bLAAVazIWNQSgs1lxOQmuj9AANvh/4NL3YdfrJD7foz
        kQ+hjcdzDQaVQN7+vt8t7VBgrQ==
X-Google-Smtp-Source: AHgI3IZEQ0yJJz3s8V0klutMpLsQAm74CR5tSGGtHWyl4TAhVWbtq+u5mv0pmng0lskLGaYz4z/sqg==
X-Received: by 2002:a7b:c103:: with SMTP id w3mr9614921wmi.41.1549888008827;
        Mon, 11 Feb 2019 04:26:48 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:48 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 29/33] ARM: davinci: cp-intc: use readl/writel_relaxed()
Date:   Mon, 11 Feb 2019 13:26:02 +0100
Message-Id: <20190211122606.8662-30-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
and writel_relaxed() respectively. It's safe to do as there's no
endianness conversion being done in the code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index c1efb9390655..4bbf0eba1920 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -45,13 +45,13 @@ static struct irq_domain *davinci_cp_intc_irq_domain;
 
 static inline unsigned int davinci_cp_intc_read(unsigned int offset)
 {
-	return __raw_readl(davinci_cp_intc_base + offset);
+	return readl_relaxed(davinci_cp_intc_base + offset);
 }
 
 static inline void davinci_cp_intc_write(unsigned long value,
 					 unsigned int offset)
 {
-	__raw_writel(value, davinci_cp_intc_base + offset);
+	writel_relaxed(value, davinci_cp_intc_base + offset);
 }
 
 static void davinci_cp_intc_ack_irq(struct irq_data *d)
-- 
2.20.1

