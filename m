Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeDMFjL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:39:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:42320 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750867AbeDMFjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:39:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,444,1517904000";
   d="scan'208";a="31720628"
Message-ID: <1523597945.16235.52.camel@intel.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
From: Zhang Rui <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Date: Fri, 13 Apr 2018 13:39:05 +0800
In-Reply-To: <20180413040855.GA29826@localhost.localdomain>
References: <1523436077.16235.5.camel@intel.com>
         <CA+55aFzqJ2PfUnkVJ6A-8WRQTciWb8j+25r41JLCvz7h0QEJiA@mail.gmail.com>
         <1523509711.16235.25.camel@intel.com>
         <CA+55aFw0C-S0L-cnk0oROG=Khqy9s36O+g3_BxqPfewKGQ9_EQ@mail.gmail.com>
         <20180413040855.GA29826@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eduardo,

On 四, 2018-04-12 at 21:08 -0700, Eduardo Valentin wrote:
> Hello,
> 
> On Thu, Apr 12, 2018 at 09:55:19AM -0700, Linus Torvalds wrote:
> > 
> > On Wed, Apr 11, 2018 at 10:08 PM, Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > > 
> > > 
> > > could you please illustrate me what the kconfig & warning is?
> > Just "make allmodconfig" and the warning is about a uninitialized
> > variable.
> > 
> > Line 304 in drivers/thermal/samsung/exynos_tmu.c if my shell
> > history
> > is to be believed.
> > 
> >                 Linus
> Yeah, this has also passed my local compilation error. Somehow my
> gcc4.9
> is not catching it. Using an older gcc (gcc4.6) does catch it.
> 
> Anyways, given that the conversion functions are written to cover
> for unexpected cal_type, the right way of fixing this is to rewrite
> the conversion functions to allow for returning error codes and
> adjusting the callers as expected.
> 
> Rui, bzolnier, please consider the following fix:
> 
as it is late in this merge window, I'd prefer to
1. drop all the thermal-soc material in the first pull request which I
will send out soon.
2. you can prepare another pull request containing the thermal-soc
materials except the exynos fixes
3. exynos fixes with the problem solved can be queued for -rc2 or
later.

thanks,
rui

