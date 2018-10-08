Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88CFC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8202075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8202075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeJHVip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:38:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:20417 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeJHVip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:38:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 07:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="270504247"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by fmsmga006.fm.intel.com with ESMTP; 08 Oct 2018 07:25:10 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Alharthi\, Mansour A" <mansourah@gatech.edu>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "acme\@kernel.org" <acme@kernel.org>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "adrian.hunter\@intel.com" <adrian.hunter@intel.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: tracing child threads with address filtering using intel_pt in perf
In-Reply-To: <87o9c464gi.fsf@ashishki-desk.ger.corp.intel.com>
References: <8fc78808-db61-2f41-180a-9713178e22f6@gatech.edu> <5267CD8C-A8B1-416E-BCCD-5DD87DCA4FB1@gatech.edu> <87o9c464gi.fsf@ashishki-desk.ger.corp.intel.com>
Date:   Mon, 08 Oct 2018 17:25:09 +0300
Message-ID: <87k1ms5xdm.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> "Alharthi, Mansour A" <mansourah@gatech.edu> writes:
>
>> Hello all,
>
> Hi,
>
>> Assume this test code:
>>
>> thread_start(){
>> ...
>> test();
>> ...
>> }
>>
>> test(){
>> printf("test");
>> }
>>
>> main(){
>> ...
>> pthread_create(......, thread_start,....);
>> }
>
> Can you include the complete test case code?
>
>> Tracing the above program with the following command:
>> perf record -v -m 512,10000 -e intel_pt//u -T --switch-events --filter
>> 'filter * @ ./test' -- ./test
>
> Can you run it with -vvv and also include its output?

Scratch that. Instead, can you try the below patch and see if it works
for you?

Thanks,
--
Alex

From 029a726b63ed6ebef527393704c83dab9c76fb9a Mon Sep 17 00:00:00 2001
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Mon, 8 Oct 2018 17:16:30 +0300
Subject: [PATCH] perf: Copy parent's address filter offsets on clone

When a child event is allocated in the inherit_event() path, the VMA
based filter offsets are not copied from the parent, even though the
address space mapping of the new task remains the same, which leads
to no trace for the new task until exec.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c80549bf82c6..8cecbd61cd90 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1254,6 +1254,7 @@ static void put_ctx(struct perf_event_context *ctx)
  *	      perf_event_context::lock
  *	    perf_event::mmap_mutex
  *	    mmap_sem
+ *	      perf_addr_filters_head::lock
  *
  *    cpu_hotplug_lock
  *      pmus_lock
@@ -10058,6 +10059,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 			goto err_per_task;
 		}
 
+		/*
+		 * Clone the parent's vma offsets: they are valid until exec()
+		 * even if the mm is not shared with the parent.
+		 */
+		if (event->parent) {
+			struct perf_addr_filters_head *ifh = perf_event_addr_filters(event);
+
+			raw_spin_lock_irq(&ifh->lock);
+			memcpy(event->addr_filters_offs,
+			       event->parent->addr_filters_offs,
+			       pmu->nr_addr_filters * sizeof(unsigned long));
+			raw_spin_unlock_irq(&ifh->lock);
+		}
+
 		/* force hw sync on the address filters */
 		event->addr_filters_gen = 1;
 	}
-- 
2.19.0

