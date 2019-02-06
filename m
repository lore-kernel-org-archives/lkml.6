Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC99C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2B3218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfBFUXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:23:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:62469 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfBFUXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:23:02 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 12:23:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,341,1544515200"; 
   d="scan'208";a="132100106"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2019 12:22:57 -0800
Received: from andy by smile with local (Exim 4.92-RC5)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1grTii-0000Qp-Kf; Wed, 06 Feb 2019 22:22:56 +0200
Date:   Wed, 6 Feb 2019 22:22:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190206202256.GZ9224@smile.fi.intel.com>
References: <20190204081947.25152-1-ronald@innovation.ch>
 <20190204081947.25152-3-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204081947.25152-3-ronald@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:19:47AM -0800, Ronald Tschalär wrote:
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

Thanks for doing this. My review below.

> +/**

I'm not sure it's kernel doc format comment.

> + * The keyboard and touchpad controller on the MacBookAir6, MacBookPro12,
> + * MacBook8 and newer can be driven either by USB or SPI. However the USB
> + * pins are only connected on the MacBookAir6 and 7 and the MacBookPro12.
> + * All others need this driver. The interface is selected using ACPI methods:
> + *
> + * * UIEN ("USB Interface Enable"): If invoked with argument 1, disables SPI
> + *   and enables USB. If invoked with argument 0, disables USB.
> + * * UIST ("USB Interface Status"): Returns 1 if USB is enabled, 0 otherwise.
> + * * SIEN ("SPI Interface Enable"): If invoked with argument 1, disables USB
> + *   and enables SPI. If invoked with argument 0, disables SPI.
> + * * SIST ("SPI Interface Status"): Returns 1 if SPI is enabled, 0 otherwise.
> + * * ISOL: Resets the four GPIO pins used for SPI. Intended to be invoked with
> + *   argument 1, then once more with argument 0.
> + *
> + * UIEN and UIST are only provided on models where the USB pins are connected.
> + *
> + * SPI-based Protocol
> + * ------------------
> + *
> + * The device and driver exchange messages (struct message); each message is
> + * encapsulated in one or more packets (struct spi_packet). There are two types
> + * of exchanges: reads, and writes. A read is signaled by a GPE, upon which one
> + * message can be read from the device. A write exchange consists of writing a
> + * command message, immediately reading a short status packet, and then, upon
> + * receiving a GPE, reading the response message. Write exchanges cannot be
> + * interleaved, i.e. a new write exchange must not be started till the previous
> + * write exchange is complete. Whether a received message is part of a read or
> + * write exchange is indicated in the encapsulating packet's flags field.
> + *
> + * A single message may be too large to fit in a single packet (which has a
> + * fixed, 256-byte size). In that case it will be split over multiple,
> + * consecutive packets.
> + */
> +

> +#define pr_fmt(fmt) "applespi: " fmt

Better to use usual pattern.

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/spi/spi.h>
> +#include <linux/interrupt.h>
> +#include <linux/property.h>
> +#include <linux/delay.h>
> +#include <linux/spinlock.h>
> +#include <linux/crc16.h>
> +#include <linux/wait.h>
> +#include <linux/leds.h>
> +#include <linux/ktime.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input-polldev.h>
> +#include <linux/workqueue.h>
> +#include <linux/efi.h>

Can we keep them sorted? Do you need, btw, all of them?

+ blank line.

> +#include <asm/barrier.h>

> +#define MIN_KBD_BL_LEVEL	32
> +#define MAX_KBD_BL_LEVEL	255

I would rather use similar pattern as below, i.e. KBD_..._MIN/_MAX.

> +#define KBD_BL_LEVEL_SCALE	1000000
> +#define KBD_BL_LEVEL_ADJ	\
> +	((MAX_KBD_BL_LEVEL - MIN_KBD_BL_LEVEL) * KBD_BL_LEVEL_SCALE / 255)

> +#define	debug_print(mask, fmt, ...) \
> +	do { \
> +		if (debug & mask) \
> +			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); \
> +	} while (0)
> +
> +#define	debug_print_header(mask) \
> +	debug_print(mask, "--- %s ---------------------------\n", \
> +		    applespi_debug_facility(mask))
> +
> +#define	debug_print_buffer(mask, fmt, ...) \
> +	do { \
> +		if (debug & mask) \
> +			print_hex_dump(KERN_DEBUG, pr_fmt(fmt), \
> +				       DUMP_PREFIX_NONE, 32, 1, ##__VA_ARGS__, \
> +				       false); \
> +	} while (0)

