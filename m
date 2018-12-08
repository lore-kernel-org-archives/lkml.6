Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0443C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3EB20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544270724;
	bh=/Vm3WtqAq8bkzKwND88/cyeatgqIjS857dQPcPfc53A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hzn6JOOMqWMp4x8nW79nrcEWl74RQ92aV0RCsfZwRSkPKHwJ82P4ckHwwccDWRi0E
	 95ig+GKoX8UbaCbZQQyjLJ1IEjmPlkfHY3WNNtC0iKjrP3cGz16Vg0u+siAPyz/Siq
	 VJH5I38imfWb85Exm+JdoGeAooVAnaMryEuj4bTQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3EB20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLHMFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbeLHMFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:05:21 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A91C2081C;
        Sat,  8 Dec 2018 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544270720;
        bh=/Vm3WtqAq8bkzKwND88/cyeatgqIjS857dQPcPfc53A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M9/hx/b1Al+hHTVxurjOfBLxZtyDpaGPJRWH+rZUNjsfTzNE59fJjY2GE7SLsTx/o
         +fPMtp5AXaN5R/FD/ZaDo6MFQ07blAnkRVzU7JELlJPBZXVsDF9YRSwNDhzklQA219
         naKKWMGHGNUR1GjJSZpWqC2Balv8Y7Ok+760xuP8=
Date:   Sat, 8 Dec 2018 12:05:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Initialize prescale properly
Message-ID: <20181208120515.3ccf7e9a@archlinux>
In-Reply-To: <20181204195732.GC14307@google.com>
References: <20181204191419.144726-1-evgreen@chromium.org>
        <20181204195732.GC14307@google.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 11:57:32 -0800
Matthias Kaehlcke <mka@chromium.org> wrote:

