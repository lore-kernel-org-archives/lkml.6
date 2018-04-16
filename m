Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx4/r6OpDMB47rZIY3AP3i8pCRUURyG0u9NPImiziQ1ABHRGfSvJBxpaOdWd4KJlQICHMUfRp
ARC-Seal: i=1; a=rsa-sha256; t=1523919155; cv=none;
        d=google.com; s=arc-20160816;
        b=tWDD3MbynTkKCoeImw43Pl1O9liMlEdAIcQznVMHjtrGUOqL62cGJn4u0B80kSLPjN
         HZZb8qkXHqmo1HjMy5oczlFnR1MJSuHNORk7Z2KePALfe5KOuh0ZHVOhIgYSLce5Q/HI
         LUmuTdwgLXe10rPp7E75RHvT3M+RGGhoXN6a51Wgqg5DsJYCUyGcfn1K6mxYOlIr5NGK
         f95jop5tn2Nish8M2K2bmB7hrr1a5+hDVmHQ98b8i3K76wlobsvK964IEevBhogX39u/
         qaCSuEBfKeCWmZox8MvpQxFc5lC54TWZMOKGxC3xhabcKpf3iUxiwzKfErUbXIDIXDYb
         5FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=nmDkQXElOfQiiu3s2wXaBMlnqp8s86RoylJaIU9921o=;
        b=K9Lwcz3nCHp2uBKhSO3h2qLE7BTYs9o4EdWS/5GGiZaLiNomJWJxNR8E3DzWo3uRuF
         Bb0Vcb6UgtIvVhG0Cm2M5Q5/yY13F/uxn9CA7AP3YU0DauhigUgcLc9yCIc4bTIEwM3F
         FFnMwsT/gX3i69nz1pp019zqrSWG52LamxIymh+G69P7xxfgVcubs/MHFBN2ZHGhjqtt
         Y9tJtzvY+NYAsJgyLCn/MgwhLygFcA+dCE/wmPHZrA/TByP29qlaagVh4bOpl0TGzwcC
         uSobdh7aQbFzeRvCzmLabwdofEr9m+vPCa/I/W9mIizyuNC5IPcmpb3fQtd6RD+mab91
         mUBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=gpsp891x;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=gpsp891x;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 4/8] firmware: add functions to load firmware without
 warnings v3
To: Andres Rodriguez <andresx7@gmail.com>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mcgrof@kernel.org, alexdeucher@gmail.com,
 ckoenig.leichtzumerken@gmail.com, kvalo@codeaurora.org,
 arend.vanspriel@broadcom.com
References: <20180416222427.29683-1-andresx7@gmail.com>
 <20180416222427.29683-5-andresx7@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <615140ec-4a2a-f181-f3b8-8c097a3be296@infradead.org>
Date: Mon, 16 Apr 2018 15:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416222427.29683-5-andresx7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943305003671369?=
X-GMAIL-MSGID: =?utf-8?q?1597945052138628601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/16/18 15:24, Andres Rodriguez wrote:
> Currently the firmware loader only exposes one silent path for querying
> optional firmware, and that is firmware_request_direct(). This function
> also disables the fallback path, which might not always be the
> desired behaviour. [0]
> 
> This patch introduces variations of firmware_request() and
> firmware_request_nowait() that enable the caller to disable the
> undesired warning messages. This is equivalent to adding FW_OPT_NO_WARN,
> to the old behaviour.
> 
> v2: add header prototype, use updated opt_flags
> v3: split debug message to separate patch
>     added _nowait variant
>     added documentation
> 
> [0]: https://git.kernel.org/linus/c0cc00f250e1
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>  .../driver-api/firmware/request_firmware.rst       | 13 ++++--
>  drivers/base/firmware_loader/main.c                | 52 ++++++++++++++++++++--
>  include/linux/firmware.h                           |  6 +++
>  3 files changed, 63 insertions(+), 8 deletions(-)

> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 5baadad3012d..14ded1de84bf 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -631,6 +631,30 @@ firmware_request(const struct firmware **firmware_p, const char *name,
>  }
>  EXPORT_SYMBOL(firmware_request);
>  

Please see/use Documentation/doc-guide/kernel-doc.rst:
  /**
   * function_name() - Brief description of function.
   * @arg1: Describe the first argument.
   * @arg2: Describe the second argument.
   *        One can provide multiple line descriptions
   *        for arguments.
...

> +/**
> + * firmware_request_nowarn: - request for an optional fw module

no ':' above.

> + * @firmware: pointer to firmware image
> + * @name: name of firmware file
> + * @device: device for which firmware is being loaded
> + *
> + * This function is similar in behaviour to firmware_request(), except
> + * it doesn't produce warning messages when the file is not found.
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
>   * firmware_request_direct: - load firmware directly without usermode helper

No ':' above.

>   * @firmware_p: pointer to firmware image
> @@ -755,10 +779,11 @@ static void firmware_request_work_func(struct work_struct *work)
>  }
>  
>  /**
> - * firmware_request_nowait - asynchronous version of firmware_request
> + * firmware_request_nowait2 - asynchronous version of firmware_request
>   * @module: module requesting the firmware
>   * @uevent: sends uevent to copy the firmware image if this flag
>   *	is non-zero else the firmware copy must be done manually.
> + * @warn: enable warnings
>   * @name: name of firmware file
>   * @device: device for which firmware is being loaded
>   * @gfp: allocation flags
> @@ -778,8 +803,8 @@ static void firmware_request_work_func(struct work_struct *work)
>   *		- can't sleep at all if @gfp is GFP_ATOMIC.
>   **/
>  int
> -firmware_request_nowait(
> -	struct module *module, bool uevent,
> +firmware_request_nowait2(
> +	struct module *module, bool uevent, bool warn,
>  	const char *name, struct device *device, gfp_t gfp, void *context,
>  	void (*cont)(const struct firmware *fw, void *context))
>  {
> @@ -799,7 +824,8 @@ firmware_request_nowait(
>  	fw_work->context = context;
>  	fw_work->cont = cont;
>  	fw_work->opt_flags = FW_OPT_NOWAIT |
> -		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
> +		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER) |
> +		(warn ? 0 : FW_OPT_NO_WARN);
>  
>  	if (!uevent && fw_cache_is_setup(device, name)) {
>  		kfree_const(fw_work->name);
> @@ -818,6 +844,24 @@ firmware_request_nowait(
>  	schedule_work(&fw_work->work);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(firmware_request_nowait2);
> +
> +/**
> + * firmware_request_nowait - compatibility version of firmware_request_nowait2
> + *
> + * This is equivalent to calling firmware_request_nowait2 with warnings enabled.
> + *
> + * Refer to firmware_request_nowait2 for further details.
> + **/
> +int
> +firmware_request_nowait(
> +	struct module *module, bool uevent,
> +	const char *name, struct device *device, gfp_t gfp, void *context,
> +	void (*cont)(const struct firmware *fw, void *context))
> +{
> +	return firmware_request_nowait2(module, uevent, true, name, device,
> +					gfp, context, cont);
> +}
>  EXPORT_SYMBOL(firmware_request_nowait);
>  
>  #ifdef CONFIG_PM_SLEEP


-- 
~Randy
