Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA1CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256F62080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256F62080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeJ3Pnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:43:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53174 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeJ3Pnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:43:45 -0400
Received: from tmo-115-37.customers.d1-online.com ([80.187.115.37] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gHNs7-0000xx-LM; Tue, 30 Oct 2018 07:51:27 +0100
Date:   Tue, 30 Oct 2018 07:51:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Laurence Oberman <loberman@redhat.com>
cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] V6 init/main.c Enable watchdog_thresh control from kernel
 line To: loberman@redhat.com
In-Reply-To: <1540410119-21120-1-git-send-email-loberman@redhat.com>
Message-ID: <alpine.DEB.2.21.1810300713320.5984@nanos.tec.linutronix.de>
References: <1540410119-21120-1-git-send-email-loberman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurence,

On Wed, 24 Oct 2018, Laurence Oberman wrote:

your subject line reads a bit strange:

Subject: [PATCH] V6 init/main.c Enable watchdog_thresh control from kernel line To: loberman@redhat.com

Aside of that extra 'To:...', please move the V6 inside the square brackets
together with PATCH so tools can strip off the whole thing.

Also please refrain from using file path as a prefix. It's sufficient to
use 'init' and please add a colon after the prefix to separate it from the
short log string. 'kernel line' reads strange, that should be 'kernel
command line'. 

> Both graphics and serial consoles are exposed to hard lockups
> when handling a large amount of messaging. The kernel watchdog_thresh
> parameter up to now has not been available to be set on the kernel line for
> early boot.
> This patch allows the setting of watchdog_thresh to be increased
> when needed to avoid the hard lockups in the console code.

git grep 'This patch' Documentation/process/

> Signed-off-by: Laurence Oberman <loberman@redhat.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
>  init/main.c                                     | 11 +++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4cdcd1a..102382f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4932,6 +4932,13 @@
>  			or other driver-specific files in the
>  			Documentation/watchdog/ directory.
>  
> +	watchdog_thresh=
> +			This parameter allows early boot to change the
> +			value of the watchdog timeout threshold from the default
> +			of 10 seconds to avoid hard lockups.  Example:
> +			watchdog_thresh=30
> +			Default: 10

  Describing a parameter with 'This parameter' is pointless. The 'early
  boot' extra is not really helpful either as the kernel command line
  parameters are evaluated during early boot.

  Changing this parameter does not avoid hard lockups, really. It changes
  the time which has to elapse for a lockup to be detected.

  Aside of that it does not only affect the hard lockup detector it also
  affects the soft lockup detector.

  You also fail to mention that setting this to 0 disables both lockup
  detectors completely. Something like this perhaps:

	watchdog_thresh=
			[KNL]
			Set the hard lockup detector stall duration
			threshold in seconds. The soft lockup detector
			threshold is set to twice the value. A value of 0
			disables both lockup detectors. Default is 10
			seconds.

> --- a/init/main.c
> +++ b/init/main.c
> @@ -1038,6 +1038,17 @@ static int __init set_debug_rodata(char *str)
>  __setup("rodata=", set_debug_rodata);
>  #endif
>  
> +#ifdef CONFIG_LOCKUP_DETECTOR
> +extern int watchdog_thresh;
> +
> +static int __init watchdog_thresh_setup(char *str)
> +{
> +	get_option(&str, &watchdog_thresh);
> +	return 1;
> +}
> +__setup("watchdog_thresh=", watchdog_thresh_setup);
> +#endif

Why are you adding this to init/main.c?

This really belongs into kernel/watchdog.c which also avoids the ifdeffery
and the ugly extern. Then the subject line becomes something like this:

 [PATCH V$N] watchdog/core: Add watchdog_thresh command line parameter

Thanks,

	tglx
