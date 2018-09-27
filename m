Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF994C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A330121547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A330121547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeI0U7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:59:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52146 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeI0U7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:59:52 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5XTd-0005NL-EC; Thu, 27 Sep 2018 16:41:13 +0200
Date:   Thu, 27 Sep 2018 16:41:12 +0200 (CEST)
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
In-Reply-To: <alpine.DEB.2.21.1809181731570.7302@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1809271638110.8118@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de> <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com> <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
 <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de> <20180918083055.GJ24106@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1809181050020.4167@nanos.tec.linutronix.de> <alpine.DEB.2.21.1809181204460.4167@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809181237140.4167@nanos.tec.linutronix.de> <20180918124800.GL24106@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1809181515170.6950@nanos.tec.linutronix.de> <alpine.DEB.2.21.1809181731570.7302@nanos.tec.linutronix.de>
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
> > So if the TSC on CPU1 is slightly behind the TSC on CPU0 then now1 can be
> > smaller than cycle_last. The TSC sync stuff does not catch the small delta
> > for unknown raisins. I'll go and find that machine and test that again.
> 
> Of course it does not trigger anymore. We accumulated code between the
> point in timekeeping_advance() where the TSC is read and the update of the
> VDSO data.
> 
> I'll might have to get an 2.6ish kernel booted on that machine and try with
> that again. /me shudders

Actually it does happen, because the TSC is very slowly drifting apart due
to SMI wreckage trying to hide itself. It just takes a very long time.

Thanks,

	tglx


