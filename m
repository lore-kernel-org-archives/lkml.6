Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935748AbeBWTBR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:01:17 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37776 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932159AbeBWTBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:01:14 -0500
X-Google-Smtp-Source: AG47ELvl1aQ0O6l8vuqVWV0HddpxOZGpDA8F+UwNJzg09KDv0zKTeN4mrwJ1jvkZPtHxn6Ez5TuhdA==
Subject: Re: [PATCH] rtc: brcmstb-waketimer: Set wktmr prescaler
To: Justin Chen <justin.chen@broadcom.com>, linux-rtc@vger.kernel.org
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        computersforpeace@gmail.com, gregory.0xf0@gmail.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Justin Chen <justinpopo6@gmail.com>
References: <1519262155-15580-1-git-send-email-justin.chen@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e991b6b5-3f3d-f9da-2655-008921eee2a7@gmail.com>
Date: Fri, 23 Feb 2018 11:01:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519262155-15580-1-git-send-email-justin.chen@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 05:15 PM, Justin Chen wrote:
> The HW default is one tick per second, however instead of assuming this,
> lets make sure the waketimer is actually one tick per second before
> arming the alarm.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/rtc/rtc-brcmstb-waketimer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
> index 796ac79..46116b7 100644
> --- a/drivers/rtc/rtc-brcmstb-waketimer.c
> +++ b/drivers/rtc/rtc-brcmstb-waketimer.c
> @@ -60,6 +60,10 @@ static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
>  {
>  	brcmstb_waketmr_clear_alarm(timer);
>  
> +	/* Make sure we are actually counting in seconds */
> +	writel_relaxed(BRCMSTB_WKTMR_DEFAULT_FREQ,
> +			timer->base + BRCMSTB_WKTMR_PRESCALER);

The change is correct, however you would likely want to use timer->rate
which makes sure that we either got the clock rate information from the
LCCF, or we got the correct fixed rate frequency. With that fixed:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
