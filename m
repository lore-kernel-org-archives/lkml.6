Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD260C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824A4206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WIjaQdWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824A4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeJDXko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:40:44 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39161 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeJDXkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:40:43 -0400
Received: by mail-ua1-f67.google.com with SMTP id g18-v6so3649637uam.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LhSMcfg0AtLDIutqPLXMNrDzSLxcFAK6T9g/56Hc//8=;
        b=WIjaQdWvnrI+kOa3hsK/KM1TXQbr/BNHxMUVQrRgESSTm+lu7Vhp5qxVR0nfR+1197
         HKKgugnPxObadHLxbSP2yS6O20go1yAyqRUYdZooqcsB0ZdL3X/EFJ2iKHjU5WPq+eFk
         eNwhWyjC471F72rQODPwPQwAjGj03PWcIhz0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhSMcfg0AtLDIutqPLXMNrDzSLxcFAK6T9g/56Hc//8=;
        b=A1GScCSuFhAmvVDCNs2Vnpjft6a5TcpBD/axzM8+By2Qe2XsDCcSjXWu3tE5c1eKEZ
         jtgayMUB1U+QMwJZqyL/3xdBDPoMISv+Uu+gY3fn4enJ8U4UUPqUAnkyPWLNGLfpDQHM
         WBQvBm9Ec9o8HKGZQehVRrlS0nuMmKRM5FCE6dcE64zmuqEvlDTFwC7cskRCZSLuNt5Y
         ZLyv9qTxPGDpmtPCuUooCvJ4vXpT3wzoh2OWJHc8s+GSEemgV2b1P45GeA1GuRhN3kWy
         BB7fzbtjuJog2AbUwzeJYq8Nn2Sq7C3z+jS4W5Pw4EEoqUET5QhovgWvChC/TPg7rzY0
         oWMg==
X-Gm-Message-State: ABuFfohv5jh3uniaQf0rlktD3m1rix6MZJvoJQU0FyH/Qeh8aqSaDlED
        GRMaHqR+L1qaeY8sXNQOQ6Mv5bGgz8I=
X-Google-Smtp-Source: ACcGV614wzvQKVg6wIYjPob935eLbBdqsTspIcMVZ9mDAzJokOyzfAgfV4yOPFeBQsefOhWtfdKIiQ==
X-Received: by 2002:ab0:7de:: with SMTP id d30mr790810uaf.82.1538671597826;
        Thu, 04 Oct 2018 09:46:37 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id x67-v6sm922079vkx.48.2018.10.04.09.46.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 09:46:35 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id g80-v6so2246004vke.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:46:35 -0700 (PDT)
X-Received: by 2002:a1f:101f:: with SMTP id g31-v6mr2817125vki.90.1538671595307;
 Thu, 04 Oct 2018 09:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181004001432.21218-1-mka@chromium.org> <20181004001432.21218-3-mka@chromium.org>
In-Reply-To: <20181004001432.21218-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 4 Oct 2018 09:46:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U0k2L4aqJeges-u-CSF6VwnU1h0kfR3GCv7BgU95gOcQ@mail.gmail.com>
Message-ID: <CAD=FV=U0k2L4aqJeges-u-CSF6VwnU1h0kfR3GCv7BgU95gOcQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
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
> Add a channel node for the die temperature to the ADC.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v4:
> - added unit address to 'die-temp' node

This probably should have been "changes in v5"

> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 048f19fa0150..32b141637d13 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -75,6 +75,11 @@
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         #io-channel-cells = <1>;
> +
> +                       die-temp@ADC5_DIE_TEMP {
> +                               reg = <ADC5_DIE_TEMP>;

Thanks for adding the unit address.  Note to Andy that this ought to
go into the queue for 4.20 since you'll have the ADC5_DIE_TEMP then.


-Doug
