Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx48rJuZl8TRR6YpxoN9YcQzCe7WGqrc1rpQrmXo7nk9FRXju12tra4cNEXD3R41T7NhQTKxU
ARC-Seal: i=1; a=rsa-sha256; t=1524321128; cv=none;
        d=google.com; s=arc-20160816;
        b=vLTMU7r03GBDgQ2kR+SxLB+vuyJgxNNkgGgT+G+nWXX8RCOV7l7QTk0RaVa03vXiOu
         qPtIwz7BmphXH1iTrZ0ZAbALaf5BFA94xPCTwzT33i8ReeMVMugNmS5ORsTsWr55NndF
         bdX9cTEPzS5b7fBF0hPNKXEyaav/udYCSKDbz6BL0tGNn3lcEGHpAVscEbxtlMm7JTaD
         tRGlSEoBS5uifKaKcMbHR+8yFqpymK+G2BxO2dT7/kqJ3cOkJxe2jFgOeHJ166060qjU
         /Qo1WKawvaTYuxg7X66tq4OH4tRoFUa3l7B7NK5kBqjfDVHNt7pyKd4+L6yfJBmWcAE1
         I4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=JIt3BXUkCp6Fi6q0jv6ffa5Qt34iXOUwqPjcBG4hnMo=;
        b=TUANiahtw0RNt8HK5/jvkavUJ49+01ZprOFbglvXiugO/XKwK2sE7VYLQ5UFNcGsB/
         D1CKuImerFQ1JsqcUbKhPcTQ4E0ILsH67KdWfFgWO1DJ5twCbM8Phu/BPB2ZiAUmhDrK
         6ZpNutvVPXsDISOwgDyzA1T8SykHP9jpDVZoGgX54Nax6xtAvgEh7jWv11aczZjbKkqx
         yNRwKkyazpLAnmY6xTodqjmuaVeTIcMptEa9N/9Xj4U9cjD/KjzWffSKhgtDxIe6qBg8
         nD7kwS5GgYqQKk6j7U0PMnVAsyuhoMPmHfjmDkSPH2wfvZP3DG5vQRPzXX5BfjXcMVnq
         /6hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sat, 21 Apr 2018 16:32:06 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com, kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: Re: [PATCH 5/9] firmware: add functions to load firmware without
 warnings v4
Message-ID: <20180421143206.GQ14440@wotan.suse.de>
References: <20180417153307.3693-1-andresx7@gmail.com>
 <20180417153307.3693-6-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417153307.3693-6-andresx7@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008015463324966?=
X-GMAIL-MSGID: =?utf-8?q?1598366552404136774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 11:33:03AM -0400, Andres Rodriguez wrote:
> @@ -755,10 +779,11 @@ static void firmware_request_work_func(struct work_struct *work)
>  }
>  
>  /**
> - * firmware_request_nowait() - asynchronous version of firmware_request
> + * firmware_request_nowait2() - asynchronous version of firmware_request
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
> + * firmware_request_nowait() - compatibility version of firmware_request_nowait2
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

Ugh this is precisely the type of naming issue I predicted *years ago*
about the unflexibility of the naming scheme we used. Greg, since you had
sent us this rabbit hole, any name preference here? Please review what is
proposed and also suggest a scheme which you do prefer. I'm done with
the bikeshedding and just want to move on, but in a way that scales.

  Luis
