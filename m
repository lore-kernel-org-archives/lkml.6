Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0963C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C889F2080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBGVlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:41:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40698 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGVlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:41:24 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1grrPp-0004UV-2a; Thu, 07 Feb 2019 22:41:01 +0100
Date:   Thu, 7 Feb 2019 22:40:55 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 03/32] timens: Introduce CLOCK_MONOTONIC offsets
In-Reply-To: <20190206001107.16488-4-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1902072225420.1645@nanos.tec.linutronix.de>
References: <20190206001107.16488-1-dima@arista.com> <20190206001107.16488-4-dima@arista.com>
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

On Wed, 6 Feb 2019, Dmitry Safonov wrote:
>  #include "timekeeping.h"
>  #include "posix-timers.h"
> @@ -1041,6 +1042,9 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
>  
>  	error = kc->clock_get(which_clock, &kernel_tp);
>  
> +	if (!error && kc->clock_timens_adjust)
> +		timens_clock_from_host(which_clock, &kernel_tp);

Why are you adding this conditional instead of sticking the offset
magic into the affected ->clock_get() implementations?

That spares you the switch() and the !offsets conditional.

> +static void clock_timens_fixup(int clockid, struct timespec64 *val, bool to_ns)
> +{
> +	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
> +	struct timespec64 *offsets = NULL;
> +
> +	if (!ns_offsets)
> +		return;
> +
> +	if (val->tv_sec == 0 && val->tv_nsec == 0)
> +		return;

I have no idea why 0/0 is special.

> +
> +	switch (clockid) {
> +	case CLOCK_MONOTONIC:
> +	case CLOCK_MONOTONIC_RAW:
> +	case CLOCK_MONOTONIC_COARSE:
> +		offsets = &ns_offsets->monotonic_time_offset;
> +		break;
> +	}
> +
> +	if (!offsets)
> +		return;
> +
> +	if (to_ns)
> +		*val = timespec64_add(*val, *offsets);
> +	else
> +		*val = timespec64_sub(*val, *offsets);
> +}
> +
> +void timens_clock_to_host(int clockid, struct timespec64 *val)

Does this really need to be an out of line call? If you stick this into the
clock_get() implementations then it boils down to:

static inline void timens_add_monotonic(struct timespec64 *ts)
{
	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;

	if (ns_offsets)
		*ts = timespec64_add(*ts, ns_offsets->monotonic_time_offset);
}

and

static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
{
        ktime_get_ts64(tp);
	timens_add_monotonic(tp);
        return 0;
}

Hmm?

Thanks,

	tglx