I'm not sure we need all of these... But okay, the driver is
reverse-engineered, perhaps we can drop it later on.

> +#define SPI_RW_CHG_DLY		100	/* from experimentation, in us */

In _US would be good to have in a constant name, i.e.

SPI_RW_CHG_DELAY_US


> +static unsigned int fnmode = 1;
> +module_param(fnmode, uint, 0644);
> +MODULE_PARM_DESC(fnmode, "Mode of fn key on Apple keyboards (0 = disabled, [1] = fkeyslast, 2 = fkeysfirst)");

fn -> Fn ?

Ditto for the rest.

Btw, do we need all these parameters? Can't we do modify behaviour run-time
using some Input framework facilities?

> +static unsigned int iso_layout;
> +module_param(iso_layout, uint, 0644);
> +MODULE_PARM_DESC(iso_layout, "Enable/Disable hardcoded ISO-layout of the keyboard. ([0] = disabled, 1 = enabled)");

bool ?

> +static int touchpad_dimensions[4];
> +module_param_array(touchpad_dimensions, int, NULL, 0444);
> +MODULE_PARM_DESC(touchpad_dimensions, "The pixel dimensions of the touchpad, as x_min,x_max,y_min,y_max .");

We have some parsers for similar data as in format

%dx%d%+d%+d ?

For example, 200x100+20+10.

