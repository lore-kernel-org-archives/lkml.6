Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A9AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC78A206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC78A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeGTJ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:26:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35846 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeGTJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:26:29 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgQwQ-0002yh-Qg; Fri, 20 Jul 2018 10:39:11 +0200
Date:   Fri, 20 Jul 2018 10:39:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel+linux-x86@molgen.mpg.de>
cc:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: UBSAN: Undefined behaviour in arch/x86/events/amd/ibs.c:582:24:
 member access within null pointer of type 'struct perf_event'
In-Reply-To: <eb1d1d7d-7ca6-677d-2ae5-911935706516@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1807200958390.1580@nanos.tec.linutronix.de>
References: <eb1d1d7d-7ca6-677d-2ae5-911935706516@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Fri, 20 Jul 2018, Paul Menzel wrote:
> Enabling the undefined behavior sanitizer and building GNU/Linux 4.18-rc5+
> (with some unrelated commits) with GCC 8.1.0 from Debian Sid/unstable, the
> warning below is shown.
> 
> > [    2.111913]
> > ================================================================================
> > [    2.111917] UBSAN: Undefined behaviour in
> > arch/x86/events/amd/ibs.c:582:24
> > [    2.111919] member access within null pointer of type 'struct perf_event'
> > [    2.111926] CPU: 0 PID: 144 Comm: udevadm Not tainted
> > 4.18.0-rc5-00316-g4864b68cedf2 #104
> > [    2.111928] Hardware name: ASROCK E350M1/E350M1, BIOS TIMELESS 01/01/1970
> > [    2.111930] Call Trace:
> > [    2.111943]  dump_stack+0x55/0x89
> > [    2.111949]  ubsan_epilogue+0xb/0x33
> > [    2.111953]  handle_null_ptr_deref+0x7f/0x90
> > [    2.111958]  __ubsan_handle_type_mismatch_v1+0x55/0x60
> > [    2.111964]  perf_ibs_handle_irq+0x596/0x620

Right, the code dereferences event before checking the STARTED bit. Patch
below should cure the issue. The warning should not trigger, if I analyzed
the thing correctly. Emphasis on *should*

Thanks,

	tglx

8<--------------------
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
@@ -602,6 +602,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		return 0;
 	}
 
+	if (WARN_ON_ONCE(!event))
+		goto fail;
+
+	hwc = &event->hw;
 	msr = hwc->config_base;
 	buf = ibs_data.regs;
 	rdmsrl(msr, *buf);