> From 2aaf94f80c0021a21b4122c9f4197acff08ea398 Mon Sep 17 00:00:00
> 2001
> From: Eduardo Valentin <edubezval@gmail.com>
> Date: Thu, 12 Apr 2018 21:00:48 -0700
> Subject: [PATCH 1/1] thermal: exynos: fix compilation warning around
>  conversion functions
> 
> In order to fix the warns:
> drivers/thermal/samsung/exynos_tmu.c:931:37: warning: 'temp' may be
> used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/thermal/samsung/exynos_tmu.c:304:9: warning: 'temp_code' may
> be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> the conversion functions should allow return error codes
> and the not mix the converted value with error code.
> 
> This patch change the conversion functions to return
> error code or success and adjusts the callers accordingly.
> 
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 120 ++++++++++++++++++++++++-
> ----------
>  1 file changed, 84 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> b/drivers/thermal/samsung/exynos_tmu.c
> index 2ec8548..b3f0704 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -282,52 +282,54 @@ static void exynos_report_trigger(struct
> exynos_tmu_data *p)
>   * TMU treats temperature as a mapped temperature code.
>   * The temperature is converted differently depending on the
> calibration type.
>   */
> -static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
> +static int temp_to_code(struct exynos_tmu_data *data, u8 temp, int
> *temp_code)
>  {
> -	int temp_code;
> +	int ret = 0;
>  
>  	switch (data->cal_type) {
>  	case TYPE_TWO_POINT_TRIMMING:
> -		temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
> +		*temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
>  			(data->temp_error2 - data->temp_error1) /
>  			(EXYNOS_SECOND_POINT_TRIM -
> EXYNOS_FIRST_POINT_TRIM) +
>  			data->temp_error1;
>  		break;
>  	case TYPE_ONE_POINT_TRIMMING:
> -		temp_code = temp + data->temp_error1 -
> EXYNOS_FIRST_POINT_TRIM;
> +		*temp_code = temp + data->temp_error1 -
> EXYNOS_FIRST_POINT_TRIM;
>  		break;
>  	default:
>  		WARN_ON(1);
> +		ret = -EINVAL;
>  		break;
>  	}
>  
> -	return temp_code;
> +	return ret;
>  }
>  
>  /*
>   * Calculate a temperature value from a temperature code.
>   * The unit of the temperature is degree Celsius.
>   */
> -static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
> +static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code,
> int *temp)
>  {
> -	int temp;
> +	int ret = 0;
>  
>  	switch (data->cal_type) {
>  	case TYPE_TWO_POINT_TRIMMING:
> -		temp = (temp_code - data->temp_error1) *
> +		*temp = (temp_code - data->temp_error1) *
>  			(EXYNOS_SECOND_POINT_TRIM -
> EXYNOS_FIRST_POINT_TRIM) /
>  			(data->temp_error2 - data->temp_error1) +
>  			EXYNOS_FIRST_POINT_TRIM;
>  		break;
>  	case TYPE_ONE_POINT_TRIMMING:
> -		temp = temp_code - data->temp_error1 +
> EXYNOS_FIRST_POINT_TRIM;
> +		*temp = temp_code - data->temp_error1 +
> EXYNOS_FIRST_POINT_TRIM;
>  		break;
>  	default:
>  		WARN_ON(1);
> +		ret = -EINVAL;
>  		break;
>  	}
>  
> -	return temp;
> +	return ret;
>  }
>  
>  static void sanitize_temp_error(struct exynos_tmu_data *data, u32
> trim_info)
> @@ -352,7 +354,7 @@ static u32 get_th_reg(struct exynos_tmu_data
> *data, u32 threshold, bool falling)
>  	struct thermal_zone_device *tz = data->tzd;
>  	const struct thermal_trip * const trips =
>  		of_thermal_get_trip_points(tz);
> -	unsigned long temp;
> +	int temp;
>  	int i;
>  
>  	if (!trips) {
> @@ -362,6 +364,8 @@ static u32 get_th_reg(struct exynos_tmu_data
> *data, u32 threshold, bool falling)
>  	}
>  
>  	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
> +		int val, ret;
> +
>  		if (trips[i].type == THERMAL_TRIP_CRITICAL)
>  			continue;
>  
> @@ -371,7 +375,14 @@ static u32 get_th_reg(struct exynos_tmu_data
> *data, u32 threshold, bool falling)
>  		else
>  			threshold &= ~(0xff << 8 * i);
>  
> -		threshold |= temp_to_code(data, temp) << 8 * i;
> +		ret = temp_to_code(data, temp, &val);
> +		if (ret) {
> +			pr_err("%s: Convertion error from temp (%d)
> to code: %d!\n",
> +				__func__, temp, ret);
> +			return 0;
> +		}
> +
> +		threshold |= val << 8 * i;
>  	}
>  
>  	return threshold;
> @@ -460,11 +471,10 @@ static int exynos4210_tmu_initialize(struct
> platform_device *pdev)
>  
>  	/* Write temperature code for threshold */
>  	reference = trips[0].temperature / MCELSIUS;
> -	threshold_code = temp_to_code(data, reference);
> -	if (threshold_code < 0) {
> -		ret = threshold_code;
> +	ret = temp_to_code(data, reference, &threshold_code);
> +	if (ret < 0 || threshold_code < 0)
>  		goto out;
> -	}
> +
>  	writeb(threshold_code, data->base +
> EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
>  
>  	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
> @@ -537,7 +547,10 @@ static int exynos4412_tmu_initialize(struct
> platform_device *pdev)
>  		goto out;
>  	}
>  
> -	threshold_code = temp_to_code(data, crit_temp / MCELSIUS);
> +	ret = temp_to_code(data, crit_temp / MCELSIUS,
> &threshold_code);
> +	if (ret)
> +		goto out;
> +
>  	/* 1-4 level to be assigned in th0 reg */
>  	rising_threshold &= ~(0xff << 8 * i);
>  	rising_threshold |= threshold_code << 8 * i;
> @@ -620,7 +633,9 @@ static int exynos5433_tmu_initialize(struct
> platform_device *pdev)
>  		/* Write temperature code for rising threshold */
>  		tz->ops->get_trip_temp(tz, i, &temp);
>  		temp /= MCELSIUS;
> -		threshold_code = temp_to_code(data, temp);
> +		ret = temp_to_code(data, temp, &threshold_code);
> +		if (ret)
> +			goto out;
>  
>  		rising_threshold = readl(data->base +
> rising_reg_offset);
>  		rising_threshold |= (threshold_code << j * 8);
> @@ -629,7 +644,9 @@ static int exynos5433_tmu_initialize(struct
> platform_device *pdev)
>  		/* Write temperature code for falling threshold */
>  		tz->ops->get_trip_hyst(tz, i, &temp_hist);
>  		temp_hist = temp - (temp_hist / MCELSIUS);
> -		threshold_code = temp_to_code(data, temp_hist);
> +		ret = temp_to_code(data, temp_hist,
> &threshold_code);
> +		if (ret)
> +			goto out;
>  
>  		falling_threshold = readl(data->base +
> falling_reg_offset);
>  		falling_threshold &= ~(0xff << j * 8);
> @@ -677,7 +694,12 @@ static int exynos5440_tmu_initialize(struct
> platform_device *pdev)
>  
>  	/* if last threshold limit is also present */
>  	if (!data->tzd->ops->get_crit_temp(data->tzd, &crit_temp)) {
> -		threshold_code = temp_to_code(data, crit_temp /
> MCELSIUS);
> +		int ret;
> +
> +		ret = temp_to_code(data, crit_temp / MCELSIUS,
> &threshold_code);
> +		if (ret)
> +			return ret;
> +
>  		/* 5th level to be assigned in th2 reg */
>  		rising_threshold =
>  			threshold_code <<
> EXYNOS5440_TMU_TH_RISE4_SHIFT;
> @@ -749,7 +771,10 @@ static int exynos7_tmu_initialize(struct
> platform_device *pdev)
>  		temp_hist = temp - (temp_hist / MCELSIUS);
>  
>  		/* Set 9-bit temperature code for rising threshold
> levels */
> -		threshold_code = temp_to_code(data, temp);
> +		ret = temp_to_code(data, temp, &threshold_code);
> +		if (ret)
> +			goto out;
> +
>  		rising_threshold = readl(data->base +
>  			EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
>  		rising_threshold &= ~(EXYNOS7_TMU_TEMP_MASK << (16 *
> bit_off));
> @@ -758,7 +783,9 @@ static int exynos7_tmu_initialize(struct
> platform_device *pdev)
>  		       data->base + EXYNOS7_THD_TEMP_RISE7_6 +
> reg_off);
>  
>  		/* Set 9-bit temperature code for falling threshold
> levels */
> -		threshold_code = temp_to_code(data, temp_hist);
> +		ret = temp_to_code(data, temp_hist,
> &threshold_code);
> +		if (ret)
> +			goto out;
>  		falling_threshold &= ~(EXYNOS7_TMU_TEMP_MASK << (16
> * bit_off));
>  		falling_threshold |= threshold_code << (16 *
> bit_off);
>  		writel(falling_threshold,
> @@ -925,11 +952,18 @@ static int exynos_get_temp(void *p, int *temp)
>  	clk_enable(data->clk);
>  
>  	value = data->tmu_read(data);
> -	if (value < 0)
> +	if (value < 0) {
>  		ret = value;
> -	else
> -		*temp = code_to_temp(data, value) * MCELSIUS;
> +		goto out;
> +	}
> +
> +	ret = code_to_temp(data, value, temp);
> +	if (ret)
> +		goto out;
>  
> +	*temp *= MCELSIUS;
> +
> +out:
>  	clk_disable(data->clk);
>  	mutex_unlock(&data->lock);
>  
> @@ -937,9 +971,11 @@ static int exynos_get_temp(void *p, int *temp)
>  }
>  
>  #ifdef CONFIG_THERMAL_EMULATION
> -static u32 get_emul_con_reg(struct exynos_tmu_data *data, unsigned
> int val,
> -			    int temp)
> +static int get_emul_con_reg(struct exynos_tmu_data *data, unsigned
> int val,
> +			    int temp, u32 *con_reg)
>  {
> +	int code, ret = 0;
> +
>  	if (temp) {
>  		temp /= MCELSIUS;
>  
> @@ -950,27 +986,36 @@ static u32 get_emul_con_reg(struct
> exynos_tmu_data *data, unsigned int val,
>  		if (data->soc == SOC_ARCH_EXYNOS7) {
>  			val &= ~(EXYNOS7_EMUL_DATA_MASK <<
>  				EXYNOS7_EMUL_DATA_SHIFT);
> -			val |= (temp_to_code(data, temp) <<
> -				EXYNOS7_EMUL_DATA_SHIFT) |
> +			ret = temp_to_code(data, temp, &code);
> +			if (ret)
> +				goto out;
> +
> +			val |= (code << EXYNOS7_EMUL_DATA_SHIFT) |
>  				EXYNOS_EMUL_ENABLE;
>  		} else {
>  			val &= ~(EXYNOS_EMUL_DATA_MASK <<
>  				EXYNOS_EMUL_DATA_SHIFT);
> -			val |= (temp_to_code(data, temp) <<
> -				EXYNOS_EMUL_DATA_SHIFT) |
> +			ret = temp_to_code(data, temp, &code);
> +			if (ret)
> +				goto out;
> +
> +			val |= (code << EXYNOS_EMUL_DATA_SHIFT) |
>  				EXYNOS_EMUL_ENABLE;
>  		}
>  	} else {
>  		val &= ~EXYNOS_EMUL_ENABLE;
>  	}
>  
> -	return val;
> +	*con_reg = val;
> +out:
> +	return ret;
>  }
>  
>  static void exynos4412_tmu_set_emulation(struct exynos_tmu_data
> *data,
>  					 int temp)
>  {
>  	unsigned int val;
> +	int ret;
>  	u32 emul_con;
>  
>  	if (data->soc == SOC_ARCH_EXYNOS5260)
> @@ -983,18 +1028,21 @@ static void
> exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
>  		emul_con = EXYNOS_EMUL_CON;
>  
>  	val = readl(data->base + emul_con);
> -	val = get_emul_con_reg(data, val, temp);
> -	writel(val, data->base + emul_con);
> +	ret = get_emul_con_reg(data, val, temp, &val);
> +	if (!ret)
> +		writel(val, data->base + emul_con);
>  }
>  
>  static void exynos5440_tmu_set_emulation(struct exynos_tmu_data
> *data,
>  					 int temp)
>  {
>  	unsigned int val;
> +	int ret;
>  
>  	val = readl(data->base + EXYNOS5440_TMU_S0_7_DEBUG);
> -	val = get_emul_con_reg(data, val, temp);
> -	writel(val, data->base + EXYNOS5440_TMU_S0_7_DEBUG);
> +	ret = get_emul_con_reg(data, val, temp, &val);
> +	if (!ret)
> +		writel(val, data->base + EXYNOS5440_TMU_S0_7_DEBUG);
>  }
>  
>  static int exynos_tmu_set_emulation(void *drv_data, int temp)
