Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD0CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582912177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfBSK0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:26:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58333 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfBSK0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:26:02 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id afe34b449a1f16d5; Tue, 19 Feb 2019 11:26:00 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] PM / suspend: measure the time of filesystem syncing
Date:   Tue, 19 Feb 2019 11:24:36 +0100
Message-ID: <2819109.DzhZvocLkm@aspire.rjw.lan>
In-Reply-To: <20190214111543.22137-1-harry.pan@intel.com>
References: <20190206154214.576-1-harry.pan@intel.com> <20190214111543.22137-1-harry.pan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 14, 2019 12:15:43 PM CET Harry Pan wrote:
> This patch gives the reader an intuitive metric of the time cost by
> the kernel issuing a filesystem sync during suspend; although developer
> can guess by the timestamp of next log or enable the ftrace power event
> for manual calculation, this manner is easier to read and benefits the
> automatic script.
> 
> v2: simplify the variables, apply the simplest form of ktime API.
> v3: reduce conditional compilation, rectify profiling in better syntax
> 
> Signed-off-by: Harry Pan <harry.pan@intel.com>
> ---
>  kernel/power/suspend.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 0bd595a0b610..4844fc6a796d 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -568,13 +568,20 @@ static int enter_state(suspend_state_t state)
>  	if (state == PM_SUSPEND_TO_IDLE)
>  		s2idle_begin();
>  
> -#ifndef CONFIG_SUSPEND_SKIP_SYNC
> -	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> -	pr_info("Syncing filesystems ... ");
> -	ksys_sync();
> -	pr_cont("done.\n");
> -	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> -#endif
> +	if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
> +		ktime_t start;
> +		unsigned int elapsed_msecs;
> +
> +		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> +		pr_info("Syncing filesystems ... ");
> +		start = ktime_get();
> +		ksys_sync();
> +		elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
> +		pr_cont("(elapsed %d.%03d seconds) done.\n",
> +			elapsed_msecs / MSEC_PER_SEC,
> +			elapsed_msecs % MSEC_PER_SEC);

One more nit.

Since you are printing the sync time anyway, there is a little sense to
split the message using pr_cont() that may be messed up with by any
intervening messages, so why don't you just print a one-line
pr_info("Filesystems sync: %d.%03d seconds\n", ...) message?

Also, if you change it here, I guess it would be consistent to make an
analogous change for hibernation.

> +		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> +	}
>  
>  	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
>  	pm_suspend_clear_flags();
> 


