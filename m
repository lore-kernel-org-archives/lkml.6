Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983AFC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D53C21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfA3Q6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:58:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57928 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732159AbfA3Q6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:58:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B4880D;
        Wed, 30 Jan 2019 08:58:06 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 064D33F589;
        Wed, 30 Jan 2019 08:58:04 -0800 (PST)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com, hpa@zytor.com
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9ba3c7a7-80a8-da29-ffb7-3841ea8548b5@arm.com>
Date:   Wed, 30 Jan 2019 16:58:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2019 13:58, Julien Thierry wrote:
[...]> @@ -6151,6 +6159,20 @@ void ___might_sleep(const char *file, int line, int preempt_offset)
>  EXPORT_SYMBOL(___might_sleep);
>  #endif
> 
> +#ifdef CONFIG_DEBUG_UACCESS_SLEEP
> +void __might_resched(const char *file, int line)
> +{
> +	if (!unsafe_user_region_active())
> +		return;
> +
> +	printk(KERN_ERR
> +		"BUG: rescheduling function called from user access context at %s:%d\n",
> +			file, line);
> +	dump_stack();

Since I've been staring intensely at ___might_sleep() lately, I was thinking
we could "copy" it a bit more closely (sorry for going back on what I said
earlier).

Coming back to the double warnings (__might_resched() + schedule_debug()),
it might be better to drop the schedule_debug() warning and just have the
one in __might_resched() - if something goes wrong, there'll already be a
"BUG" in the log.

> +}
> +EXPORT_SYMBOL(__might_resched);
> +#endif
> +
>  #ifdef CONFIG_MAGIC_SYSRQ
>  void normalize_rt_tasks(void)
>  {
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d4df5b2..d030e31 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2069,6 +2069,14 @@ config IO_STRICT_DEVMEM
> 
>  	  If in doubt, say Y.
> 
> +config DEBUG_UACCESS_SLEEP
> +	bool "Check sleep inside a user access region"
> +	depends on DEBUG_KERNEL
> +	help
> +	  If you say Y here, various routines which may sleep will become very
> +	  noisy if they are called inside a user access region (i.e. between
> +	  a user_access_begin() and a user_access_end())

If it does get noisy, we should go for some ratelimiting - it's probably
good practice even if it is not noisy actually.

___might_sleep() has this:

  if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
  	return;
  prev_jiffy = jiffies;

> +
>  source "arch/$(SRCARCH)/Kconfig.debug"
> 
>  endmenu # Kernel hacking
> --
> 1.9.1
> 
