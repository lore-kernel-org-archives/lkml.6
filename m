Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EA020823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550823202;
	bh=ljvD/aGj+6Hipv0rUE56d5fYerjq/aYHjKYQ9G5T5gA=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=g9oaPcBcCCIHivUTvpNylv9n8KP5viAwLOITE+lt9LIo1pJQrJDtaBXQ+WARZUxor
	 8qgvGiubVnDIaOImPOIwZLkvFTH22ELDpZCQ/yIJZVHcTIF31x3tX3DWvxBjLYwjx2
	 Qm+vCvk9RPJGWQaYeGDEwma9CcgnbDWrLoRH+JGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfBVINU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVINT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:13:19 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2478120823;
        Fri, 22 Feb 2019 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550823199;
        bh=ljvD/aGj+6Hipv0rUE56d5fYerjq/aYHjKYQ9G5T5gA=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=VTvOlSzqBB5QzLrdkk1Uc5Z8hrhsfHRq3W+a+QyxZFSZX/pM1tnFccoornqJk2S7S
         HtiKbukXqD2Jc42uRtF/un1afpACYWQbk4reVruBhvyYB/7PvGaPw2qTwCntsaQUBe
         jz7sTc/80zB3f0Z+81nA9nn2w2CohYTyRPlR+UIk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] clk: fractional-divider: check parent rate only if flag is set
Message-ID: <155082319829.77512.7935951458664373330@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190210153806.24201-1-katsuhiro@katsuster.net>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190210153806.24201-1-katsuhiro@katsuster.net>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date:   Fri, 22 Feb 2019 00:13:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Katsuhiro Suzuki (2019-02-10 07:38:06)
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate even if target rate is greater than parent.
>=20
> This patch checks parent clock rate only if CLK_SET_RATE_PARENT flag
> is set.
>=20
> For detailed example, clock tree of Rockchip I2S audio hardware.
>   - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
>   - i2s1_div is integer divider can divide N (N is 1~128).
>     Input clock is CPLL or GPLL. Initial divider value is N =3D 1.
>     Ex) PLL =3D CPLL, N =3D 10, i2s1_div output rate is
>       CPLL / 10 =3D 1.2GHz / 10 =3D 120MHz
>   - i2s1_frac is fractional divider can divide input to x/y, x and
>     y are 16bit integer.
>=20
> CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK

Applied to clk-next but I made the function into a macro because I don't
see the benefit to exporting such a simple thing.

