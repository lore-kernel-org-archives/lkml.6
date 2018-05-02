Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AB8JxZo3F+cnLTwmU0YooaKJgFC0aXnFf8EUDYtX3PbUxjTToayYBJOeBSwtCpskDydiqxAdU2YH
ARC-Seal: i=1; a=rsa-sha256; t=1525261239; cv=none;
        d=google.com; s=arc-20160816;
        b=h0uq5XzmT5um4NDdBzagSaBeCyZYiaA9M2PG47N7s6HqWh3ZktOvIcTWSHFueJtnx3
         byxs/GEEbmdlrKyfcXpWpRLlLoUtGsxEisOa4sQC8ZMddnkcU9saRA7QKUxw+O5daCC9
         kgPVTqE7xOL7d/db8KziL+I7ly52sNUXHdH5YdmfxzTr8rhfY0cAOZ0DNb0QYufxd5fR
         Rwvh4aqRl0X6ZrguezBCLbTVFfPo9y8DjF8GfFA9NCOFvu8JXCYusvqStW73kb3Z7BqL
         //CeqmtLx0OHvtzQncEvXBYh6kdRCpaftmlZsCF7IhoNncysijWeW2cZ1tF7xi2sfJir
         fRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=E8d3XDJ5HYRdjmSPKHhI6/CkSeUVpXFFH1EVUj4Aj7I=;
        b=FKH97yTQXItPJG1ZgjySuiYsdubuOaG1lpFZtbXJ4nXwFKQpvJZ4qakrlftpv1rFid
         hLbAJktM8UfFic2jBS8vg7O9xYPCZnGOMQCOps3DiFjBzZJ+2K5AN+lrCNj/lezuhHF1
         CNHPItm/dDvmLwnK5q0YM7r/tur/oa2lSx7QEG4RVvm6479WKdAZ1eyG7eQV7MSy1D8z
         /55egvc2ak4J0VG7ysIpacPH03r9GOM1eysWvXxrZqbaLzMdpp94iDrmPgC89Tk0c3lX
         F1CV3SbX7I1IBQe6z8vdPL8/PAOPlQnrq73EptB1JdiPxnYwYDdHmy2fAnj2KspvwyfF
         N3Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: boot-architecture@lists.linaro.org, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Alexander Graf <agraf@suse.de>,
 Grant Likely <grant.likely@arm.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20180501213114.20183-1-robh@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
Date: Wed, 2 May 2018 12:40:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501213114.20183-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1599352329640326555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/05/18 22:31, Rob Herring wrote:
> Deferred probe will currently wait forever on dependent devices to probe,
> but sometimes a driver will never exist. It's also not always critical for
> a driver to exist. Platforms can rely on default configuration from the
> bootloader or reset defaults for things such as pinctrl and power domains.
> This is often the case with initial platform support until various drivers
> get enabled. There's at least 2 scenarios where deferred probe can render
> a platform broken. Both involve using a DT which has more devices and
> dependencies than the kernel supports. The 1st case is a driver may be
> disabled in the kernel config. The 2nd case is the kernel version may
> simply not have the dependent driver. This can happen if using a newer DT
> (provided by firmware perhaps) with a stable kernel version.
> 
> Unfortunately, this change breaks with modules as we have no way of
> knowing when modules are done loading. One possibility is to make this
> opt in or out based on compatible strings rather than at a subsystem level.
> Ideally this information could be extracted automatically somehow. OTOH,
> maybe the lists are pretty small. There's only a handful of subsystems
> that can be optional, and then only so many drivers in those that can be
> modules (at least for pinctrl, many drivers are built-in only).

Ooh, this is exactly what I wanted for of_iommu_xlate(), and would be 
much nicer than the current bodge using system_state that I ended up 
with. The context there is very similar - if the device has a parent 
IOMMU then we want to wait for that to probe first if possible, but with 
a deadline such that if it doesn't show up then we can go ahead and make 
progress without it (on the assumption that DMA ops can fall back to 
CMA). The modules problem doesn't currently apply to IOMMU drivers 
either, although we do use a special of_device_id table for detecting 
built-in drivers via OF_IOMMU_DECLARE() to avoid deferring at all when 
we know it would be pointless - a more generic solution for that could 
certainly be useful too.

I agree with Greg that the naming here is a bit tricky - FWIW my initial 
thought would be something like driver_defer_until_init(), which is 
still clunky but at least imperative.

Robin.

> Cc: Alexander Graf <agraf@suse.de>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This patch came out of a discussion on the ARM boot-architecture
> list[1] about DT forwards and backwards compatibility issues. There are
> issues with newer DTs breaking on older, stable kernels. Some of these
> are difficult to solve, but cases of optional devices not having
> kernel support should be solvable.
> 
> I tested this on a RPi3 B with the pinctrl driver forced off. With this
> change, the MMC/SD and UART drivers can function without the pinctrl
> driver.
> 
> Rob
> 
> [1] https://lists.linaro.org/pipermail/boot-architecture/2018-April/000466.html
> 
>   drivers/base/dd.c            | 16 ++++++++++++++++
>   drivers/pinctrl/devicetree.c |  2 +-
>   include/linux/device.h       |  2 ++
>   3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index c9f54089429b..5848808b9d7a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -226,6 +226,15 @@ void device_unblock_probing(void)
>   	driver_deferred_probe_trigger();
>   }
>   
> +
> +int driver_deferred_probe_optional(void)
> +{
> +	if (initcalls_done)
> +		return -ENODEV;
> +
> +	return -EPROBE_DEFER;
> +}
> +
>   /**
>    * deferred_probe_initcall() - Enable probing of deferred devices
>    *
> @@ -240,6 +249,13 @@ static int deferred_probe_initcall(void)
>   	/* Sort as many dependencies as possible before exiting initcalls */
>   	flush_work(&deferred_probe_work);
>   	initcalls_done = true;
> +
> +	/*
> +	 * Trigger deferred probe again, this time we won't defer anything
> +	 * that is optional
> +	 */
> +	driver_deferred_probe_trigger();
> +	flush_work(&deferred_probe_work);
>   	return 0;
>   }
>   late_initcall(deferred_probe_initcall);
> diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> index b601039d6c69..096e52a5c506 100644
> --- a/drivers/pinctrl/devicetree.c
> +++ b/drivers/pinctrl/devicetree.c
> @@ -120,7 +120,7 @@ static int dt_to_map_one_config(struct pinctrl *p,
>   				np_config);
>   			of_node_put(np_pctldev);
>   			/* OK let's just assume this will appear later then */
> -			return -EPROBE_DEFER;
> +			return driver_deferred_probe_optional();
>   		}
>   		/* If we're creating a hog we can use the passed pctldev */
>   		if (pctldev && (np_pctldev == p->dev->of_node))
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0059b99e1f25..8de920442bc1 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -332,6 +332,8 @@ struct device *driver_find_device(struct device_driver *drv,
>   				  struct device *start, void *data,
>   				  int (*match)(struct device *dev, void *data));
>   
> +int driver_deferred_probe_optional(void);
> +
>   /**
>    * struct subsys_interface - interfaces to device functions
>    * @name:       name of the device function
> 
