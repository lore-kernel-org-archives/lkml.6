Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3E4222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404588AbfBPAob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:44:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:10562 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfBPAob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:44:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 16:44:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,374,1544515200"; 
   d="scan'208";a="139048618"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2019 16:44:27 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1guo5i-0007FX-Eu; Sat, 16 Feb 2019 02:44:26 +0200
Date:   Sat, 16 Feb 2019 02:44:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190216004426.GE9224@smile.fi.intel.com>
References: <20190204081947.25152-1-ronald@innovation.ch>
 <20190204081947.25152-3-ronald@innovation.ch>
 <20190206202256.GZ9224@smile.fi.intel.com>
 <20190210111834.GA27627@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190210111834.GA27627@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 03:18:34AM -0800, Life is hard, and then you die wrote:
> On Wed, Feb 06, 2019 at 10:22:56PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 04, 2019 at 12:19:47AM -0800, Ronald Tschalär wrote:

> > > +#define	debug_print(mask, fmt, ...) \
> > > +	do { \
> > > +		if (debug & mask) \
> > > +			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); \
> > > +	} while (0)
> > > +
> > > +#define	debug_print_header(mask) \
> > > +	debug_print(mask, "--- %s ---------------------------\n", \
> > > +		    applespi_debug_facility(mask))
> > > +
> > > +#define	debug_print_buffer(mask, fmt, ...) \
> > > +	do { \
> > > +		if (debug & mask) \
> > > +			print_hex_dump(KERN_DEBUG, pr_fmt(fmt), \
> > > +				       DUMP_PREFIX_NONE, 32, 1, ##__VA_ARGS__, \
> > > +				       false); \
> > > +	} while (0)
> > 
> > I'm not sure we need all of these... But okay, the driver is
> > reverse-engineered, perhaps we can drop it later on.
> 
> These have been extremely useful for debugging; but yes, they are for
> debugging only. They also explicitly do not use the dynamic-debug
> facilities because
>   1. those can't be enabled at a function or line level on the kernel
>      command line (the docs indicate this should work, but it doesn't,
>      or at the very least I've been unable to figure out how, at least
>      for those drivers built as modules)

Hmm... Usually you put either module_name.dyndbg into kernel command line to
enable Dynamic Debug on built-in modules, or modprobe module_name dyndbg if
it's built as a module.

>   2. the expressions to enable them quite brittle (in particular the
>      line-based ones) since they (may) change any time the code is
>      changed - having stable commands to give to users and put in
>      documentation (e.g.
>      "echo 0x200 > /sys/module/applespi/parameters/debug") is
>      quite valuable.
>   3. In at least two places we log different types of packets in the
>      same lines of code - dynamic-debug would only allow enabling or
>      disabling logging of all packets, unless we do something like
>      create separate functions for logging each type of packet.

> > > +static unsigned int fnmode = 1;
> > > +module_param(fnmode, uint, 0644);
> > > +MODULE_PARM_DESC(fnmode, "Mode of fn key on Apple keyboards (0 = disabled, [1] = fkeyslast, 2 = fkeysfirst)");
> > 
> > fn -> Fn ?
> 
> The physical key is actually labelled "fn" (no uppercase). But will
> certainly change it if you still wish.

I think Fn would be suitable (on the computer I'm typing this message the
special keys are all marked in small case, but we don't change HP driver to
state 'ctrl' instead 'Ctrl', for example, do we?).

> > Btw, do we need all these parameters? Can't we do modify behaviour run-time
> > using some Input framework facilities?
> 
> I'm not aware of any way to do so. I suppose the event callback could
> be used/extended to send "configuration" data, but that would require
> changes to the input core.
> 
> Also, for what it's worth, current drivers such as hid-apple (from
> which 'fnmode' and 'iso_layout' were copied and intentionally kept the
> same) use this approach too.

Hmm... Okay, I leave this to Input maintainers.

