Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeD3JEU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:04:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43987 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbeD3JET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:04:19 -0400
Date: Mon, 30 Apr 2018 11:04:18 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Eric Anholt <eric@anholt.net>
Cc: dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel: Enable DSI transactions on the RPi
 panel.
Message-ID: <20180430110418.5ba6baab@bbrezillon>
In-Reply-To: <20171031193258.17373-2-eric@anholt.net>
References: <20171031193258.17373-1-eric@anholt.net>
        <20171031193258.17373-2-eric@anholt.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2017 12:32:58 -0700
Eric Anholt <eric@anholt.net> wrote:

> It turns out that I had just mistaken what type of write the register
> writes were supposed to be, using DCS instead of generic long writes.
> 
> Switching to transactions instead of using the atmel as a bridge also
> seems to resolve the sparkling pixels problem I've had.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touchscreen.")

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> index d964d454e4ae..2c9c9722734f 100644
> --- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> +++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
> @@ -238,12 +238,6 @@ static void rpi_touchscreen_i2c_write(struct rpi_touchscreen *ts,
>  
>  static int rpi_touchscreen_write(struct rpi_touchscreen *ts, u16 reg, u32 val)
>  {
> -#if 0
> -	/* The firmware uses LP DSI transactions like this to bring up
> -	 * the hardware, which should be faster than using I2C to then
> -	 * pass to the Toshiba.  However, I was unable to get it to
> -	 * work.
> -	 */
>  	u8 msg[] = {
>  		reg,
>  		reg >> 8,
> @@ -253,13 +247,7 @@ static int rpi_touchscreen_write(struct rpi_touchscreen *ts, u16 reg, u32 val)
>  		val >> 24,
>  	};
>  
> -	mipi_dsi_dcs_write_buffer(ts->dsi, msg, sizeof(msg));
> -#else
> -	rpi_touchscreen_i2c_write(ts, REG_WR_ADDRH, reg >> 8);
> -	rpi_touchscreen_i2c_write(ts, REG_WR_ADDRL, reg);
> -	rpi_touchscreen_i2c_write(ts, REG_WRITEH, val >> 8);
> -	rpi_touchscreen_i2c_write(ts, REG_WRITEL, val);
> -#endif
> +	mipi_dsi_generic_write(ts->dsi, msg, sizeof(msg));
>  
>  	return 0;
>  }



-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
