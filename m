Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A41C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8988F2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8988F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbeIXSkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:40:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeIXSkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:40:36 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ABEF8107F;
        Mon, 24 Sep 2018 12:38:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yabin Cui <yabinc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.18 138/235] perf/core: Force USER_DS when recording user stack data
Date:   Mon, 24 Sep 2018 13:52:04 +0200
Message-Id: <20180924113119.528506819@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yabin Cui <yabinc@google.com>

commit 02e184476eff848273826c1d6617bb37e5bcc7ad upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5948,6 +5948,7 @@ perf_output_sample_ustack(struct perf_ou
 		unsigned long sp;
 		unsigned int rem;
 		u64 dyn_size;
+		mm_segment_t fs;
 
 		/*
 		 * We dump:
@@ -5965,7 +5966,10 @@ perf_output_sample_ustack(struct perf_ou
 
 		/* Data. */
 		sp = perf_user_stack_pointer(regs);
+		fs = get_fs();
+		set_fs(USER_DS);
 		rem = __output_copy_user(handle, (void *) sp, dump_size);
+		set_fs(fs);
 		dyn_size = dump_size - rem;
 
 		perf_output_skip(handle, rem);


