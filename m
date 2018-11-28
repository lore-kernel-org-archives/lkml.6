Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D127C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FC82081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FC82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeK2DLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:11:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeK2DLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:11:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFCD4308123E;
        Wed, 28 Nov 2018 16:08:58 +0000 (UTC)
Received: from treble (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEE991948E;
        Wed, 28 Nov 2018 16:08:56 +0000 (UTC)
Date:   Wed, 28 Nov 2018 10:08:49 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin " <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 0/5] x86: dynamic indirect call promotion
Message-ID: <20181128160849.epmoto4o5jaxxxol@treble>
References: <20181018005420.82993-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181018005420.82993-1-namit@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 28 Nov 2018 16:08:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 05:54:15PM -0700, Nadav Amit wrote:
> This RFC introduces indirect call promotion in runtime, which for the
> matter of simplification (and branding) will be called here "relpolines"
> (relative call + trampoline). Relpolines are mainly intended as a way
> of reducing retpoline overheads due to Spectre v2.
> 
> Unlike indirect call promotion through profile guided optimization, the
> proposed approach does not require a profiling stage, works well with
> modules whose address is unknown and can adapt to changing workloads.
> 
> The main idea is simple: for every indirect call, we inject a piece of
> code with fast- and slow-path calls. The fast path is used if the target
> matches the expected (hot) target. The slow-path uses a retpoline.
> During training, the slow-path is set to call a function that saves the
> call source and target in a hash-table and keep count for call
> frequency. The most common target is then patched into the hot path.
> 
> The patching is done on-the-fly by patching the conditional branch
> (opcode and offset) that is used to compare the target to the hot
> target. This allows to direct all cores to the fast-path, while patching
> the slow-path and vice-versa. Patching follows 2 more rules: (1) Only
> patch a single byte when the code might be executed by any core. (2)
> When patching more than one byte, ensure that all cores do not run the
> to-be-patched-code by preventing this code from being preempted, and
> using synchronize_sched() after patching the branch that jumps over this
> code.
> 
> Changing all the indirect calls to use relpolines is done using assembly
> macro magic. There are alternative solutions, but this one is
> relatively simple and transparent. There is also logic to retrain the
> software predictor, but the policy it uses may need to be refined.
> 
> Eventually the results are not bad (2 VCPU VM, throughput reported):
> 
> 		base		relpoline
> 		----		---------
> nginx 	22898 		25178 (+10%)
> redis-ycsb	24523		25486 (+4%)
> dbench	2144		2103 (+2%)
> 
> When retpolines are disabled, and if retraining is off, performance
> benefits are up to 2% (nginx), but are much less impressive.

Hi Nadav,

Peter pointed me to these patches during a discussion about retpoline
profiling.  Personally, I think this is brilliant.  This could help
networking and filesystem intensive workloads a lot.

Some high-level comments:

- "Relpoline" looks confusingly a lot like "retpoline".  How about
  "optpoline"?  To avoid confusing myself I will hereafter refer to it
  as such :-)

- Instead of patching one byte at a time, is there a reason why
  text_poke_bp() can't be used?  That would greatly simplify the
  patching process, as everything could be patched in a single step.

- In many cases, a single direct call may not be sufficient, as there
  could be for example multiple tasks using different network protocols
  which need different callbacks for the same call site.

- I'm not sure about the periodic retraining logic, it seems a bit
  nondeterministic and bursty.
  
So I'd propose the following changes:

- In the optpoline, reserve space for multiple (5 or so) comparisons and
  direct calls.  Maybe the number of reserved cmp/jne/call slots can be
  tweaked by the caller somehow.  Or maybe it could grow as needed.
  Starting out, they would just be NOPs.

- Instead of the temporary learning mode, add permanent tracking to
  detect a direct call "miss" -- i.e., when none of the existing direct
  calls are applicable and the retpoline will be used.

- In the case of a miss (or N misses), it could trigger a direct call
  patching operation to be run later (workqueue or syscall exit).  If
  all the direct call slots are full, it could patch the least recently
  modified one.  If this causes thrashing (>x changes over y time), it
  could increase the number of direct call slots using a trampoline.
  Even if there were several slots, CPU branch prediction would
  presumably help make it much faster than a basic retpoline.

Thoughts?

-- 
Josh
