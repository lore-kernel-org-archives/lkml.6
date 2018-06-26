Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50EEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC1A26EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC1A26EAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754318AbeFZRbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:31:38 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36850 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeFZRbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:31:37 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fXroS-0005n2-Cv; Tue, 26 Jun 2018 13:31:32 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        efault@gmx.de, songliubraving@fb.com
Subject: [PATCH v2 0/7] x86,tlb,mm: make lazy TLB mode even lazier
Date:   Tue, 26 Jun 2018 13:31:20 -0400
Message-Id: <20180626173126.12296-1-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song noticed switch_mm_irqs_off taking a lot of CPU time in recent
kernels, using 1.9% of a 48 CPU system during a netperf run. Digging
into the profile, the atomic operations in cpumask_clear_cpu and
cpumask_set_cpu are responsible for about half of that CPU use.

However, the CPUs running netperf are simply switching back and
forth between netperf and the idle task, which does not require any
changes to the mm_cpumask if lazy TLB mode were used.

Additionally, the init_mm cpumask ends up being the most heavily
contended one in the system, for no reason at all.

Making really lazy TLB mode work again on modern kernels, by sending
a shootdown IPI only when page table pages are being unmapped, we get
back some performance.

v2 of the series implements things in the way suggested by Andy
Lutomirski, which is a nice simplification from before.  If patch 3
looks larger, it is because some of the existing code changed
indentation, so it can easily be used by both sides of the if/else
test.


Song's netperf performance results:

w/o patchset:

0.95%  swapper          [kernel.vmlinux]          [k] switch_mm_irqs_off
0.77%  netserver        [kernel.vmlinux]          [k] switch_mm_irqs_off

w/ patchset:

Throughput: 1.74075e+06
0.87%  swapper          [kernel.vmlinux]          [k] switch_mm_irqs_off

With these patches, netserver no longer calls switch_mm_irqs_off,
and the CPU use of enter_lazy_tlb was below the 0.05% threshold of
statistics gathered by Song's scripts.


With a memcache style workload, performance does not change measurably,
but the amount of CPU time used by switch_mm_irqs_off and other parts
of the context switch code do appear to go down in profiles.


I am still working on a patch to also get rid of the continuous
pounding on mm->count during lazy TLB entry and exit, when the same
mm_struct is being used all the time. I do not have that working yet.

Until then, these patches provide a nice performance boost, as well
as a little memory savings by shrinking the size of mm_struct.

