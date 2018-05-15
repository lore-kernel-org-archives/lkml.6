Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbeEOP3k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:29:40 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:41567 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752522AbeEOP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:29:38 -0400
Subject: Re: [PATCH v2 4/5] mfd: cros_ec_dev: Add CEC sub-device registration
To: Neil Armstrong <narmstrong@baylibre.com>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1526395342-15481-1-git-send-email-narmstrong@baylibre.com>
 <1526395342-15481-5-git-send-email-narmstrong@baylibre.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <568980a1-9c22-ccdb-de43-ba88cdce4ecd@xs4all.nl>
Date: Tue, 15 May 2018 17:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1526395342-15481-5-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFLgUpe/Pe0UurlfosCcfImI9XFesMGIV4q5hreu+nUviObAGWzLI9nwPMqvV5xt8PSvl+XZgqcxPGHagjMyWRRcu56ylou2lQofPpWn6KNJaZezt88P
 ijNdF0wfvzGxyQkNkHy9f43hnBPHRwz0Ix/+Kj9gllSo0ZUcSgKUO005ih4BsqjHXqNEsWhRyxQOhmk8gcImTBqs4vCypyvhwnmDtsaNm5T3cX/LN+MPK1fW
 EI4me8faCRMocgoMacnHjcxxAt+jQ+7R4lP8GCgudNJCS7ZS2ss/IhLmNoIw1RRFI75ufE9z9AoFJAKq3TrmwJkEGoSUOp1Lp8PTGkG+GXme1j2NgsehbycM
 5VNjpLYhd+IGtMeiWldDH035LOGha6MOre29Noj9V6bGc28c5ftlvQDBfV+6FKjyT98ZTtaavdr2+9uARUYPeWM0aVtvJlhvrpkgaFXKzZQV7Om9jdExD93N
 r1HwlO7GlpGj2eH54JwNnZdKL+hw3zCc25c2n2qWvRwqNMoQkkAdMqzVIZxOYi0b2QMPrsEVJeP2GDuuPhWXJNBjrpx5ZaswA9cor2RRr/Cqul7fB8L2rnc9
 uuOsx18MyLRUokYXWJm6XBk0zFP4odu7o7KMkdB2aF0YzCIwO9XcrAsPPCqQbNFps/2tAotubqUUruAFm+vQwwoTS+gUX+MYY6gAieLL0GZmBVUIuKZunqXx
 /A0MjB9Pi94=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 04:42 PM, Neil Armstrong wrote:
> The EC can expose a CEC bus, thus add the cros-ec-cec MFD sub-device
> when the CEC feature bit is present.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

For what it is worth (not an MFD expert):

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

	Hans

> ---
>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index eafd06f..57064ec 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -383,6 +383,18 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  	kfree(msg);
>  }
>  
> +static void cros_ec_cec_register(struct cros_ec_dev *ec)
> +{
> +	int ret;
> +	struct mfd_cell cec_cell = {
> +		.name = "cros-ec-cec",
> +	};
> +
> +	ret = mfd_add_devices(ec->dev, 0, &cec_cell, 1, NULL, 0, NULL);
> +	if (ret)
> +		dev_err(ec->dev, "failed to add EC CEC\n");
> +}
> +
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>  	int retval = -ENOMEM;
> @@ -422,6 +434,10 @@ static int ec_device_probe(struct platform_device *pdev)
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec);
>  
> +	/* check whether this EC handles CEC. */
> +	if (cros_ec_check_features(ec, EC_FEATURE_CEC))
> +		cros_ec_cec_register(ec);
> +
>  	/* Take control of the lightbar from the EC. */
>  	lb_manual_suspend_ctrl(ec, 1);
>  
> 
