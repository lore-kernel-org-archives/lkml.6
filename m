Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9134AECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4BF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fsfxZo+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4BF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJYCMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:12:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeJYCMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QHa6Eav4nuPVE7UCmjaNJsVI2e7kyHeIiXoTKaqtfFk=; b=fsfxZo+HnasoNmosY4fNxYeNc
        x2mWrIOrU0p1nLEoK5zMq+9uQDEIySZxGsIkifgAjmi0ElAohLbLZFkpScK7EnKQyMVTAnrQahP6z
        Bu26+fAWgh6onNQsQsVxesLMZiHLIEma4s1nlt9CZlo50OgHKTnwPQH17q/YbuBopeK80q9b9vhon
        yZRPDGe3CF9Sdohzr+5+ppFiCU2c+1+R5B6MK40ow3kv5a/e68AgKu4mDWjsEfkLcl313n44c231F
        vaGIyA+LWTbez4mgYD3KxzNmJKnYXBqwKs5laB3NUy0jqTUtAajrahPCMnWoocK2Wnccs/E6wkZvd
        m93fZCqjw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFNBl-0002M3-BS; Wed, 24 Oct 2018 17:43:25 +0000
Subject: Re: [PATCH] V3 init/main.c Enable watchdog_thresh control from kernel
 line
To:     Laurence Oberman <loberman@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de
References: <1540399992-23448-1-git-send-email-loberman@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <42417c52-1a49-88aa-6665-4a1eafe6f7b0@infradead.org>
Date:   Wed, 24 Oct 2018 10:43:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540399992-23448-1-git-send-email-loberman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 9:53 AM, Laurence Oberman wrote:
> Both graphics and serial consoles are exposed to hard lockups
> when handling a large amount of messaging. The kernel watchdog_thresh
> parameter up to now has not been available to be set on the kernel line for
> early boot.
> This patch allows the setting of watchdog_thresh to be increased
> when needed to avoid the hard lockups in the console code.
> 
> Signed-off-by: Laurence Oberman <loberman@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
>  init/main.c                                     | 9 +++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4cdcd1a..cd8d588 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4932,6 +4932,14 @@
>  			or other driver-specific files in the
>  			Documentation/watchdog/ directory.
>  
> +	watchdog_thresh=
> +			This parameter is now available as a kernel line
> +			parameter. Use watchdog_thresh=30 as example
> +			This will allow early boot changes of the current
> +			default of 10s to be increased when needed to
> +			avoid hard lockups.
> +			Default: 10
> +

The first sentence isn't needed.  and s/10s/10 seconds/
How about this?

			This parameter allows early boot to change the default
			value of the watchdog timeout threshold from the default
			of 10 seconds to avoid hard lockups.  Example:
			watchdog_thresh=30

			

>  	workqueue.watchdog_thresh=
>  			If CONFIG_WQ_WATCHDOG is configured, workqueue can
>  			warn stall conditions and dump internal state to
> diff --git a/init/main.c b/init/main.c
> index 1c3f902..88cbed9 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1038,6 +1038,15 @@ static int __init set_debug_rodata(char *str)
>  __setup("rodata=", set_debug_rodata);
>  #endif
>  
> +static int __init
> +is_watchdog_thresh_setup(char *str)

No need to split that into 2 lines; just join them, please.

> +{
> +	get_option(&str, &watchdog_thresh);
> +	return 1;
> +}
> +__setup("watchdog_thresh=", is_watchdog_thresh_setup);
> +
> +
>  #ifdef CONFIG_STRICT_KERNEL_RWX
>  static void mark_readonly(void)
>  {
> 


-- 
~Randy
