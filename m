Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C2C04AB9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358B0208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D1lKNXhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358B0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeHXL4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:56:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32892 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbeHXL4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:56:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so4206765pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=BYbArSWLlD9BeWe+HSmpb3sGYvyY6JnBEUU2tEHyIuc=;
        b=D1lKNXhIlfiEsbgcoupszN7CKxJ68V3x0gDtzaLQGzIdlGaAPdZq0+CxV7xmBfhoPP
         LJuH7mgx0cRZYGlegI9eO+qgk2TLc/rtZTZMpseXPf7UvWpb/Urmq0W1s/Ml+rtGhhtw
         xJ5kJUZGFLVT1VQLJs7VpxaN7mNDUcXFNCCSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=BYbArSWLlD9BeWe+HSmpb3sGYvyY6JnBEUU2tEHyIuc=;
        b=VkC7sDvXoa7Jjogr+qUmKcnbS9r1Aeuui0GaVSO7RlB8HcrNmhYwvyr5vPpa4N1toA
         V0b4m7in6KzZKEe5XY4HI77zHDSDC/XHJD4RXft2C+lUU43wqLIxCkJzxstMYWV/JFJQ
         ivDkyCcKkmRFoAe0s5NhfXIBESsJ1dk4qAZEv5O+fFLwEDVvd7EtS0Cg2jUXC/p2ZYzS
         zh+O0NKU+I8qoAsXOjHvDtMMiH8/aSZxxdoBwCff1jZ1mLrg3E9pRwwb/6Ratt7YHM7A
         +1CBK3RnY1M4qoAgY574lhhni3MWhTIX0ldzLEZ3luc35+/BvbkjNULNb51rXd7d+60m
         Uo5g==
X-Gm-Message-State: APzg51C3vZaGE2uyZD+53Arn0Nmn5ouv42H9BytRAEo0rPBcMuF50Ufl
        Q+CeJUj5ST0onkT6Op4PQVgF/A==
X-Google-Smtp-Source: ANB0VdYgrJUXzvDx0ws5krNbOGbQc2djtU6zcLjdbj568xF0M+EC+6y6SrMTGOzULdjFoJ3SaRT+Xg==
X-Received: by 2002:a62:54c7:: with SMTP id i190-v6mr789955pfb.155.1535098962546;
        Fri, 24 Aug 2018 01:22:42 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id 1-v6sm13846561pfk.134.2018.08.24.01.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 01:22:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        marc.zyngier@arm.com
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180817191026.32245-3-ilina@codeaurora.org>
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-3-ilina@codeaurora.org>
Message-ID: <153509896098.28926.3622217918056498792@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND v1 2/5] drivers: pinctrl: msm: enable PDC interrupt only
 during suspend
Date:   Fri, 24 Aug 2018 01:22:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-08-17 12:10:23)
> During suspend the system may power down some of the system rails. As a
> result, the TLMM hw block may not be operational anymore and wakeup
> capable GPIOs will not be detected. The PDC however will be operational
> and the GPIOs that are routed to the PDC as IRQs can wake the system up.
> =

> To avoid being interrupted twice (for TLMM and once for PDC IRQ) when a
> GPIO trips, use TLMM for active and switch to PDC for suspend. When
> entering suspend, disable the TLMM wakeup interrupt and instead enable
> the PDC IRQ and revert upon resume.

What about idle paths? Don't we want to disable the TLMM interrupt and
enable the PDC interrupt when the whole cluster goes idle so we get
wakeup interrupts? It's really unfortunate that the hardware can't
replay the interrupt from PDC to TLMM when it knows TLMM didn't get the
interrupt (because the whole chip was off) or the GIC didn't get the
summary irq (because the GIC was powered off). A little more hardware
effort would make this completely transparent to software and make TLMM
work across all low power modes.

Because of this complicated dance, it may make sense to always get the
interrupt at the PDC and then replay it into the TLMM chip "manually"
with the irq_set_irqchip_state() APIs. This way the duplicate interrupt
can't happen. The only way for the interrupt handler to run would be by
PDC poking the TLMM hardware to inject the irq into the status register.
I think with the TLMM that's possible if we configure the pin to have
the raw status bit disabled (so that edges on the physical line don't
latch into the GPIO interrupt status register) and the normal status bit
enabled (so that if the status register changes we'll interrupt the
CPU). It needs some testing to make sure that actually works though. If
it does work, then we have a way to inject interrupts on TLMM without
worry that the TLMM hardware will also see the interrupt.

Is there a good way to test an interrupt to see if it's edge or level
type configured? And is it really a problem to make PDC the hierarchical
parent of TLMM here so that PDC can intercept the type and wake state of
the GPIO irq? Plus there's the part where a GIC SPI interrupt runs for
some GPIO irq, and that needs to be decoded to figure out which GPIO it
is for and if it should be replayed or not. Maybe all types of GPIO irqs
can be replayed and if it's a level type interrupt we waste some time
handling the PDC interrupt just to do nothing besides forward what would
presumably already work without PDC intervention.

