Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD8C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9D0214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9D0214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389253AbeKVGx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:53:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45179 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbeKVGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:53:57 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYwm-0000FI-ON; Wed, 21 Nov 2018 21:18:04 +0100
Message-Id: <20181121201430.559770965@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:30 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 00/24] x86/speculation: Remedy the STIBP/IBPB overhead
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on Tim Chen's V5 patch series. The following changes have
been made:

   - Control STIPB evaluation with a single static key

   - Move IBPB out from switch_mm() into switch_to() and control the
     always and the conditional mode with static keys.

     The mainline implementation is wrong in a few aspects, e.g. it fails
     to protect tasks within the same process, which breaks
     sandboxing. That same process optimization was the sole reason to have
     it in switch_mm().

     The new always mode is just issuing the barrier unconditionally when
     switching to a user task, but that also leaves STIPB always on. So
     really paranoid people get the highest possible protection and the
     highest overhead.

     The conditional mode issues the barrier when a task which is mitigated
     is scheduling out or scheduling in. That is required to support proper
     sandboxing.

   - Remove the ptrace_may_access_sched() code as it's unused now. It was
     ugly anyway and would have given people ideas how to slow down
     switch_mm() some more.

   - Rename TIF_STIPB to TIF_SPEC_IB because it controls both STIBP and
     IBPB.

   - Fix all the corner cases vs. UP and SMT disabled.

   - Limit the overhead when conditional STIPB is not enabled so
     switch_to_xtra() is not invoked for nothing when the TIF bit would
     trigger the entry and nothing else is to do. That can happen when SMT
     is off and a task has the TIF bit set. On UP STIPB is never enabled.

   - Dropped the dumpable part

TODO: Write documentation

It's avaiable from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/pti

It's based on the x86/pti branch unfortunately, which contains the removal
of the minimal asm retpoline hackery. I noticed too late. If the minimal
asm stuff should not be backported it's trivial to rebase that series on
Linus tree.

Thanks,

	tglx



