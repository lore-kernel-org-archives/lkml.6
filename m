Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2D1C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A776920879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A776920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeI2M5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:57:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeI2M5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:57:36 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g68lh-0001Li-3v; Sat, 29 Sep 2018 08:30:21 +0200
Date:   Sat, 29 Sep 2018 08:30:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Jann Horn <jannh@google.com>, Mark Rutland <mark.rutland@arm.com>,
        tursulin@ursulin.net, kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com,
        alexey.budankov@linux.intel.com, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
In-Reply-To: <20180928205907.GD32651@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1809290821150.1432@nanos.tec.linutronix.de>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com> <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de> <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com> <20180928172340.GA32651@tassilo.jf.intel.com>
 <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com> <20180928204930.GC32651@tassilo.jf.intel.com> <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com> <20180928205907.GD32651@tassilo.jf.intel.com>
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

On Fri, 28 Sep 2018, Andi Kleen wrote:
> > > This new file descriptor argument doesn't exist today so it would
> > > need to create a new system call with more arguments
> > 
> > Is that true? The first argument is a pointer to a struct that
> > contains its own size, so it can be expanded without an ABI break. I
> > don't see any reason why you couldn't cram more stuff in there.
> 
> You're right we could put the fd into the perf_event, but the following is
> still true:
> 
> > > Obviously we would need to keep the old system call around
> > > for compability, so you would need to worry about this
> > > interaction in any case!
> > >
> > > So tying it together doesn't make any sense, because
> > > the problem has to be solved separately anyways.

And why so? You can keep the original functionality around with the
existing restrictions without breaking any existing user space. That
existing functionality does not require new knobs. It stays as is.

So if you want to use the enhanced version with per PMU permissions based
on file descriptors you need a new version of perf. That's nothing new, if
the kernel adds new features to any syscall, then you need new tools, new
libraries etc. The only guarantee the kernel makes is not to break existing
user space, but there is no guarantee that you can utilize new features
with existing userspace.

Thanks,

	tglx
