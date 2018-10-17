Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430B5ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1426421523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1426421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJQVg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:36:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51778 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJQVg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:36:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5B3280D;
        Wed, 17 Oct 2018 06:41:13 -0700 (PDT)
Received: from arrakis.emea.arm.com (unknown [10.1.196.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D45F3F5D3;
        Wed, 17 Oct 2018 06:41:11 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:41:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Prateek Patel <prpatel@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-tegra@vger.kernel.org, snikam@nvidia.com, vdumpa@nvidia.com,
        talho@nvidia.com, swarren@nvidia.com,
        Sri Krishna chowdary <schowdary@nvidia.com>
Subject: Re: [PATCH] kmemleak: Add config to select auto scan
Message-ID: <20181017134109.GA223677@arrakis.emea.arm.com>
References: <1539763408-22085-1-git-send-email-prpatel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539763408-22085-1-git-send-email-prpatel@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 01:33:28PM +0530, Prateek Patel wrote:
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e5e7c03..9542852 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -593,6 +593,17 @@ config DEBUG_KMEMLEAK_DEFAULT_OFF
>  	  Say Y here to disable kmemleak by default. It can then be enabled
>  	  on the command line via kmemleak=on.
>  
> +config DEBUG_KMEMLEAK_SCAN_ON

Nitpick: DEBUG_KMEMLEAK_AUTO_SCAN may be a better name since you don't
aim to disable scanning altogether.

> +	bool "Enable kmemleak auto scan thread on boot up"
> +	default y
> +	depends on DEBUG_KMEMLEAK
> +	help
> +	  Kmemleak scan is cpu intensive and can stall user tasks at times.

I guess that depends on the CPU.

> +	  This option enables/disables automatic kmemleak scan at boot up.
> +
> +	  Say N here to disable kmemleak auto scan thread to stop automatic
> +	  scanning.

You should also mention that disabling this option also disables
automatic reporting of memory leaks. And I'd add a "if unsure, say Y".

> +
>  config DEBUG_STACK_USAGE
>  	bool "Stack utilization instrumentation"
>  	depends on DEBUG_KERNEL && !IA64
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 877de4f..ac53678 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1647,11 +1647,14 @@ static void kmemleak_scan(void)
>   */
>  static int kmemleak_scan_thread(void *arg)
>  {
> +#ifdef CONFIG_DEBUG_KMEMLEAK_SCAN_ON
>  	static int first_run = 1;
> +#endif

	static int first_run = IS_ENABLED(CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN);

>  
>  	pr_info("Automatic memory scanning thread started\n");
>  	set_user_nice(current, 10);
>  
> +#ifdef CONFIG_DEBUG_KMEMLEAK_SCAN_ON
>  	/*
>  	 * Wait before the first scan to allow the system to fully initialize.
>  	 */
> @@ -1661,6 +1664,7 @@ static int kmemleak_scan_thread(void *arg)
>  		while (timeout && !kthread_should_stop())
>  			timeout = schedule_timeout_interruptible(timeout);
>  	}
> +#endif

With the first_run change above, this #ifdef is no longer needed.

>  
>  	while (!kthread_should_stop()) {
>  		signed long timeout = jiffies_scan_wait;
> @@ -2141,9 +2145,11 @@ static int __init kmemleak_late_init(void)
>  		return -ENOMEM;
>  	}
>  
> +#ifdef CONFIG_DEBUG_KMEMLEAK_SCAN_ON
>  	mutex_lock(&scan_mutex);
>  	start_scan_thread();
>  	mutex_unlock(&scan_mutex);
> +#endif

Please use:

	if (IS_ENABLED(CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN)) {
		...
	}

-- 
Catalin
