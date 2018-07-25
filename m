Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA77BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0020843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Dh8z5b/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A0020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbeGYUbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:31:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:43085 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYUbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:31:41 -0400
Received: by mail-oi0-f65.google.com with SMTP id b15-v6so15869429oib.10;
        Wed, 25 Jul 2018 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6S2uRnnCZm1f76HqgNB8BMKdvEb2M/Bx7lK1WqzfNtA=;
        b=Dh8z5b/+F8dzdUoz/615RBFo2L4lkO4R69QDrGmEhNqYFARfRlQdkH988tv2czGid8
         KsFyzCv46blDZIldQPGIZfnwgBktegfezB1ArPbQb8U+21vUPhTg+VOTfDs9gf4oZLYf
         3KwEeFx+6k2UREJhMcbCpmyl7rMe1rYE0J3jOtyhJsLkYypv7U3o9OvM7zJWwrTbl7hp
         sYFJa0d2T4hGTx4pvJQ5AJMHLa49WmmGw+qaLeFGnTefyAB+keAuHqoIiakZKygF1O6G
         6773KBnSBBcIwrJSvTlRMMoKXY6xM1zE2l8lMDzrFHIvtJ5ZEfyfqp3Rzqbxrfp78vKY
         6Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6S2uRnnCZm1f76HqgNB8BMKdvEb2M/Bx7lK1WqzfNtA=;
        b=FafjbfF+kJBJP0462xqOyQfbqzW+qrLtZJ2p6cHI/vnnrV0WFrHHHK5s0Ct/dEXobw
         RYXp9fj8Zl4CMntkuk200PINoEc4wbpaLdW1xDD7IxHjoSwprJ8Mq/t/pqryCVt/q/aL
         pO6mGh74Ra5wmmP9p7EEQyFOinDuqxXYaxsC+WfGKS2D/eMS9a5pa7fUIqina/ScZCYc
         imYPe1CIgDd2vOukYbXcq0Ky8TYRUlDsSd2u4pTntn/Qf2D1M4zFRCINpwPKxfLGlkbS
         GNEQK7yHZJHph42WvG5BSwgjq9W+4v/Pv8UHoIxy/4HRZYP3tbyirk7sGDeVOjXvmxM2
         Tf1Q==
X-Gm-Message-State: AOUpUlFtGKmjWgyN2r6ZfAoa16joRTGsMGs8WmnLwurzddx27dCPhfKZ
        grgkZbXjc2qNrer3ozug9x9LVps+1Y6xLvh5gAQ=
X-Google-Smtp-Source: AAOMgpeCnL1sFDBWBdRjuaQfwnUT9xgAZx0wxQz6foWVpHz7GpKsua9XM0P4U+ZMulo+at7zXRgEqYOfiEE2Hfux/DY=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr5068523oib.116.1532546318233;
 Wed, 25 Jul 2018 12:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180724125238.14567-1-jbrunet@baylibre.com> <20180724125238.14567-11-jbrunet@baylibre.com>
In-Reply-To: <20180724125238.14567-11-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 25 Jul 2018 21:18:27 +0200
Message-ID: <CAFBinCAgMhVOpCipV2D_UPqX7z0bcT=qnfRXTWpO7zigzS_TAQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] arm64: dts: meson-axg: add linein codec
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, carlo@caione.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Jul 24, 2018 at 3:09 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the es7241 analog to digital converter which is fed by the
> lienin jack of the s400
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index 7489b88f27d7..fb101a1c6660 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -178,6 +178,16 @@
>                         gpios = <&gpio_speaker 2 0>;
>                 };
>         };
> +
> +       linein: audio-codec@0 {
there is a unit-address but no reg property - I am wondering if this is allowed?
for the regulators we're using regulator-<unique-name> instead of
regulator@<unique number>

(this applies to other patches in this series as well)

> +               #sound-dai-cells = <0>;
> +               compatible = "everest,es7241";
> +               VDDA-supply = <&vcc_3v3>;
> +               VDDP-supply = <&vcc_3v3>;
> +               VDDD-supply = <&vcc_3v3>;
> +               status = "okay";
> +               sound-name-prefix = "Linein";
SPDIF output uses capital letters "SPDIFOUT"
I am not familiar with the sound subsystem (thus I'm not sure where
this shows up) so I am wondering if the naming should be consistent?


Regards
Martin
