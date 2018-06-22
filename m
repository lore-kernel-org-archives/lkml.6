Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F27C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3791324519
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3791324519
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934363AbeFVPkB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:40:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42049 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933674AbeFVPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:39:59 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWOA1-0007oK-Ei; Fri, 22 Jun 2018 17:39:41 +0200
Date:   Fri, 22 Jun 2018 17:39:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] x86/fsgsbase/64: Introduce FS/GS base helper
 functions
In-Reply-To: <CALCETrVzLT0AwUFxZGjuREaontqzJe0DEccNFwLTKdLcLxcARA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806221735400.2402@nanos.tec.linutronix.de>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-2-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1806221610500.2402@nanos.tec.linutronix.de>
 <CALCETrVzLT0AwUFxZGjuREaontqzJe0DEccNFwLTKdLcLxcARA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Andy Lutomirski wrote:
> On Fri, Jun 22, 2018 at 7:28 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > +unsigned long read_task_fsbase(struct task_struct *task)
> > > +{
> > > +     unsigned long fsbase;
> > > +
> > > +     if (task == current) {
> > > +             fsbase = read_fsbase();
> > > +     } else {
> > > +             /*
> > > +              * XXX: This will not behave as expected if called
> > > +              * if fsindex != 0. This preserves an existing bug
> > > +              * that will be fixed.
> >
> > I'm late to this party, but let me ask the obvious question:
> >
> >     Why is the existing bug not fixed as the first patch in the series?
> 
> IIRC that was how I did it in the old version of this code.  I think
> it did it because it was less messy to fix the bug after cleaning up
> the code, but I could be remembering wrong.

Fair enough. Though the general rule is: Fix bugs first and then do
features, unless you really need the extra step to fix it proper.

Now in that case the real question is whether this is a bug or just a
slight incorrectness which has no practical impact. If it's the latter,
then introduce the new function which does the right thing first and make
the new fs/gs base functions use it without having a blurb about preserving
bugs.

Thanks,

	tglx



