Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F87C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AC72084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AC72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeH2Mgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:36:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:6798 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeH2Mgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:36:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 01:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="scan'208";a="228544097"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2018 01:40:48 -0700
Received: from [10.125.252.129] (abudanko-mobl.ccr.corp.intel.com [10.125.252.129])
        by linux.intel.com (Postfix) with ESMTP id BCD545802AD;
        Wed, 29 Aug 2018 01:40:46 -0700 (PDT)
Subject: Re: [PATCH v4 0/2]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <74fbcac7-80af-fcf0-2666-adefca98c271@linux.intel.com>
 <20180828144317.8684910d2b7abc9d6dca70f6@arm.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9fcb59e7-6c26-33ad-172f-1d6b21b28f72@linux.intel.com>
Date:   Wed, 29 Aug 2018 11:40:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828144317.8684910d2b7abc9d6dca70f6@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kim,

On 28.08.2018 22:43, Kim Phillips wrote:
> On Tue, 28 Aug 2018 18:44:57 +0300
> Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
>> Experiment with profiling matrix multiplication code executing 128 
>> threads on Intel Xeon Phi (KNM) with 272 cores, like below,
>> demonstrates data loss metrics value of 98%:
> 
> So I took these two patches for a quick test-drive on intel-pt.

Thanks for testing that out in this scenario! It hasn't been tested yet.

> 
> BEFORE (acme's today's perf/core branch):
> 
> $ sudo perf version
> perf version 4.18.rc7.g55fc647
> $ sudo perf record -e intel_pt//  dd if=/dev/zero of=/dev/null count=100000
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB, 49 MiB) copied, 0.0868081 s, 590 MB/s
> [ perf record: Woken up 21 times to write data ]
> [ perf record: Captured and wrote 41.302 MB perf.data ]
> $ 
> 
> AFTER (== BEFORE + these two patches):
> 
> $ sudo ./perf version
> perf version 4.18.rc7.gbc1c99
> $ sudo perf record -e intel_pt//  dd if=/dev/zero of=/dev/null count=100000
> 100000+0 records in
> 100000+0 records out
> 51200000 bytes (51 MB, 49 MiB) copied, 0.0931142 s, 550 MB/s
> 
> ...and it's still running, minutes afterwards.  Before I kill it,
> here's some strace output:
> 
> nanosleep({tv_sec=0, tv_nsec=500000}, NULL) = 0
> lseek(3, 332556518, SEEK_SET)           = 332556518
> write(3, "D\0\0\0\0\0\10\0", 8)         = 8
> lseek(3, 0, SEEK_CUR)                   = 332556526
> futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> nanosleep({tv_sec=0, tv_nsec=500000}, NULL) = 0
> lseek(3, 332578462, SEEK_SET)           = 332578462
> write(3, "D\0\0\0\0\0\10\0", 8)         = 8
> lseek(3, 0, SEEK_CUR)                   = 332578470
> futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> nanosleep({tv_sec=0, tv_nsec=500000}, NULL) = 0
> lseek(3, 332598822, SEEK_SET)           = 332598822
> write(3, "D\0\0\0\0\0\10\0", 8)         = 8
> lseek(3, 0, SEEK_CUR)                   = 332598830
> futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252c8, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e725200, FUTEX_WAKE_PRIVATE, 1) = 1
> futex(0x7f221e7252cc, FUTEX_WAKE_PRIVATE, 1) = 1
> ^Cstrace: Process 3597 detached
> 
> I can't prove that it's these two patches that create the hang, but
> this does look like a livelock situation...hm, hitting ^C doesn't stop
> it...had to kill -9 it...erm, does 'perf record -e intel_pt// dd...'
> work for you on a more standard machine?:
> 
> $ dmesg | grep Perf
> [    0.044226] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.

Strace patterns look similar to the ones implemented in the patches. 
Let me reproduce and investigate the hang locally.

Thanks,
Alexey

> 
> Thanks,
> 
> Kim
> 