(But still same question, wouldn't input subsystem allows to do this run-time?)

> +/**
> + * struct keyboard_protocol - keyboard message.
> + * message.type = 0x0110, message.length = 0x000a
> + *
> + * @unknown1:		unknown
> + * @modifiers:		bit-set of modifier/control keys pressed
> + * @unknown2:		unknown
> + * @keys_pressed:	the (non-modifier) keys currently pressed
> + * @fn_pressed:		whether the fn key is currently pressed
> + * @crc_16:		crc over the whole message struct (message header +
> + *			this struct) minus this @crc_16 field

Something wrong with indentation. Check it over all your kernel doc comments.

> + */

> +struct touchpad_info_protocol {
> +	__u8			unknown1[105];
> +	__le16			model_id;
> +	__u8			unknown2[3];
> +	__le16			crc_16;
> +} __packed;

112 % 16 == 0, why do you need __packed?

> +	__le16			crc_16;

Can't you use crc16 everywhere for the name?

> +struct applespi_tp_info {
> +	int	x_min;
> +	int	x_max;
> +	int	y_min;
> +	int	y_max;
> +};

Perhaps use the same format as in struct drm_rect in order to possibility of
unifying them in the future?

> +	{ },

Terminators are better without comma.

> +	switch (log_mask) {
> +	case DBG_CMD_TP_INI:
> +		return "Touchpad Initialization";
> +	case DBG_CMD_BL:
> +		return "Backlight Command";
> +	case DBG_CMD_CL:
> +		return "Caps-Lock Command";
> +	case DBG_RD_KEYB:
> +		return "Keyboard Event";
> +	case DBG_RD_TPAD:
> +		return "Touchpad Event";
> +	case DBG_RD_UNKN:
> +		return "Unknown Event";
> +	case DBG_RD_IRQ:
> +		return "Interrupt Request";
> +	case DBG_RD_CRC:
> +		return "Corrupted packet";
> +	case DBG_TP_DIM:
> +		return "Touchpad Dimensions";
> +	default:
> +		return "-Unknown-";

What the difference to RD_UNKN ?

Perhaps "Unrecognized ... "-ish better?

> +	}

> +static inline bool applespi_check_write_status(struct applespi_data *applespi,
> +					       int sts)

Indentation broken.

> +{
> +	static u8 sts_ok[] = { 0xac, 0x27, 0x68, 0xd5 };

Spell it fully, i.e. status_ok.

> +	bool ret = true;

Directly return from each branch, it also will make 'else' redundant.

> +
> +	if (sts < 0) {
> +		ret = false;
> +		pr_warn("Error writing to device: %d\n", sts);
> +	} else if (memcmp(applespi->tx_status, sts_ok,
> +			  APPLESPI_STATUS_SIZE) != 0) {

Redundant ' != 0' part.

After removing this and 'else' would be fit on one line.

> +		ret = false;

> +		pr_warn("Error writing to device: %x %x %x %x\n",
> +			applespi->tx_status[0], applespi->tx_status[1],
> +			applespi->tx_status[2], applespi->tx_status[3]);

pr_warn("...: %ph\n", applespi->tx_status);

> +	}
> +
> +	return ret;
> +}

> +static int applespi_enable_spi(struct applespi_data *applespi)
> +{
> +	int result;

Sometimes you have ret, sometimes this. Better to unify across the code.

> +	unsigned long long spi_status;

> +	return 0;
> +}

> +static void applespi_async_write_complete(void *context)
> +{
> +	struct applespi_data *applespi = context;

> +	if (!applespi_check_write_status(applespi, applespi->wr_m.status))
> +		/*
> +		 * If we got an error, we presumably won't get the expected
> +		 * response message either.
> +		 */
> +	applespi_msg_complete(applespi, true, false);

Style issue, either use {} or positive condition like

if (...)
	 return;

...

> +}

> +static int applespi_send_cmd_msg(struct applespi_data *applespi)
> +{

> +	if (applespi->want_tp_info_cmd) {

> +	} else if (applespi->want_mt_init_cmd) {

> +	} else if (applespi->want_cl_led_on != applespi->have_cl_led_on) {

> +	} else if (applespi->want_bl_level != applespi->have_bl_level) {

> +	} else {
> +		return 0;
> +	}

Can we refactor to use some kind of enumeration and do switch-case here?

> +	message->counter = applespi->cmd_msg_cntr++ & 0xff;

Usual pattern for this kind of entries is

      x = ... % 256;

Btw, isn't 256 is defined somewhere?

> +	crc = crc16(0, (u8 *)message, le16_to_cpu(packet->length) - 2);
> +	*((__le16 *)&message->data[msg_len - 2]) = cpu_to_le16(crc);

put_unaligned_le16() ?

> +	if (sts != 0) {
> +		pr_warn("Error queueing async write to device: %d\n", sts);
> +	} else {
> +		applespi->cmd_msg_queued = true;
> +		applespi->write_active = true;
> +	}

Usual pattern is

if (sts) {
	...
	return sts;
}

...

return 0;

Btw, consider to use dev_warn() and Co instead of pr_warn() or in cases where
appropriate acpi_handle_warn(), etc.

> +
> +	return sts;
> +}

> +static void applespi_init(struct applespi_data *applespi, bool is_resume)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +
> +	if (!is_resume)
> +		applespi->want_tp_info_cmd = true;
> +	else
> +		applespi->want_mt_init_cmd = true;

Why not positive conditional?

> +	applespi_send_cmd_msg(applespi);
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
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
> +		applespi->want_bl_level = (unsigned int)
> +			((value * KBD_BL_LEVEL_ADJ) / KBD_BL_LEVEL_SCALE +
> +			 MIN_KBD_BL_LEVEL);

Why do you need casting? Your defines better to have U or UL suffixes where
appropriate.

Besides, run checkpatch.pl!

> +
> +	sts = applespi_send_cmd_msg(applespi);
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +}

> +static int applespi_event(struct input_dev *dev, unsigned int type,
> +			  unsigned int code, int value)
> +{
> +	struct applespi_data *applespi = input_get_drvdata(dev);
> +
> +	switch (type) {
> +	case EV_LED:

> +		applespi_set_capsl_led(applespi,
> +				       !!test_bit(LED_CAPSL, dev->led));

I would put it on one line disregard checkpatch warnings.

> +		return 0;
> +	}
> +

> +	return -1;

Can't you use appropriate Linux error code?

> +}

> +/* lifted from the BCM5974 driver */
> +/* convert 16-bit little endian to signed integer */
> +static inline int raw2int(__le16 x)
> +{
> +	return (signed short)le16_to_cpu(x);
> +}

Perhaps it's time to introduce it inside include/linux/input.h ?

