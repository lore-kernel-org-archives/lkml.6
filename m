Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B41620823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B41620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbeKTIFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:05:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730602AbeKTIFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:05:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44DA03097043;
        Mon, 19 Nov 2018 21:40:15 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7C1618E4B;
        Mon, 19 Nov 2018 21:40:14 +0000 (UTC)
Date:   Mon, 19 Nov 2018 16:40:14 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [Patch v5 11/16] x86/speculation: Add Spectre v2 app to app
 protection modes
Message-ID: <20181119214014.GF29258@redhat.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
 <ca5dd01c12789d3f75ab1b73bfcac3bdaea93dd6.1542418937.git.tim.c.chen@linux.intel.com>
 <nycvar.YFH.7.76.1811171044510.21108@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1811182358370.21108@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1811191433100.1537@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1811191438290.21108@cbobk.fhfr.pm>
 <20181119193253.GE29258@redhat.com>
 <nycvar.YFH.7.76.1811192035590.21108@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1811192035590.21108@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 19 Nov 2018 21:40:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 08:39:41PM +0100, Jiri Kosina wrote:
> On Mon, 19 Nov 2018, Andrea Arcangeli wrote:
> 
> > Generally speaking the untrusted code that would try to use spectrev2
> > to attack the other processes is more likely to run inside SECCOMP
> > jail than outside, so if SECCOMP should be used as a best effort
> > heuristic to decide when to enable STIBP, it would make more sense to
> > enable STIBP outside SECCOMP, and not inside. I.e. the exact opposite
> > of what you're proposing above.
> 
> Hmm, that's a very good point. But I actually don't see why both 
> directions wouldn't be possible real-blackhat-world scenarios. So perhaps 
> we'd want, under the basic asumption that "SECCOMP should really be 
> sandboxed from outisde interventions and from causing them from inside as 
> well", flush on both switch-to-seccomp and switch-from-seccomp?

STIBP doesn't flush so I don't see how "flush" and "switch" fits the
STIBP discussion.

Flush as in IPBP on switch-to-seccomp and switch-from-seccomp? IBPB is
not going to solve the HT attack and STIBP is only about the HT
attack. IBPB only solves the user-to-user context switch attack.

I just don't see SECCOMP as a good fit for a default-on heuristic
because there would be more arguments to enable STIBP outside seccomp
than inside and even if you ignore that, SECCOMP is used by pretty
much everything including wrapping through containers and systemd so
it would still leave lots of software running with STIBP (and for all
the wrong reasons too).

As opposed the not dumpable was a much better fit for a per-process
enablement heuristic, because the not dumpable code is more likely to
be the one that needs protection from attack and it's less likely to
be the very malicious code that got exploited (or was untrusted to
begin with like DRM binary blobs or public cloud usages). However like
mentioned in this thread suid calls can set the non dumpable flag, so
it's not ideal either. We'd need to track which processes turned off
the not dumpable flag with SUID_DUMP_DISABLE explicitly.

> So if I understand you correctly, what you are proposing here is to keep 
> the current code, but just switch the default, and make it 
> runtime/boottime togglable?

Deciding the default on this stuff is nightmarish, there's no good
default and the best system-wide default is data and workload
dependent.

And this is precisly why this should be runtime toggable and not just
boot-time toggable in my view.

I don't disagree with default disabled, that may be safer to avoid
breaking workloads near full capacity (same reason for why HT isn't
disabled by default for L1TF), we've to draw a line somewhere with the
default.

The ASLR argument from Tim's patchset cover letter combined with PID
namespaces should go a long way to mitigate the HT attack too even
without STIBP.

In my understanding you need to know what's running on the sibling
thread to derandomize ASLR, otherwise you'd be potentially attacking
glibc or some lib that yes is always mapped by all processes but it's
not mapped at the same address in all processes. You need to restrict
the measurement during ASLR derandomization to the exact time there's
the target process running in the sibling (any thread of the process
would be good).

Now assuming there's no pid namespace that prevents to see what's
running on the sibling thread, it depends on the scheduling jittering
and on the size and hw hashfn of the BTB (which varies across CPUs)
how hard it is to derandomize ASLR. According to the original paper,
some non-Linux OS has many low significant bits of their ASLR not
randomized and the high bits don't go into the hashfn of the BTB
(incidentally the ASLR derandomization technique to attack userland is
apparently not tested for Linux). We should be randomizing all bits
down to bit 12 (not bit 15), so for us the derandomizing should be 256
times more expensive? (At least until the day we map .text into
filesystem THP pagecache...) The more bits randomized that are part of
the BTB hashfn input, the more computational expensive it becomes to
derandomize ASLR, the more the random scheduling jittering will
interfere with the longer measurement, so hopefully the complexity of
the attack grows more than linearly with the number of random ASLR low
bits that gets into the BTB hashfn input. This is an optimistic guess
though.

Overall for on-prem cloud usages where no random malicious code can
run in the CPU by design, and this is only a post-exploitation
robustness issue, it doesn't seem a major concern if STIBP is disabled
if pid namespaces and ASLR have been fully leveraged by default in
Kubernetes containers. I'm curious to hear other people opinion on
this too however.

Downstream we always provided ibrs_enabled=2/3 which already implies
STIBP implicitly enabled at all times too, and that unlike STIBP
alone, also protects against guest attack on host userland too within
the same context. It's tunable at runtime. It's not enabled by default
for similar considerations as above for STIBP. I think it's good to
give the users the choice to be 100% secure against everything as an
opt-in (ideally requiring a reboot, that actually helps the evaluation
of the performance impact, which is obviously workload dependent too).

As an alternative to STIBP it would also be possible to alter the
scheduler so it never runs different processes in different siblings
of the same core, unless they can ptrace each other (same exact ptrace
check as the one to decide if to run IBPB to protect against the
context switch spectrev2 attack, except it needs to be checked in both
directions here). This way you could still have zero penalty for all
kernel builds and all threaded programs etc.. while still retaining
full security against the HT attack (and IBPB takes care of the rest
with the same ptrace check). With several containerized single
threaded workloads it would be slower than STIBP though by leaving all
siblings idle. However we could also let any process under pid
namespace to run along with any other processes under pid namespaces
even if they cannot ptrace each other to take care of that detail. Not
sure if it's worth it, but it remains a possibility that may perform
better than STIBP. It would also take care in general of cache attacks
on non-constant time algorithms etc.. not just spectrev2 HT attack.

Thanks,
Andrea
