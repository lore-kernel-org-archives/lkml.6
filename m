Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77224C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383E82089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383E82089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeJBNWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:22:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeJBNWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:22:11 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7EM5-00036k-Ug; Tue, 02 Oct 2018 08:40:26 +0200
Date:   Tue, 2 Oct 2018 08:40:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
cc:     Jann Horn <jannh@google.com>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andi Kleen <ak@linux.intel.com>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
In-Reply-To: <905796f8-4704-66a8-ee0a-ac8aba90b179@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810020832430.32062@nanos.tec.linutronix.de>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com> <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de> <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com> <20180928172340.GA32651@tassilo.jf.intel.com>
 <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com> <20180928204930.GC32651@tassilo.jf.intel.com> <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com> <20180928205907.GD32651@tassilo.jf.intel.com> <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
 <20180928212757.GE32651@tassilo.jf.intel.com> <22155f49-2f57-73b8-6e89-ddd8a127967b@linux.intel.com> <alpine.DEB.2.21.1810011741070.32062@nanos.tec.linutronix.de> <905796f8-4704-66a8-ee0a-ac8aba90b179@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-784198692-1538462425=:32062"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-784198692-1538462425=:32062
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Alexey,

On Mon, 1 Oct 2018, Alexey Budankov wrote:
> > perf_event_open() knows which PMU is associated with the event the caller
> > tries to open. So perf_event_open() can try to access/open the special per
> > PMU file on behalf of the caller. That should get the same security
> > treatment like a regular open() from user space. If that succeeds, access
> > is granted.
> > 
> > The magic file could still be writeable for root to give general
> > restrictions aside of the file based ones similar to what you are
> > proposing.
> 
> Let me wrap up all the requirements and ideas that have been captured so far.
> 
> 1. A file [1] is added so that it can belong to a group of users allowed to use ${PMU}, 
>    something like this:
> 
> ls -alh /sys/bus/event_source/devices/${PMU}/caps/
> total 0
> drwxr-xr-x 2 root root            0 Oct  1 20:36 .
> drwxr-xr-x 6 root root            0 Oct  1 20:36 ..
> -r--r--r-- 1 root root         4.0K Oct  1 20:36 branches
> -r--r--r-- 1 root root         4.0K Oct  1 20:36 max_precise
> -r--r--r-- 1 root root         4.0K Oct  1 20:36 pmu_name
> -rw-r--r--   root ${PMU}_users                   paranoid        <===

Right, though I personaly prefer something like 'access_control' as file
name, but that's bike shed painting realm.

>    Modifications of file content are allowed to those who can 
>    modify /proc/sys/kernel/perf_event_paranoid setting.
> 
> 2. Semantics and content of the introduced paranoid file is 
>    similar to /proc/sys/kernel/perf_even_paranoid [2]:
> 
>    The perf_event_paranoid file can be set to restrict access
>    to the performance counters.
> 
>    2   allow only user-space measurements (default since Linux 4.6).
>    1   allow both kernel and user measurements (default before Linux 4.6).
>    0   allow access to CPU-specific data but not raw trace‐point samples.
>   -1  no restrictions.
>
>    The existence of the perf_event_paranoid file is the official method 
>    for determining if a kernel supports perf_event_open().
> 
> 3. Every time an event for ${PMU} is created over perf_event_open():
>    a) the calling thread's euid is checked to belong to ${PMU}_users group 
>       and if it does then the event's fd is allocated;

Not only the user group, it really should do the full security checks which
are done on open().

>    b) then traditional checks against perf_event_pranoid content are applied;

Hmm, not sure about that because that might be conflicting.

>    c) if the file doesn't exist the access is governed by global setting 
>       at /proc/sys/kernel/perf_even_paranoid;

Correct.

> 4. Documentation/admin-guide/perf-security.rst file is introduced that:

     0) Better documentation of /proc/sys/kernel/perf_even_paranoid

>    a) contains general explanation for fine grained access control;
>    b) contains a section with guidance about scope and risk for each PMU
>       which is enabled for fine grained access control;
>    c) file is extended when more PMUs are enabled for fine grain control;

Thanks,

	tglx
--8323329-784198692-1538462425=:32062--
