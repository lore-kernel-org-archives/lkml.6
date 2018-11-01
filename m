Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B577C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0902320820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0902320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeKAU5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:57:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57331 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeKAU5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:57:49 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gIBZ6-0003P6-IX; Thu, 01 Nov 2018 12:55:08 +0100
Date:   Thu, 1 Nov 2018 12:55:08 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Laurence Oberman <loberman@redhat.com>
cc:     linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        prarit@redhat.com
Subject: Re: [PATCH] [PATCH V7] watchdog/core: Add watchdog_thresh command
 line parameter
In-Reply-To: <1540911004-11539-1-git-send-email-loberman@redhat.com>
Message-ID: <alpine.DEB.2.21.1811011240310.1642@nanos.tec.linutronix.de>
References: <1540911004-11539-1-git-send-email-loberman@redhat.com>
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

On Tue, 30 Oct 2018, Laurence Oberman wrote:

This looks much better.

But please send your patches first to yourself. Your subject ended up with
'[PATCH] [PATCH V7]' instead of just '[PATCH V7]'

> Both graphics and serial consoles are exposed to hard lockups
> when handling a large amount of messaging. The kernel watchdog_thresh
> parameter up to now has not been available to be set on the kernel line for

kernel command line please. kernel line does not mean anything,

> early boot.
> This patch allows the setting of watchdog_thresh to be increased

Again:

 git grep 'This patch' Documentation/process/

This leads you to:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Documentation is there for a reason.

> Both graphics and serial consoles are exposed to hard lockups
> when handling a large amount of messaging. The kernel watchdog_thresh
> parameter up to now has not been available to be set on the kernel line for
> early boot.
> This patch allows the setting of watchdog_thresh to be increased
> when needed to extend the hard lockup timer in the console code.
> Note that this also affects the soft lockup detector

Just for nitpickings sake. The change log is slightly confusing. Let me
give you a suggestion:

  The hard and soft lockup detector threshold has a default value of 10
  seconds which can only be changed via sysctl.

  During early boot lockup detection can trigger when noisy debugging emits
  a large amount of messages to the console, but there is no way to set a
  larger threshold on the kernel command line. The detector can only be
  completely disabled.

  Add a new watchdog_thresh= command line parameter to allow boot time
  control over the threshold. It works in the same way as the sysctl and
  affects both the soft and the hard lockup detectors.

Hmm?

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4957,6 +4957,14 @@
>  			or other driver-specific files in the
>  			Documentation/watchdog/ directory.
>  
> +        watchdog_thresh=

Please use tabs instead of spaces

> +                        [KNL]
> +                        Set the hard lockup detector stall duration
> +                        threshold in seconds. The soft lockup detector
> +                        threshold is set to twice the value. A value of 0
> +                        disables both lockup detectors. Default is 10
> +                        seconds.

Same here.

Thanks,

	tglx

