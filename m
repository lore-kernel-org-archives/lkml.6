Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbeA3LCy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:02:54 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36955 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeA3LCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:02:51 -0500
X-Google-Smtp-Source: AH8x225mCG5daRVjFG6iZS5oh8CfBgSQ21x8RW26iL2xwN5eiuVEIIfdh0BlB30yyOTUt42bIa9qtQ==
Date: Tue, 30 Jan 2018 12:02:47 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: Guard SMBIOS calls with a
 mutex
Message-ID: <20180130110247.5w4qreycdp2o5pjw@pali>
References: <1517267756-29878-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1517267756-29878-1-git-send-email-mario.limonciello@dell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0UB2v2s010917

On Monday 29 January 2018 17:15:56 Mario Limonciello wrote:
> Suggested-by: Pali Rohar <pali.rohar@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/platform/x86/dell-laptop.c | 67 ++++++++++++++++++++++++++++++--------
>  1 file changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index fc2dfc8..f8e2bd8 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -85,6 +85,7 @@ static struct rfkill *wifi_rfkill;
>  static struct rfkill *bluetooth_rfkill;
>  static struct rfkill *wwan_rfkill;
>  static bool force_rfkill;
> +static DEFINE_MUTEX(buffer_mutex);
>  
>  module_param(force_rfkill, bool, 0444);
>  MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
> @@ -472,16 +473,17 @@ static int dell_rfkill_set(void *data, bool blocked)
>  	int status;
>  	int ret;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(0, 0, 0, 0);
>  	ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
>  	if (ret)
> -		return ret;
> +		goto out;
>  	status = buffer->output[1];
>  
>  	dell_set_arguments(0x2, 0, 0, 0);
>  	ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);

Hi! I'm looking at this code, and do we need shared global buffer with
mutex protection at all? Is not buffer allocated on stack enough?

