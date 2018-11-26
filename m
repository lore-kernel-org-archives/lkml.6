Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F529C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD7620672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD7620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeKZRoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:44:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53592 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeKZRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:44:09 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gRAjP-0001Rj-8x; Mon, 26 Nov 2018 07:50:55 +0100
Date:   Mon, 26 Nov 2018 07:50:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
In-Reply-To: <20181126030708.GP13936@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1811260750330.1684@nanos.tec.linutronix.de>
References: <20181125183328.318175777@linutronix.de> <20181125185005.466447057@linutronix.de> <20181125205330.GO13936@tassilo.jf.intel.com> <alpine.DEB.2.21.1811252316560.1684@nanos.tec.linutronix.de> <20181126030708.GP13936@tassilo.jf.intel.com>
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

On Sun, 25 Nov 2018, Andi Kleen wrote:
> On Sun, Nov 25, 2018 at 11:20:50PM +0100, Thomas Gleixner wrote:
> > On Sun, 25 Nov 2018, Andi Kleen wrote:
> > 
> > > > The current check whether two tasks belong to the same context is using the
> > > > tasks context id. While correct, it's simpler to use the mm pointer because
> > > > it allows to mangle the TIF_SPEC_IB bit into it. The context id based
> > > > mechanism requires extra storage, which creates worse code.
> > > 
> > > [We tried similar in some really early versions, but it was replaced
> > > with the context id later.]
> > > 
> > > One issue with using the pointer is that the pointer can be reused
> > > when the original mm_struct is freed, and then gets reallocated
> > > immediately to an attacker. Then the attacker may avoid the IBPB.
> > > 
> > > Given it's probably hard to generate any reasonable leak bandwidth with
> > > such a complex scenario, but it still seemed better to close the hole.
> > 
> > Sorry, but that's really a purely academic exercise. 
> 
> Ok fair enough. I guess it's acceptable if you add a comment explaining it.

Will do.

Thanks,

	tglx
