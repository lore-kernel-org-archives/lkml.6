Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DEDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D36C23F97
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D36C23F97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeFVJaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:30:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40986 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeFVJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:30:38 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWIOm-0002dd-Ee; Fri, 22 Jun 2018 11:30:32 +0200
Date:   Fri, 22 Jun 2018 11:30:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
In-Reply-To: <20180621224203.GA18979@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806221129010.2402@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <20180621193738.GA13636@worktop.programming.kicks-ass.net> <20180621201851.GC114883@romley-ivt3.sc.intel.com> <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
 <20180621220003.GD114883@romley-ivt3.sc.intel.com> <20180621220844.GB2494@hirez.programming.kicks-ass.net> <6fbff2df-96c9-db51-371b-a23d1a84d070@intel.com> <20180621224203.GA18979@romley-ivt3.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018, Fenghua Yu wrote:
> On Thu, Jun 21, 2018 at 03:18:19PM -0700, Dave Hansen wrote:
> > On 06/21/2018 03:08 PM, Peter Zijlstra wrote:
> > > On Thu, Jun 21, 2018 at 03:00:03PM -0700, Fenghua Yu wrote:
> > >> The control knob for kernel is to choose re-executing the faulting
> > >> instruction (default) or kernel panic. Kernel panic may be useful in hard
> > >> real time which has less tolerant to bad performance.
> > > The kernel should never trigger this, ever. Any #AC is a plain bug and
> > > should be fixed. So unconditional WARN+disable is suffient.
> > 
> > It sounds like we need to start with that functionality and then if
> > Fenghua wants to do more, we have add-on patches that can be evaluated
> > by themselves.
> 
> For split lock in kernel, by default, I just do warning, disable feature
> in #AC handler, continue to execute the faulting instruction, and re-enable
> #AC for split lock after a delay. This is the default behavior in the
> current patches.

That default behaviour is broken beyond repair. I'll explain that when
replying to 2/N.

Plus the broken design prevents #AC early usage which is completely wrong
to begin with.

Thanks,

	tglx
