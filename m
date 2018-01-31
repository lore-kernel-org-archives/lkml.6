Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeAaJPo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:15:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751619AbeAaJPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:15:42 -0500
Date: Wed, 31 Jan 2018 10:15:39 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 0/5] bugs fix for large PEBS mmap read and rdpmc read
Message-ID: <20180131091539.GA3313@krava>
References: <CABPqkBRjQp62ArVZzuH=TRU3mDPkS93D8_cNev6M=eXTCpBLkA@mail.gmail.com>
 <20180130133917.GC29098@krava>
 <6d708c09-52a7-a906-b651-b133a7b4f189@linux.intel.com>
 <20180130150454.GE29098@krava>
 <35090c62-466a-aec8-b1a3-69def959c1c6@linux.intel.com>
 <CABPqkBRWtSsKEM7ycPs0HYSKLsYDmZhr4ztUmMMqsytYamPGsw@mail.gmail.com>
 <24210bcb-0e4b-58fe-bcda-da30019f6e7e@linux.intel.com>
 <20180130185212.GA16806@krava>
 <CABPqkBRp9bDmGECStbAHA5Ja0SjJmDQ2SOceat=qXno707MuAA@mail.gmail.com>
 <20180131035941.GW26209@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131035941.GW26209@tassilo.jf.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 07:59:41PM -0800, Andi Kleen wrote:
> > Still, the part I am missing here, is why asking for
> > PERF_SAMPLE_PERIOD voids large PEBS.
> 
> I think it was disabled together with frequency mode
> (which we could support too, but it's a bit more work)
> 
> But yes PERIOD could probably be allowed.

looks like it's just a matter of adding PERF_SAMPLE_PERIOD
into PEBS_FREERUNNING_FLAGS, we already populate period
in setup_pebs_sample_data

jirka


---
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8e4ea143ed96..78f91ec1056e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -93,7 +93,8 @@ struct amd_nb {
 	PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID | \
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
-	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)
+	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
+	PERF_SAMPLE_PERIOD)
 
 #define PEBS_REGS \
 	(PERF_REG_X86_AX | \
