Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A30C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E456020671
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E456020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeI2Dxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 23:53:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:46640 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeI2Dxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 23:53:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 14:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="94851232"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2018 14:27:57 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5CE6E300B51; Fri, 28 Sep 2018 14:27:57 -0700 (PDT)
Date:   Fri, 28 Sep 2018 14:27:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com,
        alexey.budankov@linux.intel.com, Kees Cook <keescook@chromium.org>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
Message-ID: <20180928212757.GE32651@tassilo.jf.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com>
 <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
 <20180928204930.GC32651@tassilo.jf.intel.com>
 <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
 <20180928205907.GD32651@tassilo.jf.intel.com>
 <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:22:37PM +0200, Jann Horn wrote:
> On Fri, Sep 28, 2018 at 10:59 PM Andi Kleen <ak@linux.intel.com> wrote:
> > > > This new file descriptor argument doesn't exist today so it would
> > > > need to create a new system call with more arguments
> > >
> > > Is that true? The first argument is a pointer to a struct that
> > > contains its own size, so it can be expanded without an ABI break. I
> > > don't see any reason why you couldn't cram more stuff in there.
> >
> > You're right we could put the fd into the perf_event, but the following is
> > still true:
> >
> > > > Obviously we would need to keep the old system call around
> > > > for compability, so you would need to worry about this
> > > > interaction in any case!
> 
> <blasphemy>
> Is that true? IIRC if you want to use the perf tools after a kernel
> update, you have to install a new version of perf anyway, no?

Not at all. perf is fully ABI compatible.

Yes Ubuntu/Debian make you do it, but there is no reason for it other
than their ignorance. Other sane distributions don't.

Usually the first step when I'm forced to use one of those machine is to
remove the useless wrapper and call the perf binary directly.

-Andi
