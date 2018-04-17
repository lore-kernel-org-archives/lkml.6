Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx4+V5Bu0oxnin570QowpI2LG9yf33EcCgRIH1vcHD4+blV0GXrqtwtDkhW2g2syK2pOp6UcU
ARC-Seal: i=1; a=rsa-sha256; t=1523924260; cv=none;
        d=google.com; s=arc-20160816;
        b=dXdJKV8hk3vGEI9a9TGNgqj+zzvKZvgF6haxp0uWOfPa22l2FXeY6eBRxqO7JaOvW2
         kWNf9HywN0ONyV800+Mz0s0x1kjRrzN9zO7+PJf1B8An4MTUKM8DgqbM/ncgGxMI/Wqc
         v21JywH63/hQQc/x4cM3X+oOpHb1/VqK/U9Ee2Pg4OMIPBxSqzbkVl+kLfS2T84nS3j8
         lt0ZpzEpxD2Hb90O+Svkl02I8bcyOCnCsh3GOZtwXp1s1FeGRKDgZ/z2H5eIUE1vElrt
         xq3n2uQ77tTqOorTZ+Rc4BsJQmXrqTN+JTtVXp+Gpu48yID7mu3p4Zju3j0KWPlbjm3f
         u3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=7LHHHQ88PuAsD0iABn7paAFpY/NlUR1xaRy53vRDBD8=;
        b=XRU2+PrZLBZwtP5nMbsSvNFCiybYmm39EoSbSKtzxvMREFqBhv9a0ZUTl4CtDsKkKw
         eM9FsOQ3EfYKTNMZJQu140YwkRgSTzO+TXlfibfFYSz7qDOe/mW1xSB/R7/nNOw5OYQi
         5NXetWDwcdzuqjAZvIsK4djtbCziH5FaZila3w9r/gMXXrTHecvGEVWd+TzG/VTDg75D
         UKlHsR5MuRE9L3+tD/L+y9qWZqlEzDu2Uwv8vrjC5A8tTTMnc5prH229unmU3waF6NQU
         2/esYUqUrZxOx+EHgMJNZu8eX74t+YqSd3qEMYuEQtAQnAPSoiBUM65c9aG/3ZPPnXt8
         40cg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Tue, 17 Apr 2018 00:17:38 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
	Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Josh Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com,
	mfuzzey@parkeon.com, keescook@chromium.org,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>,
	x86@kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180417001738.GN30543@wotan.suse.de>
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408174014.21908-3-hdegoede@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199782052351527?=
X-GMAIL-MSGID: =?utf-8?q?1597950405556760051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 07:40:11PM +0200, Hans de Goede wrote:
>  static void firmware_free_data(const struct firmware *fw)
>  {
> @@ -576,6 +600,15 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  		goto out;
>  
>  	ret = fw_get_filesystem_firmware(device, fw->priv);
> +#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
> +	if (ret && device &&
> +	    device_property_read_bool(device, "efi-embedded-firmware")) {
> +		ret = fw_get_efi_embedded_fw(device, fw->priv, ret);
> +		if (ret == 0)
> +			ret = assign_fw(fw, device, opt_flags | FW_OPT_NOCACHE);
> +		goto out;
> +	}
> +#endif

You mussed what I asked for in terms of adding a new flag, (please work on top
of Andre's patches as those likely will be merged first, and also have kdocs
for the flags) and then a new firmware API to wrap the above into a function
which would only do something if the driver *asked* for it on their firmware
API call.  Ie, please add a new firmware_request_efi_fw(). Also if you see the
work I've done to remove the ifdefs over fallback mechanism you'll see it helps
split code and make it easier to read. We should strive to not add any more
ifdefery and instead make tehis code read easily.

  Luis
