Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeCPRVu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:21:50 -0400
Received: from muru.com ([72.249.23.125]:60726 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932101AbeCPRV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:21:26 -0400
Date: Fri, 16 Mar 2018 10:21:21 -0700
From: Tony Lindgren <tony@atomide.com>
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v6 0/5] Add coupled regulators mechanism
Message-ID: <20180316172121.GT5799@atomide.com>
References: <CGME20180309122231eucas1p1b8e0a85a73b31aa07eac08f809face6e@eucas1p1.samsung.com>
 <1520598128-11768-1-git-send-email-m.purski@samsung.com>
 <20180309124234.GC5252@sirena.org.uk>
 <20180309155827.GS5799@atomide.com>
 <c6f43013-3d2e-afbc-9be8-2e07f58fda98@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f43013-3d2e-afbc-9be8-2e07f58fda98@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Maciej Purski <m.purski@samsung.com> [180312 12:24]:
> On 03/09/2018 04:58 PM, Tony Lindgren wrote:
> > * Mark Brown <broonie@kernel.org> [180309 12:43]:
> > > On Fri, Mar 09, 2018 at 01:22:02PM +0100, Maciej Purski wrote:
> > > 
> > > > I would like to kindly ask Fabio Estevam and Tony Lindgren to test the patch
> > > > series on their boards.
> > 
> > I gave it a quick try and this set still causes at least mmc0
> > to fail for me.
>
> Thanks. Here's a small patch, which adds some debugs. Maybe they will reveal,
> where the problem is.

Sorry for the delay, now back from ELC. I tried applying this on
top of Linux next + your six patches but it fails to apply. Do
I need something else too?

Regards,

Tony


> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index f1f11cf..0e80ba5 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2280,7 +2280,6 @@ int regulator_enable(struct regulator *regulator)
>  {
>  	struct regulator_dev *rdev = regulator->rdev;
>  	int ret = 0;
> -	int ret2;
> 
>  	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
>  		rdev_err(rdev, "not all coupled regulators registered\n");
> @@ -2298,15 +2297,9 @@ int regulator_enable(struct regulator *regulator)
> 
>  	regulator_lock_dependent(rdev);
>  	ret = _regulator_enable(rdev);
> -	ret2 = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
> +	regulator_balance_voltage(rdev, PM_SUSPEND_ON);
>  	regulator_unlock_dependent(rdev);
> 
> -	if (ret2 != 0) {
> -		rdev_err(rdev,
> -			"balancing failed when trying to enable regulator: %d",
> -			ret2);
> -	}
> -
>  	if (ret != 0 && rdev->supply)
>  		regulator_disable(rdev->supply);
> 
> @@ -3149,7 +3142,7 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
>  		ret = regulator_set_voltage_unlocked(rdev->supply,
>  				best_supply_uV, INT_MAX, state);
>  		if (ret)
> -			dev_err(&rdev->dev, "Failed to decrease supply voltage: %d\n",
> +			dev_warn(&rdev->dev, "Failed to decrease supply voltage: %d\n",
>  					ret);
>  		/* No need to fail here */
>  		ret = 0;
> @@ -3332,11 +3325,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
>  		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
>  						 best_uV, state);
> 
> -		if (ret < 0) {
> -			rdev_err(rdev,
> -				"Failed to set voltage with error: %d", ret);
> +		if (ret < 0)
>  			goto out;
> -		}
>  	}
> 
>  out:
> 
> 
