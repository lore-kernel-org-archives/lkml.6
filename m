Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9BEECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1607221471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1607221471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeIRQOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:14:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57415 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeIRQOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:14:07 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2DSF-0007YN-KN; Tue, 18 Sep 2018 12:42:03 +0200
Date:   Tue, 18 Sep 2018 12:41:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
In-Reply-To: <alpine.DEB.2.21.1809181204460.4167@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1809181237140.4167@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de> <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com> <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
 <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de> <20180918083055.GJ24106@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1809181050020.4167@nanos.tec.linutronix.de> <alpine.DEB.2.21.1809181204460.4167@nanos.tec.linutronix.de>
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

On Tue, 18 Sep 2018, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Thomas Gleixner wrote:
> > On Tue, 18 Sep 2018, Peter Zijlstra wrote:
> > > > Your memory serves you right. That's indeed observable on CPUs which
> > > > lack TSC_ADJUST.
> > > 
> > > But, if the gtod code can observe this, then why doesn't the code that
> > > checks the sync?
> > 
> > Because it depends where the involved CPUs are in the topology. The sync
> > code might just run on the same package an simply not see it. Yes, w/o
> > TSC_ADJUST the TSC sync code can just fail to see the havoc.
> 
> Even with TSC adjust the TSC can be slightly off by design on multi-socket
> systems.

Here are the gory details:

   https://lore.kernel.org/lkml/3c1737210708230408i7a8049a9m5db49e6c4d89ab62@mail.gmail.com/

The changelog has an explanation as well.

    d8bb6f4c1670 ("x86: tsc prevent time going backwards")

I still have one of the machines which is affected by this.

Thanks,

	tglx
