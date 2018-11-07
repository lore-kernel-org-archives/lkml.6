Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8668EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570FB20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570FB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbeKHBzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:55:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35209 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbeKHBzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:55:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1C910224CD; Wed,  7 Nov 2018 17:23:55 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id E6DEF20712;
        Wed,  7 Nov 2018 17:23:54 +0100 (CET)
Date:   Wed, 7 Nov 2018 17:23:54 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Xulin Sun <xulin.sun@windriver.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, xulinsun@gmail.com
Subject: Re: [PATCH] rtc: pcf2127: fix a kmemleak caused in
 pcf2127_i2c_gather_write
Message-ID: <20181107162354.GE21694@piout.net>
References: <1541493739-85733-1-git-send-email-xulin.sun@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541493739-85733-1-git-send-email-xulin.sun@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 16:42:19+0800, Xulin Sun wrote:
> pcf2127_i2c_gather_write() allocates memory as local variable
> for i2c_master_send(), after finishing the master transfer,
> the allocated memory should be freed. The kmemleak is reported:
> 
> unreferenced object 0xffff80231e7dba80 (size 64):
>   comm "hwclock", pid 27762, jiffies 4296880075 (age 356.944s)
>   hex dump (first 32 bytes):
>     03 00 12 03 19 02 11 13 00 80 98 18 00 00 ff ff ................
>     00 50 00 00 00 00 00 00 02 00 00 00 00 00 00 00 .P..............
>   backtrace:
>     [<ffff000008221398>] create_object+0xf8/0x278
>     [<ffff000008a96264>] kmemleak_alloc+0x74/0xa0
>     [<ffff00000821070c>] __kmalloc+0x1ac/0x348
>     [<ffff0000087ed1dc>] pcf2127_i2c_gather_write+0x54/0xf8
>     [<ffff0000085fd9d4>] _regmap_raw_write+0x464/0x850
>     [<ffff0000085fe3f4>] regmap_bulk_write+0x1a4/0x348
>     [<ffff0000087ed32c>] pcf2127_rtc_set_time+0xac/0xe8
>     [<ffff0000087eaad8>] rtc_set_time+0x80/0x138
>     [<ffff0000087ebfb0>] rtc_dev_ioctl+0x398/0x610
>     [<ffff00000823f2c0>] do_vfs_ioctl+0xb0/0x848
>     [<ffff00000823fae4>] SyS_ioctl+0x8c/0xa8
>     [<ffff000008083ac0>] el0_svc_naked+0x34/0x38
>     [<ffffffffffffffff>] 0xffffffffffffffff
> 
> Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
