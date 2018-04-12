Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeDLGUO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:20:14 -0400
Received: from leo.clearchain.com ([199.73.29.74]:19526 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeDLGUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:20:13 -0400
Date: Thu, 12 Apr 2018 16:20:01 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tasos Sahanidis <tasos@tasossah.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH] Input: leds - fix out of bound access
Message-ID: <20180412062001.GA5560@jelly>
References: <20180406181242.GA225849@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406181242.GA225849@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 11:12:42AM -0700, Dmitry Torokhov wrote:
> UI_SET_LEDBIT ioctl() causes the following KASAN splat when used with
> led > LED_CHARGING:
> 
> [ 1274.663418] BUG: KASAN: slab-out-of-bounds in input_leds_connect+0x611/0x730 [input_leds]
> [ 1274.663426] Write of size 8 at addr ffff88003377b2c0 by task ckb-next-daemon/5128
> 
> This happens because we were writing to the led structure before making
> sure that it exists.
> 
> Reported-by: Tasos Sahanidis <tasos@tasossah.com>
> Tested-by: Tasos Sahanidis <tasos@tasossah.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> ---
>  drivers/input/input-leds.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
> index 766bf26601163..5f04b2d946350 100644
> --- a/drivers/input/input-leds.c
> +++ b/drivers/input/input-leds.c
> @@ -88,6 +88,7 @@ static int input_leds_connect(struct input_handler *handler,
>  			      const struct input_device_id *id)
>  {
>  	struct input_leds *leds;
> +	struct input_led *led;
>  	unsigned int num_leds;
>  	unsigned int led_code;
>  	int led_no;
> @@ -119,14 +120,13 @@ static int input_leds_connect(struct input_handler *handler,
>  
>  	led_no = 0;
>  	for_each_set_bit(led_code, dev->ledbit, LED_CNT) {
> -		struct input_led *led = &leds->leds[led_no];
> +		if (!input_led_info[led_code].name)
> +			continue;
>  
> +		led = &leds->leds[led_no];
>  		led->handle = &leds->handle;
>  		led->code = led_code;
>  
> -		if (!input_led_info[led_code].name)
> -			continue;
> -
>  		led->cdev.name = kasprintf(GFP_KERNEL, "%s::%s",
>  					   dev_name(&dev->dev),
>  					   input_led_info[led_code].name);
> -- 
> 2.17.0.484.g0c8726318c-goog
