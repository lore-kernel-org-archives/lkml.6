Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95B920871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek84JRYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95B920871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeKKWh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbeKKWh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:37:57 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9918E20866;
        Sun, 11 Nov 2018 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541940567;
        bh=Idhje+JtrbdA9BJ+OrWSbDPkol3TPKwLff0n6Ep6jHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ek84JRYUIdH0k0g7D6poHWvbDDFxyTHEuuVZIPBnMQXrRpaC8iKpdX/7PKpq9ab/f
         GmK+nJcRBHzXfGiuQdtJpNLtOH7bxHm4J8acKP3Oq0eR5U91cC8pwxZAfeHaALCXcp
         EVN4PMXIMZ8oqAALtzUrvPoIx1q8hzLZnZelOrUA=
Date:   Sun, 11 Nov 2018 12:49:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Walker <mattofak@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: extend dac/MCP4922 to MCP49x1 devices
Message-ID: <20181111124827.26b7e086@archlinux>
In-Reply-To: <20181108203655.17448-1-mattofak@gmail.com>
References: <20181108203655.17448-1-mattofak@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 15:36:53 -0500
Matt Walker <mattofak@gmail.com> wrote:

> Extend the existing dual channel MCP4922 DAC driver to single channel
> MCP49x1 devices. These devices are simple and write only. The most
> significant bit of the transfer dictates what channel to write to.
> 
> Although there is no danger in writing to the non existant channel in
> the single channel devices, it's better to not register it at all.
> Therefore extend the driver to know how many channels a device has at
> probe time based on the ID table.
Definitely!
> 
> Signed-off-by: Matt Walker <mattofak@gmail.com>
Hi Matt,

Patch looks good, but I think this is now become complex enough we should
be looking at a level of indirection to give us something more extensible
on the long run.

See inline,

Thanks,

Jonathan

> ---
>  drivers/iio/dac/mcp4922.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index b5190d1dae8e..094f7dd560ca 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -29,8 +29,11 @@
>  #define MCP4922_NUM_CHANNELS	2
>  
>  enum mcp4922_supported_device_ids {
> +	ID_MCP4901,
>  	ID_MCP4902,
> +	ID_MCP4911,
>  	ID_MCP4912,
> +	ID_MCP4921,
>  	ID_MCP4922,
>  };
>  
> @@ -115,10 +118,22 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static const struct iio_chan_spec mcp4922_channels[3][MCP4922_NUM_CHANNELS] = {
> -	[ID_MCP4902] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
> -	[ID_MCP4912] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
> -	[ID_MCP4922] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
> +static const unsigned int mcp4922_channel_counts[6] = {
> +	[ID_MCP4901] = 1,
> +	[ID_MCP4902] = 2,
> +	[ID_MCP4911] = 1,
> +	[ID_MCP4912] = 2,
> +	[ID_MCP4921] = 1,
> +	[ID_MCP4922] = 2,
> +};
> +
> +static const struct iio_chan_spec mcp4922_channels[6][MCP4922_NUM_CHANNELS] = {
> +	[ID_MCP4901] = { MCP4922_CHAN(0, 8),  {} },
> +	[ID_MCP4902] = { MCP4922_CHAN(0, 8),  MCP4922_CHAN(1, 8) },
> +	[ID_MCP4911] = { MCP4922_CHAN(0, 10), {} },
> +	[ID_MCP4912] = { MCP4922_CHAN(0, 10), MCP4922_CHAN(1, 10) },
> +	[ID_MCP4921] = { MCP4922_CHAN(0, 12), {} },
> +	[ID_MCP4922] = { MCP4922_CHAN(0, 12), MCP4922_CHAN(1, 12) },
>  };
It is getting to the point where a spot of indirection would make for a cleaner
result and prove easier to build on for future additions.

struct mcp4922_data {
	static const struct iio_chan_spec *channels;
	int num_channels;
};

//could use macros to simplify this but probably not worth it as only 3 copies.
static const struct iio_chan_spec mcp4902_channels[] = {
	MCP4922_CHAN(0, 8), MCP3922_CHAN(1, 8),
};

static const struct mcp4922_data[] = {
	[ID_MCP4901] = { mcp4902_channels, 1 },
	[ID_MCP4902] = { mcp4902_channels, 2 },
	... 
};


>  
>  static const struct iio_info mcp4922_info = {
> @@ -166,7 +181,7 @@ static int mcp4922_probe(struct spi_device *spi)
>  	indio_dev->info = &mcp4922_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = mcp4922_channels[id->driver_data];
> -	indio_dev->num_channels = MCP4922_NUM_CHANNELS;
> +	indio_dev->num_channels = mcp4922_channel_counts[id->driver_data];
>  	indio_dev->name = id->name;
>  
>  	ret = iio_device_register(indio_dev);
> @@ -197,8 +212,11 @@ static int mcp4922_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id mcp4922_id[] = {
> +	{"mcp4901", ID_MCP4901},
>  	{"mcp4902", ID_MCP4902},
> +	{"mcp4911", ID_MCP4911},
>  	{"mcp4912", ID_MCP4912},
> +	{"mcp4921", ID_MCP4921},
>  	{"mcp4922", ID_MCP4922},
>  	{}
>  };
> @@ -215,5 +233,5 @@ static struct spi_driver mcp4922_driver = {
>  module_spi_driver(mcp4922_driver);
>  
>  MODULE_AUTHOR("Michael Welling <mwelling@ieee.org>");
> -MODULE_DESCRIPTION("Microchip MCP4902, MCP4912, MCP4922 DAC");
> +MODULE_DESCRIPTION("Microchip MCP49xx DAC");
That wild card seems far to likely to hit devices it doesn't support
and end up causing confusion.  The usual nasty trick here is to
say something like

Microchip MCP4902 and similar DACs.

>  MODULE_LICENSE("GPL v2");

