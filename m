Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E840CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BA220892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BA220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeG3VEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:04:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730607AbeG3VE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DACC2402316D;
        Mon, 30 Jul 2018 19:28:01 +0000 (UTC)
Received: from redhat.com (ovpn-123-16.rdu2.redhat.com [10.10.123.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3694620389E0;
        Mon, 30 Jul 2018 19:28:01 +0000 (UTC)
Date:   Mon, 30 Jul 2018 15:28:01 -0400
From:   Don Zickus <dzickus@redhat.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] watchdog: Reduce message verbosity
Message-ID: <20180730192800.nqdhugzbxmin6e25@redhat.com>
References: <20180730190949.141996-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730190949.141996-1-okaya@kernel.org>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 30 Jul 2018 19:28:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 30 Jul 2018 19:28:01 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dzickus@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:09:47PM -0700, Sinan Kaya wrote:
> Reducing the verbosity level to debug for people that are interested in
> debugging watchdog issues.
> 
> [    0.152492] NMI watchdog: Perf event create on CPU 0 failed with -2
> [    0.156002] NMI watchdog: Perf NMI watchdog permanently disabled

Hi Sinan,

Any reason why?  Usually when the 'perf event' fails, that indicates a
system problem.  And most folks don't boot with the 'debug' option.  This
means these unusual failures are hidden and become difficult to debug later
when it propagates.

Or are you running the watchdog in a different configuration such that this
is a common nuisance that you are trying to suppress?

Cheers,
Don

> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  kernel/watchdog_hld.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
> index e449a23e9d59..1f7020d65d0a 100644
> --- a/kernel/watchdog_hld.c
> +++ b/kernel/watchdog_hld.c
> @@ -175,8 +175,8 @@ static int hardlockup_detector_event_create(void)
>  	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
>  					       watchdog_overflow_callback, NULL);
>  	if (IS_ERR(evt)) {
> -		pr_info("Perf event create on CPU %d failed with %ld\n", cpu,
> -			PTR_ERR(evt));
> +		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
> +			 PTR_ERR(evt));
>  		return PTR_ERR(evt);
>  	}
>  	this_cpu_write(watchdog_ev, evt);
> -- 
> 2.17.1
> 
