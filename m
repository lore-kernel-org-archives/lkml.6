Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CBCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EA32150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EA32150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeISTHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:07:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60771 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeISTHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:07:40 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2cXv-0002im-Rx; Wed, 19 Sep 2018 15:29:36 +0200
Date:   Wed, 19 Sep 2018 15:29:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc:     Andy Lutomirski <luto@amacapital.net>,
        John Stultz <john.stultz@linaro.org>,
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
In-Reply-To: <06e91c26-756f-f236-0af2-327e520c3065@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.21.1809191523010.18945@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de> <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com> <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
 <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de> <863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net> <alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de> <06e91c26-756f-f236-0af2-327e520c3065@rasmusvillemoes.dk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1406624157-1537363775=:18945"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1406624157-1537363775=:18945
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 19 Sep 2018, Rasmus Villemoes wrote:
> On 2018-09-19 00:46, Thomas Gleixner wrote:
> > On Tue, 18 Sep 2018, Andy Lutomirski wrote:
> >>>
> >>
> >> Do we do better if we use signed arithmetic for the whole calculation?
> >> Then a small backwards movement would result in a small backwards result.
> >> Or we could offset everything so that we’d have to go back several
> >> hundred ms before we cross zero.
> > 
> > That would be probably the better solution as signed math would be
> > problematic when the resulting ns value becomes negative. As the delta is
> > really small, otherwise the TSC sync check would have caught it, the caller
> > should never be able to observe time going backwards.
> > 
> > I'll have a look into that. It needs some thought vs. the fractional part
> > of the base time, but it should be not rocket science to get that
> > correct. Famous last words...
> 
> Does the sentinel need to be U64_MAX? What if vgetcyc and its minions
> returned gtod->cycle_last-1 (for some value of 1), and the caller just
> does "if ((s64)cycles - (s64)last < 0) return fallback; ns +=
> (cycles-last)* ...". That should just be a "sub ; js ; ". It's an extra
> load of ->cycle_last, but only on the path where we're heading for the
> fallback anyway. The value of 1 can be adjusted so that in the "js"
> path, we could detect and accept an rdtsc_ordered() call that's just a
> few 10s of cycles behind last and treat that as 0 and continue back on
> the normal path. But maybe it's hard to get gcc to generate the expected
> code.

I played around with a lot of variants and GCC generates all kinds of
interesting ASM. And at some point optimizing that math code is not buying
anything because the LFENCE before RDTSC is dominating all of it.

Thanks,

	tglx
--8323329-1406624157-1537363775=:18945--
