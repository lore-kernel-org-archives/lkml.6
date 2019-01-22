Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CC8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DFF218D9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548149858;
	bh=GUpWqifi+ww1FYhpfmzC6BDAzq5GQ2f5hA18yaMz1LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sW7hmYYJWtmiqERGXNK/lS1xQ6M/0Hs1m1NgZD2BMS8r7NbmhOy5jhsPSKZxAU+Bd
	 IQbYLKR0D6neuSUtpzH3OqF9fyrr6hLBhCbreqo7lDrDBtpkQtcAfgDwpCi+eIwk+o
	 iPGwmDY8FlAIFroI1xXxZLy3Ryg2qL3WZkVy2R30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfAVJhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbfAVJhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:37:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D15F218D0;
        Tue, 22 Jan 2019 09:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548149854;
        bh=GUpWqifi+ww1FYhpfmzC6BDAzq5GQ2f5hA18yaMz1LQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSFLPz6TSCJu0Sbbxg7+0U+bjL2XKVdDcI8wNn6kEXOH/mJyAKZiC8j0rBHD904Fi
         3/EZsdRba/iJU0tya97KAZd9P5kWIyyaK6lzAOirXiup9yzXvXpIyPM+o1tN2qSYj1
         RvI4+kTZRm3f/Kyf9VyLC+qM5+JQD51qRFqntAF4=
Date:   Tue, 22 Jan 2019 10:37:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6]  misc/pvpanic: Add pvpanic driver framework
Message-ID: <20190122093732.GA29657@kroah.com>
References: <1548098711-52497-1-git-send-email-peng.hao2@zte.com.cn>
 <1548098711-52497-2-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548098711-52497-2-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:25:07AM +0800, Peng Hao wrote:
> Add pvpanic driver framework.
> 

You need a lot more description of what you did here than this, as I can
not understand from this text, what the patch does, or more importantly,
why it is doing this, at all.



> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic/pvpanic.c | 171 ++++++++++-------------------------------
>  1 file changed, 39 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 595ac06..6380540 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -8,15 +8,20 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/acpi.h>
> +#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>  
> -static void __iomem *base;
> +static struct {
> +	struct platform_device *pdev;
> +	void __iomem *base;
> +	bool is_ioport;
> +} pvpanic_data = {
> +	.pdev = NULL,
> +	.is_ioport = false,

You do not need to initialize variables to 0 specifically like this.

> +};
>  
>  #define PVPANIC_PANICKED        (1 << 0)
>  
> @@ -27,7 +32,7 @@
>  static void
>  pvpanic_send_event(unsigned int event)
>  {
> -	iowrite8(event, base);
> +	iowrite8(event, pvpanic_data.base);

Why did you convert a single global variable into a single global
structure?  Why not, if you really need to pass this value around, do
that at the same time as you will end up touching these same functions
again, right?

thanks,

greg k-h
