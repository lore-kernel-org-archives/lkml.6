Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C22FECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098DB21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098DB21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbeISEvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:51:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59134 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeISEvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:51:44 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g2PEd-00067g-21; Wed, 19 Sep 2018 01:16:47 +0200
Date:   Wed, 19 Sep 2018 01:16:46 +0200 (CEST)
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
In-Reply-To: <439A3E73-E4FF-4D66-800E-5BEE58EDE8F6@amacapital.net>
Message-ID: <alpine.DEB.2.21.1809190112020.1468@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de> <20180914125118.909646643@linutronix.de> <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com> <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
 <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de> <863331ED-B04A-4B94-91A2-D34002C9CCDC@amacapital.net> <alpine.DEB.2.21.1809190037570.1468@nanos.tec.linutronix.de> <439A3E73-E4FF-4D66-800E-5BEE58EDE8F6@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1986204183-1537312607=:1468"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1986204183-1537312607=:1468
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 18 Sep 2018, Andy Lutomirski wrote:
> > On Sep 18, 2018, at 3:46 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Tue, 18 Sep 2018, Andy Lutomirski wrote:
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
> > 
> 
> It’s also fiddly to tune. If you offset it too much, then the fancy
> divide-by-repeated-subtraction loop will hurt more than the comparison to
> last.

Not really. It's sufficient to offset it by at max. 1000 cycles or so. That
won't hurt the magic loop, but it will definitely cover that slight offset
case.

Thanks,

	tglx


--8323329-1986204183-1537312607=:1468--