> +static void report_tp_state(struct applespi_data *applespi,
> +			    struct touchpad_protocol *t)
> +{
> +	static int min_x, max_x, min_y, max_y;
> +	static bool dim_updated;
> +	static ktime_t last_print;

> +

Redundant.

> +	const struct tp_finger *f;
> +	struct input_dev *input;
> +	const struct applespi_tp_info *tp_info = &applespi->tp_info;
> +	int i, n;
> +
> +	/* touchpad_input_dev is set async in worker */
> +	input = smp_load_acquire(&applespi->touchpad_input_dev);
> +	if (!input)
> +		return;	/* touchpad isn't initialized yet */
> +

> +	n = 0;
> +
> +	for (i = 0; i < t->number_of_fingers; i++) {

for (n = 0, i = 0; i < ...; i++, n++) {

?

> +		f = &t->fingers[i];
> +		if (raw2int(f->touch_major) == 0)
> +			continue;
> +		applespi->pos[n].x = raw2int(f->abs_x);
> +		applespi->pos[n].y = tp_info->y_min + tp_info->y_max -
> +				     raw2int(f->abs_y);
> +		n++;
> +

> +		if (debug & DBG_TP_DIM) {
> +			#define UPDATE_DIMENSIONS(val, op, last) \
> +				do { \
> +					if (raw2int(val) op last) { \
> +						last = raw2int(val); \
> +						dim_updated = true; \
> +					} \
> +				} while (0)
> +
> +			UPDATE_DIMENSIONS(f->abs_x, <, min_x);
> +			UPDATE_DIMENSIONS(f->abs_x, >, max_x);
> +			UPDATE_DIMENSIONS(f->abs_y, <, min_y);
> +			UPDATE_DIMENSIONS(f->abs_y, >, max_y);

#undef ...

> +		}

...and better to move this to separate helper function.

> +	}
> +
> +	if (debug & DBG_TP_DIM) {
> +		if (dim_updated &&
> +		    ktime_ms_delta(ktime_get(), last_print) > 1000) {
> +			printk(KERN_DEBUG
> +			       pr_fmt("New touchpad dimensions: %d %d %d %d\n"),
> +			       min_x, max_x, min_y, max_y);
> +			dim_updated = false;
> +			last_print = ktime_get();
> +		}
> +	}

Same, helper function.

> +
> +	input_mt_assign_slots(input, applespi->slots, applespi->pos, n, 0);
> +
> +	for (i = 0; i < n; i++)
> +		report_finger_data(input, applespi->slots[i],
> +				   &applespi->pos[i], &t->fingers[i]);
> +
> +	input_mt_sync_frame(input);
> +	input_report_key(input, BTN_LEFT, t->clicked);
> +
> +	input_sync(input);
> +}

> +
> +static unsigned int applespi_code_to_key(u8 code, int fn_pressed)
> +{
> +	unsigned int key = applespi_scancodes[code];
> +	const struct applespi_key_translation *trans;
> +
> +	if (fnmode) {
> +		int do_translate;
> +
> +		trans = applespi_find_translation(applespi_fn_codes, key);
> +		if (trans) {
> +			if (trans->flags & APPLE_FLAG_FKEY)
> +				do_translate = (fnmode == 2 && fn_pressed) ||
> +					       (fnmode == 1 && !fn_pressed);
> +			else
> +				do_translate = fn_pressed;
> +
> +			if (do_translate)
> +				key = trans->to;
> +		}
> +	}
> +
> +	if (iso_layout) {
> +		trans = applespi_find_translation(apple_iso_keyboard, key);
> +		if (trans)
> +			key = trans->to;
> +	}

I would split this to three helpers like

static unsigned int ..._code_to_fn_key()
{
}

static unsigned int ..._code_to_iso_key()
{
}

static unsigned int ..._code_to_key()
{
	if (fnmode)
		key = ..._code_to_fn_key();
	if (iso_layout)
		key = ..._code_to_iso_key();
	return key;
}

> +
> +	return key;
> +}

> +static void applespi_remap_fn_key(struct keyboard_protocol
> +							*keyboard_protocol)

Better to split like

static void
fn(struct ...);


> +{
> +	unsigned char tmp;
> +	unsigned long *modifiers = (unsigned long *)
> +						&keyboard_protocol->modifiers;

Don't split casting from the rest, better

	... var =
		(type)...;

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
> +}

> +
> +static void applespi_handle_keyboard_event(struct applespi_data *applespi,

> +					   struct keyboard_protocol
> +							*keyboard_protocol)

Put this to one line, consider reformat like I mentioned above.

> +{

> +		if (!still_pressed) {
> +			key = applespi_code_to_key(
> +					applespi->last_keys_pressed[i],
> +					applespi->last_keys_fn_pressed[i]);
> +			input_report_key(applespi->keyboard_input_dev, key, 0);
> +			applespi->last_keys_fn_pressed[i] = 0;
> +		}

This could come as

if (...)
	continue;
...

> +	}

> +	memcpy(&applespi->last_keys_pressed, keyboard_protocol->keys_pressed,
> +	       sizeof(applespi->last_keys_pressed));

applespi->last_keys_pressed = *keyboard_protocol->keys_pressed;

(if they are of the same type) ?

> +}

