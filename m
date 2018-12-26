Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6E5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D706217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 08:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLZIc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 03:32:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44986 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbeLZIc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 03:32:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 59FB2209ED; Wed, 26 Dec 2018 09:32:25 +0100 (CET)
Received: from localhost (uni14-h01-176-184-39-184.dsl.sta.abo.bbox.fr [176.184.39.184])
        by mail.bootlin.com (Postfix) with ESMTPSA id 029EC2072F;
        Wed, 26 Dec 2018 09:32:24 +0100 (CET)
Date:   Wed, 26 Dec 2018 09:32:24 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atmel: fix a missing check of clk_prepare
Message-ID: <20181226083224.GR2188@piout.net>
References: <20181226025405.72480-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226025405.72480-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/12/2018 20:54:05-0600, Kangjie Lu wrote:
> clk_prepare() could fail, so let's check its status, and if it fails,
> issue an error message.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/misc/atmel-ssc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index d8e3cc2dc747..9e69d0585f49 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -60,7 +60,8 @@ struct ssc_device *ssc_request(unsigned int ssc_num)
>  	ssc->user++;
>  	spin_unlock(&user_lock);
>  
> -	clk_prepare(ssc->clk);
> +	if (clk_prepare(ssc->clk))
> +		pr_err("ssc: failed to prepare clk.\n");
>  

There is no point in adding this check and yet another string to please
a static analysis tool. This is especially true because clk_prepare will
never actually fail else you wouldn't reach this code anyway.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
