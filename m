Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CCCECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3122086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 11:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3122086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeIORIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 13:08:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34170 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIORIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 13:08:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E971320794; Sat, 15 Sep 2018 13:49:56 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id BAF5F206A7;
        Sat, 15 Sep 2018 13:49:56 +0200 (CEST)
Date:   Sat, 15 Sep 2018 13:49:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Denis Osterland <Denis.Osterland@diehl.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] rtc: isl1208: fix error handling in isl1208_probe()
Message-ID: <20180915114957.GW14988@piout.net>
References: <1533766387-30529-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533766387-30529-1-git-send-email-khoroshilov@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey,

On 09/08/2018 01:13:07+0300, Alexey Khoroshilov wrote:
> After moving rtc_register_device() sysfs group is left unremoved
> on the error path.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 236b7187034e ("rtc: isl1208: switch to rtc_register_device")

Thank you for that report, I've fixed it that way which also avoid the
sysfs race:

http://patchwork.ozlabs.org/patch/970216/

> ---
>  drivers/rtc/rtc-isl1208.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> index 1a2c38cc0178..4b5df9bfb8d4 100644
> --- a/drivers/rtc/rtc-isl1208.c
> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -674,7 +674,12 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		}
>  	}
>  
> -	return rtc_register_device(rtc);
> +	rc = rtc_register_device(rtc);
> +	if (rc) {
> +		sysfs_remove_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
> +		return rc;
> +	}
> +	return 0;
>  }
>  
>  static int
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
