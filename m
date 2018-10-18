Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB7ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A10A2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A10A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeJSA2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:28:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35388 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJSA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:28:36 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gDB8G-0005ZO-Ss; Thu, 18 Oct 2018 18:26:45 +0200
Date:   Thu, 18 Oct 2018 18:26:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
Message-ID: <20181018162644.qqjkzoqn2fleyi2b@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-6-bigeasy@linutronix.de>
 <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com>
 <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-12 11:02:18 [-0700], Andy Lutomirski wrote:
> On Fri, Oct 12, 2018 at 10:54 AM Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
> >
> > On 10/04/2018 07:05 AM, Sebastian Andrzej Siewior wrote:
> > > The PKRU value is not set for kernel threads because they do not have
> > > the ->initialized value set. As a result the kernel thread has a random
> > > PKRU value set which it inherits from the previous task.
> > > It has been suggested by Paolo Bonzini to set it for kernel threads, too
> > > because it might be a fix.
> > > I *think* this is not required because the kernel threads don't copy
> > > data to/from userland and don't have access to any userspace mm in
> > > general.
> > > However there is this use_mm(). If we gain a mm by use_mm() we don't
> > > have a matching PKRU value because those are per thread. It has been
> > > suggested to use 0 as the PKRU value but this would bypass PKRU.
> > >
> > > Set the initial (default) PKRU value for kernel threads.
> >
> > We might want to do this for cleanliness reasons...  Maybe.
> >
> > But this *should* have no practical effects.  Kernel threads have no
> > real 'mm' and no user pages.  They should not have do access to user
> > mappings.  Protection keys *only* apply to user mappings.  Thus,
> > logically, they should never be affected by PKRU values.
> >
> > So I'm kinda missing the point of the patch.
> 
> use_mm().

So. I would drop that patch from queue. Anyone feels different about it?

Sebastian
