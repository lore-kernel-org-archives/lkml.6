Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42CDC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E5021741
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 00:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeL1AnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 19:43:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39739 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbeL1AnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 19:43:08 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 30B162073D; Fri, 28 Dec 2018 01:43:06 +0100 (CET)
Received: from localhost (sar95-h02-176-184-10-235.dsl.sta.abo.bbox.fr [176.184.10.235])
        by mail.bootlin.com (Postfix) with ESMTPSA id B2D14206F9;
        Fri, 28 Dec 2018 01:43:05 +0100 (CET)
Date:   Fri, 28 Dec 2018 01:43:05 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rv8803: Check return value of rv8803_write_reg
Message-ID: <20181228004305.GW2188@piout.net>
References: <20181227202856.27408-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227202856.27408-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2018 14:28:55-0600, Aditya Pakki wrote:
> In rv8803_handle_irq, rv8803_write_reg can return a failed return
> value when attempting to write to the bus. The fix checks the output
> and throws a dev_warn notifying of the failure.
> 

Is there any point in doing that as the error will self correct later
anyway?

I really doubt there is any user reading the logs on the systems with an
rv8803 and there is no user action needed anyway.

> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/rtc/rtc-rv8803.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
> index 450a0b831a2d..5a19d5ecbf57 100644
> --- a/drivers/rtc/rtc-rv8803.c
> +++ b/drivers/rtc/rtc-rv8803.c
> @@ -180,8 +180,13 @@ static irqreturn_t rv8803_handle_irq(int irq, void *dev_id)
>  
>  	if (events) {
>  		rtc_update_irq(rv8803->rtc, 1, events);
> -		rv8803_write_reg(client, RV8803_FLAG, flags);
> -		rv8803_write_reg(rv8803->client, RV8803_CTRL, rv8803->ctrl);
> +		if (rv8803_write_reg(client, RV8803_FLAG, flags))
> +			dev_warn(&client->dev, "Failed to write RV8803 reg.\n");
> +
> +		if (rv8803_write_reg(rv8803->client, RV8803_CTRL,
> +					rv8803->ctrl))
> +			dev_warn(&rv8803->client->dev,
> +				"Failed to write RV8803_CTRL reg.\n");
>  	}
>  
>  	mutex_unlock(&rv8803->flags_lock);
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
