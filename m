Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B59C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC7920817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECbop1/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC7920817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeKRDRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:17:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbeKRDRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:17:44 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8592080D;
        Sat, 17 Nov 2018 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542474028;
        bh=Ed8mXnvnXT0Exg3EzhEK70oXPFYJtzW6suSVLIIrZ/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ECbop1/voZF2/MnjTdVW/dtJ2h8Lj9vSvLlKXkk4ClwxvfEfePEz+GbnVEzyuuXdG
         UCjbPwqR2Z9VIEg5fr6qyZ0smFxfsHW9Sl4Jh/uHaHHBfT9yyhAY/pv43/20pl6OUI
         ow6rVZpxwBLY+aPXFv0FBJoO5w1HlINdNUMXudbI=
Date:   Sat, 17 Nov 2018 17:00:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] Staging: iio: adt7316: Add an extra check for 'ret'
 equals to 0
Message-ID: <20181117170023.54892898@archlinux>
In-Reply-To: <20181116225132.24459-1-shreeya.patel23498@gmail.com>
References: <20181116225132.24459-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2018 04:21:32 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> ret = 0 indicates a case of no error but no data read from
> the bus which is an invalid case. This case doesn't ever happen
> in reality. It should perhaps be handled for correctness though.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
> index 856bcfa60c6c..473e5e34ec00 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -30,6 +30,10 @@ static int adt7316_i2c_read(void *client, u8 reg, u8 *data)
>  	}
>  
>  	ret = i2c_smbus_read_byte(client);
> +
> +	if (!ret)
> +		return -EIO;
> +
>  	if (ret < 0) {
>  		dev_err(&cl->dev, "I2C read error\n");
>  		return ret;

