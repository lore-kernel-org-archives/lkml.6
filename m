Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0935C6787F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2D22147C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNyJ+DJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2D22147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJMBPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeJMBPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:15:53 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AD4D20865;
        Fri, 12 Oct 2018 17:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539366137;
        bh=IEwEL0ecmTw4TnbGarl4OUsbQV5zjeuwrstOqlLC56M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kNyJ+DJlBycKdxZzOhajBCbe1lnk0uyutC16iU8crsWN6i6vMfwSgoq4EKcUzD0Nr
         5/IY41lnH4bqyKkbNwp1xfnQhYgzBLew+Z4KiQH+kVsSLBNSu8PU6GfnyZp3u7ccez
         NN00v7W7P8B4f6GL+o31p8cDrFp7jzNIXbrMZTi0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180922181709.13007-7-gregory.clement@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-7-gregory.clement@bootlin.com>
Message-ID: <153936613666.5275.6122138233361141260@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 6/6] arm64: dts: marvell: Add cpu clock node on Armada 7K/8K
Date:   Fri, 12 Oct 2018 10:42:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob

Quoting Gregory CLEMENT (2018-09-22 11:17:09)
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-ap806.dtsi
> index 4a65e4e830aa..27c840e91abe 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -280,6 +280,12 @@
>                                 #address-cells =3D <1>;
>                                 #size-cells =3D <1>;
>  =

> +                               cpu_clk: clock-cpu {
> +                                       compatible =3D "marvell,ap806-cpu=
-clock";
> +                                       clocks =3D <&ap_clk 0>, <&ap_clk =
1>;
> +                                       #clock-cells =3D <1>;
> +                               };

This looks like the wrong place because there isn't a reg property. It
should go to the root of the tree. And then it looks like we're adding
something to DT to get a driver to probe, which is improper DT design.