> > > +static int touchpad_dimensions[4];
> > > +module_param_array(touchpad_dimensions, int, NULL, 0444);
> > > +MODULE_PARM_DESC(touchpad_dimensions, "The pixel dimensions of the touchpad, as x_min,x_max,y_min,y_max .");
> > 
> > We have some parsers for similar data as in format
> > 
> > %dx%d%+d%+d ?
> > 
> > For example, 200x100+20+10.
> 
> Maybe it's just my grep-foo that is lacking, but I couldn't find
> anything useful. There is some stuff for framebuffer video modes, but
> that is too different and not really amenable for use here. OTOH, a
> simple sscanf(buf, "%dx%d+%d+%d", ...) would parse this just fine
> without the need for any fancier parser.
> 
> OTOH, I'm not sure this format is any better: internally we need
> x/y min/max, not x/y/w/h (though obviously the two are trivially
> convertable); and for the user it doesn't really matter since they would
> basically be getting the dimensions from running with debug set to
> 0x10000 and using that output to set this param, i.e. I don't see any
> inherent advantage of using x/y/w/h.

I would stick with some more or less standard notation. The XxY+W+H is widely
used in X11 world.

If you have better examples for input devices, choose them. My point that it
would be better to be a standard to some extent.

> > > +/**
> > > + * struct keyboard_protocol - keyboard message.
> > > + * message.type = 0x0110, message.length = 0x000a
> > > + *
> > > + * @unknown1:		unknown
> > > + * @modifiers:		bit-set of modifier/control keys pressed
> > > + * @unknown2:		unknown
> > > + * @keys_pressed:	the (non-modifier) keys currently pressed
> > > + * @fn_pressed:		whether the fn key is currently pressed
> > > + * @crc_16:		crc over the whole message struct (message header +
> > > + *			this struct) minus this @crc_16 field
> > 
> > Something wrong with indentation. Check it over all your kernel doc comments.
> 
> I used tabs here between the name and description, so it will show up
> odd in a diff or where quoted, but it is fine in the original. I've seen
> both styles (tabs and just spaces) used in the rest of code, so I'm not
> sure what the preferred one is. I'll switch to plain spaces if that's
> preferred.

Ah, if the result is okay, I'm fine.

> > > + */

> > > +struct touchpad_info_protocol {
> > > +	__u8			unknown1[105];
> > > +	__le16			model_id;
> > > +	__u8			unknown2[3];
> > > +	__le16			crc_16;
> > > +} __packed;
> > 
> > 112 % 16 == 0, why do you need __packed?
> 
> Because 'model_id' is not aligned on a 16-bit boundary. That this is a
> model id is just a guess (these are the only 2 bytes that differ
> between various touchpads, and those two bytes are always the same for
> a given touchpad size), and the fact that it's not aligned is
> suspicious (since everything else is), so it may actually well be two
> separate 8-bit fields. Looking at the known values (0x0417, 0x0557,
> and 0x06d7) it very well may be a 1-byte model (0x04, 0x05, 0x06) and
> a 1-byte "flags" (0x17, 0x57, 0xd7 - note how each one is a superset
> of the previous in terms of bits set).
> 
> In short, I can change this to 2 1-byte fields instead and thereby
> avoid the need for __packed.

If you feel that it's indeed 16=bit value, better to leave it as is.
But your guess sounds very reasonable to me to split it to something like you
proposed.

> > > +struct applespi_tp_info {
> > > +	int	x_min;
> > > +	int	x_max;
> > > +	int	y_min;
> > > +	int	y_max;
> > > +};
> > 
> > Perhaps use the same format as in struct drm_rect in order to possibility of
> > unifying them in the future?
> 
> You mean change the order to be x_min, y_min, x_max, y_max? (the field
> types and semantics already match). Ok.

Yep.

> > > +	switch (log_mask) {
> > > +	case DBG_CMD_TP_INI:
> > > +		return "Touchpad Initialization";
> > > +	case DBG_CMD_BL:
> > > +		return "Backlight Command";
> > > +	case DBG_CMD_CL:
> > > +		return "Caps-Lock Command";
> > > +	case DBG_RD_KEYB:
> > > +		return "Keyboard Event";
> > > +	case DBG_RD_TPAD:
> > > +		return "Touchpad Event";
> > > +	case DBG_RD_UNKN:
> > > +		return "Unknown Event";
> > > +	case DBG_RD_IRQ:
> > > +		return "Interrupt Request";
> > > +	case DBG_RD_CRC:
> > > +		return "Corrupted packet";
> > > +	case DBG_TP_DIM:
> > > +		return "Touchpad Dimensions";
> > > +	default:
> > > +		return "-Unknown-";
> > 
> > What the difference to RD_UNKN ?
> 
> RD_UNKN signifies an unknown packet type was received; default catches
> programming errors where a new log type was added without creating an
> entry here (i.e. defensive programmming).

I see.

> > Perhaps "Unrecognized ... "-ish better?
> 
> Sure. I've updated these now to
> 
>         case DBG_RD_UNKN:
>                 return "Unrecognized Event";
> 
>         default:
>                 return "-Unrecognized log mask-";

What I suggested here (in case they are different) is to leave UNKN  message as
is, but change default to use different word.

> > > +	}

