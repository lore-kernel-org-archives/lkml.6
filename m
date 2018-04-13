Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeDMQIb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:08:31 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37048 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDMQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:08:28 -0400
X-Google-Smtp-Source: AIpwx4/x3sZSkJg+KvTWndugWbRqVo4ox88cZ6HNgIBUnu7/L6BqafBYzFFBBUKn95lC7WIiR30U5A==
Date: Fri, 13 Apr 2018 18:08:24 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RESEND] backlight: pwm_bl: don't use GPIOF_* with
 gpiod_get_direction
Message-ID: <20180413160824.GD31310@phenom.ffwll.local>
Mail-Followup-To: Simon Horman <horms@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
References: <20180410123241.25745-1-wsa+renesas@sang-engineering.com>
 <20180411073215.fzvh4ejj2kd7wam3@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411073215.fzvh4ejj2kd7wam3@verge.net.au>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 09:32:16AM +0200, Simon Horman wrote:
> On Tue, Apr 10, 2018 at 02:32:40PM +0200, Wolfram Sang wrote:
> > The documentation was wrong, gpiod_get_direction() returns 0/1 instead
> > of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
> > ("gpio: correct docs about return value of gpiod_get_direction"). Now,
> > fix this user (until a better, system-wide solution is in place).
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
> > ---
> > 
> > Changes since V1:
> > 	* rebased to top-of-linus-tree
> > 	* added tag from Daniel, thanks!
> > 
> > Through which tree does this need to go?

I think Daniel Thompson has one ...
-Daniel

> > 
> >  drivers/video/backlight/pwm_bl.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 1c2289ddd555..0fa7d2bd0e48 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -301,14 +301,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  
> >  	/*
> >  	 * If the GPIO is not known to be already configured as output, that
> > -	 * is, if gpiod_get_direction returns either GPIOF_DIR_IN or -EINVAL,
> > -	 * change the direction to output and set the GPIO as active.
> > +	 * is, if gpiod_get_direction returns either 1 or -EINVAL, change the
> > +	 * direction to output and set the GPIO as active.
> >  	 * Do not force the GPIO to active when it was already output as it
> >  	 * could cause backlight flickering or we would enable the backlight too
> >  	 * early. Leave the decision of the initial backlight state for later.
> >  	 */
> >  	if (pb->enable_gpio &&
> > -	    gpiod_get_direction(pb->enable_gpio) != GPIOF_DIR_OUT)
> > +	    gpiod_get_direction(pb->enable_gpio) != 0)
> >  		gpiod_direction_output(pb->enable_gpio, 1);
> >  
> >  	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
> > -- 
> > 2.11.0
> > 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
