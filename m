Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZq+k1UpyRB4VSvOLmt2tFpziZ9vHbS5HKX4OneqOZBPTxI13zGiKjrxK9mUFCOh14Ov+Kvk
ARC-Seal: i=1; a=rsa-sha256; t=1525390805; cv=none;
        d=google.com; s=arc-20160816;
        b=waUpEiMH7WKdT1UZhD7SOma8erCSn6+COlbxf4o0tGxPU66dBqAbJ64P0Z/W+mV7YP
         bLUe1NQjyHISq/Te9ql0WOe6j3W9Ui4Ohk/nvT7aDJezjOrirQXQLjkTAgywmSvXUmaw
         H8dKlSoo0BxMogUB8xcjel9jDRhsi2A0g6coY0Ohei01vuCTi0I3c5ZRyPJIsD+NfLRg
         vu1TFoq4NWqZZZICDCwAKbXS5gvVZC7JW8ZylbUBbp+/igDAoQNzLE9Uuk9i0SpRIarL
         4yd0XU5K63x+WeD6oYg2BXeAUVvfkdt6Q+VOgBssgvLXZsMJ05OBLXsQRklzGKcNJpir
         gYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ZZUDCY7seWx/TgpqI3XPM0zEy7reDhDoDivvvsNYSOk=;
        b=t/pcCDL0eucNYT5TURX4wBgy6tge9ZzItotURjUIiVbAJtJmyqN4a7vzvDwBMOwRhI
         bBWY9j1ySGMIRnSIQGE+hzO+eEmP+F2+2+RAGJQ7L9bL+G+ExaOUSwulFM7O8PNTrEld
         B86QV93POQ50CYy4kmEd8Mugfgjxdop2F8Ji1WZNYB9HV0l0PgZ41eYsGxDysC6m3t3n
         65z5A6s2BqlqEOFohhYlcJEglHOOA+qj7a57KIMQgc8VAoGHSgXnFbuE178K98jRO2fk
         zu9KY9QqRe6B70uBkqF8YRcdo0lwWjLA7gHmdqb+wcPusgffk7QTYqInyjKeOfi/lHhT
         XcAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 3 May 2018 23:40:03 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, alexdeucher@gmail.com, christian.koenig@amd.com,
	kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	hdegoede@redhat.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 5/9] firmware: add function to load firmware without
 warnings v5
Message-ID: <20180503234003.GW27853@wotan.suse.de>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-6-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423201205.20533-6-andresx7@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569150296096540?=
X-GMAIL-MSGID: =?utf-8?q?1599488189125221075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:12:01PM -0400, Andres Rodriguez wrote:
> Currently the firmware loader only exposes one silent path for querying
> optional firmware, and that is firmware_request_direct(). This function
> also disables the fallback path, which might not always be the
> desired behaviour. [0]
> 
> This patch introduces a variations of firmware_request() that enable the
> caller to disable the undesired warning messages. This is equivalent to
> adding FW_OPT_NO_WARN to the old behaviour.
> 
> v2: add header prototype, use updated opt_flags
> v3: split debug message to separate patch
>     added _nowait variant
>     added documentation
> v4: fix kernel-doc style
> v5: drop _nowait for now, since we lack agreement on the API
> 
> [0]: https://git.kernel.org/linus/c0cc00f250e1
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>  .../driver-api/firmware/request_firmware.rst       |  5 +++++
>  drivers/base/firmware_loader/main.c                | 24 ++++++++++++++++++++++
>  include/linux/firmware.h                           |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
> index 7632f8807472..c8bddbdcfd10 100644
> --- a/Documentation/driver-api/firmware/request_firmware.rst
> +++ b/Documentation/driver-api/firmware/request_firmware.rst
> @@ -20,6 +20,11 @@ firmware_request
>  .. kernel-doc:: drivers/base/firmware_loader/main.c
>     :functions: firmware_request
>  
> +firmware_request_nowarn
> +-----------------------
> +.. kernel-doc:: drivers/base/firmware_loader/main.c
> +   :functions: firmware_request_nowarn
> +
>  firmware_request_direct
>  -----------------------
>  .. kernel-doc:: drivers/base/firmware_loader/main.c
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index d028cd3257f7..58aaadf81e12 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -631,6 +631,30 @@ firmware_request(const struct firmware **firmware_p, const char *name,
>  }
>  EXPORT_SYMBOL(firmware_request);
>  
> +/**
> + * firmware_request_nowarn() - request for an optional fw module
> + * @firmware: pointer to firmware image
> + * @name: name of firmware file
> + * @device: device for which firmware is being loaded
> + *
> + * This function is similar in behaviour to firmware_request(), except
> + * it doesn't produce warning messages when the file is not found.

It doesn't explain the difference between this and firmware_request_direct()
I'll go ahead and add this and expand also on firmware_request_direct() to be
clearer on the differences to a reader.

I'll queue this up and resubmit myself.

  Luis

> + **/
> +int
> +firmware_request_nowarn(const struct firmware **firmware, const char *name,
> +			struct device *device)
> +{
> +	int ret;
> +
> +	/* Need to pin this module until return */
> +	__module_get(THIS_MODULE);
> +	ret = _firmware_request(firmware, name, device, NULL, 0,
> +				FW_OPT_UEVENT | FW_OPT_NO_WARN);
> +	module_put(THIS_MODULE);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(firmware_request_nowarn);
> +
>  /**
>   * firmware_request_direct() - load firmware directly without usermode helper
>   * @firmware_p: pointer to firmware image
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index db8351a42405..a34e16f77f20 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -42,6 +42,8 @@ struct builtin_fw {
>  #if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
>  int firmware_request(const struct firmware **fw, const char *name,
>  		     struct device *device);
> +int firmware_request_nowarn(const struct firmware **fw, const char *name,
> +			    struct device *device);
>  int firmware_request_nowait(
>  	struct module *module, bool uevent,
>  	const char *name, struct device *device, gfp_t gfp, void *context,
> -- 
> 2.14.1
> 
> 

-- 
Do not panic
