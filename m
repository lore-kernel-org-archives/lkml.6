Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23922082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ro4axiIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23922082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeLJRp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:45:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45286 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeLJRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:45:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so5727963pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Mqj/hInBJrqadxZw1FUKIU4EFe57TRrDWBMyK4jWzO8=;
        b=Ro4axiIXscgWZwW29Zh2WMOeJEAT1tBvzhwl/YxLwynaEnw8UW7PnCPaD2Iif/ncCf
         jG4/0Mk4/bN06c9JL/mJ1EFv/iFX36jegoeng03DKaiNomNuNM8IQ268eaCKdgDVtvdT
         oSzpUSPFoXW22zuXSlYhnnqzaNqJkuy7HbQpTM99eQZSddah7wknnGKmhsIzbicti1q4
         XDTYMJhEtrlavW7PsG9mMD87XR2JjNxNJ3KqeFwd3T3I7Sh5qy0b/Ppuih+kD6WPHcU5
         +3j/Es2l8Kekh0Mfd3YTCe9NMmw6RrGlQ+oeZrF87nBJnak2tIUvOXFVM4nVe5WJgcaE
         x75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Mqj/hInBJrqadxZw1FUKIU4EFe57TRrDWBMyK4jWzO8=;
        b=JiXG3qoexEyDCMIK/cK3qaIvxCGZjRRdpx2AirpogVcGsjNFer2pjQKN7ivvA1E7P+
         OHgpTdZPVdm7aRb9Njs3AvCZ23vKLHHRE55ofiuTk1n9bo5dxHoTApC/N/NpbeRNHR5r
         QNX4XThuDlXPzDO+bOqxuniGn7le2qqFATCzLMRgltGn4Sk2hIJboWwjmWF4hycYYUi5
         uzJxeMBV54jpkZ3iRlRU+QHOp3ls6nB4Pyi2XSNICWhxVsWs0ULts2iPEqxzAgK2Dwm6
         7VzrIDXTDw0SECCpmq1AO7+Cgf8K1RR31ADdQNuZDH969PCXjhkVZXXjLfH+3HJxsm+X
         IHbQ==
X-Gm-Message-State: AA+aEWbUNOSBvRECty42YmqA3aPuVJyPVQz+OC2RTi3aaIRszm8Z4d3w
        EalcZAMNAoDCFYoSAky5IbnW0g==
X-Google-Smtp-Source: AFSGD/VAf2Szn7csElez15lhlfrz+WSkI5N21wiVT3wuekfJfQmpu5cJXDNRgZ3lOtwpnOku90UFng==
X-Received: by 2002:a63:e156:: with SMTP id h22mr11703038pgk.255.1544463956129;
        Mon, 10 Dec 2018 09:45:56 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v9sm16920525pfg.144.2018.12.10.09.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:45:55 -0800 (PST)
Date:   Mon, 10 Dec 2018 09:45:55 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 09:40:50 PST (-0800)
Subject:     Re: [PATCH 1/5] clocksource/drivers/riscv: Change name riscv_timer to timer-riscv
In-Reply-To: <20181210165243.5625-1-daniel.lezcano@linaro.org>
CC:     tglx@linutronix.de, daniel.lezcano@linaro.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     daniel.lezcano@linaro.org
Message-ID: <mhng-fbeac354-518b-4c8a-94a3-ffc4f7a9dfd8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 08:52:38 PST (-0800), daniel.lezcano@linaro.org wrote:
> In order to unify the names in this directory, let's rename the driver to be
> prefixed with timer-*
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/Makefile                         | 2 +-
>  drivers/clocksource/{riscv_timer.c => timer-riscv.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/clocksource/{riscv_timer.c => timer-riscv.c} (100%)
>
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index dd9138104568..ddf697b29df9 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -78,6 +78,6 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
>  obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
> -obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
> +obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
>  obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
>  obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/timer-riscv.c
> similarity index 100%
> rename from drivers/clocksource/riscv_timer.c
> rename to drivers/clocksource/timer-riscv.c

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
