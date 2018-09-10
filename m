Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8A9C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D56F20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D56F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbeIJRd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:33:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:33:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ACdd9F1846821
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 05:39:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ACdd2o1846818;
        Mon, 10 Sep 2018 05:39:39 -0700
Date:   Mon, 10 Sep 2018 05:39:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yabin Cui <tipbot@zytor.com>
Message-ID: <tip-02e184476eff848273826c1d6617bb37e5bcc7ad@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com,
        stable@vger.kernel.org, yabinc@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        acme@kernel.org
Reply-To: acme@kernel.org, mingo@kernel.org, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org, yabinc@google.com, stable@vger.kernel.org,
          hpa@zytor.com, torvalds@linux-foundation.org
In-Reply-To: <20180823225935.27035-1-yabinc@google.com>
References: <20180823225935.27035-1-yabinc@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Force USER_DS when recording user
 stack data
Git-Commit-ID: 02e184476eff848273826c1d6617bb37e5bcc7ad
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

Commit-ID:  02e184476eff848273826c1d6617bb37e5bcc7ad
Gitweb:     https://git.kernel.org/tip/02e184476eff848273826c1d6617bb37e5bcc7ad
Author:     Yabin Cui <yabinc@google.com>
AuthorDate: Thu, 23 Aug 2018 15:59:35 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 14:01:46 +0200

perf/core: Force USER_DS when recording user stack data

Perf can record user stack data in response to a synchronous request, such
as a tracepoint firing. If this happens under set_fs(KERNEL_DS), then we
end up reading user stack data using __copy_from_user_inatomic() under
set_fs(KERNEL_DS). I think this conflicts with the intention of using
set_fs(KERNEL_DS). And it is explicitly forbidden by hardware on ARM64
when both CONFIG_ARM64_UAO and CONFIG_ARM64_PAN are used.

So fix this by forcing USER_DS when recording user stack data.

Signed-off-by: Yabin Cui <yabinc@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 88b0193d9418 ("perf/callchain: Force USER_DS when invoking perf_callchain_user()")
Link: http://lkml.kernel.org/r/20180823225935.27035-1-yabinc@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index abaed4f8bb7f..c80549bf82c6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5943,6 +5943,7 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 		unsigned long sp;
 		unsigned int rem;
 		u64 dyn_size;
+		mm_segment_t fs;
 
 		/*
 		 * We dump:
@@ -5960,7 +5961,10 @@ perf_output_sample_ustack(struct perf_output_handle *handle, u64 dump_size,
 
 		/* Data. */
 		sp = perf_user_stack_pointer(regs);
+		fs = get_fs();
+		set_fs(USER_DS);
 		rem = __output_copy_user(handle, (void *) sp, dump_size);
+		set_fs(fs);
 		dyn_size = dump_size - rem;
 
 		perf_output_skip(handle, rem);
