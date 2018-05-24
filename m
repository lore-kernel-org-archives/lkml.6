Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967989AbeEXLYr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:24:47 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:57671 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967779AbeEXLY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:24:28 -0400
Subject: Re: [PATCH v6 5/6] mfd: cros_ec_dev: Add CEC sub-device registration
To: Neil Armstrong <narmstrong@baylibre.com>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
References: <1527155841-28494-1-git-send-email-narmstrong@baylibre.com>
 <1527155841-28494-6-git-send-email-narmstrong@baylibre.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5fa2ded2-3072-6dba-dd7f-1dc39fdc4d23@xs4all.nl>
Date: Thu, 24 May 2018 13:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527155841-28494-6-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfG7O1qtiOtosQTIq224GLZB9cesuFpvbrjjIkPgcgYgnDNFZW1OJqZqWh+tO0OqBYG04Gz77WXZD0bgQZBiTNzaZzABcCqFXiiI5vXqi7z6N5FlN3Pxh
 cRkbOtuBHFVIGbWhztXI4pWBLNPfdMUzyJ52UEL9bvOhVBIadrxz45dIpfFVbO5s4LyAvpU1r9NGCO/ZhoUfgsy4oKaWuORYDhImTSXzhUPnCDCBs/64j8h3
 r0s/7gcNADfrzlVzyAsFWCxXzfAomYqFldOJ2iu6eapq27oM+iIawv060Kdt3ycnl53/5ZueWNNTOTWHCwnfxk3G5K7a1FbpethzOlGyf/o8TvwCv8K2yMag
 1WYN5uglo4gQEwn0ioMU7hPW52OMwtLLv2W2oOse5Ytd7meNByI6ZwILOSx0LPmo1QUfsI0tP6HF42vpyou+2Vo5v6zuNBJ4CHyl+zsWQHwqCZOAJxVUDKFs
 l4ESx0ElhDcrojxvnBjBubGPg7zVIbEKXTfN8OdB3xk0sXocY9+PWHhNY5mN7fK2gRuNXmXsCLPywLdr6w6YJIJCl4BmIhTF4LdJNdPD+19KpEos8zvtxcgs
 DUwMQvMYTXufv6CzTdG/uDiQDBwHmn/JsmBNXqOA6uQKwzBbQbGzIaVO+iGgLcuuZJdywzLt2uRhtUMfkA0MYpDfG6xEV3HBS2SHs2aprDdokniMWiJJDlal
 mqrHhOdB9+vQDeh9j40t7CM2HjzIdyeZ1fhSbIuQnIrl8aNsXmw5AvRt9pzuw5TbgJ7XqivexT0w9euDN/v/zBcAVatYPSihbvoe5bt73l12tej/XZo6SdEE
 0BtjnU8yDfLAJGklPSg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 11:57, Neil Armstrong wrote:
> The EC can expose a CEC bus, thus add the cros-ec-cec MFD sub-device
> when the CEC feature bit is present.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

For whatever it is worth:

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans

> ---
>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 1d6dc5c..272969e 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -383,6 +383,10 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  	kfree(msg);
>  }
>  
> +static const struct mfd_cell cros_ec_cec_cells[] = {
> +	{ .name = "cros-ec-cec" }
> +};
> +
>  static const struct mfd_cell cros_ec_rtc_cells[] = {
>  	{ .name = "cros-ec-rtc" }
>  };
> @@ -426,6 +430,18 @@ static int ec_device_probe(struct platform_device *pdev)
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec);
>  
> +	/* Check whether this EC instance has CEC host command support */
> +	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
> +		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> +					 cros_ec_cec_cells,
> +					 ARRAY_SIZE(cros_ec_cec_cells),
> +					 NULL, 0, NULL);
> +		if (retval)
> +			dev_err(ec->dev,
> +				"failed to add cros-ec-cec device: %d\n",
> +				retval);
> +	}
> +
>  	/* Check whether this EC instance has RTC host command support */
>  	if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
>  		retval = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> 
