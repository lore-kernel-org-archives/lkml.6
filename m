Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE8C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4192082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y8KSQb4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4192082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJDWIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:08:38 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42078 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeJDWIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:08:37 -0400
Received: by mail-vs1-f68.google.com with SMTP id w16-v6so5573834vso.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLUZlAEuI80YOsK7uODQB3rfm1N8Lu9Vuv38c6Q9A4U=;
        b=Y8KSQb4FSgXRhj/teS15Z5MlqjVcM/vspQ+woMBHp0/lBWVTNAlL9r4XC57XLj2UWx
         gfZi8pssxCeuNv2wEt4OkVIaIPNZU9e/mj8XED3gUFYfAKUrRzavu4kFi0ZEiHlP0d+r
         R7AnrwcrAtlfequahfEJxXCkx2FXDgNrGPsPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLUZlAEuI80YOsK7uODQB3rfm1N8Lu9Vuv38c6Q9A4U=;
        b=J7tUWIuJtsn0VgkG+jfPSQy1AzPRzD4N+M/sKnhMiRD5O1pRFteFl2VJm/3Li0dCUj
         MEDfrHsUF8hSlmX4sMEQQQWu74uuUFs581g7IMHAXUTDXhWJ8c2oVh/HHXXPwrWVm0xN
         egZS7Yusn9UL1MEES6awXkGi8h1kEZa8ZheqgvqM1iZJuOvNJZ0fGR3vSGG22sHesv8V
         lAD0YCA21Ff9npG21gHUKSqrVHKCZpdmOquO8gdeWcwGzRCCJnI7Ob+q/xxkEsiXq6e7
         x10nkzQ0SqxbEcDrdWa3u44SaXLdiMb7x+OgoKMy3zSwsEKDcN0bPcE1iKXDuXcutSEY
         N/cw==
X-Gm-Message-State: ABuFfohnjtAEbCd8NO9s8LcdgiWjTd9sqsm81WxaaU40F8vwfNsCTqcQ
        sR56sOHDHBo9fmXZuj07MX1OoRPddF8=
X-Google-Smtp-Source: ACcGV635kI/Y1B5uCU04AoYiCMoWsBJxQWqYdbND223wCwGvbi0Zqf472Qsw/ITg/7gbAB9cRRoFGg==
X-Received: by 2002:a67:b14c:: with SMTP id z12mr2741283vsl.28.1538666093450;
        Thu, 04 Oct 2018 08:14:53 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id v85-v6sm294855vkd.18.2018.10.04.08.14.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 08:14:52 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id t202-v6so2235771vke.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:14:51 -0700 (PDT)
X-Received: by 2002:a1f:280c:: with SMTP id o12-v6mr2691499vko.4.1538666091362;
 Thu, 04 Oct 2018 08:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181004001432.21218-1-mka@chromium.org> <20181004001432.21218-2-mka@chromium.org>
In-Reply-To: <20181004001432.21218-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 Oct 2018 08:14:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xhic45SCQSVx0XXgtcyFAMEmOt97HUKZjHa_nyd4Ur2A@mail.gmail.com>
Message-ID: <CAD=FV=Xhic45SCQSVx0XXgtcyFAMEmOt97HUKZjHa_nyd4Ur2A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 3, 2018 at 5:14 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The node has a reg property, therefore its name should include a unit
> address.
>
> Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> DT conventions.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v4:
> - patch added to the series
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> index d0c188e5c922..ff7aa5038ba6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
> @@ -112,7 +112,7 @@ Example:
>                 io-channel-ranges;
>
>                 /* Channel node */
> -               usb_id_nopull {
> +               usb-id-nopull@VADC_LR_MUX10_USB_ID {
>                         reg = <VADC_LR_MUX10_USB_ID>;

This is my understanding of how it should be done and matches some
existing examples I see in the tree.  AKA "pd_hdcp@RK3399_PD_HDCP".
Thanks for cleaning it up!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
