Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522872524; cv=none;
        d=google.com; s=arc-20160816;
        b=OmvpxU0LZZJEAaj6URlmWVHAmdAcIPl/mhnN0iuDwVOYVCLxH3hBC+OmQMtlK5CUaj
         Rz7LwcZH1QBhHqVbPeyisSx7BhrKgkLXVgcD2L6ZTpOttHzLNmXxCcUJNWbewrSPiOP7
         Bi54qxiSyS/agxvuzG2eWfW9v4HQedUEXOriYjZHV7ILrm1EC7UIulTSGnRvQ3Y41a99
         N7fGNK3CWlJHaKzGJ46y7eta23NM4jAtPGLwwYSvX2ZBM/eDV1Bm3Aff8xMBguAAXeDR
         7nBGxfxdm2N+RiFdeOMhbMOR37tnf2fCkL/MhLhYjnC53lt7Kj3uUqWD/gBLXt5q4Ddq
         RlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=H7N2joOmZ85I8u/03K2lzp1lvlBwxLVjBV6WfyH5xAg=;
        b=bytwsSgQyhdeEctRmkEO4/iR0bKUVjVPUKl0cAsZQUH/r/ryQUvtQ1sT61XxdATSCd
         zVeFhW75NYXx/9mPZVQ/6gXk0ZW2VfnmJV5MrtAq3nRNKCllKWBrFznj7GxyKAogPD7D
         1QsOFD7gaujWbo+4OIje7gjlmZVkzw2HRJRXvf6T3wf1g7HHB6q9hNUtaAX1MWYkLDJx
         2O+oQcQjeMM1jTk4Tn3CmUqArEnO6/hHMgWZrGYvg/OX4EbrxijjnPyunTyLDf6qXnNW
         WKwK4EwLbLHF94UuhV0PWRsKM6DiL8w7MAfgbk1Ulo4xS6eFJK0M727E72pIrLhjUZ1K
         0veQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4+w6TS2MTNBXycQTIdNngFm1BZwWV91/wBrIU4Cu3JOqD19O8ZCTyavASBP8dn8zELQQXmd7w==
Subject: Re: [PATCH] usb: select USB_COMMON for usb role switch config
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180404122211.3309577-1-arnd@arndb.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <545bff65-cd68-1694-06e6-5e9d53ab12e9@redhat.com>
Date: Wed, 4 Apr 2018 22:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404122211.3309577-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596818231491207540?=
X-GMAIL-MSGID: =?utf-8?q?1596847581058464698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 04-04-18 14:21, Arnd Bergmann wrote:
> The new axp288 extcon driver has no dependency on USB itself but
> calls the usb role switch helper functions. This causes a link error
> when USB_COMMON is disabled, as that subdirectory never gets entered:
> 
> drivers/extcon/extcon-axp288.o: In function `axp288_usb_role_work':
> extcon-axp288.c:(.text+0x47b): undefined reference to `usb_role_switch_set_role'
> extcon-axp288.c:(.text+0x498): undefined reference to `usb_role_switch_get_role'
> drivers/extcon/extcon-axp288.o: In function `axp288_extcon_probe':
> extcon-axp288.c:(.text+0x675): undefined reference to `usb_role_switch_get'
> extcon-axp288.c:(.text+0x6d1): undefined reference to `usb_role_switch_put'
> drivers/extcon/extcon-axp288.o: In function `axp288_put_role_sw':
> extcon-axp288.c:(.text+0x1c): undefined reference to `usb_role_switch_put'
> 
> There are multiple ways of fixing this, I chose to 'select USB_COMMON',
> since that is how we solved the same problem for other helpers like
> USB_LED_TRIG or PHY drivers.
> 
> Fixes: d54f063cdbe4 ("extcon: axp288: Set USB role where necessary")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Thanks.

I agree that this is the right way to fix this (matches the other
drivers/usb/Kconfig bits):

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/usb/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 75f7fb151f71..987fc5ba6321 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -207,5 +207,6 @@ config USB_ULPI_BUS
>   
>   config USB_ROLE_SWITCH
>   	tristate
> +	select USB_COMMON
>   
>   endif # USB_SUPPORT
> 
