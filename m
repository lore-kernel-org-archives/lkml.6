Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA69C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817122146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817122146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeISEVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:21:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59078 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeISEVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:21:47 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2Oli-0005c2-Uu; Wed, 19 Sep 2018 00:46:55 +0200
Date:   Wed, 19 Sep 2018 00:46:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
In-Reply-To: <863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net>
Message-ID: <alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de> <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com> <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
 <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de> <863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1153053927-1537310814=:1468"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1153053927-1537310814=:1468
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 18 Sep 2018, Andy Lutomirski wrote:
> > On Sep 18, 2018, at 12:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> >> On Mon, 17 Sep 2018, John Stultz wrote:
> >>> On Mon, Sep 17, 2018 at 12:25 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >>> Also, I'm not entirely convinced that this "last" thing is needed at
> >>> all.  John, what's the scenario under which we need it?
> >> 
> >> So my memory is probably a bit foggy, but I recall that as we
> >> accelerated gettimeofday, we found that even on systems that claimed
> >> to have synced TSCs, they were actually just slightly out of sync.
> >> Enough that right after cycles_last had been updated, a read on
> >> another cpu could come in just behind cycles_last, resulting in a
> >> negative interval causing lots of havoc.
> >> 
> >> So the sanity check is needed to avoid that case.
> > 
> > Your memory serves you right. That's indeed observable on CPUs which
> > lack TSC_ADJUST.
> > 
> > @Andy: Welcome to the wonderful world of TSC.
> > 
> 
> Do we do better if we use signed arithmetic for the whole calculation?
> Then a small backwards movement would result in a small backwards result.
> Or we could offset everything so that we’d have to go back several
> hundred ms before we cross zero.

That would be probably the better solution as signed math would be
problematic when the resulting ns value becomes negative. As the delta is
really small, otherwise the TSC sync check would have caught it, the caller
should never be able to observe time going backwards.

I'll have a look into that. It needs some thought vs. the fractional part
of the base time, but it should be not rocket science to get that
correct. Famous last words...

Thanks,

	tglx



--8323329-1153053927-1537310814=:1468--
