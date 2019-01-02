Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE36C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7FE2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="P6WjS79b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfABKvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:51:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35622 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfABKvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:51:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so30092719wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 02:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8MmLBCI2PIoQ8MIUEoJ2wCK/ssvfuTsMrNba1wjWWZM=;
        b=P6WjS79bJcOn2dhtizkDZC4pJI5RerhuQ5sAWonwOoRO/9tGTcpjrTYxDbbOps9rBp
         zSSwWDU69XmFdeYWV09lBFnRoRt8PJiKazI3KSt/S0v0GJJMaCBlO8CdwU98VehrBW0E
         9X6IwAG7TbZIhSSQzQTptixXB8MaQ+0TamYjv1BonSen7a6S3wX0Xl8i1r7vSUEKQvN7
         zb0kye/iDLurFj7THJXSqa6+LDGQYGM8istIeZMjv2GBYyIod97x4D1X53Tc0ufnE2ZZ
         t0e0+HPltJ5BUgJIY3i73GUqem7bkbXOPcDf1WrtVfUod5tLq7fgkpAvztdjpgwr9heO
         axEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8MmLBCI2PIoQ8MIUEoJ2wCK/ssvfuTsMrNba1wjWWZM=;
        b=bDhGnIgeA0+AXj5lKWawjaFENJRebCmjwtrSbM8tH1gE3sazt2C3mizvU1/vwXSU9g
         cUd0o3fA0Mi0hMhB02YDpqP2ji6Mphflzo3AgzD7H5GGa3R4Q+dXarPaRTeNUKiyJPhz
         ITHoGGGtkTSKdloGbaVN2VXlrOhDUAO1zdMjEFbOcKGIKjYG+h4qnel0HiP6wv1VyVGT
         72b11fWrrX704UhxZ1LDwyhDhl6lRF1nP/HUj0d56m2HqrZDS17HNDOaxGUgcjnrmRwH
         osqDC5IDqYh4rjlnIEWIVsP6tARVT8qT0C4eqhAm29gKGsLG4WXpXTJ9PLpYR6ioy2hB
         ITXg==
X-Gm-Message-State: AJcUukf8oJbcLwjhacECiDWWSuQ5n8zTqINYWTnPvM7lmRy0sc3tX7P7
        vuVknXaFIe6kGkPu1n8d7J+HJw==
X-Google-Smtp-Source: ALg8bN6n41xk9YnjSihHkqvG0avbzSe0eKT0bldMHW0Vyt4XN1F+XgUrZsKkusOT+p06EZr1bTCchw==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr37207582wrx.315.1546426281734;
        Wed, 02 Jan 2019 02:51:21 -0800 (PST)
Received: from boomer.baylibre.com (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id t76sm68331814wme.33.2019.01.02.02.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 02:51:21 -0800 (PST)
Message-ID: <f4fa4226a508d563d1a77eaafa5590fd84577c15.camel@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: dts: meson: libretech-cc: switch eMMC to 1.8v
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Jan 2019 11:51:19 +0100
In-Reply-To: <CAFBinCBQkpLxUZYp2NQoXEA=8t_XCJMHauM+DwTz-p0FA57CrA@mail.gmail.com>
References: <20181220161037.23756-1-jbrunet@baylibre.com>
         <20181220161037.23756-3-jbrunet@baylibre.com>
         <CAFBinCBQkpLxUZYp2NQoXEA=8t_XCJMHauM+DwTz-p0FA57CrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-22 at 18:01 +0100, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Thu, Dec 20, 2018 at 5:11 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > While some 3.3v eMMC 4.0 are available from libretech, the default
> > option for the aml-s905x-cc seems to 1.8v 5.0 modules.
> nit-pick:
> can you please state which module (storage size) you used for testing?
> you probably still remember that we had some confusion on Odroid-C2
> which eMMC module works and which doesn't, so let's be explicit here
> 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts    | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> > b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> > index daad007fac1f..d0d202cf7161 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
> > @@ -118,8 +118,8 @@
> >         vddio_boot: regulator-vddio_boot {
> >                 compatible = "regulator-fixed";
> >                 regulator-name = "VDDIO_BOOT";
> > -               regulator-min-microvolt = <3300000>;
> > -               regulator-max-microvolt = <3300000>;
> > +               regulator-min-microvolt = <1800000>;
> > +               regulator-max-microvolt = <1800000>;
> is there a 3.3V -> 1.8V regulator on the eMMC module?
> I'm not sure about the schematics but it seems to be that the board
> itself supplies only 3.3V to the eMMC connector, so I'm not sure where
> 1.8V come from in this case

The module is indeed fed by 3.3v only but it has embedded LDOs add will feed
back the supply of the BOOT gpio bank.

I tried the following modules:
* 8 GB samsung - v1.0-170420
* 32 GB toshiba - v1.0-170421

I think you can't get them here [0].

In theory, these 4.x modules [1] could also work. They don't have the LDOs and
are directly feeding back the 3.3v to the BOOT bank. Since the modules are
advertised as being compatible with the Allwinner boards only, and not the AML
ones, it should not be the default option.

[0] : 
https://www.loverpi.com/collections/libre-computer-project/products/libre-computer-board-emmc-5-x-module?variant=4173557729
[1] : 
https://www.loverpi.com/collections/libre-computer-project/products/libre-computer-board-emmc-4-x-module?variant=761282232333

> can you please add a comment to the .dts about this?

Sure

> 
> 
> Regards
> Martin


