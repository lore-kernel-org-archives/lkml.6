Return-Path: <bjorn.andersson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525717784; cv=none;
        d=google.com; s=arc-20160816;
        b=ESN/9CiYUuqD5yzqTkzGA3/dhMep7jhbnztSH5txaNnotLx+Aiood8XOhBWdh8X+Zf
         lPX9jLCxycYljRhKghLRlZonMVs/dfY2hq4TlIAxRCEIb73RUEujSfJj0BlQwAgg7Gm1
         FtyLPHhbGt6Zr+ISQy84fOnLtITx7zCVcxP8X6yGzzjpTelTX0AJh9tl5IMjZnKeuRyV
         lOWk+SmzKX433BP9MEwVqg9UkT2cic1B8TGmLQakI8ufAbkh0250j5jmIJwV7pMayicv
         Be3WlQT/vvRctJy/e9ty/KXyWLbkPTy3+EgZztZu3Ou3S1zRDExLjEAAZ/VExEFtyazk
         ctGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=yq8Ioa23SZN0SBj5CSGWfS1hw39l85DU/HQlRo0UJGo=;
        b=m7jfx/2NoEZv02Y5CoecudxvmORciDKXU5+YouNSU5OoXZFR2+7m6TjpFzulAw8kp+
         WCZPf++z9HgkcoFlmoCpK3U003hQZ4A0S7r40Yg4WOPfg/23X45Gcv4kMONy5wRZYZxQ
         HDxH0FQDy/fiH1Dum+7ATr58Xl49anMyD4CDoc6kDZbfLbdOWZi4DwuGbsLpCC+EY7CC
         66qIEbpj+TNwADAzQZjnxYPejkOHq7H+dM/gEOIRMsZSG4fdnyIt2KJa63BSLXv7Qafs
         Ef0/IA6QSan7YeRAhWjYfif4v0NTJ0aNlfYT84Pq/INHEbK06UmpbqUnDs0Ms+NnvH+L
         1X7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ngbi2Pst;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ngbi2Pst;
       spf=pass (google.com: domain of bjorn.andersson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bjorn.andersson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrf1nNPVe0v6kVRFHVvEGyoA6b8rEVAdq/QT1b7tQMN8CN2eAUBY+4HnNtrvwImjkwLU3EeKA==
Date: Mon, 7 May 2018 11:31:06 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Grant Likely <grant.likely@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	boot-architecture@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
Message-ID: <20180507183106.GF2259@tuxbook-pro>
References: <20180501213114.20183-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501213114.20183-1-robh@kernel.org>
X-TUID: ElwpAdRVJzeN
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599831051328337813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 01 May 14:31 PDT 2018, Rob Herring wrote:

> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.

But how do you know if this is the case?

> This is often the case with initial platform support until various drivers
> get enabled.

Can you please name platform that has enough support for Alexander to
care about backwards and forwards compatibility but lacks a pinctrl
driver.

> There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config.

I agree that there is a chance that you _might_ get some parts of the
system working by relying on the boot loader configuration, but
misconfiguration issues applies to any other fundamental providers, such
as clocks, regulators, power domains and gpios as well.

> The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version.
> 

As above, this is in no way limited to pinctrl drivers.

> Unfortunately, this change breaks with modules as we have no way of
> knowing when modules are done loading. One possibility is to make this
> opt in or out based on compatible strings rather than at a subsystem level.
> Ideally this information could be extracted automatically somehow. OTOH,
> maybe the lists are pretty small. There's only a handful of subsystems
> that can be optional, and then only so many drivers in those that can be
> modules (at least for pinctrl, many drivers are built-in only).
> 

On the Qualcomm platform most drivers are tristate and on most platforms
there are size restrictions in the proprietary boot loader preventing us
from boot the kernel after switching all these frameworks from tristate
to bool (which feels like a more appropriate solution than your hack).

> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This patch came out of a discussion on the ARM boot-architecture 
> list[1] about DT forwards and backwards compatibility issues. There are 
> issues with newer DTs breaking on older, stable kernels. Some of these 
> are difficult to solve, but cases of optional devices not having 
> kernel support should be solvable.
> 

There are two cases here:
1) DT contains compatibles that isn't supported by the kernel. In this
case the associated device will remain in the probe deferral list and
user space won't know about the device.

2) DT contains compatibles known to the kernel but has new optional
properties that makes things functional or works around hardware bugs.

> I tested this on a RPi3 B with the pinctrl driver forced off. With this 
> change, the MMC/SD and UART drivers can function without the pinctrl 
> driver.
> 

Cool, so what about graphics, audio, networking, usb and all the other
things that people actually expect when they _use_ a distro?

> Rob
> 
> [1] https://lists.linaro.org/pipermail/boot-architecture/2018-April/000466.html
> 
>  drivers/base/dd.c            | 16 ++++++++++++++++
>  drivers/pinctrl/devicetree.c |  2 +-
>  include/linux/device.h       |  2 ++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index c9f54089429b..5848808b9d7a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -226,6 +226,15 @@ void device_unblock_probing(void)
>  	driver_deferred_probe_trigger();
>  }
>  
> +
> +int driver_deferred_probe_optional(void)
> +{
> +	if (initcalls_done)
> +		return -ENODEV;

You forgot the humongous printout here that tells the users that we do
not want any bug reports related hardware not working as expected after
this point.

> +
> +	return -EPROBE_DEFER;
> +}
> +

I do not agree with the partial benefits of this at the cost of not
supporting kernel modules.

Regards,
Bjorn
