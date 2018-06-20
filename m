Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11000C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F1C2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F1C2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbeFTT5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:57:04 -0400
Received: from shelob.surriel.com ([96.67.55.147]:51978 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbeFTT5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:57:02 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fVjDr-0002g7-7p; Wed, 20 Jun 2018 15:56:55 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     86@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, dave.hansen@linux.intel.com, efault@gmx.de,
        songliubraving@fb.com, kernel-team@fb.com
Subject: [PATCH 0/7] x86,tlb,mm: make lazy TLB mode even lazier
Date:   Wed, 20 Jun 2018 15:56:45 -0400
Message-Id: <20180620195652.27251-1-riel@surriel.com>
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


Using a memcache style workload on Broadwell systems, these patches
result in about a 0.5% reduction of CPU use on the system. Numbers
on Haswell are inconclusive so far.


Song's netperf performance results:

w/o patchset:

Throughput: 1.74716e+06
perf profile:
+    0.95%  swapper          [kernel.vmlinux]          [k] switch_mm_irqs_off
+    0.82%  netserver        [kernel.vmlinux]          [k] switch_mm_irqs_off

w/ patchset:

Throughput: 1.76911e+06
perf profile:
+    0.81%  swapper          [kernel.vmlinux]          [k] switch_mm_irqs_off

With these patches, netserver no longer calls switch_mm_irqs_off,
and the CPU use of enter_lazy_tlb was below the 0.05% threshold of
statistics gathered by Song's scripts.


I am still working on a patch to also get rid of the continuous
pounding on mm->count during lazy TLB entry and exit, when the same
mm_struct is being used all the time. I do not have that working yet.

Until then, these patches provide a nice performance boost, as well
as a little memory savings by shrinking the size of mm_struct.


