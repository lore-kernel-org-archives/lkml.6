Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeBYNUx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 08:20:53 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:38954 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBYNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 08:20:50 -0500
Date: Sun, 25 Feb 2018 13:20:14 +0000
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [SIL2review] [PATCH] i2c: img-scb: fix PM device usage count
Message-ID: <20180225132014.GA8844@osadl.at>
References: <20180224224303.3mpwhal2axcr6aos@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224224303.3mpwhal2axcr6aos@agrajag.zerfleddert.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 11:43:03PM +0100, Tobias Jordan wrote:
> pm_runtime_get_sync() increases the device's usage count even when
> reporting an error, so add a call to pm_runtime_put_noidle() in the
> error branch.

the increment is unconditional:
  pm_runtime_get_sync
  -> __pm_runtime_resume(dev, RPM_GET_PUT);
     -> if (rpmflags & RPM_GET_PUT) atomic_inc(&dev->power.usage_count);

the decrement though is conditional:
  pm_runtime_put_noidle
  -> atomic_add_unless(&dev->power.usage_count, -1, 0);

would it not be possible to use an atomic_dec() here rahter than
atomic_add_unless() ? probably only a few cylces

Also just wondering - could one not decrement in pm_runtime_get_sync on the
error path rather than defering this to the caller and fixing it there ?
something like:

int __pm_runtime_resume(struct device *dev, int rpmflags)
{
	...
	if (rpmflags & RPM_GET_PUT) 
		atomic_inc(&dev->power.usage_count);

        spin_lock_irqsave(&dev->power.lock, flags);
        retval = rpm_resume(dev, rpmflags);
        spin_unlock_irqrestore(&dev->power.lock, flags);

	if (retival < 0)
		atomic_dec(&dev->power.usage_count);

	return retval;
}

that would require other changes then I guess (did not look into it).
but if resume fails does it ever make sense to increment the use count ?

> 
> Fixes: 93222bd9b966 ("i2c: img-scb: Add runtime PM")
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>

Reviewed-by: Nicholas Mc Guire <der.herr@hofr.at>

> ---
> This is one of a number of patches for problems found using coccinelle 
> scripting in the SIL2LinuxMP project. The patch has been compile-tested;
> it's based on linux-next-20180223.
> 
> For a discussion of the corresponding issue, see
> https://marc.info/?l=linux-pm&m=151904483924999&w=2
> 
>  drivers/i2c/busses/i2c-img-scb.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
> index f038858b6c54..569a1a8a2753 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -1061,8 +1061,10 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	}
>  
>  	ret = pm_runtime_get_sync(adap->dev.parent);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(adap->dev.parent);
>  		return ret;
> +	}
>  
>  	for (i = 0; i < num; i++) {
>  		struct i2c_msg *msg = &msgs[i];
> @@ -1162,8 +1164,10 @@ static int img_i2c_init(struct img_i2c *i2c)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(i2c->adap.dev.parent);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(i2c->adap.dev.parent);
>  		return ret;
> +	}
>  
>  	rev = img_i2c_readl(i2c, SCB_CORE_REV_REG);
>  	if ((rev & 0x00ffffff) < 0x00020200) {
> -- 
> 2.11.0
> 
> _______________________________________________
> SIL2review mailing list
> SIL2review@lists.osadl.org
> https://lists.osadl.org/mailman/listinfo/sil2review
