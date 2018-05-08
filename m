Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933026AbeEHWct (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:32:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34881 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeEHWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:32:48 -0400
X-Google-Smtp-Source: AB8JxZoqLbUQiTSwyk6/YKuP6KCwJ1X2waiMZ/zZxmkhxF/+a6odLA2g2uLzDsDPA/VEwaUNSigm6g==
Date: Tue, 8 May 2018 15:32:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] input: gamecon: avoid using __set_bit() for
 capabilities
Message-ID: <20180508223244.GC129015@dtor-ws>
References: <20180331112143.18768-1-marcus.folkesson@gmail.com>
 <20180331112143.18768-3-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331112143.18768-3-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 01:21:42PM +0200, Marcus Folkesson wrote:
> input_set_capability() and input_set_abs_param() will do it for you.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/gamecon.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
> index 2ffb2e8bdc3b..e3a9ef3d5f5a 100644
> --- a/drivers/input/joystick/gamecon.c
> +++ b/drivers/input/joystick/gamecon.c
> @@ -862,7 +862,7 @@ static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
>  
>  	case GC_N64:
>  		for (i = 0; i < 10; i++)
> -			__set_bit(gc_n64_btn[i], input_dev->keybit);
> +			input_set_capability(input_dev, EV_KEY, gc_n64_btn[i]);
>  
>  		for (i = 0; i < 2; i++) {
>  			input_set_abs_params(input_dev, ABS_X + i, -127, 126, 0, 2);
> @@ -879,26 +879,27 @@ static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
>  		break;
>  
>  	case GC_SNESMOUSE:
> -		__set_bit(BTN_LEFT, input_dev->keybit);
> -		__set_bit(BTN_RIGHT, input_dev->keybit);
> -		__set_bit(REL_X, input_dev->relbit);
> -		__set_bit(REL_Y, input_dev->relbit);
> +		input_set_capability(input_dev, EV_KEY, BTN_LEFT);
> +		input_set_capability(input_dev, EV_KEY, BTN_RIGHT);
> +		input_set_capability(input_dev, EV_REL, REL_X);
> +		input_set_capability(input_dev, EV_REL, REL_Y);
>  		break;
>  
>  	case GC_SNES:
>  		for (i = 4; i < 8; i++)
> -			__set_bit(gc_snes_btn[i], input_dev->keybit);
> +			input_set_capability(input_dev, EV_KEY, gc_snes_btn[i]);
>  		/* fall through */
>  	case GC_NES:
>  		for (i = 0; i < 4; i++)
> -			__set_bit(gc_snes_btn[i], input_dev->keybit);
> +			input_set_capability(input_dev, EV_KEY, gc_snes_btn[i]);
>  		break;
>  
>  	case GC_MULTI2:
> -		__set_bit(BTN_THUMB, input_dev->keybit);
> +		input_set_capability(input_dev, EV_KEY, BTN_THUMB);
>  		/* fall through */
>  	case GC_MULTI:
> -		__set_bit(BTN_TRIGGER, input_dev->keybit);
> +		input_set_capability(input_dev, EV_KEY, BTN_TRIGGER);
> +		/* fall through */
>  		break;
>  
>  	case GC_PSX:
> @@ -906,15 +907,16 @@ static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
>  			input_set_abs_params(input_dev,
>  					     gc_psx_abs[i], 4, 252, 0, 2);
>  		for (i = 0; i < 12; i++)
> -			__set_bit(gc_psx_btn[i], input_dev->keybit);
> +			input_set_capability(input_dev, EV_KEY, gc_psx_btn[i]);
> +		break;
>  
>  		break;
>  
>  	case GC_DDR:
>  		for (i = 0; i < 4; i++)
> -			__set_bit(gc_psx_ddr_btn[i], input_dev->keybit);
> +			input_set_capability(input_dev, EV_KEY, gc_psx_ddr_btn[i]);
>  		for (i = 0; i < 12; i++)
> -			__set_bit(gc_psx_btn[i], input_dev->keybit);
> +			input_set_capability(input_dev, EV_KEY, gc_psx_btn[i]);
>  
>  		break;
>  	}
> -- 
> 2.16.2
> 

-- 
Dmitry
