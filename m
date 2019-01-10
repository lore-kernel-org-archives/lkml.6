Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F9EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5B0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbfAJNPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:15:23 -0500
Received: from ozlabs.org ([203.11.71.1]:48317 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfAJNPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:15:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43b61H3QY0z9sLt;
        Fri, 11 Jan 2019 00:15:15 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com
Subject: Re: [PATCH v4 10/13] x86: perf/core: use PERF_PMU_CAP_NO_EXCLUDE for exclude incapable PMUs
In-Reply-To: <20190108104841.GD6808@hirez.programming.kicks-ass.net>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com> <1546878450-20341-11-git-send-email-andrew.murray@arm.com> <20190108104841.GD6808@hirez.programming.kicks-ass.net>
Date:   Fri, 11 Jan 2019 00:15:13 +1100
Message-ID: <87ef9kslge.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Jan 07, 2019 at 04:27:27PM +0000, Andrew Murray wrote:
>> For drivers that do not support context exclusion let's advertise the
>> PERF_PMU_CAP_NOEXCLUDE capability. This ensures that perf will
>> prevent us from handling events where any exclusion flags are set.
>> Let's also remove the now unnecessary check for exclusion flags.
>> 
>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
>> ---
>>  arch/x86/events/amd/ibs.c          | 13 +------------
>>  arch/x86/events/amd/power.c        | 10 ++--------
>>  arch/x86/events/intel/cstate.c     | 12 +++---------
>>  arch/x86/events/intel/rapl.c       |  9 ++-------
>>  arch/x86/events/intel/uncore_snb.c |  9 ++-------
>>  arch/x86/events/msr.c              | 10 ++--------
>>  6 files changed, 12 insertions(+), 51 deletions(-)
>
> You (correctly) don't add CAP_NO_EXCLUDE to the main x86 pmu code, but
> then you also don't check if it handles all the various exclude options
> correctly/consistently.
>
> Now; I must admit that that is a bit of a maze, but I think we can at
> least add exclude_idle and exclude_hv fails in there, nothing uses those
> afaict.
>
> On the various exclude options; they are as follows (IIUC):
>
>   - exclude_guest: we're a HV/host-kernel and we don't want the counter
>                    to run when we run a guest context.
>
>   - exclude_host: we're a HV/host-kernel and we don't want the counter
>                   to run when we run in host context.
>
>   - exclude_hv: we're a guest and don't want the counter to run in HV
>                 context.
>
> Now, KVM always implies exclude_hv afaict (for guests)

On Power it mostly does.

There's some host code that can run in real mode (MMU off) and therefore
doesn't do a full context switch out of the guest (including the PMU),
so that's host code that is running while the guest PMCs are still
counting.

cheers
