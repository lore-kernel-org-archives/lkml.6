Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5585C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8590420855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="idTX8LHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfAQSOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:14:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35436 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfAQSOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:14:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so2097455wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ykscII2ksBNyB/Hjd+f+Vn2Obzc7BvKpk00Ux9/48dY=;
        b=idTX8LHZ8CxERMf+DA/UY4F4Rn4+V0awRVM0LO6N2FU0DpFk/ciy/xH4a2JO1dCYQa
         JO9SVtiOk/8w/kfnJWB3qANrb8agrtc9lQdnPro3uqIlwX5Gla/IUIT227LTqDPLEVN5
         eRJQjiu6n6mZg/Xfk6DGX2BEaMRR+Yb9za5k6ZAYZaJQK3UHSux6OyJQETYka2POfS+i
         cpBqagzjtkxlSv7cCSHbmni9sonEaqCCEGMKExn/I9C9auOvinAKFMBufBG0gn1zSWps
         H+1xWsXZPkMjHRPi+Ho3HmqCeXmRbXdZ5Hey1W9WwPVpA1t9Q2z36TLZb+TaJxyuFS9h
         CZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ykscII2ksBNyB/Hjd+f+Vn2Obzc7BvKpk00Ux9/48dY=;
        b=PUINvFSDsboCuzH0Khu3ZBuIvdRXObSRDg6NLf/u0ryuLLK4FlCMje3LpYRoRijCkF
         NJBvP2KOD4gFS/qhnLD/nI5AXNl7Rm4l9FlUnq913rnosYkHlms7cTB4s7UiuGgucCtr
         nVYcZmTCzV8tXmIN8jJ7dhfJKMlBXv85UlbMDKKrmBouSiBDFyQZX0Tr/qzCYIH/Nzwo
         RwdEpJJ0z2s7pebU6bSFHj9D6R1BRLJkHEwH1mLIfHZUGg9TH38IGnbodJU+zBfP2o4P
         j/q7KpJhBpitISvm6wdQSo0j236kdSVungtm6T6E79jYMISzu5+YSRHY3bMq3h6ldSNh
         FYbA==
X-Gm-Message-State: AJcUukfhz+DH4jD7g6sL+6tfav6pSAciarGV0Li0+kkixjoDkoVXMZy5
        EjEiiSxSFeKrymZ8Fl1Wz09Cuw==
X-Google-Smtp-Source: ALg8bN6ddt/5ZTwc41pOMsPMLu+R4ReEZJ+2EgW2MwUYFXlPJbClaf1jOaeveGEvKpxgeJAAp1Tndw==
X-Received: by 2002:a1c:570d:: with SMTP id l13mr13183908wmb.139.1547748847669;
        Thu, 17 Jan 2019 10:14:07 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id y13sm40912021wme.2.2019.01.17.10.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 10:14:07 -0800 (PST)
Message-ID: <284838d9e1672f2d733e687cedbda1239eab5279.camel@baylibre.com>
Subject: Re: [PATCH 4/4] arm64: dts: meson: g12a: add clk measure support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Date:   Thu, 17 Jan 2019 19:14:05 +0100
In-Reply-To: <20190117164838.8008-5-jbrunet@baylibre.com>
References: <20190117164838.8008-1-jbrunet@baylibre.com>
         <20190117164838.8008-5-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 17:48 +0100, Jerome Brunet wrote:
> Add the clock measure device to the g12a SoC family
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index bd24de947a5b..0d3d3af8ea6f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -181,6 +181,11 @@
>  			status = "disabled";
>  		};
>  
> +		clk_msr: clock-sensor@ffd18000 {
> +			compatible = "amlogic,meson-g12a-clk-measure";
> +			reg = <0x0 0xffd18000 0x0 0x10>;
> +		};
> +

Hi Kevin,
I just noticed that I hace misplaced this node if, like for the axg, we are
ordering them by address

It should be under the GIC node.
Can you fix this on the fly or do you want me to resend ?

Cheers
Jerome

>  		gic: interrupt-controller@ffc01000 {
>  			compatible = "arm,gic-400";
>  			reg = <0x0 0xffc01000 0 0x1000>,