> On Tue, Dec 04, 2018 at 11:14:19AM -0800, Evan Green wrote:
> > adc5_get_dt_data uses a local, prop, feeds it to adc5_get_dt_channel_data,
> > and then puts the result into adc->chan_props. The problem is
> > adc5_get_dt_channel_data may not initialize that structure fully, so a
> > garbage value is used for prescale if the optional "qcom,pre-scaling" is
> > not defined in DT. adc5_read_raw then uses this as an array index,
> > generating a crash that looks like this:
> > 
> > [    6.683186] Unable to handle kernel paging request at virtual address ffffff90e78c7964
> > Call trace:
> > qcom_vadc_scale_code_voltage_factor+0x74/0x104
> > qcom_vadc_scale_hw_calib_die_temp+0x20/0x60
> > qcom_adc5_hw_scale+0x78/0xa4
> > adc5_read_raw+0x3d0/0x65c
> > iio_channel_read+0x240/0x30c
> > iio_read_channel_processed+0x10c/0x150
> > qpnp_tm_get_temp+0xc0/0x40c
> > of_thermal_get_temp+0x7c/0x98
> > thermal_zone_get_temp+0xac/0xd8
> > thermal_zone_device_update+0xc0/0x38c
> > qpnp_tm_probe+0x624/0x81c
> > platform_drv_probe+0xe4/0x11c
> > really_probe+0x188/0x3fc
> > driver_probe_device+0xb8/0x188
> > __device_attach_driver+0x114/0x180
> > bus_for_each_drv+0xd8/0x118
> > __device_attach+0x180/0x27c
> > device_initial_probe+0x20/0x2c
> > bus_probe_device+0x78/0x124
> > deferred_probe_work_func+0xfc/0x138
> > process_one_work+0x3d8/0x8b0
> > process_scheduled_works+0x48/0x6c
> > worker_thread+0x488/0x7cc
> > kthread+0x24c/0x264
> > ret_from_fork+0x10/0x18
> > 
> > Unfortunately, when I went to add the initializer for this and tried to
> > boot it, my machine shut down immediately, complaining that it was
> > hotter than the sun. It appears that adc5_chans_pmic and adc5_chans_rev2
> > were initializing prescale_index as if it were directly a divisor,
> > rather than the index into adc5_prescale_ratios that it is.
> > 
> > Fix the uninitialized value, and change the static initialization to use
> > indices into adc5_prescale_ratios.
> > 
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> > 
> >  drivers/iio/adc/qcom-spmi-adc5.c | 58 +++++++++++++++++---------------
> >  1 file changed, 31 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> > index f9af6b082916b..6a866cc187f7d 100644
> > --- a/drivers/iio/adc/qcom-spmi-adc5.c
> > +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> > @@ -423,6 +423,7 @@ struct adc5_channels {
> >  	enum vadc_scale_fn_type scale_fn_type;
> >  };
> >  
> > +/* In these definitions, _pre refers to an index into adc5_prescale_ratios. */
> >  #define ADC5_CHAN(_dname, _type, _mask, _pre, _scale)			\
> >  	{								\
> >  		.datasheet_name = _dname,				\
> > @@ -443,63 +444,63 @@ struct adc5_channels {
> >  		  _pre, _scale)						\
> >  
> >  static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
> > -	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 1,
> > +	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 0,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 1,
> > +	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 3,
> > +	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 3,
> > +	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 1,
> > +	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
> >  					SCALE_HW_CALIB_PMIC_THERM)
> > -	[ADC5_USB_IN_I]		= ADC5_CHAN_VOLT("usb_in_i_uv", 1,
> > +	[ADC5_USB_IN_I]		= ADC5_CHAN_VOLT("usb_in_i_uv", 0,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_USB_IN_V_16]	= ADC5_CHAN_VOLT("usb_in_v_div_16", 16,
> > +	[ADC5_USB_IN_V_16]	= ADC5_CHAN_VOLT("usb_in_v_div_16", 8,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_CHG_TEMP]		= ADC5_CHAN_TEMP("chg_temp", 1,
> > +	[ADC5_CHG_TEMP]		= ADC5_CHAN_TEMP("chg_temp", 0,
> >  					SCALE_HW_CALIB_PM5_CHG_TEMP)
> >  	/* Charger prescales SBUx and MID_CHG to fit within 1.8V upper unit */
> > -	[ADC5_SBUx]		= ADC5_CHAN_VOLT("chg_sbux", 3,
> > +	[ADC5_SBUx]		= ADC5_CHAN_VOLT("chg_sbux", 1,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_MID_CHG_DIV6]	= ADC5_CHAN_VOLT("chg_mid_chg", 6,
> > +	[ADC5_MID_CHG_DIV6]	= ADC5_CHAN_VOLT("chg_mid_chg", 3,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 1,
> > +	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 0,
> >  					SCALE_HW_CALIB_XOTHERM)
> > -	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
> > +	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > -	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
> > +	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 0,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > -	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
> > +	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 0,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > -	[ADC5_AMUX_THM2]	= ADC5_CHAN_TEMP("amux_thm2", 1,
> > +	[ADC5_AMUX_THM2]	= ADC5_CHAN_TEMP("amux_thm2", 0,
> >  					SCALE_HW_CALIB_PM5_SMB_TEMP)
> >  };
> >  
> >  static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
> > -	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 1,
> > +	[ADC5_REF_GND]		= ADC5_CHAN_VOLT("ref_gnd", 0,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 1,
> > +	[ADC5_1P25VREF]		= ADC5_CHAN_VOLT("vref_1p25", 0,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 3,
> > +	[ADC5_VPH_PWR]		= ADC5_CHAN_VOLT("vph_pwr", 1,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 3,
> > +	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_VCOIN]		= ADC5_CHAN_VOLT("vcoin", 3,
> > +	[ADC5_VCOIN]		= ADC5_CHAN_VOLT("vcoin", 1,
> >  					SCALE_HW_CALIB_DEFAULT)
> > -	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 1,
> > +	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
> >  					SCALE_HW_CALIB_PMIC_THERM)
> > -	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
> > +	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > -	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
> > +	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 0,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > -	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
> > +	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 0,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > -	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 1,
> > +	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 0,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > -	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 1,
> > +	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 0,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > -	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 1,
> > +	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 0,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> >  };
> >  
> > @@ -558,6 +559,9 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
> >  			return ret;
> >  		}
> >  		prop->prescale = ret;
> > +	} else {
> > +		prop->prescale =
> > +			adc->data->adc_chans[prop->channel].prescale_index;
> >  	}
> >  
> >  	ret = of_property_read_u32(node, "qcom,hw-settle-time", &value);  
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Good as an immediate fix.
> 
> In the long term I wonder if it would be better to pass a ratio to
> ADC5_CHAN_XYZ and store it in struct adc5_channel_prop, instead of
> specifying the index, which is more error prone and errors are harder
> to spot. With this adc5_prescale_ratios would still exist, but only be
> used for the sanity check of prescaling values from the DT.

I am going to let this sit for a little longer to let Siddartha have
a chance to comment as well.  We are getting late this cycle
so this may end up going upstream at the start of the next one
(as it'll be marked for stable that shouldn't matter much).

Poke me if I seem to have forgotten it in a week or so.

Thanks,

Jonathan

