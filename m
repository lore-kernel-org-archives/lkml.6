Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeCIIMZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:12:25 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7948 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeCIIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:12:22 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Mar 2018 00:12:22 -0800
Date: Fri, 9 Mar 2018 10:12:17 +0200
From: Peter De Schrijver <pdeschrijver@nvidia.com>
To: Jon Hunter <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/11] clk: tegra: dfll: support PWM regulator control
Message-ID: <20180309081217.GN6190@tbergstrom-lnx.Nvidia.com>
References: <1517934852-23255-1-git-send-email-pdeschrijver@nvidia.com>
 <1517934852-23255-7-git-send-email-pdeschrijver@nvidia.com>
 <c2026bdf-e796-22ac-c5b3-f022f23c493e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c2026bdf-e796-22ac-c5b3-f022f23c493e@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [10.21.24.170]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 11:15:17PM +0000, Jon Hunter wrote:
> 
> On 06/02/18 16:34, Peter De Schrijver wrote:
> > The DFLL can directly generate a PWM signal to control the regulator IC
> > rather then sending i2c messages. This patch adds support for this mode.
> > In this mode the hardware LUT is not used and also there is no regulator
> > object involved because there is no way to control the regulator voltage
> > without also changing the DFLL output frequency. Also the register debugfs
> > file is slightly reworked to only show the i2c registers when i2c mode is
> > in use. As there is no regulator object for the PWM regulator, its step and
> > offset values are retrieved from DT instead.
> 
> It is unclear to me why we bother creating the LUT for PWM if it is not
> used? Is this for debug to get an approximation? Why do we do this?
> 

lut_uv certainly is used. This makes it easier to abstract PWM vs i2c. It
would also be possible to replace every reference to lut_uv with a function
which calculates the corresponding voltage by either querying the regulator
framework in case of i2c or doing alignment.offset_uv + x * alignment.step_uv
in case of PWM. Doing this once seems a bit easier to me.

> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  drivers/clk/tegra/clk-dfll.c               | 398 ++++++++++++++++++++++++++---
> >  drivers/clk/tegra/clk-tegra124-dfll-fcpu.c |  23 +-
> >  2 files changed, 382 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
> > index fa97763..228edb4 100644
> > --- a/drivers/clk/tegra/clk-dfll.c
> > +++ b/drivers/clk/tegra/clk-dfll.c
> > @@ -243,6 +243,12 @@ enum dfll_tune_range {
> >  	DFLL_TUNE_LOW = 1,
> >  };
> >  
> > +
> > +enum tegra_dfll_pmu_if {
> > +	TEGRA_DFLL_PMU_I2C = 0,
> > +	TEGRA_DFLL_PMU_PWM = 1,
> > +};
> > +
> >  /**
> >   * struct dfll_rate_req - target DFLL rate request data
> >   * @rate: target frequency, after the postscaling
> > @@ -294,17 +300,25 @@ struct tegra_dfll {
> >  	u32				ci;
> >  	u32				cg;
> >  	bool				cg_scale;
> > +	u32				reg_init_uV;
> >  
> >  	/* I2C interface parameters */
> >  	u32				i2c_fs_rate;
> >  	u32				i2c_reg;
> >  	u32				i2c_slave_addr;
> >  
> > -	/* i2c_lut array entries are regulator framework selectors */
> > +	/* lut array entries are regulator framework selectors or PWM values*/
> >  	unsigned int			i2c_lut[MAX_DFLL_VOLTAGES];
> >  	unsigned int			lut_uv[MAX_DFLL_VOLTAGES];
> >  	int				lut_size;
> >  	u8				lut_bottom, lut_min, lut_max, lut_safe;
> > +
> > +	/* PWM interface */
> > +	enum tegra_dfll_pmu_if		pmu_if;
> > +	unsigned long			pwm_rate;
> > +	struct pinctrl			*pwm_pin;
> > +	struct pinctrl_state		*pwm_enable_state;
> > +	struct pinctrl_state		*pwm_disable_state;
> >  };
> >  
> >  #define clk_hw_to_dfll(_hw) container_of(_hw, struct tegra_dfll, dfll_clk_hw)
> > @@ -491,6 +505,36 @@ static void dfll_set_mode(struct tegra_dfll *td,
> >  }
> >  
> >  /*
> > + * DVCO rate control
> > + */
> > +
> > +static unsigned long get_dvco_rate_below(struct tegra_dfll *td, u8 out_min)
> > +{
> > +	struct dev_pm_opp *opp;
> > +	unsigned long rate, prev_rate;
> > +	int uv, min_uv;
> > +
> > +	min_uv = td->lut_uv[out_min];
> > +	for (rate = 0, prev_rate = 0; ; rate++) {
> > +		rcu_read_lock();
> > +		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
> > +		if (IS_ERR(opp)) {
> > +			rcu_read_unlock();
> > +			break;
> > +		}
> > +		uv = dev_pm_opp_get_voltage(opp);
> > +		rcu_read_unlock();
> > +
> > +		if (uv && uv > min_uv)
> > +			return prev_rate;
> > +
> > +		prev_rate = rate;
> > +	}
> > +
> > +	return prev_rate;
> > +}
> > +
> > +/*
> >   * DFLL-to-I2C controller interface
> >   */
> >  
> > @@ -519,6 +563,119 @@ static int dfll_i2c_set_output_enabled(struct tegra_dfll *td, bool enable)
> >  	return 0;
> >  }
> >  
> > +
> > +/*
> > + * DFLL-to-PWM controller interface
> > + */
> > +
> > +/**
> > + * dfll_pwm_set_output_enabled - enable/disable PWM voltage requests
> > + * @td: DFLL instance
> > + * @enable: whether to enable or disable the PWM voltage requests
> > + *
> > + * Set the master enable control for PWM control value updates. If disabled,
> > + * then the PWM signal is not driven. Also configure the PWM output pad
> > + * to the appropriate state.
> > + */
> > +static int dfll_pwm_set_output_enabled(struct tegra_dfll *td, bool enable)
> > +{
> > +	int ret;
> > +	u32 val, div;
> > +
> > +	if (enable) {
> > +		ret = pinctrl_select_state(td->pwm_pin, td->pwm_enable_state);
> > +		if (ret < 0) {
> > +			dev_err(td->dev, "setting enable state failed\n");
> > +			return ret;
> > +		}
> > +		val = dfll_readl(td, DFLL_OUTPUT_CFG);
> > +		val &= ~DFLL_OUTPUT_CFG_PWM_DIV_MASK;
> > +		div = DIV_ROUND_UP(td->ref_rate, td->pwm_rate);
> > +		val |= (div << DFLL_OUTPUT_CFG_PWM_DIV_SHIFT)
> > +				& DFLL_OUTPUT_CFG_PWM_DIV_MASK;
> > +		dfll_writel(td, val, DFLL_OUTPUT_CFG);
> > +		dfll_wmb(td);
> > +
> > +		val |= DFLL_OUTPUT_CFG_PWM_ENABLE;
> > +		dfll_writel(td, val, DFLL_OUTPUT_CFG);
> > +		dfll_wmb(td);
> > +	} else {
> > +		ret = pinctrl_select_state(td->pwm_pin, td->pwm_disable_state);
> > +		if (ret < 0)
> > +			dev_warn(td->dev, "setting disable state failed\n");
> > +
> > +		val = dfll_readl(td, DFLL_OUTPUT_CFG);
> > +		val &= ~DFLL_OUTPUT_CFG_PWM_ENABLE;
> > +		dfll_writel(td, val, DFLL_OUTPUT_CFG);
> > +		dfll_wmb(td);
> > +	}
> > +
> > +	return 0;
> > +}
> > +/**
> > + * dfll_set_force_output_value - set fixed value for force output
> > + * @td: DFLL instance
> > + * @out_val: value to force output
> > + *
> > + * Set the fixed value for force output, DFLL will output this value when
> > + * force output is enabled.
> > + */
> > +static u32 dfll_set_force_output_value(struct tegra_dfll *td, u8 out_val)
> > +{
> > +	u32 val = dfll_readl(td, DFLL_OUTPUT_FORCE);
> > +
> > +	val &= ~OUT_MASK;
> > +	val = (val & DFLL_OUTPUT_FORCE_ENABLE) | (out_val & OUT_MASK);
> 
> This masking of out_val is not needed as you check in dfll_force_output().
> 
> > +	dfll_writel(td, val, DFLL_OUTPUT_FORCE);
> > +	dfll_wmb(td);
> > +
> > +	return dfll_readl(td, DFLL_OUTPUT_FORCE);
> > +}
> > +
> > +/**
> > + * dfll_set_force_output_enabled - enable/disable force output
> > + * @td: DFLL instance
> > + * @enable: whether to enable or disable the force output
> > + *
> > + * Set the enable control for fouce output with fixed value.
> > + */
> > +static void dfll_set_force_output_enabled(struct tegra_dfll *td, bool enable)
> > +{
> > +	u32 val = dfll_readl(td, DFLL_OUTPUT_FORCE);
> > +
> > +	if (enable)
> > +		val |= DFLL_OUTPUT_FORCE_ENABLE;
> > +	else
> > +		val &= ~DFLL_OUTPUT_FORCE_ENABLE;
> > +
> > +	dfll_writel(td, val, DFLL_OUTPUT_FORCE);
> > +	dfll_wmb(td);
> > +}
> > +
> > +/**
> > + * dfll_i2c_set_output_enabled - enable/disable I2C PMIC voltage requests
> > + * @td: DFLL instance
> > + * @enable: whether to enable or disable the I2C voltage requests
> > + *
> > + * Set the master enable control for I2C control value updates. If disabled,
> > + * then I2C control messages are inhibited, regardless of the DFLL mode.
> > + */
> 
> The above description needs correcting.
> 
> > +static int dfll_force_output(struct tegra_dfll *td, unsigned int out_sel)
> > +{
> > +	u32 val;
> > +
> > +	if (out_sel > OUT_MASK)
> > +		return -EINVAL;
> > +
> > +	val = dfll_set_force_output_value(td, out_sel);
> > +	if ((td->mode < DFLL_CLOSED_LOOP) &&
> > +	    !(val & DFLL_OUTPUT_FORCE_ENABLE)) {
> > +		dfll_set_force_output_enabled(td, true);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * dfll_load_lut - load the voltage lookup table
> >   * @td: struct tegra_dfll *
> > @@ -599,20 +756,50 @@ static void dfll_init_out_if(struct tegra_dfll *td)
> >  	td->lut_max = td->lut_size - 1;
> >  	td->lut_safe = td->lut_min + (td->lut_min < td->lut_max ? 1 : 0);
> >  
> > -	dfll_i2c_writel(td, 0, DFLL_OUTPUT_CFG);
> > -	val = (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
> > -		(td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
> > -		(td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
> > -	dfll_i2c_writel(td, val, DFLL_OUTPUT_CFG);
> > -	dfll_i2c_wmb(td);
> > -
> > -	dfll_writel(td, 0, DFLL_OUTPUT_FORCE);
> > -	dfll_i2c_writel(td, 0, DFLL_INTR_EN);
> > -	dfll_i2c_writel(td, DFLL_INTR_MAX_MASK | DFLL_INTR_MIN_MASK,
> > -			DFLL_INTR_STS);
> > -
> > -	dfll_load_i2c_lut(td);
> > -	dfll_init_i2c_if(td);
> > +	if (td->pmu_if == TEGRA_DFLL_PMU_PWM) {
> > +		int vinit = td->reg_init_uV;
> > +		int vstep = td->soc->alignment.step_uv;
> > +		int vmin = td->lut_uv[0];
> > +
> > +		/* clear DFLL_OUTPUT_CFG before setting new value */
> > +		dfll_writel(td, 0, DFLL_OUTPUT_CFG);
> > +		dfll_wmb(td);
> > +
> > +		val = dfll_readl(td, DFLL_OUTPUT_CFG);
> > +		val |= (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
> > +		       (td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
> > +		       (td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
> > +		dfll_writel(td, val, DFLL_OUTPUT_CFG);
> > +		dfll_wmb(td);
> > +
> > +		dfll_writel(td, 0, DFLL_OUTPUT_FORCE);
> > +		dfll_i2c_writel(td, 0, DFLL_INTR_EN);
> > +		dfll_i2c_writel(td, DFLL_INTR_MAX_MASK | DFLL_INTR_MIN_MASK,
> > +				DFLL_INTR_STS);
> > +
> > +		/* set initial voltage */
> > +		if ((vinit >= vmin) && vstep) {
> > +			unsigned int vsel;
> > +
> > +			vsel = DIV_ROUND_UP((vinit - vmin), vstep);
> > +			dfll_force_output(td, vsel);
> > +		}
> > +	} else {
> > +		dfll_i2c_writel(td, 0, DFLL_OUTPUT_CFG);
> > +		val = (td->lut_safe << DFLL_OUTPUT_CFG_SAFE_SHIFT) |
> > +			(td->lut_max << DFLL_OUTPUT_CFG_MAX_SHIFT) |
> > +			(td->lut_min << DFLL_OUTPUT_CFG_MIN_SHIFT);
> > +		dfll_i2c_writel(td, val, DFLL_OUTPUT_CFG);
> > +		dfll_i2c_wmb(td);
> > +
> > +		dfll_writel(td, 0, DFLL_OUTPUT_FORCE);
> > +		dfll_i2c_writel(td, 0, DFLL_INTR_EN);
> > +		dfll_i2c_writel(td, DFLL_INTR_MAX_MASK | DFLL_INTR_MIN_MASK,
> > +				DFLL_INTR_STS);
> > +
> > +		dfll_load_i2c_lut(td);
> > +		dfll_init_i2c_if(td);
> > +	}
> >  }
> >  
> >  /*
> > @@ -864,9 +1051,14 @@ static int dfll_lock(struct tegra_dfll *td)
> >  			return -EINVAL;
> >  		}
> >  
> > -		dfll_i2c_set_output_enabled(td, true);
> > +		if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
> > +			dfll_pwm_set_output_enabled(td, true);
> > +		else
> > +			dfll_i2c_set_output_enabled(td, true);
> > +
> >  		dfll_set_mode(td, DFLL_CLOSED_LOOP);
> >  		dfll_set_frequency_request(td, req);
> > +		dfll_set_force_output_enabled(td, false);
> >  		return 0;
> >  
> >  	default:
> > @@ -890,7 +1082,10 @@ static int dfll_unlock(struct tegra_dfll *td)
> >  	case DFLL_CLOSED_LOOP:
> >  		dfll_set_open_loop_config(td);
> >  		dfll_set_mode(td, DFLL_OPEN_LOOP);
> > -		dfll_i2c_set_output_enabled(td, false);
> > +		if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
> > +			dfll_pwm_set_output_enabled(td, false);
> > +		else
> > +			dfll_i2c_set_output_enabled(td, false);
> >  		return 0;
> >  
> >  	case DFLL_OPEN_LOOP:
> > @@ -1172,15 +1367,17 @@ static int attr_registers_show(struct seq_file *s, void *data)
> >  		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
> >  			   dfll_i2c_readl(td, offs));
> >  
> > -	seq_puts(s, "\nINTEGRATED I2C CONTROLLER REGISTERS:\n");
> > -	offs = DFLL_I2C_CLK_DIVISOR;
> > -	seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
> > -		   __raw_readl(td->i2c_controller_base + offs));
> > -
> > -	seq_puts(s, "\nLUT:\n");
> > -	for (offs = 0; offs <  4 * MAX_DFLL_VOLTAGES; offs += 4)
> > +	if (td->pmu_if == TEGRA_DFLL_PMU_I2C) {
> > +		seq_puts(s, "\nINTEGRATED I2C CONTROLLER REGISTERS:\n");
> > +		offs = DFLL_I2C_CLK_DIVISOR;
> >  		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
> > -			   __raw_readl(td->lut_base + offs));
> > +			   __raw_readl(td->i2c_controller_base + offs));
> > +
> > +		seq_puts(s, "\nLUT:\n");
> > +		for (offs = 0; offs <  4 * MAX_DFLL_VOLTAGES; offs += 4)
> > +			seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
> > +				   __raw_readl(td->lut_base + offs));
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -1289,6 +1486,9 @@ static int dfll_init_clks(struct tegra_dfll *td)
> >  		return PTR_ERR(td->soc_clk);
> >  	}
> >  
> > +	if (td->pmu_if != TEGRA_DFLL_PMU_I2C)
> > +		return 0;
> > +
> >  	td->i2c_clk = devm_clk_get(td->dev, "i2c");
> >  	if (IS_ERR(td->i2c_clk)) {
> >  		dev_err(td->dev, "missing i2c clock\n");
> > @@ -1420,6 +1620,52 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
> >  	return -EINVAL;
> >  }
> >  
> > +/*
> > + * Look-up table in h/w is ignored when PWM is used as DFLL interface to PMIC.
> > + * In this case closed loop output is controlling duty cycle directly. The s/w
> > + * look-up that maps PWM duty cycle to voltage is still built by this function.
> 
> Why?

This actually incorrect, the table is built by dfll_fetch_pwm_params() in case
of PWM.

> 
> > + */
> > +static int dfll_build_lut_pwm(struct tegra_dfll *td, int v_max)
> > +{
> > +	int i, reg_volt;
> > +	unsigned long rate;
> > +	u8 lut_bottom = MAX_DFLL_VOLTAGES;
> > +	int v_min = td->soc->cvb->min_millivolts * 1000;
> > +
> > +	for (i = 0; i < MAX_DFLL_VOLTAGES; i++) {
> > +		reg_volt = td->lut_uv[i];
> > +
> > +		/* since opp voltage is exact mv */
> > +		reg_volt = (reg_volt / 1000) * 1000;
> > +		if (reg_volt > v_max)
> > +			break;
> > +
> > +		if ((lut_bottom == MAX_DFLL_VOLTAGES) && (reg_volt >= v_min))
> > +			lut_bottom = i;
> > +	}
> > +
> > +	/* determine voltage boundaries */
> > +	td->lut_size = i;
> > +	if ((lut_bottom == MAX_DFLL_VOLTAGES) ||
> > +	    (lut_bottom + 1 >= td->lut_size)) {
> > +		dev_err(td->dev, "no voltage above DFLL minimum %d mV\n",
> > +			td->soc->cvb->min_millivolts);
> > +		return -EINVAL;
> > +	}
> > +	td->lut_bottom = lut_bottom;
> > +
> > +	/* determine rate boundaries */
> > +	rate = get_dvco_rate_below(td, td->lut_bottom);
> > +	if (!rate) {
> > +		dev_err(td->dev, "no opp below DFLL minimum voltage %d mV\n",
> > +			td->soc->cvb->min_millivolts);
> > +		return -EINVAL;
> > +	}
> > +	td->dvco_rate_min = rate;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * dfll_build_i2c_lut - build the I2C voltage register lookup table
> >   * @td: DFLL instance
> > @@ -1432,10 +1678,10 @@ static int find_vdd_map_entry_min(struct tegra_dfll *td, int uV)
> >   *
> >   * On success, fills in td->i2c_lut and returns 0, or -err on failure.
> >   */
> > -static int dfll_build_i2c_lut(struct tegra_dfll *td)
> > +static int dfll_build_i2c_lut(struct tegra_dfll *td, int v_max)
> >  {
> >  	int ret = -EINVAL;
> > -	int j, v, v_max, v_opp;
> > +	int j, v, v_opp;
> >  	int selector;
> >  	unsigned long rate;
> >  	struct dev_pm_opp *opp;
> > @@ -1508,6 +1754,30 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
> >  	return ret;
> >  }
> >  
> > +static int dfll_build_lut(struct tegra_dfll *td)
> > +{
> > +	unsigned long rate;
> > +	struct dev_pm_opp *opp;
> > +	int v_max;
> > +
> > +	rcu_read_lock();
> > +
> > +	rate = ULONG_MAX;
> > +	opp = dev_pm_opp_find_freq_floor(td->soc->dev, &rate);
> > +	if (IS_ERR(opp)) {
> > +		dev_err(td->dev, "couldn't get vmax opp, empty opp table?\n");
> > +		return -EINVAL;
> > +	}
> > +	v_max = dev_pm_opp_get_voltage(opp);
> > +
> > +	rcu_read_unlock();
> > +
> > +	if (td->pmu_if == TEGRA_DFLL_PMU_PWM)
> > +		return dfll_build_lut_pwm(td, v_max);
> > +	else
> > +		return dfll_build_i2c_lut(td, v_max);
> > +}
> > +
> >  /**
> >   * read_dt_param - helper function for reading required parameters from the DT
> >   * @td: DFLL instance
> > @@ -1566,11 +1836,54 @@ static int dfll_fetch_i2c_params(struct tegra_dfll *td)
> >  	}
> >  	td->i2c_reg = vsel_reg;
> >  
> > -	ret = dfll_build_i2c_lut(td);
> > -	if (ret) {
> > -		dev_err(td->dev, "couldn't build I2C LUT\n");
> > +	return 0;
> > +}
> > +
> > +static int dfll_fetch_pwm_params(struct tegra_dfll *td)
> > +{
> > +	int ret, i;
> > +	u32 pwm_period;
> > +
> > +	if (!td->soc->alignment.step_uv || !td->soc->alignment.offset_uv) {
> > +		dev_err(td->dev, "Missing step or alignment info for PWM regulator");
> > +		return -EINVAL;
> > +	}
> > +	for (i = 0; i < MAX_DFLL_VOLTAGES; i++)
> > +		td->lut_uv[i] = td->soc->alignment.offset_uv +
> > +				i * td->soc->alignment.step_uv;
> > +
> > +	ret = read_dt_param(td, "nvidia,init-uv", &td->reg_init_uV);
> > +	if (!ret) {
> > +		dev_err(td->dev, "couldn't get initialized voltage\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = read_dt_param(td, "nvidia,pwm-period", &pwm_period);
> > +	if (!ret) {
> > +		dev_err(td->dev, "couldn't get PWM period\n");
> >  		return ret;
> >  	}
> > +	td->pwm_rate = (NSEC_PER_SEC / pwm_period) * (MAX_DFLL_VOLTAGES - 1);
> 
> Do we need to check that this pwm_rate is not too big so we don't end up
> with a bad value in dfll_pwm_set_output_enabled()? If this pwm_rate is
> not updated and neither is ref_rate, can we not just store the divisor
> so we can use in dfll_pwm_set_output_enabled()?
> 

ref_rate is fixed. So we could indeed store the divider rather than the rate.

Peter.

> Cheers
> Jon
> 
> -- 
> nvpublic
