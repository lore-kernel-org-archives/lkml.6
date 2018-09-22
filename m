Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49582C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34A32150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 11:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpFW4xbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34A32150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeIVRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 13:23:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38791 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeIVRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 13:23:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id h33-v6so12701613edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zeEu7IwRJbSkYrhFBI6QsA/kCEjV9MoFaatcSZMeNSI=;
        b=kpFW4xbfy8d3locCdB2BBLfcz2tJl97evQ13uCUDtUcCMGbIxqJHahp+6p9VcOnqVB
         uld8I8P5gvMK53ZzFbxrrucwzI1gHsKoWHeoUz29ZiHmzS4+tdut9Ml9xgInCN3pK65S
         e09tXxt3LipqfYz+iWaTfbhO6XrLok/2n0nMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zeEu7IwRJbSkYrhFBI6QsA/kCEjV9MoFaatcSZMeNSI=;
        b=MXQ64OWtdomp/5eZxg5Y0Kj9tYhWLhAYJODHnSjQmcmugbsljVj0qvOUTcuxKjT2gv
         QfMQK8bRqjwAT0jtV5OXRdPXzpsYfySurDRQy1S+nwbD+nQYOQGutWySjQ+yEs3/qk9a
         86ET2ejFP/GLCwtF0JvY5P4v/nC1GIvth4x+ZZkXw5HZA/pTd/keE00o9R7WUvCNrB1i
         hBHXg2XfD63hJdMn1siuL30NSYO6ocnGPv9CIzeBW7e1zhBr2EJPRTAy4bDeWVPXQRCj
         YMRJTTHSWr3jOZ4v2ed9qiXfQ5yrTtAkdA9wTsRll1slNsElQK40hSQcpP5CfOhyc+L0
         /kBQ==
X-Gm-Message-State: ABuFfojbkhGUiUc4vsL3k+UphmSPc/V+M1fBO6gpejKK4HmWWI3sP/TM
        IJ3iMaqiPK5GCNUmfRy/E2nSdtMAGTJ1Fw==
X-Google-Smtp-Source: ACcGV61/0AKj/2wACV5e2OIEtBjzZeizYijoJuiclpaBXAGGFshDOW8zAgUif019keZiq8NPjZZ6zA==
X-Received: by 2002:a50:8612:: with SMTP id o18-v6mr3334415edo.111.1537615791085;
        Sat, 22 Sep 2018 04:29:51 -0700 (PDT)
Received: from [10.22.99.68] ([89.248.140.14])
        by smtp.googlemail.com with ESMTPSA id s41-v6sm3926494edd.61.2018.09.22.04.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 04:29:50 -0700 (PDT)
Subject: Re: [PATCH v7 0/7] clocksource: rework Atmel TCB timer driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5f19043a-3be3-e25a-849f-6ca610ed6da2@linaro.org>
Date:   Sat, 22 Sep 2018 13:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2018 13:30, Alexandre Belloni wrote:
> Hi,
> 
> This series reworks the Atmel TCB drivers. It introduces a new driver to handle
> the clocksource and clockevent devices.
> 
> This is necessary because:
>  - the current tcb_clksrc driver is probed too late to be able to be used at
>    boot and we now have SoCs that don't have a PIT. They currently are not able
>    to boot a mainline kernel.
>  - using the PIT doesn't work well with preempt-rt because its interrupt is
>    shared (in particular with the UART and their interrupt flags are
>    incompatible)

You say for rt the PIT is not suitable because of the shared irq but in
the driver, the interrupt is flagged as shared.

>  - the current solution is wasting some TCB channels
> 
> The plan is to get this driver upstream, then convert the TCB PWM driver to be
> able to get rid of the tcb_clksrc driver along with atmel_tclib now that AVR32
> is gone.
> 
> changes in v7:
>  - fixed a warning when building on 64 bit platforms
> 
> changes in v6:
>  - rebased on v4.19-rc1
>  - separated the clocksource/clockevent and the single clockevent in two
>    different patches
>  - removed struct tc_clkevt_device and simply use struct atmel_tcb_clksrc
>  - removed struct atmel_tcb_info
>  - moved tcb_clk_get and tcb_irq_get to users
> 
> changes in v5:
>  - rebased on v4.18-rc1
>  - fixed the clock enabling/disabling in atomic context under preempt-rt
> 
> Changes in v4:
>  - rebased on top of v4.17-rc1
>  - fixed an issue when setting max_delta for clockevents_config_and_register
> 
> Alexandre Belloni (7):
>   ARM: at91: add TCB registers definitions
>   clocksource/drivers: Add a new driver for the Atmel ARM TC blocks
>   clocksource/drivers: timer-atmel-tcb: add clockevent device on
>     separate channel
>   clocksource/drivers: atmel-pit: make option silent
>   ARM: at91: Implement clocksource selection
>   ARM: configs: at91: use new TCB timer driver
>   ARM: configs: at91: unselect PIT
> 
>  arch/arm/configs/at91_dt_defconfig    |   2 +-
>  arch/arm/configs/sama5_defconfig      |   2 +-
>  arch/arm/mach-at91/Kconfig            |  25 ++
>  drivers/clocksource/Kconfig           |  13 +-
>  drivers/clocksource/Makefile          |   3 +-
>  drivers/clocksource/timer-atmel-tcb.c | 617 ++++++++++++++++++++++++++
>  include/soc/at91/atmel_tcb.h          | 183 ++++++++
>  7 files changed, 841 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/clocksource/timer-atmel-tcb.c
>  create mode 100644 include/soc/at91/atmel_tcb.h
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

