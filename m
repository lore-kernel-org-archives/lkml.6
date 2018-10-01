Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62223C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301F12089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301F12089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJBDcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:32:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:35716 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeJBDcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:32:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 13:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,328,1534834800"; 
   d="scan'208";a="95121450"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2018 13:51:45 -0700
Received: from [10.252.4.61] (abudanko-mobl.ccr.corp.intel.com [10.252.4.61])
        by linux.intel.com (Postfix) with ESMTP id 87A8F580268;
        Mon,  1 Oct 2018 13:51:41 -0700 (PDT)
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Andi Kleen <ak@linux.intel.com>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com>
 <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
 <20180928204930.GC32651@tassilo.jf.intel.com>
 <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
 <20180928205907.GD32651@tassilo.jf.intel.com>
 <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
 <20180928212757.GE32651@tassilo.jf.intel.com>
 <22155f49-2f57-73b8-6e89-ddd8a127967b@linux.intel.com>
 <alpine.DEB.2.21.1810011741070.32062@nanos.tec.linutronix.de>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <905796f8-4704-66a8-ee0a-ac8aba90b179@linux.intel.com>
Date:   Mon, 1 Oct 2018 23:51:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810011741070.32062@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On 01.10.2018 19:11, Thomas Gleixner wrote:

<SNIP>

> Peter and I discussed that and we came up with the idea that the file
> descriptor is not even required, i.e. you could make it backward
> compatible.
> 
> perf_event_open() knows which PMU is associated with the event the caller
> tries to open. So perf_event_open() can try to access/open the special per
> PMU file on behalf of the caller. That should get the same security
> treatment like a regular open() from user space. If that succeeds, access
> is granted.
> 
> The magic file could still be writeable for root to give general
> restrictions aside of the file based ones similar to what you are
> proposing.

Let me wrap up all the requirements and ideas that have been captured so far.

1. A file [1] is added so that it can belong to a group of users allowed to use ${PMU}, 
   something like this:

ls -alh /sys/bus/event_source/devices/${PMU}/caps/
total 0
drwxr-xr-x 2 root root            0 Oct  1 20:36 .
drwxr-xr-x 6 root root            0 Oct  1 20:36 ..
-r--r--r-- 1 root root         4.0K Oct  1 20:36 branches
-r--r--r-- 1 root root         4.0K Oct  1 20:36 max_precise
-r--r--r-- 1 root root         4.0K Oct  1 20:36 pmu_name
-rw-r--r--   root ${PMU}_users                   paranoid        <===

   Modifications of file content are allowed to those who can 
   modify /proc/sys/kernel/perf_event_paranoid setting.

2. Semantics and content of the introduced paranoid file is 
   similar to /proc/sys/kernel/perf_even_paranoid [2]:

   The perf_event_paranoid file can be set to restrict access
   to the performance counters.

   2   allow only user-space measurements (default since Linux 4.6).
   1   allow both kernel and user measurements (default before Linux 4.6).
   0   allow access to CPU-specific data but not raw trace‐point samples.
  -1  no restrictions.

   The existence of the perf_event_paranoid file is the official method 
   for determining if a kernel supports perf_event_open().

3. Every time an event for ${PMU} is created over perf_event_open():
   a) the calling thread's euid is checked to belong to ${PMU}_users group 
      and if it does then the event's fd is allocated;
   b) then traditional checks against perf_event_pranoid content are applied;
   c) if the file doesn't exist the access is governed by global setting 
      at /proc/sys/kernel/perf_even_paranoid;

4. Documentation/admin-guide/perf-security.rst file is introduced that:
   a) contains general explanation for fine grained access control;
   b) contains a section with guidance about scope and risk for each PMU
      which is enabled for fine grained access control;
   c) file is extended when more PMUs are enabled for fine grain control;

> 
> The analysis and documentation requirements still remain of course.

Security analysis for uncore IMC, QPI/UPI, PCIe PMUs is still required 
to be enabled for fine grain control.

Thanks,
Alexey

[1] https://patchwork.kernel.org/patch/9249919/#19714087
[2] http://man7.org/linux/man-pages/man2/perf_event_open.2.html
