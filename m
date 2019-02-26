Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20560C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6902173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfBZJVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:21:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:35214 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfBZJVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:21:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 01:21:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,415,1544515200"; 
   d="scan'208";a="147352363"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 26 Feb 2019 01:21:01 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gyYv5-0005t6-Ml; Tue, 26 Feb 2019 11:20:59 +0200
Date:   Tue, 26 Feb 2019 11:20:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190226092059.GV9224@smile.fi.intel.com>
References: <20190221105609.5710-1-ronald@innovation.ch>
 <20190221105609.5710-3-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221105609.5710-3-ronald@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:56:09AM -0800, Ronald Tschalär wrote:
> The keyboard and trackpad on recent MacBook's (since 8,1) and
> MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> of USB, as previously. The higher level protocol is not publicly
> documented and hence has been reverse engineered. As a consequence there
> are still a number of unknown fields and commands. However, the known
> parts have been working well and received extensive testing and use.
> 
> In order for this driver to work, the proper SPI drivers need to be
> loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> reason enabling this driver in the config implies enabling the above
> drivers.

> +config KEYBOARD_APPLESPI
> +	tristate "Apple SPI keyboard and trackpad"

> +	depends on ACPI && SPI && EFI

I would rather want to see separate line for SPI...

> +	depends on X86 || COMPILE_TEST

...like here

	depends on SPI

> +	imply SPI_PXA2XX
> +	imply SPI_PXA2XX_PCI
> +	imply MFD_INTEL_LPSS_PCI
> +	help
> +	  Say Y here if you are running Linux on any Apple MacBook8,1 or later,
> +	  or any MacBookPro13,* or MacBookPro14,*.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called applespi.

/* Perhaps a comment here that this mimics struct drm_rect */

> +struct applespi_tp_info {
> +	int	x_min;
> +	int	y_min;
> +	int	x_max;
> +	int	y_max;
> +};

...see above

> +static inline bool applespi_check_write_status(struct applespi_data *applespi,
> +					       int sts)
> +{
> +	static u8 status_ok[] = { 0xac, 0x27, 0x68, 0xd5 };
> +
> +	if (sts < 0) {
> +		dev_warn(DEV(applespi), "Error writing to device: %d\n", sts);
> +		return false;
> +	}
> +
> +	if (memcmp(applespi->tx_status, status_ok, APPLESPI_STATUS_SIZE)) {

> +		dev_warn(DEV(applespi), "Error writing to device: %*ph\n",

Hmm... DEV() is too generic name for custom macro. And frankly I don't think
it's good to have in the first place.

> +			 APPLESPI_STATUS_SIZE, applespi->tx_status);
> +		return false;
> +	}
> +
> +	return true;
> +}

> +static void applespi_set_bl_level(struct led_classdev *led_cdev,
> +				  enum led_brightness value)
> +{
> +	struct applespi_data *applespi =
> +		container_of(led_cdev, struct applespi_data, backlight_info);
> +	unsigned long flags;
> +	int sts;
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +

> +	if (value == 0)
> +		applespi->want_bl_level = value;
> +	else
> +		/*
> +		 * The backlight does not turn on till level 32, so we scale
> +		 * the range here so that from a user's perspective it turns
> +		 * on at 1.
> +		 */
> +		applespi->want_bl_level =
> +			((value * KBD_BL_LEVEL_ADJ) / KBD_BL_LEVEL_SCALE +
> +			 KBD_BL_LEVEL_MIN);


Fir multi-line conditionals the style is
	if () {
	} else {
	}

> +
> +	sts = applespi_send_cmd_msg(applespi);
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +}

> +static void
> +applespi_remap_fn_key(struct keyboard_protocol *keyboard_protocol)
> +{
> +	unsigned char tmp;

> +	unsigned long *modifiers =
> +			(unsigned long *)&keyboard_protocol->modifiers;

I would leave it on one online despite checkpatch warning (also, instead of
(unsigned long *) the (void *) might be used as a small trick).

> +
> +	if (!fnremap || fnremap > ARRAY_SIZE(applespi_controlcodes) ||
> +	    !applespi_controlcodes[fnremap - 1])
> +		return;
> +
> +	tmp = keyboard_protocol->fn_pressed;
> +	keyboard_protocol->fn_pressed = test_bit(fnremap - 1, modifiers);
> +	if (tmp)

> +		__set_bit(fnremap - 1, modifiers);
> +	else
> +		__clear_bit(fnremap - 1, modifiers);

Oh, this is not good. modifiers should be really unsigned long bounary,
otherwise it is potential overflow.

Best to fix is to define them as unsigned long in the first place.

> +}

> +					   applespi->last_keys_fn_pressed[i]);
> +		input_report_key(applespi->keyboard_input_dev, key, 0);
> +		applespi->last_keys_fn_pressed[i] = 0;
> +	}

> +	for (i = 0; i < MAX_MODIFIERS; i++) {

> +		u8 *modifiers = &keyboard_protocol->modifiers;
> +
> +		if (test_bit(i, (unsigned long *)modifiers))

Oh, this is not good idea, see above.

> +	if (touchpad_dimensions[0]) {
> +		int x, y, w, h;
> +

> +		if (sscanf(touchpad_dimensions, "%dx%d+%u+%u", &x, &y, &w, &h)
> +				== 4) {

I would leave this on one line. Or use temporary variable

	int ret;

	ret = sscanf();
	if (ret ...) {

> +			dev_info(DEV(applespi),
> +				 "Overriding touchpad dimensions from module param\n");
> +			applespi->tp_info.x_min = x;
> +			applespi->tp_info.y_min = y;
> +			applespi->tp_info.x_max = x + w;
> +			applespi->tp_info.y_max = y + h;
> +		} else {
> +			dev_warn(DEV(applespi),
> +				 "Invalid touchpad dimensions '%s': must be in the form XxY+W+H\n",
> +				 touchpad_dimensions);
> +			touchpad_dimensions[0] = '\0';
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko


