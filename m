Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1B5C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D463721479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfBBAGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:06:03 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:48692 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfBBAGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:06:00 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id C4F694C0089;
        Sat,  2 Feb 2019 00:05:58 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:05:55 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH v2 0/4] dynamic indirect call promotion
To:     <namit@vmware.com>, <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Message-ID: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
Date:   Sat, 2 Feb 2019 00:05:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24400.005
X-TM-AS-Result: No-6.091000-4.000000-10
X-TMASE-MatchedRID: VNzPqx6+DScoeQN21jrIqc+ayFtEW0uYRvyVHewb0kIJ/KT4ih4XXGb6
        PphVtfZgTj0hqOD5MLCGlU9rqkkwitTgPtgJJv6UGVyS87Wb4lwQtuqs6BbPJ1UnruyX6uBhtVT
        qD1S3H131bYZf9+gtTpTQ9wBLSljZcAcy2KepxYPDg+U1NSmcuSseSAhqf1rRTWbvjlPEa07CQq
        zNo/FDoxhIVR6mjD6sZhYdK+8dWV6P+nsIJdQKDbvfflhkCHgLA5bHoxALwIPgia+iBd8taKM1t
        LS3/RBJswZGVwllZ3Dl7N0S/wu39TNMB9zbshWILUfH1TEwaN0hmbYg1ZcOnlfXgfL55invSPvl
        igyjeAOXO1QwxscUlZkjw6+I2QxRaexB1smPXNaBi3oqrtckynu2dFMkDuUzInzOyTDR1uukJsg
        gsGau7KduP8GQpunyGLcmkMW3aSvcBsi50tRUneOqq4nQjnRgAuQDJRMogRI3DLgNZ/WB31vfOF
        fXaUuQLNsZ5fRaFK+6Avl4+Ny/sHBQEhF4lroXYR6QE8KYfsgfXzVgO0hVqp3oy+p5Iv9s2w2qU
        qKBibcJrgi+8+d75+X7QZUUx2XWpME2Z8cgSfMflhDI6DvVllTcrppXVp3tmyiLZetSf8mZMPCn
        TMzfOiq2rl3dzGQ1l3+bAt/YFVSros/pMRJT/wrAFpXEqlPN9TxyYphcO9Ugk8c77BjYJjZFEgw
        6u+Np
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.091000-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24400.005
X-MDID: 1549065958-Q644Np0lVpha
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces 'dynamic_calls', branch trees of static calls (updated
 at runtime using text patching), to avoid making indirect calls to common
 targets.  The basic mechanism is
    if (func == static_key_1.target)
        call_static_key_1(args);
    else if (func == static_key_2.target)
        call_static_key_2(args);
    /* ... */
    else
        (*func)(args); /* typically leads to a retpoline nowadays */
 with some additional statistics-gathering to allow periodic relearning of
 branch targets.  Creating and calling a dynamic call table are each a single
 line in the consuming code, although they expand to a nontrivial amount of
 data and text in the kernel image.
This is essentially indirect branch prediction, performed in software because
 we can't trust hardware to get it right.  While the processor may speculate
 into the function calls, this is *probably* OK since they are known to be
 functions that frequently get called in this path, and thus are much less
 likely to contain side-channel information leaks than a completely arbitrary
 target PC from a branch target buffer.  Moreover, when the speculation is
 accurate we positively want to be able to speculate into the callee.
The branch target statistics are collected with percpu variables, counting
 both 'hits' on the existing branch targets and 'misses', divided into counts
 for up to four specific targets (first-come-first-served) and a catch-all
 miss count used once that table is full.
When the total number of specific misses on a cpu reaches 1000, work is
 triggered which adds up counts across all CPUs and chooses the two most-
 popular call targets to patch into the call path.
If instead the catch-all miss count reaches 1000, the counts and specific
 targets for that cpu are discarded, since either the target is too
 unpredictable (lots of low-frequency callees rather than a few dominating
 ones) or the targets that populated the table were by chance unpopular ones.
To ensure that the static key target does not change between the if () check
 and the call, the whole dynamic_call must take place in an RCU read-side
 critical section (which, since the callee does not know it is being called in
 this manner, then lasts at least until the callee returns), and the patching
 at re-learning time is done with the help of a static_key to switch callers
 off the dynamic_call path and RCU synchronisation to ensure none are still on
 it.  In cases where RCU cannot be used (e.g. because some callees need to RCU
 synchronise), it might be possible to add a variant that uses
 synchronize_rcu_tasks() when updating, but this series does not attempt this.

The dynamic_calls created by this series are opt-in, partly because of the
 abovementioned rcu_read_lock requirement.

My attempts to measure the performance impact of dynamic_calls have been
 inconclusive; the effects on an RX-side UDP packet rate test were within
 ±1.5% and nowhere near statistical significance (p around 0.2-0.3 with n=6
 in a Welch t-test).  This could mean that dynamic_calls are ineffective,
 but it could also mean that many more sites need converting before any gain
 shows up, or it could just mean that my testing was insufficiently sensitive
 or measuring the wrong thing.  Given these poor results, this series is
 clearly not 'ready', hence the RFC tags, but hopefully it will inform the
 discussion in this area.

As before, this series depends on Josh's "static calls" patch series (v3 this
 time).  My testing was done with out-of-line static calls, since the inline
 implementation lead to crashes; I have not yet determined whether they were
 the fault of my patch or of the static calls series.

Edward Cree (4):
  static_call: add indirect call promotion (dynamic_call) infrastructure
  net: core: use a dynamic_call for pt_prev->func() in RX path
  net: core: use a dynamic_call for dst_input
  net: core: use a dynamic_call for pt_prev->list_func() in list RX path

 include/linux/dynamic_call.h | 300 +++++++++++++++++++++++++++++++++++++++++++
 include/net/dst.h            |   5 +-
 init/Kconfig                 |  11 ++
 kernel/Makefile              |   1 +
 kernel/dynamic_call.c        | 131 +++++++++++++++++++
 net/core/dev.c               |  18 ++-
 net/core/dst.c               |   2 +
 7 files changed, 463 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/dynamic_call.h
 create mode 100644 kernel/dynamic_call.c

