Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF2520815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF2520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeKSILQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:11:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:44472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbeKSILQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:11:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DC7EAE87;
        Sun, 18 Nov 2018 21:49:45 +0000 (UTC)
Date:   Sun, 18 Nov 2018 22:49:44 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable@vger.kernel.org
Subject: Re: STIBP by default.. Revert?
In-Reply-To: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1811182222230.21108@cbobk.fhfr.pm>
References: <CAHk-=wg-9FUGU=grF4gKDq1sm1m39Jbs3A_iyLbSSntU47ncwg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018, Linus Torvalds wrote:

> This was marked for stable, and honestly, nowhere in the discussion
> did I see any mention of just *how* bad the performance impact of this
> was.

Frankly, I ran some benchmarks myself, and am seeing very, very 
varying/noisy results, which were rather inconclusive across the 
individual workloads.

The article someone pointed me to at Phoronix yesterday also was talking 
about something between 3% and 20% IIRC.

> When performance goes down by 50% on some loads, people need to start
> asking themselves whether it was worth it. It's apparently better to
> just disable SMT entirely, which is what security-conscious people do
> anyway.
> 
> So why do that STIBP slow-down by default when the people who *really*
> care already disabled SMT?

BTW for them, there is no impact at all. And they probably did it because 
of crypto libraries being implemented in a way that their observable 
operation depends on value of the secrets (tlbleed etc), but this is being 
fixed in the said crypto code.

STIBP is only activated on systems with HT on; plus odds are that people 
who don't care about spectrev2 already have 'nospectre_v2' on their 
command-line, so they are fine as well.

> I think we should use the same logic as for L1TF: we default to
> something that doesn't kill performance. Warn once about it, and let
> the  crazy people say "I'd rather take a 50% performance hit than
> worry about a theoretical issue".

So, I think it's as theoretical as any other spectrev2 (only with the 
extra "HT" condition added on top).

Namely, I think that scenarios such as "one browser tab's javascript is 
attacking other browser's tab private data on a sibling" is rather a 
practical one, I've seen such demos (not with the sibling condition being 
in place, but I don't think that matters that much). The same likely holds 
for server threads serving individual requests in separate threads, etc 
(but yeah, you need to have proper gadgets there in place already in 
server's .text, which makes it much less practical).

For L1TF, the basic argument AFAICS was, that the default situation is 
"only special people care about strict isolation between VMs". But this is 
isolation between individual processess.

Tim is currently working [1] on a patchset on top of my original 
STIBP-enabling commit, that will make STIBP to be used in much smaller 
number of cases (taking prctl()-based aproach as one of the possible ones, 
similarly as we did for SSBD), and as I indicated in that thread, I think 
it should be really considered for this -rc cycle still if it lands in tip 
in a reasonable future.

To conclude -- I am quite happy that this finally started to move 
(although it's sad that some of it is due to clickbaity article titles, 
but whatever), as Intel didn't really provide any patch / guidance (*) in 
past ~1 year to those who care about spectrev2 isolation on HT, which is 
something I wasn't really feeling comfortable with, and that's why I 
submitted the patch.

If we make it opt-in (on kernel cmdline) and issue big fat warning if not 
mitigated, fine, but then we're bit incosistent how we deal with 
cross-core (IBPB) and cross-thread (STIBP) spectrev2 security in the 
kernel code.

If we take Tim's aproach, even better -- there would be means available to 
make system secure, although not sacrifying performance by default.

I would not prefer going the plain revert path though, as that leaves no 
other option to mitigate rather than turning SMT off, which might possibly 
have even *worse* performance numbers depending on workload.

[1] https://lore.kernel.org/lkml/?q=cover.1542418936.git.tim.c.chen%40linux.intel.com

(*) no code to implement STIBP sanely, no recommendation about turning SMT 
    off at least for some workloads

Thanks,

-- 
Jiri Kosina
SUSE Labs

