Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B73C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649812177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfAKKFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:05:44 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45811 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbfAKKFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:05:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2592B207B6; Fri, 11 Jan 2019 11:05:42 +0100 (CET)
Received: from localhost (alyon-652-1-22-18.w109-213.abo.wanadoo.fr [109.213.145.18])
        by mail.bootlin.com (Postfix) with ESMTPSA id E0F6020734;
        Fri, 11 Jan 2019 11:05:41 +0100 (CET)
Date:   Fri, 11 Jan 2019 11:05:42 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Oliver.Rohe@wago.com
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rs5c372: r2221: fix to use the correct XSTP bit
Message-ID: <20190111100542.GA2547@piout.net>
References: <1547031572-7097-1-git-send-email-oliver.rohe@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547031572-7097-1-git-send-email-oliver.rohe@wago.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 09/01/2019 10:59:40+0000, Oliver.Rohe@wago.com wrote:
> The Ricoh chips have slightly different register layouts
> and the r2221 chip uses bit 5 as the oscillator halt sensor bit.
> 
> Signed-off-by: Olive Rohe <oliver.rohe@wago.com>
> ---
>  drivers/rtc/rtc-rs5c372.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
> index c503832..ff35dce 100644
> --- a/drivers/rtc/rtc-rs5c372.c
> +++ b/drivers/rtc/rtc-rs5c372.c
> @@ -52,8 +52,8 @@
>  #	define RS5C_CTRL1_CT4		(4 << 0)	/* 1 Hz level irq */
>  #define RS5C_REG_CTRL2		15
>  #	define RS5C372_CTRL2_24		(1 << 5)
> -#	define R2025_CTRL2_XST		(1 << 5)
> -#	define RS5C_CTRL2_XSTP		(1 << 4)	/* only if !R2025S/D */
> +#	define R2x2x_CTRL2_XSTP		(1 << 5)	/* only if R2x2x */

I wouldn't rename that define as later on, it may be used for RTCs that
doesn't match R2x2x (as is the case for RV5C387_CTRL1_24 for example).
the bit doesn't even have the same meaning on R2025 and R2221.

> +#	define RS5C_CTRL2_XSTP		(1 << 4)	/* only if !R2x2x */
>  #	define RS5C_CTRL2_CTFG		(1 << 2)
>  #	define RS5C_CTRL2_AAFG		(1 << 1)	/* or WAFG */
>  #	define RS5C_CTRL2_BAFG		(1 << 0)	/* or DAFG */
> @@ -519,20 +519,30 @@ static int rs5c_oscillator_setup(struct rs5c372 *rs5c372)
>  	unsigned char buf[2];
>  	int addr, i, ret = 0;
>  
> -	if (rs5c372->type == rtc_r2025sd) {
> -		if (rs5c372->regs[RS5C_REG_CTRL2] & R2025_CTRL2_XST)
> +	addr   = RS5C_ADDR(RS5C_REG_CTRL1);
> +	buf[0] = rs5c372->regs[RS5C_REG_CTRL1];
> +	buf[1] = rs5c372->regs[RS5C_REG_CTRL2];
> +
> +	/* handle xstp bit */
> +	switch (rs5c372->type) {
> +	case rtc_r2025sd:
> +		if (buf[1] & R2x2x_CTRL2_XSTP)
>  			return ret;
> -		rs5c372->regs[RS5C_REG_CTRL2] |= R2025_CTRL2_XST;
> -	} else {
> -		if (!(rs5c372->regs[RS5C_REG_CTRL2] & RS5C_CTRL2_XSTP))
> +		rs5c372->regs[RS5C_REG_CTRL2] |= R2x2x_CTRL2_XSTP;
> +		break;
> +	case rtc_r2221tl:
> +		if (!(buf[1] & R2x2x_CTRL2_XSTP))
> +			return ret;
> +		rs5c372->regs[RS5C_REG_CTRL2] &= ~R2x2x_CTRL2_XSTP;
> +		break;
> +
> +	default:
> +		if (!(buf[1] & RS5C_CTRL2_XSTP))
>  			return ret;
>  		rs5c372->regs[RS5C_REG_CTRL2] &= ~RS5C_CTRL2_XSTP;
> +		break;
>  	}
>  

Note that this is actually quite bad to restart the oscillator on probe.
The best would be to do that only in rs5c372_rtc_set_time once you know
the set time is good. then you can return -EINVAL from
rs5c372_rtc_read_time when you know the oscillator is stopped so
userspace know the RTC time is bad. This could be done as a follw up
patch.

There is also more work needed to clean up that driver if you have time
and are willing to.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
