Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520810302; cv=none;
        d=google.com; s=arc-20160816;
        b=qdmlti1gYaLt5rMmBlDqJPRkOLqlK2z+4ktSmvPYoZ0sCsHbplWDGbI6UKYBrLQoHh
         n2SrXEIuDUlJpNO2/AmrEdtpjHMGjldLRVz8bWpp8UzkYK22Qzze/Ow0VAEMhpw2u5Qq
         Z7Y0XWRhMxnAeGVh14ZucgykJJOjGLr3FUsBQZB82gvo9zKote0qkWJRUdxx5fl6aV02
         a/tWLWqIfA3+tmghmbIEjwY5yCIN49YK5O/m5V8vNHwMXfVx8AkJGbdjrvJc+4fLITgY
         9ma6S1YwCAG0jDLWDgL+YgutgZbT15lxRANvv9wtey6IKyGKovkbwywlmSS0prT1na7b
         mUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=AA0fGKndCD23g0aF1N6HA20DXD0xMoEKkPNcS/rceXg=;
        b=RBXAwBdR9MY+T0PziF/G1ZdmRt+UggU5bknkZYnrOoX5+PcvI2N/vEP+U8XUvLMgGQ
         gdw3fAqJsu/wZCQC2ZwEA84oXIXO1x/bLUMtgf4Hx7UASY4FWh80rNaukw6x1lfuvGaV
         BrQZQxvpEcnx6+KDN9xt2VC7GPphQrgvAGwMOEmLS0FsJFR8KIZV+R3F+hBzzJ2RiHmK
         a9aMWUCd5siPBlylbiB/zYMmU4grPHCpVUZ3R4JCbOOr79NPhhNP23xumvV0e7C10NgP
         03uDC5Je70PuqNrfhPWurvBJltr4UvQvk8Kfb8EF4j1/0hRDB1AsqPrNmt8K0AC/KDiV
         Ufjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=dGwnP8rh;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=dGwnP8rh;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELs0c2B/0BiVg8u/bGrgbY7EYLxgI9hqkZXo9dSwx1ohkzkZNz9MX22+ELb3Qwk6Ci3qDXzPHg==
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
To: Andres Rodriguez <andresx7@gmail.com>, linux-kernel@vger.kernel.org
References: <20180309221243.15489-2-andresx7@gmail.com>
 <20180309230925.3573-1-andresx7@gmail.com>
Cc: gregkh@linuxfoundation.org, mcgrof@kernel.org
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA5B93E.2060905@broadcom.com>
Date: Mon, 12 Mar 2018 00:18:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180309230925.3573-1-andresx7@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594685184150084891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/10/2018 12:09 AM, Andres Rodriguez wrote:
> Currently the firmware loader only exposes one silent path for querying
> optional firmware, and that is request_firmware_direct(). This function
> also disables the usermodehelper fallback which might not always be the
> desired behaviour.
>
> This patch introduces request_firmware_optional(), which will not
> produce error/warning messages if the firmware file is not found, but
> will still attempt to query the usermodehelper for the optional
> firmware. Effectively, FW_OPT_UEVENT | FW_OPT_FALLBACK | FW_OPT_NO_WARN.
>
> v2: add header prototype, use updated opt_flags
>
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>
> Sorry, I messed up the v1 patch and sent the wrong one from before I
> rebased.
>
>   drivers/base/firmware_class.c | 26 +++++++++++++++++++++++++-
>   include/linux/firmware.h      |  2 ++
>   2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
> index 7dd36ace6152..4e1eddea241b 100644
> --- a/drivers/base/firmware_class.c
> +++ b/drivers/base/firmware_class.c
> @@ -1181,7 +1181,7 @@ static int fw_sysfs_fallback(struct firmware *fw, const char *name,
>   	if (!fw_run_sysfs_fallback(opt_flags))
>   		return ret;
>
> -	dev_warn(device, "Falling back to user helper\n");
> +	dev_warn(device, "Falling back to user helper for %s\n", name);

Helpful, but not really related to this change.

>   	return fw_load_from_user_helper(fw, name, device, opt_flags);
>   }
>   #else /* CONFIG_FW_LOADER_USER_HELPER */
> @@ -1351,6 +1351,30 @@ request_firmware(const struct firmware **firmware_p, const char *name,
>   }
>   EXPORT_SYMBOL(request_firmware);
>
> +/**
> + * request_firmware_optional: - request for an optional fw module
> + * @firmware_p: pointer to firmware image
> + * @name: name of firmware file
> + * @device: device for which firmware is being loaded
> + *
> + * This function is similar in behaviour to request_firmware(), except
> + * it doesn't produce warning messages when the file is not found.
> + **/
> +int
> +request_firmware_optional(const struct firmware **firmware_p, const char *name,
> +			  struct device *device)

So it still returns an error code. If it were truly optional I kinda 
expected a void return type. This is more request_firmware_silent(). 
Anyway, I guess Luis would call this bike-shedding ;-)

Regards,
Arend