> +static void applespi_register_touchpad_device(struct applespi_data *applespi,
> +				struct touchpad_info_protocol *rcvd_tp_info)
> +{

> +	/* create touchpad input device */
> +	touchpad_input_dev = devm_input_allocate_device(&applespi->spi->dev);

> +

Redundant.

> +	if (!touchpad_input_dev) {
> +		pr_err("Failed to allocate touchpad input device\n");

dev_err();

> +		return;

Shouldn't we return an error to a caller?

> +	}

> +	/* register input device */
> +	res = input_register_device(touchpad_input_dev);
> +	if (res)
> +		pr_err("Unabled to register touchpad input device (%d)\n", res);
> +	else

if (ret) {
	dev_err(...);
	return ret;
}

Btw, ret, res, sts, result, ... Choose one.

> +		/* touchpad_input_dev is read async in spi callback */
> +		smp_store_release(&applespi->touchpad_input_dev,
> +				  touchpad_input_dev);
> +}

> +static bool applespi_verify_crc(struct applespi_data *applespi, u8 *buffer,
> +				size_t buflen)
> +{
> +	u16 crc;
> +
> +	crc = crc16(0, buffer, buflen);
> +	if (crc != 0) {

if (crc) {

> +		dev_warn_ratelimited(&applespi->spi->dev,
> +				     "Received corrupted packet (crc mismatch)\n");
> +		debug_print_header(DBG_RD_CRC);
> +		debug_print_buffer(DBG_RD_CRC, "read   ", buffer, buflen);
> +
> +		return false;
> +	}
> +
> +	return true;
> +}

> +static void applespi_got_data(struct applespi_data *applespi)
> +{

> +	} else if (packet->flags == PACKET_TYPE_READ &&
> +		   packet->device == PACKET_DEV_TPAD) {

> +		struct touchpad_protocol *tp = &message->touchpad;
> +
> +		size_t tp_len = sizeof(*tp) +
> +				tp->number_of_fingers * sizeof(tp->fingers[0]);

Would be better

struct ...;
size_t ...;

... = ...;
if (...) {

> +		if (le16_to_cpu(message->length) + 2 != tp_len) {
> +			dev_warn_ratelimited(&applespi->spi->dev,
> +					     "Received corrupted packet (invalid message length)\n");
> +			goto cleanup;
> +		}

> +	} else if (packet->flags == PACKET_TYPE_WRITE) {
> +		applespi_handle_cmd_response(applespi, packet, message);
> +	}
> +

> +cleanup:

err_msg_complete: ?

> +	/* clean up */

Noise.

> +	applespi->saved_msg_len = 0;
> +
> +	applespi_msg_complete(applespi, packet->flags == PACKET_TYPE_WRITE,
> +			      true);
> +}

> +static u32 applespi_notify(acpi_handle gpe_device, u32 gpe, void *context)
> +{
> +	struct applespi_data *applespi = context;
> +	int sts;
> +	unsigned long flags;
> +
> +	debug_print_header(DBG_RD_IRQ);
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +
> +	if (!applespi->suspended) {
> +		sts = applespi_async(applespi, &applespi->rd_m,
> +				     applespi_async_read_complete);

> +		if (sts != 0)

if (sts)


> +			pr_warn("Error queueing async read to device: %d\n",
> +				sts);
> +		else
> +			applespi->read_active = true;
> +	}
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +
> +	return ACPI_INTERRUPT_HANDLED;
> +}
> +
> +static int applespi_get_saved_bl_level(void)
> +{
> +	struct efivar_entry *efivar_entry;
> +	u16 efi_data = 0;
> +	unsigned long efi_data_len;
> +	int sts;
> +
> +	efivar_entry = kmalloc(sizeof(*efivar_entry), GFP_KERNEL);
> +	if (!efivar_entry)

> +		return -1;

-ENOMEM

> +
> +	memcpy(efivar_entry->var.VariableName, EFI_BL_LEVEL_NAME,
> +	       sizeof(EFI_BL_LEVEL_NAME));
> +	efivar_entry->var.VendorGuid = EFI_BL_LEVEL_GUID;
> +	efi_data_len = sizeof(efi_data);
> +
> +	sts = efivar_entry_get(efivar_entry, NULL, &efi_data_len, &efi_data);
> +	if (sts && sts != -ENOENT)
> +		pr_warn("Error getting backlight level from EFI vars: %d\n",
> +			sts);
> +
> +	kfree(efivar_entry);
> +
> +	return efi_data;
> +}

> +static int applespi_probe(struct spi_device *spi)
> +{

> +	applespi->msg_buf = devm_kmalloc(&spi->dev, MAX_PKTS_PER_MSG *
> +						    APPLESPI_PACKET_SIZE,
> +					 GFP_KERNEL);

devm_kmalloc_array();

> +
> +	if (!applespi->tx_buffer || !applespi->tx_status ||
> +	    !applespi->rx_buffer || !applespi->msg_buf)
> +		return -ENOMEM;

> +	/*
> +	 * By default this device is not enable for wakeup; but USB keyboards
> +	 * generally are, so the expectation is that by default the keyboard
> +	 * will wake the system.
> +	 */
> +	device_wakeup_enable(&spi->dev);

> +	result = devm_led_classdev_register(&spi->dev,
> +					    &applespi->backlight_info);
> +	if (result) {
> +		pr_err("Unable to register keyboard backlight class dev (%d)\n",
> +		       result);

> +		/* not fatal */

Noise. Instead use dev_warn().

> +	}

> +	/* done */
> +	pr_info("spi-device probe done: %s\n", dev_name(&spi->dev));

Noise.
One may use "initcall_debug".

> +	return 0;
> +}
> +
> +static int applespi_remove(struct spi_device *spi)
> +{
> +	struct applespi_data *applespi = spi_get_drvdata(spi);
> +	unsigned long flags;

> +	/* shut things down */

Noise.

> +	acpi_disable_gpe(NULL, applespi->gpe);
> +	acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
> +

> +	/* done */
> +	pr_info("spi-device remove done: %s\n", dev_name(&spi->dev));

Noise.

It seems you still have wakeup enabled for the device.

> +	return 0;
> +}

> +static int applespi_suspend(struct device *dev)
> +{

> +	int rc;

Is it 6th type of naming for error code holding variable?

> +	/* wait for all outstanding writes to finish */
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +
> +	applespi->drain = true;
> +	wait_event_lock_irq(applespi->drain_complete, !applespi->write_active,
> +			    applespi->cmd_msg_lock);
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);

Helper? It's used in ->remove() AFAICS.

> +	pr_info("spi-device suspend done.\n");

Noise.
One may use ftrace instead.

> +	return 0;
> +}
> +
> +static int applespi_resume(struct device *dev)
> +{

> +	pr_info("spi-device resume done.\n");

Ditto.

> +
> +	return 0;
> +}

> +static const struct acpi_device_id applespi_acpi_match[] = {
> +	{ "APP000D", 0 },

> +	{ },

No comma, please.

> +};
> +MODULE_DEVICE_TABLE(acpi, applespi_acpi_match);

> +static struct spi_driver applespi_driver = {
> +	.driver		= {
> +		.name			= "applespi",

> +		.owner			= THIS_MODULE,

This set by macro.

> +

Redundant.

> +		.acpi_match_table	= ACPI_PTR(applespi_acpi_match),

Do you need ACPI_PTR() ?

> +		.pm			= &applespi_pm_ops,
> +	},
> +	.probe		= applespi_probe,
> +	.remove		= applespi_remove,
> +	.shutdown	= applespi_shutdown,
> +};
> +
> +module_spi_driver(applespi_driver)

> +MODULE_LICENSE("GPL");

License mismatch.

-- 
With Best Regards,
Andy Shevchenko


