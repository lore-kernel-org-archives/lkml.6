Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C801C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4C820879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfAJO1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:27:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36986 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbfAJO1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:27:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 907F01596;
        Thu, 10 Jan 2019 06:27:52 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15D003F5AF;
        Thu, 10 Jan 2019 06:27:50 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     julien.thierry@arm.com, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] perf/core: don't WARN for impossible rb sizes
Date:   Thu, 10 Jan 2019 14:27:45 +0000
Message-Id: <20190110142745.25495-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf tool uses /proc/sys/kernel/perf_event_mlock_kb to determine how
large its ringbuffer mmap should be. This can be configured to arbitrary
values, which can be larger than the maximum possible allocation from
kmalloc.

When this is configured to a suitably large value (e.g. thanks to the
perf fuzzer), attempting to use perf record triggers a WARN_ON_ONCE() in
__alloc_pages_nodemask():

[  337.316688] WARNING: CPU: 2 PID: 5666 at mm/page_alloc.c:4511
__alloc_pages_nodemask+0x3f8/0xbc8
[  337.316694] Modules linked in:
[  337.316704] CPU: 2 PID: 5666 Comm: perf Not tainted 5.0.0-rc1 #2669
[  337.316708] Hardware name: ARM Juno development board (r0) (DT)
[  337.316714] pstate: 20000005 (nzCv daif -PAN -UAO)
[  337.316720] pc : __alloc_pages_nodemask+0x3f8/0xbc8
[  337.316728] lr : alloc_pages_current+0x80/0xe8
[  337.316732] sp : ffff000016eeb9e0
[  337.316736] x29: ffff000016eeb9e0 x28: 0000000000080001
[  337.316744] x27: 0000000000000000 x26: ffff0000111e21f0
[  337.316751] x25: 0000000000000001 x24: 0000000000000000
[  337.316757] x23: 0000000000080001 x22: 0000000000000000
[  337.316762] x21: 0000000000000000 x20: 000000000000000b
[  337.316768] x19: 000000000060c0c0 x18: 0000000000000000
[  337.316773] x17: 0000000000000000 x16: 0000000000000000
[  337.316779] x15: 0000000000000000 x14: 0000000000000000
[  337.316784] x13: 0000000000000000 x12: 0000000000000000
[  337.316789] x11: 0000000000100000 x10: 0000000000000000
[  337.316795] x9 : 0000000010044400 x8 : 0000000080001000
[  337.316800] x7 : 0000000000000000 x6 : ffff800975584700
[  337.316806] x5 : 0000000000000000 x4 : ffff0000111cd6c8
[  337.316811] x3 : 0000000000000000 x2 : 0000000000000000
[  337.316816] x1 : 000000000000000b x0 : 000000000060c0c0
[  337.316822] Call trace:
[  337.316828]  __alloc_pages_nodemask+0x3f8/0xbc8
[  337.316834]  alloc_pages_current+0x80/0xe8
[  337.316841]  kmalloc_order+0x14/0x30
[  337.316848]  __kmalloc+0x1dc/0x240
[  337.316854]  rb_alloc+0x3c/0x170
[  337.316860]  perf_mmap+0x3bc/0x470
[  337.316867]  mmap_region+0x374/0x4f8
[  337.316873]  do_mmap+0x300/0x430
[  337.316878]  vm_mmap_pgoff+0xe4/0x110
[  337.316884]  ksys_mmap_pgoff+0xc0/0x230
[  337.316892]  __arm64_sys_mmap+0x28/0x38
[  337.316899]  el0_svc_common+0xb4/0x118
[  337.316905]  el0_svc_handler+0x2c/0x80
[  337.316910]  el0_svc+0x8/0xc
[  337.316915] ---[ end trace fa29167e20ef0c62 ]---

Let's avoid this by checking that the requested allocation is possible
before calling kzalloc.

Reported-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4a9937076331..309ef5a64af5 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -734,6 +734,9 @@ struct ring_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	size = sizeof(struct ring_buffer);
 	size += nr_pages * sizeof(void *);
 
+	if (order_base_2(size) >= MAX_ORDER)
+		goto fail;
+
 	rb = kzalloc(size, GFP_KERNEL);
 	if (!rb)
 		goto fail;
-- 
2.11.0

