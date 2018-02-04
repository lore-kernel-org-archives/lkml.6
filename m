Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbeBDMJd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 07:09:33 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39487 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeBDMJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 07:09:25 -0500
X-Google-Smtp-Source: AH8x227vvCHVuOD31Qu+jbWwUHdEDx8lax5ChlHHynvxKBeJojAoh6FBNjgqcE2NRFTMjZQj0D1whQ==
Date: Sun, 4 Feb 2018 13:09:22 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Message-ID: <20180204120922.fds52i22griw2h6e@pali>
References: <1517420855-19374-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ztp5syqpirmhdkp7"
Content-Disposition: inline
In-Reply-To: <1517420855-19374-1-git-send-email-mario.limonciello@dell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ztp5syqpirmhdkp7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 31 January 2018 11:47:35 Mario Limonciello wrote:
> There is no longer a need for the buffer to be defined in
> first 4GB physical address space.
>=20
> Furthermore there may be race conditions with multiple different functions
> working on a module wide buffer causing incorrect results.
>=20
> Fixes: 549b4930f057658dc50d8010e66219233119a4d8
> Suggested-by: Pali Rohar <pali.rohar@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---

Ok, you can add my:

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

>  drivers/platform/x86/dell-laptop.c | 188 ++++++++++++++++++++-----------=
------
>  1 file changed, 103 insertions(+), 85 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-laptop.c
> index fc2dfc8..a7b1419 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -78,7 +78,6 @@ static struct platform_driver platform_driver =3D {
>  	}
>  };
> =20
> -static struct calling_interface_buffer *buffer;
>  static struct platform_device *platform_device;
>  static struct backlight_device *dell_backlight_device;
>  static struct rfkill *wifi_rfkill;
> @@ -322,7 +321,8 @@ static const struct dmi_system_id dell_quirks[] __ini=
tconst =3D {
>  	{ }
>  };
> =20
> -static void dell_set_arguments(u32 arg0, u32 arg1, u32 arg2, u32 arg3)
> +static void dell_fill_request(struct calling_interface_buffer *buffer,
> +			       u32 arg0, u32 arg1, u32 arg2, u32 arg3)
>  {
>  	memset(buffer, 0, sizeof(struct calling_interface_buffer));
>  	buffer->input[0] =3D arg0;
> @@ -331,7 +331,8 @@ static void dell_set_arguments(u32 arg0, u32 arg1, u3=
2 arg2, u32 arg3)
>  	buffer->input[3] =3D arg3;
>  }
> =20
> -static int dell_send_request(u16 class, u16 select)
> +static int dell_send_request(struct calling_interface_buffer *buffer,
> +			     u16 class, u16 select)
>  {
>  	int ret;
> =20
> @@ -468,21 +469,22 @@ static int dell_rfkill_set(void *data, bool blocked)
>  	int disable =3D blocked ? 1 : 0;
>  	unsigned long radio =3D (unsigned long)data;
>  	int hwswitch_bit =3D (unsigned long)data - 1;
> +	struct calling_interface_buffer buffer;
>  	int hwswitch;
>  	int status;
>  	int ret;
> =20
> -	dell_set_arguments(0, 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> +	dell_fill_request(&buffer, 0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
>  	if (ret)
>  		return ret;
> -	status =3D buffer->output[1];
> +	status =3D buffer.output[1];
> =20
> -	dell_set_arguments(0x2, 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> +	dell_fill_request(&buffer, 0x2, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
>  	if (ret)
>  		return ret;
> -	hwswitch =3D buffer->output[1];
> +	hwswitch =3D buffer.output[1];
> =20
>  	/* If the hardware switch controls this radio, and the hardware
>  	   switch is disabled, always disable the radio */
> @@ -490,8 +492,8 @@ static int dell_rfkill_set(void *data, bool blocked)
>  	    (status & BIT(0)) && !(status & BIT(16)))
>  		disable =3D 1;
> =20
> -	dell_set_arguments(1 | (radio<<8) | (disable << 16), 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> +	dell_fill_request(&buffer, 1 | (radio<<8) | (disable << 16), 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
>  	return ret;
>  }
> =20
> @@ -500,9 +502,11 @@ static void dell_rfkill_update_sw_state(struct rfkil=
l *rfkill, int radio,
>  {
>  	if (status & BIT(0)) {
>  		/* Has hw-switch, sync sw_state to BIOS */
> +		struct calling_interface_buffer buffer;
>  		int block =3D rfkill_blocked(rfkill);
> -		dell_set_arguments(1 | (radio << 8) | (block << 16), 0, 0, 0);
> -		dell_send_request(CLASS_INFO, SELECT_RFKILL);
> +		dell_fill_request(&buffer,
> +				   1 | (radio << 8) | (block << 16), 0, 0, 0);
> +		dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
>  	} else {
>  		/* No hw-switch, sync BIOS state to sw_state */
>  		rfkill_set_sw_state(rfkill, !!(status & BIT(radio + 16)));
> @@ -519,21 +523,22 @@ static void dell_rfkill_update_hw_state(struct rfki=
ll *rfkill, int radio,
>  static void dell_rfkill_query(struct rfkill *rfkill, void *data)
>  {
>  	int radio =3D ((unsigned long)data & 0xF);
> +	struct calling_interface_buffer buffer;
>  	int hwswitch;
>  	int status;
>  	int ret;
> =20
> -	dell_set_arguments(0, 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> -	status =3D buffer->output[1];
> +	dell_fill_request(&buffer, 0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
> +	status =3D buffer.output[1];
> =20
>  	if (ret !=3D 0 || !(status & BIT(0))) {
>  		return;
>  	}
> =20
> -	dell_set_arguments(0, 0x2, 0, 0);
> -	ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> -	hwswitch =3D buffer->output[1];
> +	dell_fill_request(&buffer, 0, 0x2, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
> +	hwswitch =3D buffer.output[1];
> =20
>  	if (ret !=3D 0)
>  		return;
> @@ -550,22 +555,23 @@ static struct dentry *dell_laptop_dir;
> =20
>  static int dell_debugfs_show(struct seq_file *s, void *data)
>  {
> +	struct calling_interface_buffer buffer;
>  	int hwswitch_state;
>  	int hwswitch_ret;
>  	int status;
>  	int ret;
> =20
> -	dell_set_arguments(0, 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> +	dell_fill_request(&buffer, 0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
>  	if (ret)
>  		return ret;
> -	status =3D buffer->output[1];
> +	status =3D buffer.output[1];
> =20
> -	dell_set_arguments(0, 0x2, 0, 0);
> -	hwswitch_ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> +	dell_fill_request(&buffer, 0, 0x2, 0, 0);
> +	hwswitch_ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
>  	if (hwswitch_ret)
>  		return hwswitch_ret;
> -	hwswitch_state =3D buffer->output[1];
> +	hwswitch_state =3D buffer.output[1];
> =20
>  	seq_printf(s, "return:\t%d\n", ret);
>  	seq_printf(s, "status:\t0x%X\n", status);
> @@ -646,22 +652,23 @@ static const struct file_operations dell_debugfs_fo=
ps =3D {
> =20
>  static void dell_update_rfkill(struct work_struct *ignored)
>  {
> +	struct calling_interface_buffer buffer;
>  	int hwswitch =3D 0;
>  	int status;
>  	int ret;
> =20
> -	dell_set_arguments(0, 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> -	status =3D buffer->output[1];
> +	dell_fill_request(&buffer, 0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
> +	status =3D buffer.output[1];
> =20
>  	if (ret !=3D 0)
>  		return;
> =20
> -	dell_set_arguments(0, 0x2, 0, 0);
> -	ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> +	dell_fill_request(&buffer, 0, 0x2, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
> =20
>  	if (ret =3D=3D 0 && (status & BIT(0)))
> -		hwswitch =3D buffer->output[1];
> +		hwswitch =3D buffer.output[1];
> =20
>  	if (wifi_rfkill) {
>  		dell_rfkill_update_hw_state(wifi_rfkill, 1, status, hwswitch);
> @@ -719,6 +726,7 @@ static struct notifier_block dell_laptop_rbtn_notifie=
r =3D {
> =20
>  static int __init dell_setup_rfkill(void)
>  {
> +	struct calling_interface_buffer buffer;
>  	int status, ret, whitelisted;
>  	const char *product;
> =20
> @@ -734,9 +742,9 @@ static int __init dell_setup_rfkill(void)
>  	if (!force_rfkill && !whitelisted)
>  		return 0;
> =20
> -	dell_set_arguments(0, 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_INFO, SELECT_RFKILL);
> -	status =3D buffer->output[1];
> +	dell_fill_request(&buffer, 0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);
> +	status =3D buffer.output[1];
> =20
>  	/* dell wireless info smbios call is not supported */
>  	if (ret !=3D 0)
> @@ -889,6 +897,7 @@ static void dell_cleanup_rfkill(void)
> =20
>  static int dell_send_intensity(struct backlight_device *bd)
>  {
> +	struct calling_interface_buffer buffer;
>  	struct calling_interface_token *token;
>  	int ret;
> =20
> @@ -896,17 +905,21 @@ static int dell_send_intensity(struct backlight_dev=
ice *bd)
>  	if (!token)
>  		return -ENODEV;
> =20
> -	dell_set_arguments(token->location, bd->props.brightness, 0, 0);
> +	dell_fill_request(&buffer,
> +			   token->location, bd->props.brightness, 0, 0);
>  	if (power_supply_is_system_supplied() > 0)
> -		ret =3D dell_send_request(CLASS_TOKEN_WRITE, SELECT_TOKEN_AC);
> +		ret =3D dell_send_request(&buffer,
> +					CLASS_TOKEN_WRITE, SELECT_TOKEN_AC);
>  	else
> -		ret =3D dell_send_request(CLASS_TOKEN_WRITE, SELECT_TOKEN_BAT);
> +		ret =3D dell_send_request(&buffer,
> +					CLASS_TOKEN_WRITE, SELECT_TOKEN_BAT);
> =20
>  	return ret;
>  }
> =20
>  static int dell_get_intensity(struct backlight_device *bd)
>  {
> +	struct calling_interface_buffer buffer;
>  	struct calling_interface_token *token;
>  	int ret;
> =20
> @@ -914,14 +927,17 @@ static int dell_get_intensity(struct backlight_devi=
ce *bd)
>  	if (!token)
>  		return -ENODEV;
> =20
> -	dell_set_arguments(token->location, 0, 0, 0);
> +	dell_fill_request(&buffer, token->location, 0, 0, 0);
>  	if (power_supply_is_system_supplied() > 0)
> -		ret =3D dell_send_request(CLASS_TOKEN_READ, SELECT_TOKEN_AC);
> +		ret =3D dell_send_request(&buffer,
> +					CLASS_TOKEN_READ, SELECT_TOKEN_AC);
>  	else
> -		ret =3D dell_send_request(CLASS_TOKEN_READ, SELECT_TOKEN_BAT);
> +		ret =3D dell_send_request(&buffer,
> +					CLASS_TOKEN_READ, SELECT_TOKEN_BAT);
> =20
>  	if (ret =3D=3D 0)
> -		ret =3D buffer->output[1];
> +		ret =3D buffer.output[1];
> +
>  	return ret;
>  }
> =20
> @@ -1186,31 +1202,33 @@ static enum led_brightness kbd_led_level;
> =20
>  static int kbd_get_info(struct kbd_info *info)
>  {
> +	struct calling_interface_buffer buffer;
>  	u8 units;
>  	int ret;
> =20
> -	dell_set_arguments(0, 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT);
> +	dell_fill_request(&buffer, 0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer,
> +				CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT);
>  	if (ret)
>  		return ret;
> =20
> -	info->modes =3D buffer->output[1] & 0xFFFF;
> -	info->type =3D (buffer->output[1] >> 24) & 0xFF;
> -	info->triggers =3D buffer->output[2] & 0xFF;
> -	units =3D (buffer->output[2] >> 8) & 0xFF;
> -	info->levels =3D (buffer->output[2] >> 16) & 0xFF;
> +	info->modes =3D buffer.output[1] & 0xFFFF;
> +	info->type =3D (buffer.output[1] >> 24) & 0xFF;
> +	info->triggers =3D buffer.output[2] & 0xFF;
> +	units =3D (buffer.output[2] >> 8) & 0xFF;
> +	info->levels =3D (buffer.output[2] >> 16) & 0xFF;
> =20
>  	if (quirks && quirks->kbd_led_levels_off_1 && info->levels)
>  		info->levels--;
> =20
>  	if (units & BIT(0))
> -		info->seconds =3D (buffer->output[3] >> 0) & 0xFF;
> +		info->seconds =3D (buffer.output[3] >> 0) & 0xFF;
>  	if (units & BIT(1))
> -		info->minutes =3D (buffer->output[3] >> 8) & 0xFF;
> +		info->minutes =3D (buffer.output[3] >> 8) & 0xFF;
>  	if (units & BIT(2))
> -		info->hours =3D (buffer->output[3] >> 16) & 0xFF;
> +		info->hours =3D (buffer.output[3] >> 16) & 0xFF;
>  	if (units & BIT(3))
> -		info->days =3D (buffer->output[3] >> 24) & 0xFF;
> +		info->days =3D (buffer.output[3] >> 24) & 0xFF;
> =20
>  	return ret;
>  }
> @@ -1270,31 +1288,34 @@ static int kbd_set_level(struct kbd_state *state,=
 u8 level)
> =20
>  static int kbd_get_state(struct kbd_state *state)
>  {
> +	struct calling_interface_buffer buffer;
>  	int ret;
> =20
> -	dell_set_arguments(0x1, 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT);
> +	dell_fill_request(&buffer, 0, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer,
> +				CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT);
>  	if (ret)
>  		return ret;
> =20
> -	state->mode_bit =3D ffs(buffer->output[1] & 0xFFFF);
> +	state->mode_bit =3D ffs(buffer.output[1] & 0xFFFF);
>  	if (state->mode_bit !=3D 0)
>  		state->mode_bit--;
> =20
> -	state->triggers =3D (buffer->output[1] >> 16) & 0xFF;
> -	state->timeout_value =3D (buffer->output[1] >> 24) & 0x3F;
> -	state->timeout_unit =3D (buffer->output[1] >> 30) & 0x3;
> -	state->als_setting =3D buffer->output[2] & 0xFF;
> -	state->als_value =3D (buffer->output[2] >> 8) & 0xFF;
> -	state->level =3D (buffer->output[2] >> 16) & 0xFF;
> -	state->timeout_value_ac =3D (buffer->output[2] >> 24) & 0x3F;
> -	state->timeout_unit_ac =3D (buffer->output[2] >> 30) & 0x3;
> +	state->triggers =3D (buffer.output[1] >> 16) & 0xFF;
> +	state->timeout_value =3D (buffer.output[1] >> 24) & 0x3F;
> +	state->timeout_unit =3D (buffer.output[1] >> 30) & 0x3;
> +	state->als_setting =3D buffer.output[2] & 0xFF;
> +	state->als_value =3D (buffer.output[2] >> 8) & 0xFF;
> +	state->level =3D (buffer.output[2] >> 16) & 0xFF;
> +	state->timeout_value_ac =3D (buffer.output[2] >> 24) & 0x3F;
> +	state->timeout_unit_ac =3D (buffer.output[2] >> 30) & 0x3;
> =20
>  	return ret;
>  }
> =20
>  static int kbd_set_state(struct kbd_state *state)
>  {
> +	struct calling_interface_buffer buffer;
>  	int ret;
>  	u32 input1;
>  	u32 input2;
> @@ -1307,8 +1328,9 @@ static int kbd_set_state(struct kbd_state *state)
>  	input2 |=3D (state->level & 0xFF) << 16;
>  	input2 |=3D (state->timeout_value_ac & 0x3F) << 24;
>  	input2 |=3D (state->timeout_unit_ac & 0x3) << 30;
> -	dell_set_arguments(0x2, input1, input2, 0);
> -	ret =3D dell_send_request(CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT);
> +	dell_fill_request(&buffer, 0x2, input1, input2, 0);
> +	ret =3D dell_send_request(&buffer,
> +				CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT);
> =20
>  	return ret;
>  }
> @@ -1335,6 +1357,7 @@ static int kbd_set_state_safe(struct kbd_state *sta=
te, struct kbd_state *old)
> =20
>  static int kbd_set_token_bit(u8 bit)
>  {
> +	struct calling_interface_buffer buffer;
>  	struct calling_interface_token *token;
>  	int ret;
> =20
> @@ -1345,14 +1368,15 @@ static int kbd_set_token_bit(u8 bit)
>  	if (!token)
>  		return -EINVAL;
> =20
> -	dell_set_arguments(token->location, token->value, 0, 0);
> -	ret =3D dell_send_request(CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +	dell_fill_request(&buffer, token->location, token->value, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> =20
>  	return ret;
>  }
> =20
>  static int kbd_get_token_bit(u8 bit)
>  {
> +	struct calling_interface_buffer buffer;
>  	struct calling_interface_token *token;
>  	int ret;
>  	int val;
> @@ -1364,9 +1388,9 @@ static int kbd_get_token_bit(u8 bit)
>  	if (!token)
>  		return -EINVAL;
> =20
> -	dell_set_arguments(token->location, 0, 0, 0);
> -	ret =3D dell_send_request(CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> -	val =3D buffer->output[1];
> +	dell_fill_request(&buffer, token->location, 0, 0, 0);
> +	ret =3D dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> +	val =3D buffer.output[1];
> =20
>  	if (ret)
>  		return ret;
> @@ -2102,6 +2126,7 @@ static struct notifier_block dell_laptop_notifier =
=3D {
> =20
>  int dell_micmute_led_set(int state)
>  {
> +	struct calling_interface_buffer buffer;
>  	struct calling_interface_token *token;
> =20
>  	if (state =3D=3D 0)
> @@ -2114,8 +2139,8 @@ int dell_micmute_led_set(int state)
>  	if (!token)
>  		return -ENODEV;
> =20
> -	dell_set_arguments(token->location, token->value, 0, 0);
> -	dell_send_request(CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +	dell_fill_request(&buffer, token->location, token->value, 0, 0);
> +	dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> =20
>  	return state;
>  }
> @@ -2146,13 +2171,6 @@ static int __init dell_init(void)
>  	if (ret)
>  		goto fail_platform_device2;
> =20
> -	buffer =3D kzalloc(sizeof(struct calling_interface_buffer), GFP_KERNEL);
> -	if (!buffer) {
> -		ret =3D -ENOMEM;
> -		goto fail_buffer;
> -	}
> -
> -
>  	ret =3D dell_setup_rfkill();
> =20
>  	if (ret) {
> @@ -2177,10 +2195,13 @@ static int __init dell_init(void)
> =20
>  	token =3D dell_smbios_find_token(BRIGHTNESS_TOKEN);
>  	if (token) {
> -		dell_set_arguments(token->location, 0, 0, 0);
> -		ret =3D dell_send_request(CLASS_TOKEN_READ, SELECT_TOKEN_AC);
> +		struct calling_interface_buffer buffer;
> +
> +		dell_fill_request(&buffer, token->location, 0, 0, 0);
> +		ret =3D dell_send_request(&buffer,
> +					CLASS_TOKEN_READ, SELECT_TOKEN_AC);
>  		if (ret)
> -			max_intensity =3D buffer->output[3];
> +			max_intensity =3D buffer.output[3];
>  	}
> =20
>  	if (max_intensity) {
> @@ -2214,8 +2235,6 @@ static int __init dell_init(void)
>  fail_get_brightness:
>  	backlight_device_unregister(dell_backlight_device);
>  fail_backlight:
> -	kfree(buffer);
> -fail_buffer:
>  	dell_cleanup_rfkill();
>  fail_rfkill:
>  	platform_device_del(platform_device);
> @@ -2235,7 +2254,6 @@ static void __exit dell_exit(void)
>  		touchpad_led_exit();
>  	kbd_led_exit();
>  	backlight_device_unregister(dell_backlight_device);
> -	kfree(buffer);
>  	dell_cleanup_rfkill();
>  	if (platform_device) {
>  		platform_device_unregister(platform_device);

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ztp5syqpirmhdkp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWnb37wAKCRCL8Mk9A+RD
UrApAJwOCfgDumObp4cSmuRPUPH0teh7dgCaA/fe5ik5RgNBQiemn3h6UjPFoJs=
=8TJF
-----END PGP SIGNATURE-----

--ztp5syqpirmhdkp7--
