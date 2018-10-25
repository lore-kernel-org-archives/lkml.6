Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAEEECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C633E20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C633E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeJYJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:05:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59006 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeJYJFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:05:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6CA25207C3; Thu, 25 Oct 2018 02:34:56 +0200 (CEST)
Received: from localhost (unknown [2.223.63.88])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2C2C720729;
        Thu, 25 Oct 2018 02:34:56 +0200 (CEST)
Date:   Thu, 25 Oct 2018 02:34:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     a.zummo@towertech.it, broonie@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] rtc: sc27xx: Always read normal alarm when
 registering RTC device
Message-ID: <20181025003456.GB2737@piout.net>
References: <cover.1539851865.git.baolin.wang@linaro.org>
 <e3b4f8848cad42e5a2f4dfb34e342c69c8b95786.1539851865.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b4f8848cad42e5a2f4dfb34e342c69c8b95786.1539851865.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 18/10/2018 16:52:30+0800, Baolin Wang wrote:
> When registering one RTC device, it will check to see if there is an
> alarm already set in RTC hardware by reading RTC alarm, at this time
> we should always read the normal alarm put in always-on region by
> checking the rtc->registered flag.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/rtc/rtc-sc27xx.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
> index 72bb002..b4eb3b3 100644
> --- a/drivers/rtc/rtc-sc27xx.c
> +++ b/drivers/rtc/rtc-sc27xx.c
> @@ -415,10 +415,14 @@ static int sprd_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	u32 val;
>  
>  	/*
> -	 * If aie_timer is enabled, we should get the normal alarm time.
> +	 * Before RTC device is registered, it will check to see if there is an
> +	 * alarm already set in RTC hardware, and we always read the normal
> +	 * alarm at this time.
> +	 *
> +	 * Or if aie_timer is enabled, we should get the normal alarm time.
>  	 * Otherwise we should get auxiliary alarm time.
>  	 */
> -	if (rtc->rtc && rtc->rtc->aie_timer.enabled == 0)
> +	if (rtc->rtc && rtc->rtc->registered && rtc->rtc->aie_timer.enabled == 0)

Note that the driver should not access rtc->registered and
rtc->aie_timer.enabled and this is a bit fragile.
But, on the other hand, I currently don't have anything better to
suggest. I was also planning to add an in-kernel API for multiple alarms
but I'm not sure it will actually help in your case.

Anyway, this is applied.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
