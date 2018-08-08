Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7351FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2712A219EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kV2j4fJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2712A219EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbeHHWuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:50:15 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43987 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730480AbeHHWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:50:15 -0400
Received: by mail-ua0-f193.google.com with SMTP id f4-v6so3837666uao.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WRBVDhlgZLZgrUMjTHycJN5A1DlLGjb/E35QwnTfNQ0=;
        b=kV2j4fJbd0aOeVEJ2w5x4wWT3CiN+kmszX46VH6TqHGLk26CLJpYV/4bvKRZKWIXzz
         WSsXsdxH5FI4zz1KcXhpWO8+kGiMwOjYgNdnjui5H7UaTNj8Y+LrTZ0fAW1KCDB04ypD
         biOE9RDvEu3/jhcv2ppUikeWl0ShVD7z58YRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WRBVDhlgZLZgrUMjTHycJN5A1DlLGjb/E35QwnTfNQ0=;
        b=jgw+duQoxrABslC1hs/8z2r6Y6cMj1GL+TUSfWQVrt0pjBkH7TBlaTFXmqV+WAkDva
         zsk9AZMsN0ImRTsVGJc3wtih2RUVmqz3kIXZKngHKRAz+lyhwz4Se9K1JaAeX/vOmfJd
         xGn6zRV6rU83AoJN0uCrwavSaoJlRFXX2QrsCEupLZL14yKTJzCkHLO6Iodx5+nY6w/z
         uzWug5Zs1TMersqE62yGCHUfH5B3EWvUOfAn7UHcgrQWbg+MlYNZ11TWsPU+/Rf2+t4e
         +Fyne6DWavttQ2VCVwXspAAst6b4+rBgXiRn5ltkVtThgNjZpoE18N4PNqLKTJi5MKHs
         8C5g==
X-Gm-Message-State: AOUpUlFGlBQfeWj6uZSSdhyw4mT8MJxS8UcrxteN2WTdppe+xIyfjOH1
        ReBZcSbi4dKb+tvmkbclfG/+UffcGC0=
X-Google-Smtp-Source: AA+uWPxQwfStsdHiu7HuaO1R5Yko+2gtJIPn0EbvEDTC1Px8NxV8xCIjo0oq1ZCwIhGkk6udGLV8pA==
X-Received: by 2002:a1f:3a95:: with SMTP id h143-v6mr3049326vka.42.1533760135713;
        Wed, 08 Aug 2018 13:28:55 -0700 (PDT)
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com. [209.85.217.178])
        by smtp.gmail.com with ESMTPSA id j7-v6sm1607439vka.43.2018.08.08.13.28.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 13:28:54 -0700 (PDT)
Received: by mail-ua0-f178.google.com with SMTP id h1-v6so3845641uao.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 13:28:53 -0700 (PDT)
X-Received: by 2002:a1f:ebc7:: with SMTP id j190-v6mr2842963vkh.114.1533760132955;
 Wed, 08 Aug 2018 13:28:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 13:28:52 -0700 (PDT)
In-Reply-To: <20180808191339.16875-2-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org> <20180808191339.16875-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Aug 2018 13:28:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UcD0cb+jwNcw_GO_Jy_B7gMthXtuZrYaWN7bOW8OsXhw@mail.gmail.com>
Message-ID: <CAD=FV=UcD0cb+jwNcw_GO_Jy_B7gMthXtuZrYaWN7bOW8OsXhw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: vadc: Fix documentation of 'reg'
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 8, 2018 at 12:13 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The documentation of Qualcomm's SPMI PMIC voltage ADC claims that the
> 'reg' property consists of two values, the SPMI address and the length
> of the controller's registers. However the SPMI bus to which it is added
> specifies "#size-cells = <0>;". Remove the controller register length
> from the documentation of the field and the example.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