>  	if (ret)
> -		return ret;
> +		goto out;
>  	hwswitch = buffer->output[1];
>  
>  	/* If the hardware switch controls this radio, and the hardware
> @@ -492,6 +494,9 @@ static int dell_rfkill_set(void *data, bool blocked)
>  
>  	dell_set_arguments(1 | (radio<<8) | (disable << 16), 0, 0, 0);
>  	ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
> +
> +out:
> +	mutex_unlock(&buffer_mutex);
>  	return ret;
>  }
>  
> @@ -501,8 +506,10 @@ static void dell_rfkill_update_sw_state(struct rfkill *rfkill, int radio,
>  	if (status & BIT(0)) {
>  		/* Has hw-switch, sync sw_state to BIOS */
>  		int block = rfkill_blocked(rfkill);
> +		mutex_lock(&buffer_mutex);
>  		dell_set_arguments(1 | (radio << 8) | (block << 16), 0, 0, 0);
>  		dell_send_request(CLASS_INFO, SELECT_RFKILL);
> +		mutex_unlock(&buffer_mutex);
>  	} else {
>  		/* No hw-switch, sync BIOS state to sw_state */
>  		rfkill_set_sw_state(rfkill, !!(status & BIT(radio + 16)));
> @@ -523,22 +530,24 @@ static void dell_rfkill_query(struct rfkill *rfkill, void *data)
>  	int status;
>  	int ret;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(0, 0, 0, 0);
>  	ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
>  	status = buffer->output[1];
>  
> -	if (ret != 0 || !(status & BIT(0))) {
> -		return;
> -	}
> +	if (ret != 0 || !(status & BIT(0)))
> +		goto out;
>  
>  	dell_set_arguments(0, 0x2, 0, 0);
>  	ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
>  	hwswitch = buffer->output[1];
>  
>  	if (ret != 0)
> -		return;
> +		goto out;
>  
>  	dell_rfkill_update_hw_state(rfkill, radio, status, hwswitch);
> +out:
> +	mutex_unlock(&buffer_mutex);
>  }
>  
>  static const struct rfkill_ops dell_rfkill_ops = {
> @@ -555,16 +564,19 @@ static int dell_debugfs_show(struct seq_file *s, void *data)
>  	int status;
>  	int ret;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(0, 0, 0, 0);
>  	ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
>  	if (ret)
> -		return ret;
> +		goto out;
>  	status = buffer->output[1];
>  
>  	dell_set_arguments(0, 0x2, 0, 0);
>  	hwswitch_ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
> -	if (hwswitch_ret)
> -		return hwswitch_ret;
> +	if (hwswitch_ret) {
> +		ret = hwswitch_ret;
> +		goto out;
> +	}
>  	hwswitch_state = buffer->output[1];
>  
>  	seq_printf(s, "return:\t%d\n", ret);
> @@ -628,7 +640,9 @@ static int dell_debugfs_show(struct seq_file *s, void *data)
>  	seq_printf(s, "Bit 15: Wifi locator setting locked:    %lu\n",
>  		   (hwswitch_state & BIT(15)) >> 15);
>  
> -	return 0;
> +out:
> +	mutex_unlock(&buffer_mutex);
> +	return ret;
>  }
>  
>  static int dell_debugfs_open(struct inode *inode, struct file *file)
> @@ -650,12 +664,13 @@ static void dell_update_rfkill(struct work_struct *ignored)
>  	int status;
>  	int ret;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(0, 0, 0, 0);
>  	ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
>  	status = buffer->output[1];
>  
>  	if (ret != 0)
> -		return;
> +		goto out;
>  
>  	dell_set_arguments(0, 0x2, 0, 0);
>  	ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
> @@ -676,6 +691,8 @@ static void dell_update_rfkill(struct work_struct *ignored)
>  		dell_rfkill_update_hw_state(wwan_rfkill, 3, status, hwswitch);
>  		dell_rfkill_update_sw_state(wwan_rfkill, 3, status);
>  	}
> +out:
> +	mutex_unlock(&buffer_mutex);
>  }
>  static DECLARE_DELAYED_WORK(dell_rfkill_work, dell_update_rfkill);
>  
> @@ -734,9 +751,11 @@ static int __init dell_setup_rfkill(void)
>  	if (!force_rfkill && !whitelisted)
>  		return 0;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(0, 0, 0, 0);
>  	ret = dell_send_request(CLASS_INFO, SELECT_RFKILL);
>  	status = buffer->output[1];
> +	mutex_unlock(&buffer_mutex);
>  
>  	/* dell wireless info smbios call is not supported */
>  	if (ret != 0)
> @@ -896,11 +915,13 @@ static int dell_send_intensity(struct backlight_device *bd)
>  	if (!token)
>  		return -ENODEV;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(token->location, bd->props.brightness, 0, 0);
>  	if (power_supply_is_system_supplied() > 0)
>  		ret = dell_send_request(CLASS_TOKEN_WRITE, SELECT_TOKEN_AC);
>  	else
>  		ret = dell_send_request(CLASS_TOKEN_WRITE, SELECT_TOKEN_BAT);
> +	mutex_unlock(&buffer_mutex);
>  
>  	return ret;
>  }
> @@ -914,6 +935,7 @@ static int dell_get_intensity(struct backlight_device *bd)
>  	if (!token)
>  		return -ENODEV;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(token->location, 0, 0, 0);
>  	if (power_supply_is_system_supplied() > 0)
>  		ret = dell_send_request(CLASS_TOKEN_READ, SELECT_TOKEN_AC);
> @@ -922,6 +944,8 @@ static int dell_get_intensity(struct backlight_device *bd)
>  
>  	if (ret == 0)
>  		ret = buffer->output[1];
> +	mutex_unlock(&buffer_mutex);
> +
>  	return ret;
>  }
>  
> @@ -1189,10 +1213,11 @@ static int kbd_get_info(struct kbd_info *info)
>  	u8 units;
>  	int ret;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(0, 0, 0, 0);
>  	ret = dell_send_request(CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	info->modes = buffer->output[1] & 0xFFFF;
>  	info->type = (buffer->output[1] >> 24) & 0xFF;
> @@ -1212,6 +1237,8 @@ static int kbd_get_info(struct kbd_info *info)
>  	if (units & BIT(3))
>  		info->days = (buffer->output[3] >> 24) & 0xFF;
>  
> +out:
> +	mutex_unlock(&buffer_mutex);
>  	return ret;
>  }
>  
> @@ -1272,10 +1299,11 @@ static int kbd_get_state(struct kbd_state *state)
>  {
>  	int ret;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(0x1, 0, 0, 0);
>  	ret = dell_send_request(CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	state->mode_bit = ffs(buffer->output[1] & 0xFFFF);
>  	if (state->mode_bit != 0)
> @@ -1289,7 +1317,8 @@ static int kbd_get_state(struct kbd_state *state)
>  	state->level = (buffer->output[2] >> 16) & 0xFF;
>  	state->timeout_value_ac = (buffer->output[2] >> 24) & 0x3F;
>  	state->timeout_unit_ac = (buffer->output[2] >> 30) & 0x3;
> -
> +out:
> +	mutex_unlock(&buffer_mutex);
>  	return ret;
>  }
>  
> @@ -1307,8 +1336,10 @@ static int kbd_set_state(struct kbd_state *state)
>  	input2 |= (state->level & 0xFF) << 16;
>  	input2 |= (state->timeout_value_ac & 0x3F) << 24;
>  	input2 |= (state->timeout_unit_ac & 0x3) << 30;
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(0x2, input1, input2, 0);
>  	ret = dell_send_request(CLASS_KBD_BACKLIGHT, SELECT_KBD_BACKLIGHT);
> +	mutex_unlock(&buffer_mutex);
>  
>  	return ret;
>  }
> @@ -1345,8 +1376,10 @@ static int kbd_set_token_bit(u8 bit)
>  	if (!token)
>  		return -EINVAL;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(token->location, token->value, 0, 0);
>  	ret = dell_send_request(CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +	mutex_unlock(&buffer_mutex);
>  
>  	return ret;
>  }
> @@ -1364,9 +1397,11 @@ static int kbd_get_token_bit(u8 bit)
>  	if (!token)
>  		return -EINVAL;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(token->location, 0, 0, 0);
>  	ret = dell_send_request(CLASS_TOKEN_READ, SELECT_TOKEN_STD);
>  	val = buffer->output[1];
> +	mutex_unlock(&buffer_mutex);
>  
>  	if (ret)
>  		return ret;
> @@ -2114,8 +2149,10 @@ int dell_micmute_led_set(int state)
>  	if (!token)
>  		return -ENODEV;
>  
> +	mutex_lock(&buffer_mutex);
>  	dell_set_arguments(token->location, token->value, 0, 0);
>  	dell_send_request(CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +	mutex_unlock(&buffer_mutex);
>  
>  	return state;
>  }
> @@ -2177,10 +2214,12 @@ static int __init dell_init(void)
>  
>  	token = dell_smbios_find_token(BRIGHTNESS_TOKEN);
>  	if (token) {
> +		mutex_lock(&buffer_mutex);
>  		dell_set_arguments(token->location, 0, 0, 0);
>  		ret = dell_send_request(CLASS_TOKEN_READ, SELECT_TOKEN_AC);
>  		if (ret)
>  			max_intensity = buffer->output[3];
> +		mutex_unlock(&buffer_mutex);
>  	}
>  
>  	if (max_intensity) {

-- 
Pali Rohár
pali.rohar@gmail.com