> > > +static int applespi_send_cmd_msg(struct applespi_data *applespi)
> > > +{
> > 
> > > +	if (applespi->want_tp_info_cmd) {
> > 
> > > +	} else if (applespi->want_mt_init_cmd) {
> > 
> > > +	} else if (applespi->want_cl_led_on != applespi->have_cl_led_on) {
> > 
> > > +	} else if (applespi->want_bl_level != applespi->have_bl_level) {
> > 
> > > +	} else {
> > > +		return 0;
> > > +	}
> > 
> > Can we refactor to use some kind of enumeration and do switch-case here?
> 
> Multiple of these want_xyz may be "active" simultaneously (e.g. both a
> keyboard brightness change and the caps-lock-led change may be
> outstanding), as well these not all being simple booleans (want_bl_level
> is an actual level value).
> 
> The nearest I can think of right now would be to create a bitmap to hold
> potential change requests (so e.g. setting a new backlight level would
> set both the new wanted level as well a bit indicating that a backlight
> level change was requested, though the above check against the current
> level would still be needed), and use ffs() to pick a set bit and switch
> on the result. In pseudo code:
> 
>     applespi_set_bl_level()
>         want_bl_level = new-level
>         set_bit(BL_CMD, outstanding_cmds)
> 
>     applespi_set_capsl_led()
>         want_cl_led_on = new-led-on
>         set_bit(CL_CMD, outstanding_cmds)
> 
>     applespi_send_cmd_msg()
>         bool found_cmd = false
>         while (!found_cmd) {
>             cmd = ffs(outstanding_cmds)
>             switch (cmd) {
>             case CL_CMD:
>                 if (applespi->want_cl_led_on != applespi->have_cl_led_on) {
>                     found_cmd = true
>                     ...
>                 }
>                 clear_bit(CL_CMD, outstanding_cmds)
>                 break
> 
>             case BL_CMD:
>                 if (applespi->want_bl_level != applespi->have_bl_level) {
>                     found_cmd = true
>                     ...
>                 }
>                 clear_bit(BL_CMD, outstanding_cmds)
>                 break
> 
>             ... other commands ...
> 
>             default:
>                 return
>             }
>         }
> 
> Would this be preferrable?

I don't think it will make code better. Let's leave your initial proposal.

> > > +	message->counter = applespi->cmd_msg_cntr++ & 0xff;
> > 
> > Usual pattern for this kind of entries is
> > 
> >       x = ... % 256;
> > 
> > Btw, isn't 256 is defined somewhere?
> 
> Many things are defined as have a value of 256 :-) But I didn't find any
> with the intended semantics; could use (U8_MAX+1), though.

What I meant is that I saw in the same driver definition with value of 256.
Isn't it about messages?

> > Btw, consider to use dev_warn() and Co instead of pr_warn() or in cases where
> > appropriate acpi_handle_warn(), etc.
> 
> I've changed all log calls to use dev_xyz() now, including the
> debug_print()'s (for consistency in the resulting log messages).
> 
> Regarding acpi_handle_xyz(), though: isn't it better to have all log
> messages for a given device use the same logging prefix? I.e. in this
> case to use dev_xyz() instead of a mix and match of dev_xyz() and
> acpi_handle_xyz()? That makes it easier to grep for all messages related
> to a given module/device.

I'm fine with all being dev_<lvl>(). acpi_handle_<lvl>() makes sense when you
have interaction with ACPI handle and not a device.

> > > +/* lifted from the BCM5974 driver */
> > > +/* convert 16-bit little endian to signed integer */
> > > +static inline int raw2int(__le16 x)
> > > +{
> > > +	return (signed short)le16_to_cpu(x);
> > > +}
> > 
> > Perhaps it's time to introduce it inside include/linux/input.h ?
> 
> Perhaps as
> 
>     static inline int le16_to_signed_int(__le16 x)
> 
> ? (raw2int seems to ambiguous for a global function)

I'm fine. It would need a description though.

-- 
With Best Regards,
Andy Shevchenko


