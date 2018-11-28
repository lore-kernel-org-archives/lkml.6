Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D58C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097FB205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wf9Vw9ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097FB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeK2GC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:02:28 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33808 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeK2GC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:02:27 -0500
Received: by mail-vk1-f194.google.com with SMTP id y14so6198157vkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATu2TX1MQBEZHG8/yPd7l6GTq0+rDjZejTbuMZS8IUw=;
        b=Wf9Vw9ourzGaJLWRZpPGlXWgzr60O3Fvp5tFUkSYQlDznKBLiKMU25ih1Z4bdsgYDz
         3O7ubKWhgjwV9SyjkDtfgyfH8wVcZHXdEx8Zr5a6UpfVqjH3w2HRUnx+xT4x5UlKPY8O
         1qUTSL5uzYo2S/IBBKU5tnD4z647amvNz7czE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATu2TX1MQBEZHG8/yPd7l6GTq0+rDjZejTbuMZS8IUw=;
        b=gPNHVaBBvH1lYGHY7wTVQGewtw/7dnoGRcFfJ1uR69o7vWMXo1CEqY5ylnJ5CpgLAJ
         KtAK2AQ+lj282Xl4BJmiGBy9vRmgJ94M/gBr8j9CjUKcnZt/0pcsaTKWeGjNql4sD8Tm
         V7TMYygzG2nSc+Q1e44MVT2304Oe8MnyM3OTbryO1yqAihlnDYnfrmDBPmknyqa41Ppe
         DAMUFHvFE3WTr/seiAGuTHcn9J5OjfaNqX9AkBP9qEBG45qxhy81SOJWw1wRzmktRlP7
         jA1BvbewULtRQvAl1eMAmhniC2C1NvsxA7j6JwIuoqAC70u+BtoggYgzmKm98fvUUfNf
         H8pQ==
X-Gm-Message-State: AA+aEWZtvXlL5JdhnhfITUQn9XLuSuRqJLP06t5nP/Gnt93WJCrw+Vys
        ApUnm+wTMUTvPDq8VJJEWVTc23E4jbI=
X-Google-Smtp-Source: AFSGD/V+KL0s65RjBrIt68t5j+XtDvCPhOf1rltT/45iT5hm+L4wd2/Gy46ngM3jVNDJlFJiwDZFCQ==
X-Received: by 2002:a1f:bd2:: with SMTP id 201mr1602128vkl.42.1543431588195;
        Wed, 28 Nov 2018 10:59:48 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id t13sm2150379uao.19.2018.11.28.10.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 10:59:47 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id j3so9315140uap.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 10:59:46 -0800 (PST)
X-Received: by 2002:ab0:1c12:: with SMTP id a18mr15007394uaj.15.1543431585951;
 Wed, 28 Nov 2018 10:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20181008201711.152038-1-dianders@chromium.org> <153904072826.119890.13295983146179211257@swboyd.mtv.corp.google.com>
In-Reply-To: <153904072826.119890.13295983146179211257@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Nov 2018 10:59:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X-Y1q9-1EMAJmB+axwYb9yXz-vHq-3SLhwR18rTRstXg@mail.gmail.com>
Message-ID: <CAD=FV=X-Y1q9-1EMAJmB+axwYb9yXz-vHq-3SLhwR18rTRstXg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add qspi (quad SPI) node
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, ryandcase@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

On Mon, Oct 8, 2018 at 4:18 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2018-10-08 13:17:11)
> > This adds the Quad SPI controller to the main sdm845 device tree file.
> > Boards will be expected to assign the proper pinctrl depending on how
> > many chip selects they have hooked up and how many data lines.
> >
> > This depends on commit 48735597f7bd ("clk: qcom: Add qspi (Quad SPI)
> > clock defines for sdm845 to header") to add the needed defines.  It
> > also shouldn't land until the patch ("dt-bindings: spi: Qualcomm Quad
> > SPI(QSPI) documentation") [1] lands.
> >
> > [1] https://lkml.kernel.org/r/20181002214709.162330-1-ryandcase@chromium.org
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Any reason why this patch can't land?

Thanks!

-Doug
