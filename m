Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E7AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CAD20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CAD20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030228AbeFRIgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:36:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030200AbeFRIgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:36:10 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 001C6C5C;
        Mon, 18 Jun 2018 08:36:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Jan Glauber <jan.glauber@caviumnetworks.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 146/189] init: fix false positives in W+X checking
Date:   Mon, 18 Jun 2018 10:14:02 +0200
Message-Id: <20180618081215.105095824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeffrey Hugo <jhugo@codeaurora.org>

[ Upstream commit ae646f0b9ca135b87bc73ff606ef996c3029780a ]

load_module() creates W+X mappings via __vmalloc_node_range() (from
layout_and_allocate()->move_module()->module_alloc()) by using
PAGE_KERNEL_EXEC.  These mappings are later cleaned up via
"call_rcu_sched(&freeinit->rcu, do_free_init)" from do_init_module().

This is a problem because call_rcu_sched() queues work, which can be run
after debug_checkwx() is run, resulting in a race condition.  If hit,
the race results in a nasty splat about insecure W+X mappings, which
results in a poor user experience as these are not the mappings that
debug_checkwx() is intended to catch.

This issue is observed on multiple arm64 platforms, and has been
artificially triggered on an x86 platform.

Address the race by flushing the queued work before running the
arch-defined mark_rodata_ro() which then calls debug_checkwx().

Link: http://lkml.kernel.org/r/1525103946-29526-1-git-send-email-jhugo@codeaurora.org
Fixes: e1a58320a38d ("x86/mm: Warn on W^X mappings")
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reported-by: Timur Tabi <timur@codeaurora.org>
Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Laura Abbott <labbott@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/main.c     |    7 +++++++
 kernel/module.c |    5 +++++
 2 files changed, 12 insertions(+)

--- a/init/main.c
+++ b/init/main.c
@@ -974,6 +974,13 @@ __setup("rodata=", set_debug_rodata);
 static void mark_readonly(void)
 {
 	if (rodata_enabled) {
+		/*
+		 * load_module() results in W+X mappings, which are cleaned up
+		 * with call_rcu_sched().  Let's make sure that queued work is
+		 * flushed so that we don't hit false positives looking for
+		 * insecure pages which are W+X.
+		 */
+		rcu_barrier_sched();
 		mark_rodata_ro();
 		rodata_test();
 	} else
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3506,6 +3506,11 @@ static noinline int do_init_module(struc
 	 * walking this with preempt disabled.  In all the failure paths, we
 	 * call synchronize_sched(), but we don't want to slow down the success
 	 * path, so use actual RCU here.
+	 * Note that module_alloc() on most architectures creates W+X page
+	 * mappings which won't be cleaned up until do_free_init() runs.  Any
+	 * code such as mark_rodata_ro() which depends on those mappings to
+	 * be cleaned up needs to sync with the queued work - ie
+	 * rcu_barrier_sched()
 	 */
 	call_rcu_sched(&freeinit->rcu, do_free_init);
 	mutex_unlock(&module_mutex);


