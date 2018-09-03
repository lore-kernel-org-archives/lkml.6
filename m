Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5302DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180872077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180872077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbeICViX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:38:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeICViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:38:22 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 54B82D10;
        Mon,  3 Sep 2018 17:17:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Menzel <pmenzel+linux-x86@molgen.mpg.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 042/165] perf/x86/amd/ibs: Dont access non-started event
Date:   Mon,  3 Sep 2018 18:55:28 +0200
Message-Id: <20180903165657.250753353@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit d2753e6b4882a637a0e8fb3b9c2e15f33265300e ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/amd/ibs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -579,7 +579,7 @@ static int perf_ibs_handle_irq(struct pe
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


