Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755987AbeEHWFU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:05:20 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:52388 "EHLO
        6.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755734AbeEHWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:05:18 -0400
Date: Wed, 9 May 2018 06:49:09 +0900
From: Andi Shyti <andi@etezian.org>
To: Philipp Puschmann <pp@emlix.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rydberg@bitmath.org, andi@etezian.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ili251x - add support for Ilitek ILI251x
 touchscreens
Message-ID: <20180508214909.GB4974@jack.zhora.eu>
References: <20180507131823.28800-1-pp@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507131823.28800-1-pp@emlix.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Ovh-Tracer-Id: 1968073037594346124
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedrudeggddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

I had a fast look to your driver and I have few comments.

>  .../bindings/input/touchscreen/ili251x.txt    |  35 ++
>  drivers/input/touchscreen/Kconfig             |  12 +
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/ili251x.c           | 350 ++++++++++++++++++
>  4 files changed, 398 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ili251x.txt
>  create mode 100644 drivers/input/touchscreen/ili251x.c

Please split the patch, the bindig should be on a separate patch
and must come before the driver.

> +#define MAX_FINGERS		10
> +#define REG_TOUCHDATA		0x10
> +#define TOUCHDATA_FINGERS	6
> +#define REG_TOUCHDATA2		0x14
> +#define TOUCHDATA2_FINGERS	4
> +#define REG_PANEL_INFO		0x20
> +#define REG_FIRMWARE_VERSION	0x40
> +#define REG_PROTO_VERSION	0x42
> +#define REG_CALIBRATE		0xcc

Can you please group and sort these definitions by type? REGs
with REGs and others together?

Please start the defines names with a unique identifier,
ILI251X_REG_* instead of just REG_*

> +struct finger {
> +	u8 x_high:6;
> +	u8 dummy:1;
> +	u8 status:1;
> +	u8 x_low;
> +	u8 y_high;
> +	u8 y_low;
> +	u8 pressure;
> +} __packed;
> +
> +struct touchdata {
> +	u8 status;
> +	struct finger fingers[MAX_FINGERS];
> +} __packed;
> +
> +struct panel_info {
> +	u8 x_low;
> +	u8 x_high;
> +	u8 y_low;
> +	u8 y_high;
> +	u8 xchannel_num;
> +	u8 ychannel_num;
> +	u8 max_fingers;
> +} __packed;
> +
> +struct firmware_version {
> +	u8 id;
> +	u8 major;
> +	u8 minor;
> +} __packed;
> +
> +struct protocol_version {
> +	u8 major;
> +	u8 minor;
> +} __packed;

panel_info, firmware_version and protocol_version are used very
little in the driver (just in probe). Is it really necessary to
keep a definition?

Is there a way to get rid of them?

> +struct ili251x_data {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	unsigned int max_fingers;
> +	bool use_pressure;
> +	struct gpio_desc *reset_gpio;
> +};

Please start also the strct definitions with the unique
identifier ili251x_* like you did with ili251x_data.

> +
> +static int ili251x_read_reg(struct i2c_client *client, u8 reg, void *buf,
> +			    size_t len)
> +{
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr	= client->addr,
> +			.flags	= 0,
> +			.len	= 1,
> +			.buf	= &reg,
> +		},
> +		{
> +			.addr	= client->addr,
> +			.flags	= I2C_M_RD,
> +			.len	= len,
> +			.buf	= buf,
> +		}
> +	};
> +
> +	if (i2c_transfer(client->adapter, msg, 2) != 2) {
> +		dev_err(&client->dev, "i2c transfer failed\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

I do not see the need for a ili251x_read_reg function. You are
not reading more than 240 bytes per time, am I right?

In this case I would use the smbus functions (at least whenever
possible in case I miscalculated the 240b), this is ju a
duplicated code.

> +static void ili251x_report_events(struct ili251x_data *data,
> +				  const struct touchdata *touchdata)
> +{
> +	struct input_dev *input = data->input;
> +	unsigned int i;
> +	bool touch;
> +	unsigned int x, y;
> +	const struct finger *finger;
> +	unsigned int reported_fingers = 0;
> +
> +	/* the touch chip does not count the real fingers but switches between
> +	 * 0, 6 and 10 reported fingers *
> +	 *
> +	 * FIXME: With a tested ili2511 we received only garbage for fingers
> +	 *        6-9. As workaround we add a device tree option to limit the
> +	 *        handled number of fingers
> +	 */
> +	if (touchdata->status == 1)
> +		reported_fingers = 6;
> +	else if (touchdata->status == 2)
> +		reported_fingers = 10;
> +
> +	for (i = 0; i < reported_fingers && i < data->max_fingers; i++) {
> +		input_mt_slot(input, i);
> +
> +		finger = &touchdata->fingers[i];
> +
> +		touch = finger->status;
> +		input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
> +		x = finger->x_low | (finger->x_high << 8);
> +		y = finger->y_low | (finger->y_high << 8);

the x and y calculation can go uinside the if() below, right?

> +		if (touch) {
> +			input_report_abs(input, ABS_MT_POSITION_X, x);
> +			input_report_abs(input, ABS_MT_POSITION_Y, y);
> +			if (data->use_pressure)
> +				input_report_abs(input, ABS_MT_PRESSURE,
> +						 finger->pressure);
> +
> +		}

just a small nitpick, that is more a matter of preference, with

  if(!touch)
    continue;

we save a level of indentation.
