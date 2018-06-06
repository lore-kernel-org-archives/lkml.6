Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V5Vw9GLa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VbVuG37+"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0DE160263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbeFFEou (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 00:44:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56698 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbeFFEos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 00:44:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0307E60263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
Date: Wed, 06 Jun 2018 07:44:39 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20180606040929.tksvznlmb3ogtgur@vireshk-i7>
References: <20180605114453.1381941-1-arnd@arndb.de> <20180606040929.tksvznlmb3ogtgur@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cpufreq: kryo: allow building as a loadable module
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Ilia Lin <ilialin@codeaurora.org>
Message-ID: <85F1CCF0-F937-4EAA-9628-D8AA6C4EDE0E@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Viresh got ahead of my answer a bit=2E :)
Sure I'll post the module exit later=2E

On June 6, 2018 7:09:29 AM GMT+03:00, Viresh Kumar <viresh=2Ekumar@linaro=
=2Eorg> wrote:
>On 05-06-18, 13:44, Arnd Bergmann wrote:
>> Building the kryo cpufreq driver while QCOM_SMEM is a loadable module
>> results in a link error:
>>=20
>> drivers/cpufreq/qcom-cpufreq-kryo=2Eo: In function
>`qcom_cpufreq_kryo_probe':
>> qcom-cpufreq-kryo=2Ec:(=2Etext+0xbc): undefined reference to
>`qcom_smem_get'
>>=20
>> The problem is that Kconfig ignores interprets the dependency as met
>> when the dependent symbol is a 'bool' one=2E By making it 'tristate',
>> it will be forced to be a module here, which builds successfully=2E
>>=20
>> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>> ---
>>  drivers/cpufreq/Kconfig=2Earm | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/cpufreq/Kconfig=2Earm
>b/drivers/cpufreq/Kconfig=2Earm
>> index c7ce928fbf1f=2E=2E52f5f1a2040c 100644
>> --- a/drivers/cpufreq/Kconfig=2Earm
>> +++ b/drivers/cpufreq/Kconfig=2Earm
>> @@ -125,7 +125,7 @@ config ARM_OMAP2PLUS_CPUFREQ
>>  	default ARCH_OMAP2PLUS
>> =20
>>  config ARM_QCOM_CPUFREQ_KRYO
>> -	bool "Qualcomm Kryo based CPUFreq"
>> +	tristate "Qualcomm Kryo based CPUFreq"
>>  	depends on ARM64
>>  	depends on QCOM_QFPROM
>>  	depends on QCOM_SMEM
>
>Okay, so we really need this to be a module=2E But the driver can't
>really work as
>a module right now if we do this: insmod, rmmod, insmod=2E Because it
>doesn't free
>resources at rmmmod and will fail on second insmod=2E
>
>Because what you are fixing is a critical build error, we better get it
>merged
>right now=2E
>
>Acked-by: Viresh Kumar <viresh=2Ekumar@linaro=2Eorg>
>
>But Ilia needs to cook another patch to add the module removal code for
>the
>driver and mark your patch's commit id in the fixes tag=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
