Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C6C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602152176F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549804763;
	bh=343Y5jqNu9hTotntAX76szvN4bzQBg4yioPZQLl1+Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e6lrcT8jATttOyWWWoIW1OGINpGGI14y2TPhIYXPvuQYlll3pNIzBZVCf47WIYhB2
	 BjWKULiYnkhdrM9HYNBIfun9e3nJ/LevD5tF9/oKsph9q4LL7b0xwNO8Z6KIYXicpY
	 uu3MYs4WzjUO6J4PYlKsEYrdSriqFeTNPx+KTgsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfBJNTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 08:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfBJNTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 08:19:21 -0500
Received: from localhost (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B474B20823;
        Sun, 10 Feb 2019 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549804761;
        bh=343Y5jqNu9hTotntAX76szvN4bzQBg4yioPZQLl1+Hk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hZW838DEFimHjyCBKny2rCe6zbAb1MIEGUfJFFnyCN5Q9CtUql6IY2scXLADH4ITR
         vTGtRUIdsFA/XAxEBhcoLkfquR2ty9htGs8lKw/FWfvaRKrLUFRAqc0t4VjGdnEkfx
         P1xAyHp5LFvBbWPAeRJTQxNmM5E1zlHgWvCY3DKU=
Date:   Sun, 10 Feb 2019 14:19:12 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
Message-ID: <20190210141912.1da19db6@kernel.org>
In-Reply-To: <daa35c21-195e-eeb5-8aa2-cf42eff6a554@ti.com>
References: <20190128054935.4972-1-vigneshr@ti.com>
        <20190128054935.4972-3-vigneshr@ti.com>
        <2efbca08-c4ab-34ea-0e34-05aed7168df8@microchip.com>
        <daa35c21-195e-eeb5-8aa2-cf42eff6a554@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019 11:43:46 +0530
Vignesh R <vigneshr@ti.com> wrote:

> >>  static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
> >>  {
> >> -	const struct spi_nor_hwcaps hwcaps = {
> >> -		.mask = SNOR_HWCAPS_READ |
> >> -			SNOR_HWCAPS_READ_FAST |
> >> -			SNOR_HWCAPS_READ_1_1_2 |
> >> -			SNOR_HWCAPS_READ_1_1_4 |
> >> -			SNOR_HWCAPS_PP,
> >> -	};
> >>  	struct platform_device *pdev = cqspi->pdev;
> >>  	struct device *dev = &pdev->dev;
> >> +	const struct cqspi_driver_platdata *ddata;
> >> +	struct spi_nor_hwcaps hwcaps;
> >>  	struct cqspi_flash_pdata *f_pdata;
> >>  	struct spi_nor *nor;
> >>  	struct mtd_info *mtd;
> >>  	unsigned int cs;
> >>  	int i, ret;
> >>  
> >> +	ddata = of_device_get_match_data(dev);
> >> +	if (!ddata)
> >> +		hwcaps.mask = CQSPI_BASE_HWCAPS_MASK;  
> > 
> > Now that .data is set in all cqspi_dt_ids[], maybe it's better to print a
> > message and return an error here. But I guess it's a matter of taste, so not a
> > show stopper.  
> 
> Since, driver data is kernel internal field, I guess there is little
> help in printing out the error to the user when its missing. I prefer to
> keep this as is, as basic Quad mode is supported by all versions of the IP.

Well, if all compat entries have an associated platdata instance we
don't need to support the !ddata case, right? I think enforcing the
presence of such a platdata is actually is a sane thing to do (which
implies returning an error when ddata is NULL).
