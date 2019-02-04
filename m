Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4EAC282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94D020820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfBDIth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:49:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:49:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148nLaZ357000
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:49:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148nLBr356997;
        Mon, 4 Feb 2019 00:49:21 -0800
Date:   Mon, 4 Feb 2019 00:49:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-9dff0aa95a324e262ffb03f425d00e4751f3294e@git.kernel.org>
Cc:     acme@redhat.com, peterz@infradead.org, namhyung@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, hpa@zytor.com,
        mark.rutland@arm.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, julien.thierry@arm.com,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, jolsa@redhat.com, tglx@linutronix.de,
          namhyung@kernel.org, peterz@infradead.org, acme@redhat.com,
          mingo@kernel.org, mark.rutland@arm.com, julien.thierry@arm.com,
          alexander.shishkin@linux.intel.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          stable@vger.kernel.org
In-Reply-To: <20190110142745.25495-1-mark.rutland@arm.com>
References: <20190110142745.25495-1-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Don't WARN() for impossible ring-buffer
 sizes
Git-Commit-ID: 9dff0aa95a324e262ffb03f425d00e4751f3294e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9dff0aa95a324e262ffb03f425d00e4751f3294e
Gitweb:     https://git.kernel.org/tip/9dff0aa95a324e262ffb03f425d00e4751f3294e
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Thu, 10 Jan 2019 14:27:45 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 08:45:25 +0100

perf/core: Don't WARN() for impossible ring-buffer sizes

The perf tool uses /proc/sys/kernel/perf_event_mlock_kb to determine how
large its ringbuffer mmap should be. This can be configured to arbitrary
values, which can be larger than the maximum possible allocation from
kmalloc.

When this is configured to a suitably large value (e.g. thanks to the
perf fuzzer), attempting to use perf record triggers a WARN_ON_ONCE() in
__alloc_pages_nodemask():

   WARNING: CPU: 2 PID: 5666 at mm/page_alloc.c:4511 __alloc_pages_nodemask+0x3f8/0xbc8

Let's avoid this by checking that the requested allocation is possible
before calling kzalloc.

Reported-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190110142745.25495-1-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
