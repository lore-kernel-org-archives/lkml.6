Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B669C20880
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B669C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeH1Anf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:43:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52357 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbeH1Anf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:43:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CA34A2079D; Mon, 27 Aug 2018 22:55:18 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9E1A520719;
        Mon, 27 Aug 2018 22:55:18 +0200 (CEST)
Date:   Mon, 27 Aug 2018 22:55:17 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, johan@kernel.org,
        j-keerthy@ti.com
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-omap: Replace mdelay() with msleep() in
 omap_rtc_power_off()
Message-ID: <20180827205517.GD24549@piout.net>
References: <20180730135314.9336-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730135314.9336-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/07/2018 21:53:14+0800, Jia-Ju Bai wrote:
> omap_rtc_power_off() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/rtc/rtc-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 39086398833e..ef3d09525d0f 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -476,7 +476,7 @@ static void omap_rtc_power_off(void)
>  	 * power off the system. Add a 500 ms margin for external latencies
>  	 * (e.g. debounce circuits).
>  	 */
> -	mdelay(2500);
> +	msleep(2500);

I'm not sure about that one because this is a poweroff function so it
doesn't really make sense to sleep versus busy waiting (all the drivers
in power/reset use mdelay())


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
