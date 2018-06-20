Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE5AC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9135D20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltWH/oIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9135D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbeFTQhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:37:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37783 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbeFTQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:37:19 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6-v6so188025wrp.4;
        Wed, 20 Jun 2018 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=heUlefXVeVr7ZSpoHl63kOfpk0kzmwVF3vQ9Cuq9Wdw=;
        b=ltWH/oILqD0OP4lcIyPu+qCFXUUVJkj/HwrR4V/x8vyPLaHQk3T93jEuu1qNrHo9zq
         SNC3m91D2KYG7AR4JjwCjONVaGxUVR+TyD8clDv8MadeKuuksA4BDPyTm90sZ0x2smof
         yNJIDN/oQLd/NmdnLKZxlR6M+uq3tk1h6Z0sqYhjqlLW5dAyCkX2JGBrFK+crJbvnTCE
         PwcERJ58KXgwT5XPxpHaZbo3UJmp47AIgNCb+MKzUhtjSnhjc5Ogn0Mtlt2vUI7oxDyy
         iy1mGpcn8ca9w06PN8mAQkLzYFjDgeRWAod3rLc6MDG/QWwRZ52qcxr5vhBJWxXVnSnr
         Zo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=heUlefXVeVr7ZSpoHl63kOfpk0kzmwVF3vQ9Cuq9Wdw=;
        b=V9Ac9AWGKZNJ5JOGoqvlfPdX91OZHjP/FWwIi6NRRJ2R6YL7yHE8HP5WZhwatW+iJP
         TQ2lGpDh1k/UsBJUeJKUSF6q37yxafWn0yWIWGqKnLleN8JaVAM23FcMEWkS1MWXDNTh
         wlP8iaFt3m1NMUis+tmyMfCQo3zFqIiR1WoYp/cjc+W2b3YWqYHZTU8A1F4AvpdgEp2e
         Va+hPz9wVs84bGFbmJcxCQVrW67DbP0bfkSCpJmo1G071F+RfwLxzOmd203Xzl9hkWsD
         SAl9wvKmbrG035xwL3vnpLwPcV2HRjFAtlL5Qo3oPWfGQZphFHxQ1XOMfOXZ3hMZdoVp
         in+Q==
X-Gm-Message-State: APt69E2d8CDNRU4rkO67ZW12k4/VBB8YoRC6LI3YPAuL3xGxCicbjFgw
        KDHeN9ZRCcySk4kUGHcLIFth6uz8bis9P1u/X6G/ow==
X-Google-Smtp-Source: ADUXVKKjWGT4RL3b5sBwy33KEXbo6s0P7AGE4G3QHWU6qU8IQcENqDYTjetR1/zRguR40lzuIL4KT+MtPzAylmlFgmY=
X-Received: by 2002:adf:9525:: with SMTP id 34-v6mr17422968wrs.99.1529512637825;
 Wed, 20 Jun 2018 09:37:17 -0700 (PDT)
MIME-Version: 1.0
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Wed, 20 Jun 2018 18:37:06 +0200
Message-ID: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
Subject: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
To:     LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
Cc:     "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to fix warning (for omap5 board) produced by recent change
to avoid using IRQ_TYPE_NONE like:
[    1.818666] WARNING: CPU: 1 PID: 778 at
drivers/irqchip/irq-gic.c:1016 gic_irq_domain_translate+0x78/0x100
[    1.828839] Modules linked in:

I did look to other commit which did update and without deep knowledge
I just simply do this small change:
diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi
b/arch/arm/boot/dts/omap5-board-common.dtsi
index 218892b..ab2df8c 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -393,7 +393,7 @@

        palmas: palmas@48 {
                compatible = "ti,palmas";
-               interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* IRQ_SYS_1N */
+               interrupts = <GIC_SPI 7 IRQ_TYPE_HIGH>; /* IRQ_SYS_1N */
                reg = <0x48>;
                interrupt-controller;
                #interrupt-cells = <2>;

and it looks board boots fine. Only issue is that gpadc driver is not
working (at least not getting interrupts at all ADC fails with
timeout). I did look to gpadc driver and driver is not using
interrupts defined in dts but request interrupt directly from palmas
mfd module. Any ideas what needs to be changed to have gpadc again
working with mentioned patch?

I tried to use also IRQ_TYPE_LOW but in this case board cannot mount
rootfs so I was thinking this is not way to go.

Thanks for any hints.

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
