Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B7CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF53D20835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF53D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbeHaToC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:44:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52868 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeHaToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:44:02 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvlSM-0007tG-My; Fri, 31 Aug 2018 17:35:30 +0200
Date:   Fri, 31 Aug 2018 17:35:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] x86/mce: Fix set_mce_nospec() to avoid #GP fault
In-Reply-To: <CA+55aFy+R8pw1aX84cGNBNbtDgOMANXqX3+-MxAbLZRnUj=0vg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808311731110.4105@nanos.tec.linutronix.de>
References: <20180830214517.29372-1-tony.luck@intel.com> <CA+55aFxVQqnFVQaCYHbnWnt3kBfVkLWgNvKFkf6qgDWCSDNpEg@mail.gmail.com> <CA+8MBbLKWj0RVM5astYB7_htJZ0203cQ65BWJO_o4=WDWn2kAw@mail.gmail.com>
 <CA+55aFy+R8pw1aX84cGNBNbtDgOMANXqX3+-MxAbLZRnUj=0vg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Linus Torvalds wrote:
> On Thu, Aug 30, 2018 at 6:49 PM Tony Luck <tony.luck@intel.com> wrote:
> >
> > Just checking "do we have a non-canonical address" at the bottom of that
> > call stack and flipping bit 63 back on again seems like a bad idea.
> 
> You could literally do something like
> 
>     /* Make it canonical in case we flipped the high bit */
>     addr = (long)(addr<<1)>>1;
> 
> in the call to clflush and it magically does the right thing.
> 
> Pretty? No. But with a big comment about what is going on and why it's
> done, I think it's prettier than your much bigger patch.
> 
> I dunno. It does strike me as a bit hacky, but I'd rather have a
> *small*  one-liner hack that generates two instructions, than add a
> complex hack that modifies the page tables three times and has a
> serializing instruction in it.
> 
> Both are subtle fixes for a subtle issue, but one seems pretty
> harmless in comparison.
> 
> Hmm?
> 
> But I'll bow to the x86 maintainers.

The above is fugly, but it has the charm of simplicity and I assume it's
going to be useful for other places as well. With a big fat comment WHY we
are doing it it's not that horrible. We have all the other L1TF places
where we fiddle with bits in non-obvious ways, so having another instance
of magic bit fiddling is not that big of a problem.

Thanks,

	tglx
