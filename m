Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5D5C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 11:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162C22081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 11:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162C22081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeKCUjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 16:39:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43119 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeKCUjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 16:39:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so3771005eds.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 04:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tcn453aKtJMMgOUsdjfmS9udrKLA238Cvi+vA+ASh70=;
        b=iBWiKwyUfoa5k8xc4/elqDNEFpdD4Cj5+tKUhepw0rFHWpxeZEgGgO5SyD44Pz2i1F
         5Y5mQrG8epIY2KXJ3vS9m18jjk3+O/Nn+vT5uSezrSXs1KS60qfuLlVn2TaA54J9Lr94
         lQchHNh8SB5mWRY1yfsSROQlpzZ3TZLbNMsmcXwhr9ExlNLqen3WqALA7wV0NM1xkhyq
         MNbyqwTe8jNiSp9yFYoN1sYCrgLkyqoVCLMYeAKiBmy4wHCuC3KLUJr8uxk6jExk3Wgp
         rVDT0toRXdLJ8sXeLlFlF123dDWqS+T8L/mgQeCRstakZKMXMRJtGV0/+zMLOrcebecC
         jfBg==
X-Gm-Message-State: AGRZ1gLnh5VG/nigrI3w5IW9OJOT0LKC6fHi+ZkgLmbzHQYywleDW3qO
        YJDgmcKdc4uXQAx842tc7/tG6g==
X-Google-Smtp-Source: AJdET5cK2c50SeLATBzqBos6l8Rb7HD/Z/80jRCmxoypK092NtRmXq8rVvpyBfnoP3ou+lcG8qqrwA==
X-Received: by 2002:a05:6402:1609:: with SMTP id f9mr418019edv.35.1541244525479;
        Sat, 03 Nov 2018 04:28:45 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x21-v6sm10426255eds.30.2018.11.03.04.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 04:28:44 -0700 (PDT)
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
To:     =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Daniel Drake <drake@endlessm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?UTF-8?Q?Jo=c3=a3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
References: <20181103065732.12134-1-jprvita@endlessm.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <566af8d6-638e-8c7b-71b4-a7a8d6e71cdb@redhat.com>
Date:   Sat, 3 Nov 2018 12:28:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181103065732.12134-1-jprvita@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-11-18 07:57, João Paulo Rechi Vita wrote:
> Commit 19fffc8450d4378580a8f019b195c4617083176f fixed reporting
> "Discharging" on some machines when AC was connected but the battery was
> not charging. But now on these machines the battery status is reported
> as "Not charging" even when the battery is fully charged.
> 
> This commit takes the battery capacity into consideration when checking
> if "Not charging" should be returned and "Full" is returned when the
> capacity is 100%.
> 
> Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>

acpi_battery_handle_discharging() only gets called if the ACPI_BATTERY_STATE_DISCHARGING
bit is set by the firmware in that case if we are not actually discharging
returning POWER_SUPPLY_STATUS_NOT_CHARGING is the only correct thing to do,
we should never return POWER_SUPPLY_STATUS_FULL when the
ACPI_BATTERY_STATE_DISCHARGING bit is set.

I was about to point you to the upower bug for upower not
handling POWER_SUPPLY_STATUS_NOT_CHARGING as well as it
could atm, but I see you've already found that and are working
on fixing that. That is great, thank you.

As for this kernel-side fix I do not believe that fixing thus in
the kernel is the right thing to do. We try to stay away from
heuristics using full_charge_capacity in the kernel since that
is not really reliable / deterministic.

Regards,

Hans




> ---
>   drivers/acpi/battery.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index cb97b6105f52..82e194290f01 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -217,8 +217,12 @@ static int acpi_battery_handle_discharging(struct acpi_battery *battery)
>   	 * was plugged in and the device thus did not start a new charge cycle.
>   	 */
>   	if ((battery_ac_is_broken || power_supply_is_system_supplied()) &&
> -	    battery->rate_now == 0)
> +	    battery->rate_now == 0) {
> +		if (battery->capacity_now && battery->full_charge_capacity &&
> +		    battery->capacity_now / battery->full_charge_capacity == 1)
> +			return POWER_SUPPLY_STATUS_FULL;
>   		return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	}
>   
>   	return POWER_SUPPLY_STATUS_DISCHARGING;
>   }
> 
