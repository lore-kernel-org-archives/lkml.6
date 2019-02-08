Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF80C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46CC218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfBHJrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:47:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43179 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBHJrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:47:00 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gs2k0-0006Iz-E1; Fri, 08 Feb 2019 10:46:36 +0100
Date:   Fri, 8 Feb 2019 10:46:35 +0100 (CET)
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
In-Reply-To: <alpine.DEB.2.21.1902072225420.1645@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1902080859460.1645@nanos.tec.linutronix.de>
References: <20190206001107.16488-1-dima@arista.com> <20190206001107.16488-4-dima@arista.com> <alpine.DEB.2.21.1902072225420.1645@nanos.tec.linutronix.de>
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

On Thu, 7 Feb 2019, Thomas Gleixner wrote:
> Does this really need to be an out of line call? If you stick this into the
> clock_get() implementations then it boils down to:
> 
> static inline void timens_add_monotonic(struct timespec64 *ts)
> {
> 	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
> 
> 	if (ns_offsets)
> 		*ts = timespec64_add(*ts, ns_offsets->monotonic_time_offset);

And this needs to be a special variant of
timespec64-add_safe(). timespec64_add_safe() is not sufficient, because it
assumes that both values are positive, which is not the case here..

In timer_set() implementations you move the timespec_valid() check after
the add. That's wrong because you really want to check the input value from
user space.

Assume that the caller supplied value is valid and the adjustment brings it
out of range then how should the caller understand why it it rejected?

So timespec64_add_namespace() must check for under and overflow. But doing
this with timespecs is a pain. I rather suggest to rework the whole thing
so hrtimer_nanosleep() takes a ktime_t expiry value and move the conversion
to the call sites. Then the whole offset magic becomes:

   expires = timespec64_to_ktime(rqtp);

   if (abstime)
   	expires = timens_to_host_mono(expires);

and that function can nicely do the underflow and overflow detection and
cap the values to 0 on underflow and KTIME_MAX on overflow.

Hmm?

Thanks,

	tglx
