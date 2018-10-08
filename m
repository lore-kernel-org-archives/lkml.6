Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9396C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA6F2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EP47IjPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA6F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeJIDJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:09:37 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44132 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeJIDJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:09:36 -0400
Received: by mail-ua1-f65.google.com with SMTP id s8-v6so7571380uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2Hqpsdo3ZwiwRoyBf0ATmR1ShNfCE7KPx/hftJiUp0=;
        b=EP47IjPeX4vUlFT7pjcGKhPhnt6tYCHjCw3MUqKCQCIsDNFV8QYvQ76inXqUKHXsfm
         rFznoEPsMiKu/Y+5Dj9T/mAlYf45yHSMQMSnW3TCUX3Lj9qwWMPQNP/7MtqntR6C/hdA
         /7ct9GgHuqJBHHG7+TiGkTbq/088uFWMYkMkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2Hqpsdo3ZwiwRoyBf0ATmR1ShNfCE7KPx/hftJiUp0=;
        b=bkO9w94JFE+mzdjE8BiHagfoO4TCOkt8Z0ACc5Z1CuBBUj015BLftfSELN7s0xG8ea
         z+Rzyzrfyj7eKcRn9Rsz2ocmPKr1oiMq29NVKQ7Wu7QgT/stSStfrGtzwS/J0ZX2AaA6
         zBP1+nZc+Km4rrY1442Fb16P623Icrm6wfXOtZsHfNBaB7GfQKs0h+N+llPr+Wi2kc0A
         dyOGjqRK2V7F368100AiqcgRQRpCnuZJD/QtuxbZpaNd4t1Lu1WlqAbW+lQJgIE5iiCO
         qMGAGtTWfgcQojbeSH7UQjTd0yzCAA0hM0m66kAPUmOYdJ0nCm1uu/5HRtCZni062FTa
         jZ7g==
X-Gm-Message-State: ABuFfoiMocqUMubpEwvBlZWv80kO2Zat1XNW5ZmiyKmCOjKc9cpWO+Tj
        OJcNL34BYugKTwm9cK3ZrxL/cjBSkto=
X-Google-Smtp-Source: ACcGV60CyjrOXUYsuLDeg4/MVhXonXLB6TEu/hdvpQtt8hdI97f44zFPveI9UzoF4DtErYXzssoQZA==
X-Received: by 2002:ab0:1445:: with SMTP id c5mr7793965uae.18.1539028570782;
        Mon, 08 Oct 2018 12:56:10 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id m13sm9062127vsi.4.2018.10.08.12.56.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 12:56:09 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id c10so12128955vsk.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:56:09 -0700 (PDT)
X-Received: by 2002:a67:6604:: with SMTP id a4mr9154816vsc.42.1539028569039;
 Mon, 08 Oct 2018 12:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181005015902.134192-1-dianders@chromium.org>
In-Reply-To: <20181005015902.134192-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 Oct 2018 12:55:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WkSvkv-p6q9XwZekhpTozxNnA4U7=jnZSFAW0F6BK=LA@mail.gmail.com>
Message-ID: <CAD=FV=WkSvkv-p6q9XwZekhpTozxNnA4U7=jnZSFAW0F6BK=LA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add qspi (quad SPI) node
To:     Andy Gross <andy.gross@linaro.org>
Cc:     ryandcase@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 4, 2018 at 6:59 PM Douglas Anderson <dianders@chromium.org> wrote:
> +               qspi: qspi@88df000 {

Whoops!  Just re-read over the version history of the driver and
realized that Rob H. wanted the node name to be spi@, not qspi@.
Version 2 coming up.

-Doug
