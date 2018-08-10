Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD8C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4560223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 22:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4560223E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeHKBTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbeHKBTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:19:35 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC73223C6;
        Fri, 10 Aug 2018 22:47:42 +0000 (UTC)
Date:   Fri, 10 Aug 2018 18:47:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Warning splat on x86_32 during perf stress
Message-ID: <20180810184740.5f8ca46d@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I sometimes trigger this splat in my tests (which cause them to fail),
but it's not always hit. Note, this is on x86_32 arch.

------------[ cut here ]------------
IRQs not enabled as expected
WARNING: CPU: 0 PID: 0 at /work/build/trace/nobackup/linux-test.git/kernel/time/tick-sched.c:982 tick_nohz_idle_enter+0x44/0x8c
Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 crc_ccitt r8169 ppdev parport_pc parport
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc6-test+ #3
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
EIP: tick_nohz_idle_enter+0x44/0x8c
Code: e8 05 00 00 00 75 26 83 b8 bc 05 00 00 00 75 1d 80 3d 81 f7 3c c1 00 75 14 68 d6 82 11 c1 c6 05 81 f7 3c c1 01 e8 63 fb f8 ff <0f> 0b 58 fa bb 60 76 65 c1 e8 0d 04 04 00 64 03 1d 28 c1 50 c1 8b
EAX: 0000001c EBX: c14803a0 ECX: 00000006 EDX: 00000007
perf: interrupt took too long (12533 > 12527), lowering kernel.perf_event_max_sample_rate to 15000
ESI: c12b8d00 EDI: 01470000 EBP: c12a5f30 ESP: c12a5f28
DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010292
CR0: 80050033 CR2: 080a45b0 CR3: 3075b600 CR4: 001406f0
Call Trace:
 do_idle+0x33/0x1f9
 cpu_startup_entry+0x61/0x63
 rest_init+0xb2/0xb4
 start_kernel+0x3fa/0x410
 i386_start_kernel+0x9a/0x9e
 startup_32_smp+0x164/0x168
irq event stamp: 8712154
hardirqs last  enabled at (8712153): [<c04014f9>] trace_hardirqs_on_thunk+0xc/0x10
hardirqs last disabled at (8712154): [<c0401509>] trace_hardirqs_off_thunk+0xc/0x10
softirqs last  enabled at (8712148): [<c0dc8b60>] __do_softirq+0x258/0x2b8
softirqs last disabled at (8712107): [<c04169a9>] call_on_stack+0x45/0x4b
---[ end trace 7bebbaceab0fedbc ]---

This is where I think my patch:

  http://lkml.kernel.org/r/20180806214107.110626d0@gandalf.local.home

would help. As I don't know if IRQs were really enabled, or if lockdep
was broken.

-- Steve
