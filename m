Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3D1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C88206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfAHO2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:28:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAHO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:28:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 362EA27EBBB
Subject: Re: [PATCH v2] platform/chrome: Add cros_ec_readmem() helpers for
 I2C/SPI based ECs
To:     Moritz Fischer <moritz.fischer@ettus.com>,
        linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org, lee.jones@linaro.org,
        moritz@ettus.com, Moritz Fischer <mdf@kernel.org>
References: <20190108035638.9685-1-moritz.fischer@ettus.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <27c7db25-51c0-c283-c4bb-4a65df9b2105@collabora.com>
Date:   Tue, 8 Jan 2019 15:28:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190108035638.9685-1-moritz.fischer@ettus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz,

Many thanks for the patch,I've one concern on this, and I'd be also interested
on Benson and Guenter opinion ...

On 8/1/19 4:56, Moritz Fischer wrote:
> From: Moritz Fischer <mdf@kernel.org>
> 
> Add cros_ec_readmem() based helpers for I2C/SPI based ECs.
> Unlike the LPC based ECs the I2C/SPI based ones cannot just directly
> read the mapped region.
> 
> This is useful for things like accessing fan speeds or temperatures.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Hi all,
> 
> 
> I had submitted this back in May 2017 [1] and then somewhat forgot
> about it. So here's a new version :)
> 
> As to why is this required? we're using this in some of our devices
> [2] that run a modified firmware based on Chromium-EC.
> I've been carrying the patch downstream in our tree for a while and
> it would be nice if we can merge this upstream so I can stop rebasing
> this :)
> 

Right, if we merge this you'll probably reduce your downstream patches but
actually, if I am not wrong, there is no user for this. There isn't an upstream
driver that uses the new functions so we will end up having upstream dead code.
IMO if you want to have this upstream you should also upstream the drivers that
use that code. Makes sense?

Thanks,
  Enric


> Thanks,
> 
> Moritz
> 
> [1] https://lore.kernel.org/patchwork/patch/786065/ 
> [2] https://www.ettus.com/product/details/USRP-E320 
> 
> ---
>  drivers/platform/chrome/cros_ec_i2c.c   |  1 +
>  drivers/platform/chrome/cros_ec_proto.c | 38 +++++++++++++++++++++++++
>  drivers/platform/chrome/cros_ec_spi.c   |  1 +
>  include/linux/mfd/cros_ec.h             | 12 ++++++++
>  4 files changed, 52 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> index ef9b4763356f..c3a9bee37b1d 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -303,6 +303,7 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
>  	ec_dev->irq = client->irq;
>  	ec_dev->cmd_xfer = cros_ec_cmd_xfer_i2c;
>  	ec_dev->pkt_xfer = cros_ec_pkt_xfer_i2c;
> +	ec_dev->cmd_readmem = cros_ec_readmem;
>  	ec_dev->phys_name = client->adapter->name;
>  	ec_dev->din_size = sizeof(struct ec_host_response_i2c) +
>  			   sizeof(struct ec_response_get_protocol_info);
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index cc7baf0ecb3c..2f1d45a7a934 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -636,3 +636,41 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>  	return host_event;
>  }
>  EXPORT_SYMBOL(cros_ec_get_host_event);
> +
> +int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
> +		    unsigned int bytes, void *dest)
> +{
> +	int ret;
> +	struct ec_params_read_memmap *params;
> +	struct cros_ec_command *msg;
> +
> +	if (offset >= EC_MEMMAP_SIZE - bytes)
> +		return -EINVAL;
> +
> +	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), bytes), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version = 0;
> +	msg->command = EC_CMD_READ_MEMMAP;
> +	msg->insize = bytes;
> +	msg->outsize = sizeof(*params);
> +
> +	params = (struct ec_params_read_memmap *)msg->data;
> +	params->offset = offset;
> +	params->size = bytes;
> +
> +	ret = cros_ec_cmd_xfer_status(ec, msg);
> +	if (ret < 0) {
> +		dev_warn(ec->dev, "cannot read mapped reg: %d/%d\n",
> +			 ret, msg->result);
> +		goto out_free;
> +	}
> +
> +	memcpy(dest, msg->data, bytes);
> +
> +out_free:
> +	kfree(msg);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_readmem);
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 2060d1483043..b95c1a25adfc 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -666,6 +666,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>  	ec_dev->irq = spi->irq;
>  	ec_dev->cmd_xfer = cros_ec_cmd_xfer_spi;
>  	ec_dev->pkt_xfer = cros_ec_pkt_xfer_spi;
> +	ec_dev->cmd_readmem = cros_ec_readmem;
>  	ec_dev->phys_name = dev_name(&ec_spi->spi->dev);
>  	ec_dev->din_size = EC_MSG_PREAMBLE_COUNT +
>  			   sizeof(struct ec_host_response) +
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index de8b588c8776..0228fb42dcda 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -335,6 +335,18 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
>   */
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>  
> +/**
> + * cros_ec_readmem - Read mapped memory in the ChromeOS EC
> + *
> + * @ec: Device to read from
> + * @offset: Offset to read within the mapped region
> + * @bytes: number of bytes to read
> + * @data: Return data
> + * @return: 0 if Ok, -ve on error
> + */
> +int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
> +		    unsigned int bytes, void *dest);
> +
>  /* sysfs stuff */
>  extern struct attribute_group cros_ec_attr_group;
>  extern struct attribute_group cros_ec_lightbar_attr_group;
> 
