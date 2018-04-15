Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeDORKS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 13:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeDORKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 13:10:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BC42177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 18:10:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: potentiometer: mcp4018: switch to using
 .probe_new
Message-ID: <20180415181012.79f8de5f@archlinux>
In-Reply-To: <20180411124915.9587-1-peda@axentia.se>
References: <20180411124915.9587-1-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018 14:49:14 +0200
Peter Rosin <peda@axentia.se> wrote:

> Use the new probe style for i2c drivers.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiometer/mcp4018.c | 41 ++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> index 601b25d1f387..320a7c929777 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -99,6 +99,23 @@ static const struct iio_info mcp4018_info = {
>  	.write_raw = mcp4018_write_raw,
>  };
>  
> +static const struct i2c_device_id mcp4018_id[] = {
> +	{ "mcp4017-502", MCP4018_502 },
> +	{ "mcp4017-103", MCP4018_103 },
> +	{ "mcp4017-503", MCP4018_503 },
> +	{ "mcp4017-104", MCP4018_104 },
> +	{ "mcp4018-502", MCP4018_502 },
> +	{ "mcp4018-103", MCP4018_103 },
> +	{ "mcp4018-503", MCP4018_503 },
> +	{ "mcp4018-104", MCP4018_104 },
> +	{ "mcp4019-502", MCP4018_502 },
> +	{ "mcp4019-103", MCP4018_103 },
> +	{ "mcp4019-503", MCP4018_503 },
> +	{ "mcp4019-104", MCP4018_104 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp4018_id);
> +
>  #ifdef CONFIG_OF
>  
>  #define MCP4018_COMPATIBLE(of_compatible, cfg) {	\
> @@ -125,8 +142,7 @@ MODULE_DEVICE_TABLE(of, mcp4018_of_match);
>  
>  #endif
>  
> -static int mcp4018_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int mcp4018_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct mcp4018_data *data;
> @@ -150,7 +166,7 @@ static int mcp4018_probe(struct i2c_client *client,
>  	if (match)
>  		data->cfg = of_device_get_match_data(dev);
>  	else
> -		data->cfg = &mcp4018_cfg[id->driver_data];
> +		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
>  
>  	indio_dev->dev.parent = dev;
>  	indio_dev->info = &mcp4018_info;
> @@ -161,29 +177,12 @@ static int mcp4018_probe(struct i2c_client *client,
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> -static const struct i2c_device_id mcp4018_id[] = {
> -	{ "mcp4017-502", MCP4018_502 },
> -	{ "mcp4017-103", MCP4018_103 },
> -	{ "mcp4017-503", MCP4018_503 },
> -	{ "mcp4017-104", MCP4018_104 },
> -	{ "mcp4018-502", MCP4018_502 },
> -	{ "mcp4018-103", MCP4018_103 },
> -	{ "mcp4018-503", MCP4018_503 },
> -	{ "mcp4018-104", MCP4018_104 },
> -	{ "mcp4019-502", MCP4018_502 },
> -	{ "mcp4019-103", MCP4018_103 },
> -	{ "mcp4019-503", MCP4018_503 },
> -	{ "mcp4019-104", MCP4018_104 },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(i2c, mcp4018_id);
> -
>  static struct i2c_driver mcp4018_driver = {
>  	.driver = {
>  		.name	= "mcp4018",
>  		.of_match_table = of_match_ptr(mcp4018_of_match),
>  	},
> -	.probe		= mcp4018_probe,
> +	.probe_new	= mcp4018_probe,
>  	.id_table	= mcp4018_id,
>  };
>  
