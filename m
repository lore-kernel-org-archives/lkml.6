Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49598C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F0220663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F0220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeKZSEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:04:06 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53638 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKZSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:04:06 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gRB2c-0001oW-97; Mon, 26 Nov 2018 08:10:46 +0100
Date:   Mon, 26 Nov 2018 08:10:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 21/28] x86/speculation: Prepare for conditional IBPB
 in switch_mm()
In-Reply-To: <92833780-41BE-446E-A676-925BA1EC93D9@amacapital.net>
Message-ID: <alpine.DEB.2.21.1811260751030.1684@nanos.tec.linutronix.de>
References: <20181125183328.318175777@linutronix.de> <20181125185005.466447057@linutronix.de> <20181125205330.GO13936@tassilo.jf.intel.com> <alpine.DEB.2.21.1811252316560.1684@nanos.tec.linutronix.de> <92833780-41BE-446E-A676-925BA1EC93D9@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1385769263-1543216246=:1684"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1385769263-1543216246=:1684
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 25 Nov 2018, Andy Lutomirski wrote:
> > On Nov 25, 2018, at 2:20 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Sun, 25 Nov 2018, Andi Kleen wrote:
> > 
> >>> The current check whether two tasks belong to the same context is using the
> >>> tasks context id. While correct, it's simpler to use the mm pointer because
> >>> it allows to mangle the TIF_SPEC_IB bit into it. The context id based
> >>> mechanism requires extra storage, which creates worse code.
> >> 
> >> [We tried similar in some really early versions, but it was replaced
> >> with the context id later.]
> >> 
> >> One issue with using the pointer is that the pointer can be reused
> >> when the original mm_struct is freed, and then gets reallocated
> >> immediately to an attacker. Then the attacker may avoid the IBPB.
> >> 
> >> Given it's probably hard to generate any reasonable leak bandwidth with
> >> such a complex scenario, but it still seemed better to close the hole.
> > 
> > Sorry, but that's really a purely academic exercise. 
> 
> I would guess that it’s actually very easy to force mm_struct* reuse.
> Don’t the various allocators try to allocate hot memory?  There’s nothing
> hotter than a just-freed allocation of the same size.

Sure, but this is about a indirect branch predictor attack against
something which reuses the mm.

So you'd need to pull off:

   P1 poisons branch predictor
   P1 exit

   P2 starts and resuses mm(P1) and uses the poisoned branch predictor

the only thing between P1 and P2 is either idle or some other kernel
thread, but no other user task. If that happens then the code would not
issue IBPB as it assumes to switch back to the same process.

Even if you can pull that off the speculation would hit the startup code of
P2, which is truly a source of secret information. Creating a valuable
attack based on mm reuse is really less proabable than a lottery jackpot.

So using mm is really good enough and results in better assembly code which
is surely more valuable than addressing some hypothetical hole.

Thanks,

	tglx
--8323329-1385769263-1543216246=:1684--
