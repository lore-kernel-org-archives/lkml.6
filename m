Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCEFC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0430C2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0430C2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJBP4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:56:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55868 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeJBP4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:56:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8BA1320703; Tue,  2 Oct 2018 11:14:20 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2F42A20703;
        Tue,  2 Oct 2018 11:14:08 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: mv: let the core handle invalid alarms
References: <20181001220525.6735-1-alexandre.belloni@bootlin.com>
Date:   Tue, 02 Oct 2018 11:14:09 +0200
In-Reply-To: <20181001220525.6735-1-alexandre.belloni@bootlin.com> (Alexandre
        Belloni's message of "Tue, 2 Oct 2018 00:05:25 +0200")
Message-ID: <87efd8ogm6.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,
 
 On mar., oct. 02 2018, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Instead of lying to the core when the alarm is invalid, let it handle that
> by returning the error.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>  (on Armada 375 DB)

Gregory

> ---
>  drivers/rtc/rtc-mv.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
> index 4b198b3778d3..e7f14bd12fe3 100644
> --- a/drivers/rtc/rtc-mv.c
> +++ b/drivers/rtc/rtc-mv.c
> @@ -125,13 +125,9 @@ static int mv_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
>  	/* hw counts from year 2000, but tm_year is relative to 1900 */
>  	alm->time.tm_year = bcd2bin(year) + 100;
>  
> -	if (rtc_valid_tm(&alm->time) < 0) {
> -		dev_err(dev, "retrieved alarm date/time is not valid.\n");
> -		rtc_time_to_tm(0, &alm->time);
> -	}
> -
>  	alm->enabled = !!readl(ioaddr + RTC_ALARM_INTERRUPT_MASK_REG_OFFS);
> -	return 0;
> +
> +	return rtc_valid_tm(&alm->time);
>  }
>  
>  static int mv_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> -- 
> 2.19.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
