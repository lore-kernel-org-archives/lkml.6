Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A3AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2902320856
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2902320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeH1Xg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:36:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44530 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1Xg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:36:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C01080D;
        Tue, 28 Aug 2018 12:43:18 -0700 (PDT)
Received: from dupont (dupont.austin.arm.com [10.118.16.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7B833F557;
        Tue, 28 Aug 2018 12:43:17 -0700 (PDT)
Date:   Tue, 28 Aug 2018 14:43:17 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-Id: <20180828144317.8684910d2b7abc9d6dca70f6@arm.com>
In-Reply-To: <74fbcac7-80af-fcf0-2666-adefca98c271@linux.intel.com>
References: <74fbcac7-80af-fcf0-2666-adefca98c271@linux.intel.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 18:44:57 +0300
Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

> Experiment with profiling matrix multiplication code executing 128 
> threads on Intel Xeon Phi (KNM) with 272 cores, like below,
> demonstrates data loss metrics value of 98%:

So I took these two patches for a quick test-drive on intel-pt.

BEFORE (acme's today's perf/core branch):

$ sudo perf version
perf version 4.18.rc7.g55fc647
$ sudo perf record -e intel_pt//  dd if=/dev/zero of=/dev/null count=100000
100000+0 records in
100000+0 records out
51200000 bytes (51 MB, 49 MiB) copied, 0.0868081 s, 590 MB/s
[ perf record: Woken up 21 times to write data ]
[ perf record: Captured and wrote 41.302 MB perf.data ]
$ 

AFTER (== BEFORE + these two patches):

$ sudo ./perf version
perf version 4.18.rc7.gbc1c99
$ sudo perf record -e intel_pt//  dd if=/dev/zero of=/dev/null count=100000
100000+0 records in
100000+0 records out
51200000 bytes (51 MB, 49 MiB) copied, 0.0931142 s, 550 MB/s

...and it's still running, minutes afterwards.  Before I kill it,
here's some strace output:

nanosleep({tv_sec=0, tv_nsec=500000}, NULL) = 0
lseek(3, 332556518, SEEK_SET)           = 332556518
write(3, "D\0\0\0\0\0\10\0", 8)         = 8
lseek(3, 0, SEEK_CUR)                   = 332556526
futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
nanosleep({tv_sec=0, tv_nsec=500000}, NULL) = 0
lseek(3, 332578462, SEEK_SET)           = 332578462
write(3, "D\0\0\0\0\0\10\0", 8)         = 8
lseek(3, 0, SEEK_CUR)                   = 332578470
futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
nanosleep({tv_sec=0, tv_nsec=500000}, NULL) = 0
lseek(3, 332598822, SEEK_SET)           = 332598822
write(3, "D\0\0\0\0\0\10\0", 8)         = 8
lseek(3, 0, SEEK_CUR)                   = 332598830
futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
^Cstrace: Process 3597 detached

I can't prove that it's these two patches that create the hang, but
this does look like a livelock situation...hm, hitting ^C doesn't stop
it...had to kill -9 it...erm, does 'perf record -e intel_pt// dd...'
work for you on a more standard machine?:

$ dmesg | grep Perf
[    0.044226] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.

Thanks,

Kim
