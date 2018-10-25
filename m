Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5162084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dRJBA+t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5162084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJZEfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:35:15 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:32965 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeJZEfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:35:15 -0400
Received: by mail-vk1-f196.google.com with SMTP id l186so2517512vke.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQHMRUADn7+5v2cWaxowLEoNHcgMKjM4QLJzCMclOk0=;
        b=dRJBA+t/3x5Ixa249mxGWlmj/YxDz1rcbciEj+mknzk73Eybk3dUzP7B+W14KTC50q
         PTmN5rWD/bQ2A38c4b59M+saQMkbB4XJ+kVkzeItBpuOKGzX8IEko3PdmUKRE5VGMOea
         hxpKJo/ASBpEYQlZScj2PEtt7rAg8jUICov+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQHMRUADn7+5v2cWaxowLEoNHcgMKjM4QLJzCMclOk0=;
        b=Zj3TIoWxgzIVNe7gzkgTx/rTibJYX3/xeVSVHhFW0fR8T8s8uWZWZkAOYBEeB9UpkI
         Ojnv0B3/ExmjVwXlk97IaOf8WffvN49NH5Q1aPAqYl3xhuEqGsc0Rz/Mui+ALQRVfcBy
         StsagVZjnCEZZmipAabddngTq/cBNXwcebqJ90NmV5Tc+aqlGdZTCQsBhpOyl29iSe4/
         Nc+1YrxBJPZWVTysGngPF224VQv49DLIEe9qhWqdVFfXHC/7u75h4IOx/wLI6sc0YR34
         5qjyjODHpfG69Yx7oj+tHh0laYNXJ6oI5vBgBrfJxgkjixZ5YoZFL/hLCoZVvK4eOgjn
         UHIQ==
X-Gm-Message-State: AGRZ1gL6U9jmRcwHTDL5+GRTn6R5uuD5Cnnarc5itVKZ5JcnsXTquT0c
        7FRXzVLZJ2GG1t2HTChQ8EYylbiSFVA=
X-Google-Smtp-Source: AJdET5dOPV4WcQpvlV8DmyvbaoE+rvq0fX1lNKYKIy46iHcXc+TW7AgFrY73gISW2o2YSsFEE35ggQ==
X-Received: by 2002:a1f:850a:: with SMTP id h10-v6mr329806vkd.4.1540497666097;
        Thu, 25 Oct 2018 13:01:06 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 185-v6sm2162064vkf.20.2018.10.25.13.01.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:01:05 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id y195so6340309vsc.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:01:04 -0700 (PDT)
X-Received: by 2002:a67:b20e:: with SMTP id b14mr289348vsf.121.1540497664288;
 Thu, 25 Oct 2018 13:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <1540485629-5970-1-git-send-email-alokc@codeaurora.org> <1540485629-5970-2-git-send-email-alokc@codeaurora.org>
In-Reply-To: <1540485629-5970-2-git-send-email-alokc@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Oct 2018 13:00:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7Rhwhz2YH8EZ0mBRuC0rO-Wns=MOuy1-FCnwn0Z=wAg@mail.gmail.com>
Message-ID: <CAD=FV=X7Rhwhz2YH8EZ0mBRuC0rO-Wns=MOuy1-FCnwn0Z=wAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: spi-geni-qcom: fix nitpicks
To:     alokc@codeaurora.org
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Oct 25, 2018 at 9:40 AM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> fixed the nitpicks.

I probably would have put more a proper sentence, like:

Fixed small nits that were pointed out on the mailing list.  No
functional change expected.

...but I guess it's up to Mark if he cares.


> @@ -533,7 +530,7 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>
>         writel(m_irq, se->base + SE_GENI_M_IRQ_CLEAR);
>         spin_unlock_irqrestore(&mas->lock, flags);
> -       return ret;
> +       return IRQ_HANDLED;

I probably would have put a blank line before the return while I was
at it, but it's not a big deal to me.

Thanks for following up.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
