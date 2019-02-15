Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99ECF21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfBOWIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:08:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43845 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730633AbfBOWIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:08:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so5155530ede.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 14:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JkJ5c7mEn+iPhR16PmrIs/HY6O39i9DClrtVwcRSpbY=;
        b=ekPjdje/1eIBWp4nw9ajqmfadZVnuh9I4KBCT3kKkLnIAvQ+Vv7Oq3wiGmcT+zdIEd
         4+Yia5ZOLFtPcJum/85nfSopHSgE8/giFObTsnJbYm1E19t/Png2FQcIjpVIWvVIgO9J
         9OIBN0YbKbMO7afrp8MC9fr3nBwjOm0qk5kN/j06ikrEu3+hRM1Gnyo1TfJ7qP2xrmTq
         aEg/mKHnH0+HwXk5Zg77H7IIoAiAclgufOaHhWf7bvnCWs1WhzipcQVkFaD4o8TSARwA
         7wdxokk7C1MsvF6f3+PL50tLpVzlt19KJrj5MOK5ZAV8lWJ2Tis31n/4+QM7jJPlXeeu
         owNg==
X-Gm-Message-State: AHQUAuYraTQJbQZpq9wW4NvBZbKO6uUFMJK/YkSE0xwy+Z4Mt4X6F0zE
        locBUrQws3oJDPMFvKeN7PG4n5fxpP0=
X-Google-Smtp-Source: AHgI3IaPDUlIVdeCzRtXPWZ1vAvMqxkZpdOBTsRnal18H8q0vDreL07gr5w8Hqgg1AO2Eyn8WDsn/Q==
X-Received: by 2002:a50:9e87:: with SMTP id a7mr5049279edf.79.1550268501033;
        Fri, 15 Feb 2019 14:08:21 -0800 (PST)
Received: from localhost.localdomain ([2001:678:814:68:8573:4f61:f765:5d7e])
        by smtp.gmail.com with ESMTPSA id l9sm1439144ejh.74.2019.02.15.14.08.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:08:20 -0800 (PST)
Subject: Re: [PATCH] max17042_battery: fix potential use-after-free on device
 remove
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190215220344.16604-1-TheSven73@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3e771d70-4e51-114c-6e00-460b34dd0909@redhat.com>
Date:   Fri, 15 Feb 2019 23:08:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215220344.16604-1-TheSven73@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/15/19 11:03 PM, Sven Van Asbroeck wrote:
> The work which is scheduled on a POR boot is potentially left
> pending or running until after the device module is removed,
> which could result in a use-after-free.
> 
> Fix by registering a cancel/sync callback, which gets executed as
> part of standard resource unwinding.
> 
> This issue was detected with the help of Coccinelle.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/power/supply/max17042_battery.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 2a8d75e5e930..581c6bd23388 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -995,6 +995,13 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
>   	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
>   };
>   
> +static void max17042_stop_work(void *data)
> +{
> +	struct max17042_chip *chip = data;
> +
> +	cancel_work_sync(&chip->work);
> +}
> +
>   static int max17042_probe(struct i2c_client *client,
>   			const struct i2c_device_id *id)
>   {
> @@ -1101,6 +1108,9 @@ static int max17042_probe(struct i2c_client *client,
>   	regmap_read(chip->regmap, MAX17042_STATUS, &val);
>   	if (val & STATUS_POR_BIT) {
>   		INIT_WORK(&chip->work, max17042_init_worker);
> +		ret = devm_add_action(&client->dev, max17042_stop_work, chip);
> +		if (ret)
> +			return ret;
>   		schedule_work(&chip->work);
>   	} else {
>   		chip->init_complete = 1;
> 
