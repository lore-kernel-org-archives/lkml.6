Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E2C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0142075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HPSY0IBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0142075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeIGBwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:52:47 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44213 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeIGBwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:52:47 -0400
Received: by mail-ua1-f65.google.com with SMTP id m11-v6so10267782uao.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AJqu8vXoNvSNT4ogyuzuGG4OQAGCmJPElT0/M7zAZ5Y=;
        b=HPSY0IBFzeeOVI5Cx8/xycNrmkrReaYy6CjZfPk+IPeddWTlJwSk4+GazJrAoGMbo9
         NcmkEwtSXnisbCm9+UbVpZyA/u9Bq7Y1Vu5hsQyPI4+s9vrWjOSKoZRyfsG0GeshVfUt
         9sHuFCzsPZ2HE1q6ObXbn6aBE3MCawxPrhoQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AJqu8vXoNvSNT4ogyuzuGG4OQAGCmJPElT0/M7zAZ5Y=;
        b=bf5+/AgzXj4CA5YsDHlwppjNpPaW9/HOgMApnwYXhS/D+U0KzeUzszpsbBeuVHDSNF
         0c4/erLpPrB4Cv3aPAInQ14WqWe7k5sZpfgOJrwHMalALfHl6U+jtoQ39yM5qld8laOe
         aiYBxe+ajHikEjizPWo/UF8Tv1iTXaHVy44aw+nJZcrRz54+oCozjJiMPpcE2fk3x7Hn
         JExwbMJ5og7/QEMDSCqNbKlMK0bajU3Ou2NWc/igu17GlgAGPtKhdTKlaIQgOKS4kIzV
         P4veiVWHm+VaFvD5aRqbWDtrXX8jZ781IFntfAyuNUY8XLmHJIhv7akywehnyE25WqFs
         FsiQ==
X-Gm-Message-State: APzg51CIWsl5leUVhAvTlCseFZiBgKYsmY+iCicDvRNqh1P4qdGdrEcG
        nThx+ghzSc2IhYcU46X0weUX2jrpkMU=
X-Google-Smtp-Source: ANB0VdalHg+kuhRfA7RG8aMYRQvzlntzqsHMZ13GMft8bxRBMx42ubkfzmdKS0suxosS0AmU0xtzdg==
X-Received: by 2002:a1f:1a12:: with SMTP id a18-v6mr1640527vka.61.1536268527394;
        Thu, 06 Sep 2018 14:15:27 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id q19-v6sm788845uap.13.2018.09.06.14.15.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 14:15:27 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id m26-v6so10310227uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 14:15:27 -0700 (PDT)
X-Received: by 2002:a67:8dc6:: with SMTP id p189-v6mr1787231vsd.15.1536268185598;
 Thu, 06 Sep 2018 14:09:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:5e8e:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 14:09:44 -0700 (PDT)
In-Reply-To: <20180906210454.247219-3-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org> <20180906210454.247219-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Sep 2018 14:09:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTbkfF0fTot_ebqD+ohbgQBYKVwHTZunuoxC7uGYN9Zw@mail.gmail.com>
Message-ID: <CAD=FV=XTbkfF0fTot_ebqD+ohbgQBYKVwHTZunuoxC7uGYN9Zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pm8998: Add adc node
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 6, 2018 at 2:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This adds the adc node to pm8998 based on the examples in the
> bindings. It also fixes the order of the included headers.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> --
> Changes in v2:
> - removed io-channel-ranges attribute
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
