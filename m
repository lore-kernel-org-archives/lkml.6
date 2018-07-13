Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C7FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B31208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hEH+ipnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B31208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeGMQPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:15:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35983 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbeGMQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:15:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id u16-v6so22868971pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=/xfMSvzVK2b0+pcxlaJy5eI7XZxD0bz25LVhvzOzXrI=;
        b=hEH+ipnC0wS6Al/YaUaSz1JckAJC7yYXspHIVQOFRQJKEOcP196CN8UZqk3Gvl6dlB
         lS4knkm4cT+GCUQOU1cyLWLyad2l5lFQDf/1tjTXtHWN98wWJNbVXoS7mdacmZpwg+sQ
         9ZCuGDL9IhO1pR82Tf3HoBnKI9LFCVzJg8qE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=/xfMSvzVK2b0+pcxlaJy5eI7XZxD0bz25LVhvzOzXrI=;
        b=BmvQ3sMPNN3b7VuDjx77t8N2gtBnOegIwAxPZDKkLBDjP2ifcL3CXIiSyf6iPsvfPr
         iBUYSpTGGPnqjEtGaG/1g2PR3fNwFKGTQPxeuDBaCwcewoSFIS57OUWbyWt5a6P+V9FU
         pI1TebtwUnMlD5x9XjyvI+K+/CsxrV7Ldo6v/Omzv7ebrsSssIcv8y2ejhtjHmAfcJZU
         3TZl1gdtBbqhV0rUgipqm8douFYov6pVD96IWzbiu7DQHXNEFXRa3G5UJojgWjA0fz5N
         yAmrzz8+JZh63WSOu53Bv01IM4zvw55oxwhsYRPO/S4yKTeC3BjZ88ugV496CdDZNJEo
         oPHQ==
X-Gm-Message-State: AOUpUlH5fBpKbgi4bWESwTQNDjPkyikCxscw0ovC7Quqec0zP2z7M/Rw
        /Q+XKsPHxYN77RrojOLwiJtDwQ==
X-Google-Smtp-Source: AAOMgpfpjG2Ho8myRAR4+S6Idp1HjBNQowvjRPETHwT89xpQPCMG5JTN4ZkjZXGV55KJGv+IRO/BKg==
X-Received: by 2002:a63:6092:: with SMTP id u140-v6mr6623269pgb.433.1531497621173;
        Fri, 13 Jul 2018 09:00:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id k10-v6sm61896111pfj.29.2018.07.13.09.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 09:00:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180709212522.187257-1-mka@chromium.org>
Cc:     David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180709212522.187257-1-mka@chromium.org>
Message-ID: <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Date:   Fri, 13 Jul 2018 09:00:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-07-09 14:25:21)
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/q=
com/pm8998.dtsi
> index 92bed1e7d4bb..7eea94701b23 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -11,6 +11,13 @@
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>  =

> +               pm8998_temp: temp-alarm@2400 {

Are we sorting this file based on node name or unit address? Otherwise
patch looks good.

> +                       compatible =3D "qcom,spmi-temp-alarm";
> +                       reg =3D <0x2400>;
> +                       interrupts =3D <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING=
>;
> +                       #thermal-sensor-cells =3D <0>;
> +               };
> +
>                 pm8998_gpio: gpios@c000 {
>                         compatible =3D "qcom,pm8998-gpio", "qcom,spmi-gpi=
o";
>                         reg =3D <0xc000>;
