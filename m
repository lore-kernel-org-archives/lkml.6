Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82C7ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC7720C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC7720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbeIRX2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:28:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:50459 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728403AbeIRX2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:28:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 10:54:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,390,1531810800"; 
   d="scan'208";a="233972493"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.130]) ([10.24.14.130])
  by orsmga004.jf.intel.com with ESMTP; 18 Sep 2018 10:54:28 -0700
Subject: Re: [PATCH V3 2/6] perf/core: Add helper to obtain performance
 counter index
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1536685533.git.reinette.chatre@intel.com>
 <6f93048a74c66a275f8eb6e1298f10552d1e5d95.1536685533.git.reinette.chatre@intel.com>
 <20180917082336.GP24124@hirez.programming.kicks-ass.net>
 <fdb736aa-3c2a-67d3-473f-b5a2a7d2c0e5@intel.com>
 <20180917230758.GA3117@worktop.programming.kicks-ass.net>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <07d81d39-6f78-7a07-099c-883c65b540e6@intel.com>
Date:   Tue, 18 Sep 2018 10:54:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917230758.GA3117@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/17/2018 4:07 PM, Peter Zijlstra wrote:
> On Mon, Sep 17, 2018 at 09:37:14AM -0700, Reinette Chatre wrote:
>> On 9/17/2018 1:23 AM, Peter Zijlstra wrote:
> 
>>> I said arch/x86/include/asm/perf_events.h and call it:
>>> x86_perf_rdpmc_index().
>>>
>>> This function is very much x86 specific.
> 
>> Moving it to arch/x86/include/asm/perf_event.h is not trivial since this
>> file is not familiar with struct perf_event.
> 
> Urgh, right you are. Does it work if you make it a regular function
> instead of an inline? Put the thing in arch/x86/events/core.c or so and
> only an extern decl in asm/perf_event.h.

It works, but checkpatch.pl does not like it very much:
> CHECK: extern prototypes should be avoided in .h files
> #66: FILE: arch/x86/include/asm/perf_event.h:273:
> +extern int x86_perf_rdpmc_index(struct perf_event *event);

Doing this also prevents the availability of a x86_perf_rdpmc_index()
for when !CONFIG_PERF_EVENTS. I do not know if this is of big concern
since CONFIG_PERF_EVENTS is automatically selected by CONFIG_X86 ... but
at the same time there are other function definitions in
arch/x86/include/asm/perf_event.h for when !CONFIG_PERF_EVENTS.

Considering the above, would you like me to continue with the move to
arch/x86/events/core.c? Here is what I understood your suggestion to mean:

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dfb2f7c0d019..3550d800b030 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1033,6 +1033,27 @@ static inline void x86_assign_hw_event(struct
perf_event *event,
        }
 }

+/**
+ * x86_perf_rdpmc_index - Return PMC counter used for event
+ * @event: the perf_event to which the PMC counter was assigned
+ *
+ * The counter assigned to this performance event may change if interrupts
+ * are enabled. This counter should thus never be used while interrupts are
+ * enabled. Before this function is used to obtain the assigned counter the
+ * event should be checked for validity using, for example,
+ * perf_event_read_local(), within the same interrupt disabled section in
+ * which this counter is planned to be used.
+ *
+ * Return: The index of the performance monitoring counter assigned to
+ * @perf_event.
+ */
+int x86_perf_rdpmc_index(struct perf_event *event)
+{
+       lockdep_assert_irqs_disabled();
+
+       return event->hw.event_base_rdpmc;
+}
+
 static inline int match_prev_assignment(struct hw_perf_event *hwc,
                                        struct cpu_hw_events *cpuc,
                                        int i)
diff --git a/arch/x86/include/asm/perf_event.h
b/arch/x86/include/asm/perf_event.h
index 12f54082f4c8..b2cf84c35a6d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -270,6 +270,7 @@ struct perf_guest_switch_msr {
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
+extern int x86_perf_rdpmc_index(struct perf_event *event);
 #else
 static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
 {

Thank you

Reinette
