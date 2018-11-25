Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141C0C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE83120868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 18:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE83120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeKZFvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 00:51:18 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52684 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeKZFsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 00:48:55 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQzac-0003O2-OM; Sun, 25 Nov 2018 19:57:06 +0100
Message-Id: <20181125183328.318175777@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 25 Nov 2018 19:33:28 +0100
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
        Tim Chen <tim.c.chen@linux.intel.com>,
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
Subject: [patch V2 00/28] x86/speculation: Remedy the STIBP/IBPB overhead
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thats hopefully the final version of this. Changes since V1:

  - Renamed the command line option and related code to spectre_v2_user= as
    suggested by Josh.

  - Thought more about the back to back optimization and finally left the
    IBPB code in switch_mm().

    It still removes the ptrace check for the always IBPB case. That's
    substantial overhead for dubious value now that the default is
    conditional (prctl/seccomp) IBPB.

  - Added two options which allow conditional STIBP and IBPB always mode.

  - Addressed the review comments

Documentation is still work in progress. Thanks Andi for providing the
first draft for it.

Still based on tip.git x86/pti as it has been discussed to remove the
minimal RETPOLINE bandaid from stable kernels as well.

It's avaiable from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/pti


Thanks,

	tglx

8<------------------------

 Documentation/admin-guide/kernel-parameters.txt |   56 ++
 Documentation/userspace-api/spec_ctrl.rst       |    9 
 arch/x86/Kconfig                                |    8 
 arch/x86/include/asm/msr-index.h                |    5 
 arch/x86/include/asm/nospec-branch.h            |   14 
 arch/x86/include/asm/spec-ctrl.h                |   18 
 arch/x86/include/asm/switch_to.h                |    3 
 arch/x86/include/asm/thread_info.h              |   18 
 arch/x86/include/asm/tlbflush.h                 |    8 
 arch/x86/kernel/cpu/bugs.c                      |  520 ++++++++++++++++++------
 arch/x86/kernel/process.c                       |   79 ++-
 arch/x86/kernel/process.h                       |   39 +
 arch/x86/kernel/process_32.c                    |   10 
 arch/x86/kernel/process_64.c                    |   10 
 arch/x86/mm/tlb.c                               |  109 +++--
 include/linux/ptrace.h                          |   17 
 include/linux/sched.h                           |    9 
 include/linux/sched/smt.h                       |   20 
 include/uapi/linux/prctl.h                      |    1 
 kernel/cpu.c                                    |   15 
 kernel/ptrace.c                                 |   10 
 kernel/sched/core.c                             |   19 
 kernel/sched/sched.h                            |    4 
 tools/include/uapi/linux/prctl.h                |    1 
 24 files changed, 745 insertions(+), 257 deletions(-)

