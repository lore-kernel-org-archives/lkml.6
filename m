Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD8EC67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B59E204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B59E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeLJQE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:04:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:16399 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeLJQE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:04:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 08:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="300931525"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga006.fm.intel.com with ESMTP; 10 Dec 2018 08:04:27 -0800
Date:   Mon, 10 Dec 2018 08:04:27 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] x86/fault: Decode and print #PF oops in human
 readable form
Message-ID: <20181210160427.GA15686@linux.intel.com>
References: <20181207184423.1962-1-sean.j.christopherson@intel.com>
 <20181207195223.23968-1-sean.j.christopherson@intel.com>
 <CAHk-=wgtN9nQBimLuOmBxY8eYqDRhNeBOW_uvnhqtZSFycyHuA@mail.gmail.com>
 <20181207220646.GH10404@linux.intel.com>
 <CAHk-=wizzTem4B3muo+DV5JqPBD0n1JJ8-NDjyY1fn-N4WYHCg@mail.gmail.com>
 <CALCETrUu=qO4tHkk-QxKD_j687hKV56X9JvYv1YsdgtOy0urmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUu=qO4tHkk-QxKD_j687hKV56X9JvYv1YsdgtOy0urmQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 03:57:10PM -0800, Andy Lutomirski wrote:
> On Fri, Dec 7, 2018 at 2:14 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Dec 7, 2018 at 2:06 PM Sean Christopherson
> > <sean.j.christopherson@intel.com> wrote:
> > >
> > > Looking at it again, my own personal preference would be to swap the order
> > > of the #PF lines.
> >
> > Yeah, probably.
> >
> > Also:
> >
> > > [  160.246820] BUG: unable to handle kernel paging request at ffffbeef00000000
> > > [  160.247517] #PF: supervisor-privileged instruction fetch from kernel code
> > > [  160.248085] #PF: error_code(0x0010) - not-present page
> >
> > With this form, I think the "kernel" in the first line is actually
> > misleading. Yes, it's a #PF for the kernel, but then the "kernel" on
> > the second line talks about what mode we were in when it happened, so
> > we have two different meanings of "kernel" on two adjacent lines.
> 
> I'm okay with this variant.  I have a slight preference for:
> 
> #PF: supervisor-privileged instruction fetch from kernel code
> #PF error_code: 0x0010 [READ]

[INSTR], but I get the gist :)

> Which is what we'd get from Sean's patch plus my patch here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/mm&id=ccfb1941f90153818c07fb1a7dc22121a970d252
> 
> Sean, what do you think?

Munging the two concepts is my least favorite approach.  Printing the
individual bits becomes redundant (with the first line) in many cases,
and superfluous in other cases, e.g. [PROT] is effectively implied by
[RSVD], [PK] and [SGX].

In the example above, printing "[INSTR]" doesn't provide any new info
since the line above already states it was an instruction fetch, and
it never provides a human-readable message describing *why* the fault
occurred.

It'd be more palatable if we printed the negative case for PROT, e.g.
"[!PROT]", but that re-opens the discussion on which bits should be
printed in the negative case.  Like Ingo said, it's rather arbitrary
that USER=1 instead of SUPERVISOR=1.

> > So maybe  that "BUG: unable to handle kernel paging request" message
> > should be something like
> >
> >   "BUG: unable to handle page fault for address ffffbeef00000000"
> >
> > instead? Does that make sense to people?
> 
> Yes please.
