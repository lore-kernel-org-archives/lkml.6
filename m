Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70094C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3540520831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3540520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeKUEbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:31:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeKUEbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:31:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAKHxGXr3060315
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 09:59:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAKHxAtE3060293;
        Tue, 20 Nov 2018 09:59:10 -0800
Date:   Tue, 20 Nov 2018 09:59:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-2a5bf23d5b795d5df33dc284e8f5cf8b6a5b4042@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
        mingo@kernel.org, torvalds@linux-foundation.org,
        eranian@google.com, linux-kernel@vger.kernel.org,
        robert@ocallahan.org, kan.liang@linux.intel.com, acme@redhat.com,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        jolsa@redhat.com, me@kylehuey.com
Reply-To: hpa@zytor.com, peterz@infradead.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, robert@ocallahan.org,
          kan.liang@linux.intel.com, jolsa@redhat.com, me@kylehuey.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          eranian@google.com, vincent.weaver@maine.edu,
          alexander.shishkin@linux.intel.com, mingo@kernel.org
In-Reply-To: <20181120170842.GZ2131@hirez.programming.kicks-ass.net>
References: <20181120170842.GZ2131@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Fix regression by default
 disabling perfmon v4 interrupt handling
Git-Commit-ID: 2a5bf23d5b795d5df33dc284e8f5cf8b6a5b4042
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

Commit-ID:  2a5bf23d5b795d5df33dc284e8f5cf8b6a5b4042
Gitweb:     https://git.kernel.org/tip/2a5bf23d5b795d5df33dc284e8f5cf8b6a5b4042
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 20 Nov 2018 18:08:42 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Nov 2018 18:57:48 +0100

perf/x86/intel: Fix regression by default disabling perfmon v4 interrupt handling

Kyle Huey reported that 'rr', a replay debugger, broke due to the following commit:

  af3bdb991a5c ("perf/x86/intel: Add a separate Arch Perfmon v4 PMI handler")

Rework the 'disable_counter_freezing' __setup() parameter such that we
can explicitly enable/disable it and switch to default disabled.

To this purpose, rename the parameter to "perf_v4_pmi=" which is a much
better description and allows requiring a bool argument.

[ mingo: Improved the changelog some more. ]

Reported-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert O'Callahan <robert@ocallahan.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Link: http://lkml.kernel.org/r/20181120170842.GZ2131@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 ++-
 arch/x86/events/intel/core.c                    | 12 ++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a74728..5463d5a4d85c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -856,7 +856,8 @@
 			causing system reset or hang due to sending
 			INIT from AP to BSP.
 
-	disable_counter_freezing [HW]
+	perf_v4_pmi=	[X86,INTEL]
+			Format: <bool>
 			Disable Intel PMU counter freezing feature.
 			The feature only exists starting from
 			Arch Perfmon v4 (Skylake and newer).
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 273c62e81546..af8bea9d4006 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2306,14 +2306,18 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	return handled;
 }
 
-static bool disable_counter_freezing;
+static bool disable_counter_freezing = true;
 static int __init intel_perf_counter_freezing_setup(char *s)
 {
-	disable_counter_freezing = true;
-	pr_info("Intel PMU Counter freezing feature disabled\n");
+	bool res;
+
+	if (kstrtobool(s, &res))
+		return -EINVAL;
+
+	disable_counter_freezing = !res;
 	return 1;
 }
-__setup("disable_counter_freezing", intel_perf_counter_freezing_setup);
+__setup("perf_v4_pmi=", intel_perf_counter_freezing_setup);
 
 /*
  * Simplified handler for Arch Perfmon v4:
