Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A77C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AFA208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AFA208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeJAWul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:50:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58050 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJAWuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:50:40 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g70ni-0007Zo-Rl; Mon, 01 Oct 2018 18:12:03 +0200
Date:   Mon, 1 Oct 2018 18:11:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
cc:     Jann Horn <jannh@google.com>, Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
In-Reply-To: <22155f49-2f57-73b8-6e89-ddd8a127967b@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810011741070.32062@nanos.tec.linutronix.de>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com> <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de> <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com> <20180928172340.GA32651@tassilo.jf.intel.com>
 <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com> <20180928204930.GC32651@tassilo.jf.intel.com> <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com> <20180928205907.GD32651@tassilo.jf.intel.com> <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
 <20180928212757.GE32651@tassilo.jf.intel.com> <22155f49-2f57-73b8-6e89-ddd8a127967b@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey,

On Mon, 1 Oct 2018, Alexey Budankov wrote:
> > On Fri, Sep 28, 2018 at 11:22:37PM +0200, Jann Horn wrote:
> >> <blasphemy>
> >> Is that true? IIRC if you want to use the perf tools after a kernel
> >> update, you have to install a new version of perf anyway, no?
> 
> There are usages in production where perf_event_open() syscall 
> accompanied with read(), mmap() etc. is embedded into application 
> on per-thread basis and is used for self monitoring and dynamic 
> execution tuning.
> 
> There are also other Perf tools around that, for example, are 
> statically linked and then used as on Linux as on Android.
> 
> Backward compatibility does matter in these cases.

Well, it's nothing fundamentally new, that new features require changes to
applications, libraries etc. It's nice if it can be avoided of course.

From a design POV, Jann's idea to have a per PMU special file which you
need to open for getting access is way better than the extra knobs. It
allows to use all existing security mechanisms to be used.

Peter and I discussed that and we came up with the idea that the file
descriptor is not even required, i.e. you could make it backward
compatible.

perf_event_open() knows which PMU is associated with the event the caller
tries to open. So perf_event_open() can try to access/open the special per
PMU file on behalf of the caller. That should get the same security
treatment like a regular open() from user space. If that succeeds, access
is granted.

The magic file could still be writeable for root to give general
restrictions aside of the file based ones similar to what you are
proposing.

The analysis and documentation requirements still remain of course.

Thanks,

	tglx


