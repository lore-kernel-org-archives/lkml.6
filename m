Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF7C43441
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269002075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 23:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269002075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeJJHH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:07:58 -0400
Received: from sauhun.de ([88.99.104.3]:53722 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbeJJHH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:07:58 -0400
Received: from localhost (p54B336A7.dip0.t-ipconnect.de [84.179.54.167])
        by pokefinder.org (Postfix) with ESMTPSA id 0E9CE2C310A;
        Wed, 10 Oct 2018 01:48:35 +0200 (CEST)
Date:   Wed, 10 Oct 2018 01:48:30 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mmc: tmio: move MFD variant reset to a platform
 hook
Message-ID: <20181009234830.v7yzhnrtqcfwmm45@katana>
References: <1538566587-29452-1-git-send-email-yamada.masahiro@socionext.com>
 <1538566587-29452-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oknejck5xq3nafxl"
Content-Disposition: inline
In-Reply-To: <1538566587-29452-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oknejck5xq3nafxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +static void tmio_mmc_reset(struct tmio_mmc_host *host)
> +{
> +	/* FIXME - should we set stop clock reg here */
> +	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
> +	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
> +	usleep_range(10000, 11000);
> +	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
> +	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
> +	usleep_range(10000, 11000);
> +
> +	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
> +		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
> +		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
> +	}
> +}

Yes, looks much safer now.

> +	host->reset = tmio_mmc_reset;

So, you populate the new pointer here...

> +	if (!_host->reset)
> +		_host->reset = tmio_mmc_reset;

... and here. But it seems never used anywhere? Or am I missing
something?


--oknejck5xq3nafxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu9PkkACgkQFA3kzBSg
KbZnuA/+I2qZqk1fuGlq0wqo0xDfpv+d77LyeWBXWDsVa8I8YCjA0qK1Z0Bm7POJ
L9W+Pv+zvxE1AcEScUagPXLBW6fEK27NrjzKhGO15udXaQEOPVJ9wFNfHcrbKJVy
WnebEAfESUXoLbQ7CLyyNzoQUsilScErUHFtgLltN95MVYkTpd/8YlVeB+GWl6xj
MvD+MYtRw0xj+PAmanjtl2dn+oNUE6Tdg4A8VA33+qE8ujXtayOjHw5lmWXYnOav
bKe5dOMVKNw1Gc7QO0wFWYF6/0b+TYNTvE2WdsbUZx79RcNjL1DYiRRMadLATn2P
zPDnNiqnZzJsANYugn8ubvtv8XrT/degeXW4eiX6auNy0y8A1FTpD/mtLCQA5SZE
XemCYB32Pi/uFLUALD79lgP20lQqZvyWrxZd1r02dfhULO9DZ5GEDUlyglvxNWI2
5xsm5XqIR2MVqmWqwH0FwDOOoRVwYc3uH6Y65trJYMioIWEPP0h4qdfA+n+1aHTJ
KYJn2aESqgTDBmwW7X+KdtRjw1aNLVU5GnOE9Sacd5pjY9DlX0Ye4RIwyBSRDmkW
RM7j6sBEEn51sSmPP+J7qFLgM29aSjRsp4AVpCPHkGz0ATv3y55yG+kN7JKnVVjm
XxaludJs1Rma5SticTpNJPd6GYDfsubj6vU9NYYijX9lGS2mVnU=
=5rVW
-----END PGP SIGNATURE-----

--oknejck5xq3nafxl--
