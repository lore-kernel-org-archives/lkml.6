Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F4AC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C4920854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVN6erYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C4920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeKECGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:06:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbeKECGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:06:53 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35322082D;
        Sun,  4 Nov 2018 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541350277;
        bh=X25ePno31afuYSmXkz75eWxXJ/J+vNLD5g5flXWmLj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nVN6erYMYkOo+jhzMittbr/xks1laUOX28YstzXUUfY4B6H4pLe88KNOweuKbXJm6
         ew03c8D8tL2bymU2QRmETBRwsn0VglLc3+S3o/OnzPwgGE02DtHbeez7TdQcdVjoe+
         85cOGfhvy88uz8MEFOMiS8Dt2nqSbhbsGhDjj9iA=
Date:   Sun, 4 Nov 2018 16:51:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 6/6] staging:iio:ad2s90: Check channel type at
 read_raw
Message-ID: <20181104165113.3549cd4d@archlinux>
In-Reply-To: <20181103224948.31014-7-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-7-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Nov 2018 19:49:48 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch adds a channel type check at the beginning of the
> ad2s90_read_raw function. Since ad2s90 has only one channel, it just
> checks if the given channel is the expected one and if not, return
> -EINVAL.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

Given you can't actually get here with another channel type by any
valid means, this is more a form of code as documentation than anything
else.  Still it does no harm and arguably does make it easier to read.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

A nice little clean up series.  Thanks!

Jonathan
> ---
>  drivers/staging/iio/resolver/ad2s90.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 9c168b7410d0..3e257ac46f7a 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -34,6 +34,9 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  	struct ad2s90_state *st = iio_priv(indio_dev);
>  
> +	if (chan->type != IIO_ANGL)
> +		return -EINVAL;
> +
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:
>  		/* 2 * Pi / 2^12 */

