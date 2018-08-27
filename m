Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B50C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67288208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htBr7w/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67288208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeH0XtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:49:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45514 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Xs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:48:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so61775pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=bRC4We4IX5zZjxUTZwYoeC/bCsnsxV59Gv7IWcjBQEE=;
        b=htBr7w/zcjJ9UuCbLqfPq2FeWEtrR595cVRuxTzBJI9TanFpXbDXnIqZOknNR56TjK
         JJEmYzXrd3ks1zTxo+uR6CvumZViI+dJjTicQ1bTMqwbOPHKnYU59cv3OeKzmkf6TqfO
         cesdjK+THm9k1uVhxyd+GwB29j/Pt3Z+Xf8qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=bRC4We4IX5zZjxUTZwYoeC/bCsnsxV59Gv7IWcjBQEE=;
        b=NXxpaI7mK9KaCgz4yiG4qI1Gv313rH7dE24F6ZZJDemHxDVIopC+guNoybhQfPp8ui
         UJkf0HVE82joRyU6dU301LLNXB27H2oZecVw/xHnLExdTLt/xBmEtkWLAHoNrK29rkh1
         48X8OqSz9eLi3m0dlE9dsCtR+kfeiwdAbBEakrLGWbWQvet4xf/zp+x22jcgDI1R8wRP
         VAl6oCd35sm/9z+t8VpxjYMPoIKV7xCf9wPXPL2Sa/fTzk3G3FPepe8dQl8u2wI4XxCu
         lCa5igK/8XwfRAhdDDFqTN5/ssvlKJYlbnb93S+o+c0N82xtjlh8TCuRce/XpxspM7Kl
         Ln5Q==
X-Gm-Message-State: APzg51CCgjp+dm81QhFgWvR1ihpVXjwy8jtpiwh1tIPTzdwejlof1wU7
        X/Edf4hWS2UVUvZYcRA1/CgaXg==
X-Google-Smtp-Source: ANB0VdYJC77WiIr311nfbPJ+KpY3x48yBMND1yU5RgFpEbOOTWqeOZ/xK1C9XCGS/i5NWmVo777ggQ==
X-Received: by 2002:a62:c8d2:: with SMTP id i79-v6mr15641946pfk.35.1535400054796;
        Mon, 27 Aug 2018 13:00:54 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id g25-v6sm233910pfd.23.2018.08.27.13.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 13:00:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180824171432.GM5081@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-3-ilina@codeaurora.org>
 <153509896098.28926.3622217918056498792@swboyd.mtv.corp.google.com>
 <20180824171432.GM5081@codeaurora.org>
Message-ID: <153540005334.129321.18196967002233663397@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND v1 2/5] drivers: pinctrl: msm: enable PDC interrupt only
 during suspend
Date:   Mon, 27 Aug 2018 13:00:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-08-24 10:14:32)
> On Fri, Aug 24 2018 at 02:22 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2018-08-17 12:10:23)
> >> During suspend the system may power down some of the system rails. As a
> >> result, the TLMM hw block may not be operational anymore and wakeup
> >> capable GPIOs will not be detected. The PDC however will be operational
> >> and the GPIOs that are routed to the PDC as IRQs can wake the system u=
p.
> >>
> >> To avoid being interrupted twice (for TLMM and once for PDC IRQ) when a
> >> GPIO trips, use TLMM for active and switch to PDC for suspend. When
> >> entering suspend, disable the TLMM wakeup interrupt and instead enable
> >> the PDC IRQ and revert upon resume.
> >
> >What about idle paths? Don't we want to disable the TLMM interrupt and
> >enable the PDC interrupt when the whole cluster goes idle so we get
> >wakeup interrupts?
> We would need to do this from the idle paths. When we have that support
> (a patch for cluster power down is in the works), we would need to hook
> up to TLMM and do the same.

Ok so then this approach doesn't really seem to work for the CPU idle
paths.

> >Because of this complicated dance, it may make sense to always get the
> >interrupt at the PDC and then replay it into the TLMM chip "manually"
> >with the irq_set_irqchip_state() APIs. This way the duplicate interrupt
> >can't happen. The only way for the interrupt handler to run would be by
> >PDC poking the TLMM hardware to inject the irq into the status register.
> If the PDC interrupt was always enabled and the interrupt at TLMM was
> always disabled, all we would need to set the action handler of the PDC
> interrupt to that of the TLMM. I couldn't find a way to retrieve that
> nicely.

Can't we just configure a different chained IRQ handler with
irq_set_chained_handler_and_data() for each of the GPIO IRQs that are
handled by PDC to be the interrupts provide by the PDC irq controller
that match the GPIOs? And then set their parent irq with
irq_set_parent() for completeness? And also move those GPIOs from the
existing msm_gpio irqchip to a different PDC gpio irqchip that does
nothing besides push irqchip calls up to the PDC irqchip? Then we don't
even have to think about resending anything and we can rely on PDC to do
all the interrupt sensing all the time but still provide the irqs from
the GPIO controller.

> =

> >I think with the TLMM that's possible if we configure the pin to have
> >the raw status bit disabled (so that edges on the physical line don't
> >latch into the GPIO interrupt status register) and the normal status bit
> >enabled (so that if the status register changes we'll interrupt the
> >CPU). It needs some testing to make sure that actually works though. If
> >it does work, then we have a way to inject interrupts on TLMM without
> >worry that the TLMM hardware will also see the interrupt.
> =

> >
> >Is there a good way to test an interrupt to see if it's edge or level
> >type configured? And is it really a problem to make PDC the hierarchical
> >parent of TLMM here so that PDC can intercept the type and wake state of
> >the GPIO irq?
> Alternately, could we just return the PDC interrupt in gpio_to_irq() and
> let the driver manipulate only the PDC interrupt ? Ofcourse, drivers
> that request the GPIO as interrupt in DT, would now have to request the
> PDC interrupt directly. That could avoid the dance during every
> idle/suspend. I am not sure how nice it is do this, would like to know
> your thoughts.
> =


I hope it doesn't come to that.

