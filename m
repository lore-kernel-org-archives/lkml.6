Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09F2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7AA20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895896;
	bh=buwIrzeTtNxuDndP9yFI8r5S4TeNuCDP2K/6GxA0j70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QxUvjdU9oTwIylQHxssYjGhcdaejlIQNwWE4C7mFabxOHAnsVNcfQ5Xj6POLKqrTQ
	 OLBNS0nrP4JlaFjvyKK12T19Ft0KtJ69ZiXYrPlxP0j2m2ClnO1EM7qsGeMBlZHkpp
	 hnuYzFqUoCQ0BXyr5qEnb/1TRKsi2UGU4Tjev47U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfBKOiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbfBKOiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC03222A1;
        Mon, 11 Feb 2019 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895891;
        bh=buwIrzeTtNxuDndP9yFI8r5S4TeNuCDP2K/6GxA0j70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2zU8Lc5QoOFR4RKEpv0UTdd0Yb5iHKtfjelnF+6p2Sx3P+YgEMqWk+oYF/ZoIYCL
         3+cbZaU1LWkmcyMkcoJNSvzoGU0nkjBb7VtlbMRnC4+boh2kUvW/iArcB54sa+F33N
         /KKPXgGEZdel9PFbpH5gCgy4KRkJREzgGQK9gYeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.20 346/352] perf/core: Dont WARN() for impossible ring-buffer sizes
Date:   Mon, 11 Feb 2019 15:19:33 +0100
Message-Id: <20190211141909.196297884@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

commit 9dff0aa95a324e262ffb03f425d00e4751f3294e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/ring_buffer.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -734,6 +734,9 @@ struct ring_buffer *rb_alloc(int nr_page
 	size = sizeof(struct ring_buffer);
 	size += nr_pages * sizeof(void *);
 
+	if (order_base_2(size) >= MAX_ORDER)
+		goto fail;
+
 	rb = kzalloc(size, GFP_KERNEL);
 	if (!rb)
 		goto fail;


