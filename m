Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC57C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21342080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfBEL4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:56:16 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56404 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEL4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:56:15 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 591d23d00c9b99f8; Tue, 5 Feb 2019 12:56:13 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / suspend: measure the time of filesystem syncing
Date:   Tue, 05 Feb 2019 12:55:01 +0100
Message-ID: <1702604.tyfAVjpQ0o@aspire.rjw.lan>
In-Reply-To: <20190203052007.27392-1-harry.pan@intel.com>
References: <20190203052007.27392-1-harry.pan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, February 3, 2019 6:20:07 AM CET Harry Pan wrote:
> This patch gives the reader an intuitive metric of the time cost by
> the kernel issuing a filesystem sync during suspend; although developer
> can guess by the timestamp of next log or enable the ftrace power event
> for manual calculation, this manner is easier to read and benefits the
> automatic script.
> 
> Signed-off-by: Harry Pan <harry.pan@intel.com>
> ---
>  kernel/power/suspend.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 0bd595a0b610..f3b7c64f2242 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -550,6 +550,8 @@ static void suspend_finish(void)
>  static int enter_state(suspend_state_t state)
>  {
>  	int error;
> +	ktime_t start, end, elapsed;

Why do you need three vars here?  One should be sufficient.

> +	unsigned int elapsed_msecs;
>  
>  	trace_suspend_resume(TPS("suspend_enter"), state, true);
>  	if (state == PM_SUSPEND_TO_IDLE) {
> @@ -570,9 +572,14 @@ static int enter_state(suspend_state_t state)
>  
>  #ifndef CONFIG_SUSPEND_SKIP_SYNC
>  	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> +	start = ktime_get_boottime();

Why _boottime()?

>  	pr_info("Syncing filesystems ... ");
>  	ksys_sync();
> -	pr_cont("done.\n");
> +	end = ktime_get_boottime();
> +	elapsed = ktime_sub(end, start);
> +	elapsed_msecs = ktime_to_ms(elapsed);
> +	pr_cont("(elapsed %d.%03d seconds) done.\n", elapsed_msecs / 1000,
> +		elapsed_msecs % 1000);
>  	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
>  #endif
>  
> 


