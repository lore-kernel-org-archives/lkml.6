Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLwJoFBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72B9A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750955AbeFFEJg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 00:09:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44462 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeFFEJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 00:09:34 -0400
X-Google-Smtp-Source: ADUXVKK5GQGvpUVkr1CukYaNGUTsYlQVLVe+cMXgkzjXnUZyJVOguOkTR2Ci2UwvEYtQ0/9fvY6Fpw==
Date: Wed, 6 Jun 2018 09:39:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ilia Lin <ilialin@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: kryo: allow building as a loadable module
Message-ID: <20180606040929.tksvznlmb3ogtgur@vireshk-i7>
References: <20180605114453.1381941-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605114453.1381941-1-arnd@arndb.de>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-18, 13:44, Arnd Bergmann wrote:
> Building the kryo cpufreq driver while QCOM_SMEM is a loadable module
> results in a link error:
> 
> drivers/cpufreq/qcom-cpufreq-kryo.o: In function `qcom_cpufreq_kryo_probe':
> qcom-cpufreq-kryo.c:(.text+0xbc): undefined reference to `qcom_smem_get'
> 
> The problem is that Kconfig ignores interprets the dependency as met
> when the dependent symbol is a 'bool' one. By making it 'tristate',
> it will be forced to be a module here, which builds successfully.
> 
> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index c7ce928fbf1f..52f5f1a2040c 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -125,7 +125,7 @@ config ARM_OMAP2PLUS_CPUFREQ
>  	default ARCH_OMAP2PLUS
>  
>  config ARM_QCOM_CPUFREQ_KRYO
> -	bool "Qualcomm Kryo based CPUFreq"
> +	tristate "Qualcomm Kryo based CPUFreq"
>  	depends on ARM64
>  	depends on QCOM_QFPROM
>  	depends on QCOM_SMEM

Okay, so we really need this to be a module. But the driver can't really work as
a module right now if we do this: insmod, rmmod, insmod. Because it doesn't free
resources at rmmmod and will fail on second insmod.

Because what you are fixing is a critical build error, we better get it merged
right now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

But Ilia needs to cook another patch to add the module removal code for the
driver and mark your patch's commit id in the fixes tag.

-- 
viresh
