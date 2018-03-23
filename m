Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeCWS0E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:26:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42293 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeCWS0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:26:03 -0400
X-Google-Smtp-Source: AG47ELtrZdQP266MLOdkXqFHWmztldbm1LpEB1v1DQHJKW6djoDIdnXRoEDrC3u4OJ9BW/FDH9Zr3w==
Date: Fri, 23 Mar 2018 11:25:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Nick Dyer <nick@shmanahar.org>,
        linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Nandor Han <nandor.han@ge.com>
Subject: Re: [PATCHv1] Input: atmel_mxt_ts - fix the firmware update
Message-ID: <20180323182559.GB255819@dtor-ws>
References: <20180322164330.24809-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322164330.24809-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian, Nandor,

On Thu, Mar 22, 2018 at 05:43:30PM +0100, Sebastian Reichel wrote:
> From: Nandor Han <nandor.han@ge.com>
> 
> The automatic update mechanism will trigger an update if the
> info block CRCs are different between maxtouch configuration
> file (maxtouch.cfg) and chip.
> 
> The driver compared the CRCs without retrieving the chip CRC,
> resulting always in a failure and firmware flashing action
> triggered. The patch will fix this issue by retrieving the
> chip info block CRC before the check.
> 
> Suggested-by: Todd Weyenberg <Todd.Weyenberg@med.ge.com>
> Signed-off-by: Nandor Han <nandor.han@ge.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 7659bc48f1db..ab936e6b0286 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1728,6 +1728,25 @@ static int mxt_get_object_table(struct mxt_data *data)
>  	return error;
>  }
>  
> +static int mxt_get_info_block_crc(struct mxt_data *data)
> +{
> +	size_t table_size;
> +	int error;
> +	u8 info_block_crc[MXT_INFO_CHECKSUM_SIZE];
> +
> +	table_size = data->info.object_num * sizeof(struct mxt_object);
> +
> +	/* Read the info block CRC */
> +	error = __mxt_read_reg(data->client, MXT_OBJECT_START + table_size,
> +					sizeof(info_block_crc), info_block_crc);
> +	if (!error) {
> +		data->info_crc = info_block_crc[0] | (info_block_crc[1] << 8) |
> +				(info_block_crc[2] << 16);
> +	}
> +
> +	return error;
> +}
> +
>  static int mxt_read_t9_resolution(struct mxt_data *data)
>  {
>  	struct i2c_client *client = data->client;
> @@ -2077,6 +2096,14 @@ static int mxt_initialize(struct mxt_data *data)
>  		return error;
>  	}
>  
> +	/* Get info block CRC */
> +	error = mxt_get_info_block_crc(data);
> +	if (error) {
> +		dev_err(&client->dev, "Error %d reading info block CRC\n",
> +			error);
> +		return error;

You are leaking object table memory here.

By the way, why do we do this here, and not when we actually have config
file and is about to apply it?

Thanks.

-- 
Dmitry
