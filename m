Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25D2C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A8C20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A8C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeICRFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:05:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbeICRFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:05:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17F71AFFE;
        Mon,  3 Sep 2018 12:45:14 +0000 (UTC)
Date:   Mon, 3 Sep 2018 14:45:13 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v2 0/3] Harden spectrev2 userspace-userspace protection
In-Reply-To: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1809031418260.25787@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ added a few more CCs for v2 ]

Currently, linux kernel is basically not preventing userspace-userspace 
spectrev2 attack, because:

- IBPB is basically unused (issued only for tasks that marked themselves 
  explicitly non-dumpable, which is absolutely negligible minority of all 
  software out there), therefore cross-process branch buffer posioning 
  using spectrev2 is possible

- STIBP is completely unused, therefore cross-process branch buffer 
  poisoning using spectrev2 between processess running on two HT siblings 
  thread s is possible

This patchset changes IBPB semantics, so that it's now applied whenever 
context-switching between processess that can't use ptrace() to achieve 
the same. This admittedly comes with extra overhad on a context switch; 
systems that don't care about could disable the mitigation using 
nospectre_v2 boot option.
The IBPB implementaion is heavily based on original patches by Tim Chen.

In addition to that, we unconditionally turn STIBP on so that HT siblings 
always have separate branch buffers.

We've been carrying IBPB implementation with the same semantics in our 
(SUSE) trees since january disclosure; STIBP was more or less ignored up 
to today.

Jiri Kosina (3):
      ptrace: Provide ___ptrace_may_access() that can be applied on arbitrary tasks
      x86/speculation: Apply IBPB more strictly to avoid cross-process spectre v2 leak
      x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation

 arch/x86/kernel/cpu/bugs.c | 12 ++++++++++++
 arch/x86/mm/tlb.c          | 15 ++++++---------
 include/linux/ptrace.h     | 15 +++++++++++++++
 kernel/ptrace.c            | 17 +++++++++++++----
 4 files changed, 46 insertions(+), 13 deletions(-)

-- 
Jiri Kosina
SUSE Labs

