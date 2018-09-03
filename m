Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C448C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2018B2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZVkP29H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2018B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbeICVun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbeICVum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:50:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7FDF20658;
        Mon,  3 Sep 2018 17:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535995774;
        bh=mrW6MfUJP6BVuZCk4oLn90TzNdhkVZ0Fay91me6WbWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eZVkP29HlEsiQ0I9ReHZjMD7iP7fbu7e1+AdcU+aWTyLuSncC54lKXLmFDawgeX15
         gldlZPaW6UXH+LGW/kkfGqff6OAt00GumsH4StUrgvEJ1JoDHJBhZEStj31WYuM49n
         R7n4xcKQNtPrDsoFlx0MsfVplrOdqVZsykcLGSSc=
Date:   Mon, 3 Sep 2018 18:29:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 18/30] iio: adc: sun4i-gpadc-iio: rework: support
 multiple sensors
Message-ID: <20180903182927.344858c4@archlinux>
In-Reply-To: <3722842b-1aa3-ea46-c0ec-7a01bc8a723e@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
        <20180830154518.29507-19-embed3d@gmail.com>
        <20180902211125.0098c808@archlinux>
        <3722842b-1aa3-ea46-c0ec-7a01bc8a723e@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018 15:58:30 +0200
Philipp Rossak <embed3d@gmail.com> wrote:

> On 02.09.2018 22:11, Jonathan Cameron wrote:
> > This feels like a good place to factor out the code into a utility
> > function that just does one of them.  That should hopefully
> > reduce the indenting etc enough to make the code easier to read.
> >   
> >> +		info->tzds[i].info = info;
> >> +		info->tzds[i].sensor_id = i;
> >> +
> >> +		info->tzds[i].tzd = thermal_zone_of_sensor_register(
> >> +				info->sensor_device,
> >> +				i, &info->tzds[i], &sun4i_ts_tz_ops);
> >> +		/*
> >> +		 * Do not fail driver probing when failing to register in
> >> +		 * thermal because no thermal DT node is found.
> >> +		 */
> >> +		if (IS_ERR(info->tzds[i].tzd) && \
> >> +				PTR_ERR(info->tzds[i].tzd) != -ENODEV) {
> >> +			dev_err(&pdev->dev,
> >> +				"could not register thermal sensor: %ld\n",
> >> +				PTR_ERR(info->tzds[i].tzd));
> >> +			return PTR_ERR(info->tzds[i].tzd);
> >> +		}  
> 
> So this code above should be placed in a separate function and called by 
> the for loop?
> Did I understand that right?
Yes - exactly.

> 
> Philipp

