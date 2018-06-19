Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DC4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2992D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrbd/+yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2992D20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030337AbeFSSXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:23:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45130 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeFSSXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:23:11 -0400
Received: by mail-pl0-f67.google.com with SMTP id c23-v6so274361plz.12;
        Tue, 19 Jun 2018 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9yqKscspWioSQg/mdUQVbCb1IzDlTrgVuF38fd/HGmQ=;
        b=lrbd/+ywpi09p0kEaYhZf+gQj86n/cj7Tfoe4kQTnqqHeDW6Szv1u7Boe7dxskxv/p
         doMgGOetTFFrkiuBscnp3352XJQtGqlQDG/L+aKty+fbHvPZr8Loh3D1Ns7RNCZB7Prf
         6BZzv4adJgY5dHBPJRV17A7r0jMxltr11Sz7gAXraOpc3SkEHyo6GY1gI1zypcWff4+k
         qIfq/iyPHE5Wa62qVYiYUUuXxQXe6vgEbLdjL8fAzRlWyJ5Pe/tA9cHnOR+9LEeXzwmC
         ZRfQ67mkfUzr5MWrl72yXTMwkVucks26+3i2LJutzc0WYKqlXJe5P36jDZ3wh1x67V7h
         7Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9yqKscspWioSQg/mdUQVbCb1IzDlTrgVuF38fd/HGmQ=;
        b=E/LUbiPvwYbeORb8CzCS+1McZTQyFtscd/PnKk75zhVv4oMxTEDtT7UnT2GubN4QEq
         XTsXgRMavGmKdFHOb/5aEQ/ClkOi260KLgvLAHYJCG4uhiS+0goVomJmGpEVn5Q9q38i
         zGCxflEVBJeHkF2rpKCr/z0wrMAU9LHboI7PNiWr01wClvQD7TAuEO3itsXKImLvc/f6
         FlonM+vblmUX7EE+N/tbxTLfie1yTnFKsBTt+y7otjxlHZn/Yr+Zm1UTpEZezMOpvxXf
         6+ADZeJ66GDfIhe0ZcLxTfd45yheIq+92P8nSvTTlU8v0Fp9nzPs+9ASWneUZVe7eRW3
         B+bA==
X-Gm-Message-State: APt69E3dizI7pNELxnNTaNvm6UWzlScfcE6p25fRCYxwtrFRFJm/3HKV
        teaR6K3o+MberY4IdinC54o=
X-Google-Smtp-Source: ADUXVKKWR7hGXcl7XrJBhq6yYQqfB2fAAlYr81pFpyd+9nIPixyf6o5FqzIVSM0se1l2Wn4EgfAIQQ==
X-Received: by 2002:a17:902:5402:: with SMTP id d2-v6mr15781793pli.38.1529432590593;
        Tue, 19 Jun 2018 11:23:10 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id r20-v6sm321175pgu.25.2018.06.19.11.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:23:09 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:23:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anthony Kim <anthony.kim@hideep.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] dt-bindings: Fix unbalanced quotation marks
Message-ID: <20180619182307.GG71788@dtor-ws>
References: <20180617143127.11421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180617143127.11421-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 04:31:18PM +0200, Jonathan Neuschäfer wrote:
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> index 121d9b7c79a2..1063c30d53f7 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> @@ -32,7 +32,7 @@ i2c@00000000 {
>  		reg = <0x6c>;
>  		interrupt-parent = <&gpx1>;
>  		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> -		vdd-supply = <&ldo15_reg>";
> +		vdd-supply = <&ldo15_reg>;
>  		vid-supply = <&ldo18_reg>;
>  		reset-gpios = <&gpx1 5 0>;
>  		touchscreen-size-x = <1080>;

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
