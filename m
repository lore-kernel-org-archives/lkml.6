Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D31ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8708020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8708020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbeGXQJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:09:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42169 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388300AbeGXQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:09:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6OF1QXn032119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Jul 2018 08:01:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6OF1Q9U032116;
        Tue, 24 Jul 2018 08:01:26 -0700
Date:   Tue, 24 Jul 2018 08:01:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-d2753e6b4882a637a0e8fb3b9c2e15f33265300e@git.kernel.org>
Cc:     jolsa@redhat.com, vincent.weaver@maine.edu, hpa@zytor.com,
        pmenzel+linux-x86@molgen.mpg.de, linux-kernel@vger.kernel.org,
        pmenzel@molgen.mpg.de, tglx@linutronix.de, eranian@google.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, bp@alien8.de, acme@redhat.com,
        torvalds@linux-foundation.org
Reply-To: acme@redhat.com, torvalds@linux-foundation.org, bp@alien8.de,
          mingo@kernel.org, eranian@google.com, peterz@infradead.org,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          pmenzel@molgen.mpg.de, linux-kernel@vger.kernel.org,
          pmenzel+linux-x86@molgen.mpg.de, vincent.weaver@maine.edu,
          jolsa@redhat.com, hpa@zytor.com
In-Reply-To: <alpine.DEB.2.21.1807200958390.1580@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1807200958390.1580@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/amd/ibs: Don't access non-started event
Git-Commit-ID: d2753e6b4882a637a0e8fb3b9c2e15f33265300e
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

Commit-ID:  d2753e6b4882a637a0e8fb3b9c2e15f33265300e
Gitweb:     https://git.kernel.org/tip/d2753e6b4882a637a0e8fb3b9c2e15f33265300e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Fri, 20 Jul 2018 10:39:07 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 24 Jul 2018 09:51:10 +0200

perf/x86/amd/ibs: Don't access non-started event

Paul Menzel reported the following bug:

> Enabling the undefined behavior sanitizer and building GNU/Linux 4.18-rc5+
> (with some unrelated commits) with GCC 8.1.0 from Debian Sid/unstable, the
> warning below is shown.
>
> > [    2.111913]
> > ================================================================================
> > [    2.111917] UBSAN: Undefined behaviour in arch/x86/events/amd/ibs.c:582:24
> > [    2.111919] member access within null pointer of type 'struct perf_event'
> > [    2.111926] CPU: 0 PID: 144 Comm: udevadm Not tainted 4.18.0-rc5-00316-g4864b68cedf2 #104
> > [    2.111928] Hardware name: ASROCK E350M1/E350M1, BIOS TIMELESS 01/01/1970
> > [    2.111930] Call Trace:
> > [    2.111943]  dump_stack+0x55/0x89
> > [    2.111949]  ubsan_epilogue+0xb/0x33
> > [    2.111953]  handle_null_ptr_deref+0x7f/0x90
> > [    2.111958]  __ubsan_handle_type_mismatch_v1+0x55/0x60
> > [    2.111964]  perf_ibs_handle_irq+0x596/0x620

The code dereferences event before checking the STARTED bit. Patch
below should cure the issue.

The warning should not trigger, if I analyzed the thing correctly.
(And Paul's testing confirms this.)

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Menzel <pmenzel+linux-x86@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/alpine.DEB.2.21.1807200958390.1580@nanos.tec.linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/amd/ibs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 4b98101209a1..d50bb4dc0650 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -579,7 +579,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
 	struct perf_event *event = pcpu->event;
-	struct hw_perf_event *hwc = &event->hw;
+	struct hw_perf_event *hwc;
 	struct perf_sample_data data;
 	struct perf_raw_record raw;
 	struct pt_regs regs;
@@ -602,6 +602,10 @@ fail:
 		return 0;
 	}
 
+	if (WARN_ON_ONCE(!event))
+		goto fail;
+
+	hwc = &event->hw;
 	msr = hwc->config_base;
 	buf = ibs_data.regs;
 	rdmsrl(msr, *buf);
