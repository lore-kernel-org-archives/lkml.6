Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FFDC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DCD2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="if60d84o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DCD2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbeKMViL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:38:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35828 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbeKMViL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:38:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15-v6so11144352wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xW6ayJFNfSpdAxXQbKwY2qo07bP7V98pQullVRObMbA=;
        b=if60d84o+MbDKYDP7Ju5Ubre5Rk4Z2KFoWYryryDdINL1zrtUGd1FTO13bULf2oIjG
         /8jmvYrFoqaxv+mkLUiTyZFdPUpHOk4PG7MN1vpg2iLfETuJrUIGrWCIS0Zmm48+FPmn
         OcZXvqbGevfsCRadWRunDzhN5JXwA7+QUm6oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xW6ayJFNfSpdAxXQbKwY2qo07bP7V98pQullVRObMbA=;
        b=sQlnfQYHbrFH30BRjZv9X0ogNeNi+s/TP10t5VhhqIpmwljosSqG5zcqyU++q+OFS4
         v1X5LPieKhGLmx4pFSG5mIa7z+q8667NiFB1yodSU1wEw+5qB5SpO1x8uh/t5mh+fvlQ
         hraA4fJThbm1iSXRUEvd5l7+NnyjzKQwfYjCV7EzAj/od2abBH7oP2WFL+TzZbTsKSkX
         6PVYV/a/1dXZ2np0Yq480b5D0HeYogvWMS1tlKdvAPC8/kkYM7WwXfSUercNd+Suyx8j
         GCzFFZj3MI8Mt+KRkzq6SqrRCpPgT6pcVfWkbwLAubRwRhsvaUqRIeVmuw9PRz/M4gT5
         rXIA==
X-Gm-Message-State: AGRZ1gI3h28dOUqPwDGS8sMRfamX+7cOTYZ3AVPqS51xgtfzE3EPnX72
        dDGhLC2P6iIg+ytFBCZrSLMV+Q==
X-Google-Smtp-Source: AJdET5f7G/h+g/3+nyodAc8OlSVO1GB9TGbFr0iZMvSXOIZaWc+o1rCNWisfCmEpZKj0khYDLxUdxQ==
X-Received: by 2002:a1c:f30b:: with SMTP id q11-v6mr2886147wmq.45.1542109225111;
        Tue, 13 Nov 2018 03:40:25 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id b10-v6sm14423698wrt.49.2018.11.13.03.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 03:40:24 -0800 (PST)
Date:   Tue, 13 Nov 2018 11:40:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] mfd: tps6586x: Handle interrupts on suspend
Message-ID: <20181113114022.GD3513@dell>
References: <1542099391-7338-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542099391-7338-1-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018, Jon Hunter wrote:

> From: Jonathan Hunter <jonathanh@nvidia.com>
> 
> The tps6586x driver creates an irqchip that is used by its various child
> devices for managing interrupts. The tps6586x-rtc device is one of its
> children that uses the tps6586x irqchip. When using the tps6586x-rtc as
> a wake-up device from suspend, the following is seen:
> 
>  PM: Syncing filesystems ... done.
>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>  OOM killer disabled.
>  Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
>  Disabling non-boot CPUs ...
>  Entering suspend state LP1
>  Enabling non-boot CPUs ...
>  CPU1 is up
>  tps6586x 3-0034: failed to read interrupt status
>  tps6586x 3-0034: failed to read interrupt status
> 
> The reason why the tps6586x interrupt status cannot be read is because
> the tps6586x interrupt is not masked during suspend and when the
> tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
> seen before the i2c controller has been resumed in order to read the
> tps6586x interrupt status.
> 
> The tps6586x-rtc driver sets it's interrupt as a wake-up source during
> suspend, which gets propagated to the parent tps6586x interrupt.
> However, the tps6586x-rtc driver cannot disable it's interrupt during
> suspend otherwise we would never be woken up and so the tps6586x must
> disable it's interrupt instead.
> 
> Prevent the tps6586x interrupt handler from executing on exiting suspend
> before the i2c controller has been resumed by disabling the tps6586x
> interrupt on entering suspend and re-enabling it on resuming from
> suspend.
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
