Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeFDOUz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:20:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55283 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFDOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:20:54 -0400
Message-ID: <1528122047.2728.10.camel@pengutronix.de>
Subject: Re: [PATCH 5/7] regulator: core: Lock dependent regulators
From: Lucas Stach <l.stach@pengutronix.de>
To: Maciej Purski <m.purski@samsung.com>, Mark Brown <broonie@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date: Mon, 04 Jun 2018 16:20:47 +0200
In-Reply-To: <1528120764-14316-6-git-send-email-m.purski@samsung.com>
References: <20180530144505.GB5705@atomide.com>
         <1528120764-14316-1-git-send-email-m.purski@samsung.com>
         <CGME20180604135954eucas1p2156fed3300b5514a4efa2baf9e7b9bc5@eucas1p2.samsung.com>
         <1528120764-14316-6-git-send-email-m.purski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

Am Montag, den 04.06.2018, 15:59 +0200 schrieb Maciej Purski:
> Implementing coupled regulators adds a new dependency between
> regulators. Therefore, the current locking model should be changed.
> Coupled regulators should be locked with regulator's supplies at the
> same time.
> 
> Add new function regulator_lock_dependent(), which locks all regulators
> related with the one, that is being changed.

Sort of high level comment, but this doesn't look right: With dependent
regulators you don't strictly lock the regulators in the direction of
the tree root, but also siblings at the same level. This is prone with
deadlocks, as you can't control the order of the regulator locks being
taken by different tasks. This really needs a ww_mutex to be
implemented in a robust way.

Regards,
Lucas

> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  drivers/regulator/core.c | 75 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 52 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 0b366c5..7c57268 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -201,38 +201,67 @@ static void regulator_unlock(struct regulator_dev *rdev)
> >  	}
>  }
>  
> -/**
> - * regulator_lock_supply - lock a regulator and its supplies
> - * @rdev:         regulator source
> - */
> -static void regulator_lock_supply(struct regulator_dev *rdev)
> +static int regulator_lock_recursive(struct regulator_dev *rdev,
> > +				    unsigned int subclass)
>  {
> > +	struct regulator_dev *c_rdev;
> >  	int i;
>  
> > -	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
> > -		regulator_lock_nested(rdev, i);
> > +	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
> > +		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
> +
> > +		if (!c_rdev)
> > +			continue;
> +
> > +		regulator_lock_nested(c_rdev, subclass++);
> +
> > +		if (c_rdev->supply)
> > +			subclass =
> > +				regulator_lock_recursive(c_rdev->supply->rdev,
> > +							 subclass);
> > +	}
> +
> > +	return subclass;
>  }
>  
>  /**
> - * regulator_unlock_supply - unlock a regulator and its supplies
> - * @rdev:         regulator source
> + * regulator_unlock_dependent - unlock regulator's suppliers and coupled
> > + *				regulators
> > + * @rdev:			regulator source
> + *
> + * Unlock all regulators related with rdev by coupling or suppling.
>   */
> -static void regulator_unlock_supply(struct regulator_dev *rdev)
> +static void regulator_unlock_dependent(struct regulator_dev *rdev)
>  {
> > -	struct regulator *supply;
> > +	struct regulator_dev *c_rdev;
> > +	int i;
>  
> > -	while (1) {
> > -		regulator_unlock(rdev);
> > -		supply = rdev->supply;
> > +	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
> > +		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
>  
> > -		if (!rdev->supply)
> > -			return;
> > +		if (!c_rdev)
> > +			continue;
> +
> > +		regulator_unlock(c_rdev);
>  
> > -		rdev = supply->rdev;
> > +		if (c_rdev->supply)
> > +			regulator_unlock_dependent(c_rdev->supply->rdev);
> >  	}
>  }
>  
>  /**
> + * regulator_lock_dependent - lock regulator's suppliers and coupled regulators
> > + * @rdev:			regulator source
> + *
> + * This function as a wrapper on regulator_lock_recursive(), which locks
> + * all regulators related with rdev by coupling or suppling.
> + */
> +static inline void regulator_lock_dependent(struct regulator_dev *rdev)
> +{
> > +	regulator_lock_recursive(rdev, 0);
> +}
> +
> +/**
>   * of_get_regulator - get a regulator device node based on supply name
>   * @dev: Device pointer for the consumer (of regulator) device
>   * @supply: regulator supply name
> @@ -3332,12 +3361,12 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
> >  	int ret = 0;
>  
> >  	pr_err("%s: %d\n", __func__, __LINE__);
> > -	regulator_lock_supply(regulator->rdev);
> > +	regulator_lock_dependent(regulator->rdev);
>  
> >  	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
> >  					     PM_SUSPEND_ON);
>  
> > -	regulator_unlock_supply(regulator->rdev);
> > +	regulator_unlock_dependent(regulator->rdev);
>  
> >  	return ret;
>  }
> @@ -3415,12 +3444,12 @@ int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
> >  	if (regulator_check_states(state) || state == PM_SUSPEND_ON)
> >  		return -EINVAL;
>  
> > -	regulator_lock_supply(regulator->rdev);
> > +	regulator_lock_dependent(regulator->rdev);
>  
> >  	ret = _regulator_set_suspend_voltage(regulator, min_uV,
> >  					     max_uV, state);
>  
> > -	regulator_unlock_supply(regulator->rdev);
> > +	regulator_unlock_dependent(regulator->rdev);
>  
> >  	return ret;
>  }
> @@ -3612,11 +3641,11 @@ int regulator_get_voltage(struct regulator *regulator)
>  {
> >  	int ret;
>  
> > -	regulator_lock_supply(regulator->rdev);
> > +	regulator_lock_dependent(regulator->rdev);
>  
> >  	ret = _regulator_get_voltage(regulator->rdev);
>  
> > -	regulator_unlock_supply(regulator->rdev);
> > +	regulator_unlock_dependent(regulator->rdev);
>  
> >  	return ret;
>  }
