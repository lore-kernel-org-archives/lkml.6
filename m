Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43304C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE2520685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE2520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437549AbeKWB5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:57:33 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58394 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731345AbeKWB5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:57:32 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gPqj8-0004q2-00; Thu, 22 Nov 2018 15:17:10 +0000
Date:   Thu, 22 Nov 2018 10:17:10 -0500
From:   Rich Felker <dalias@libc.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
Message-ID: <20181122151710.GF23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com>
 <20181122143603.GD23599@brightrain.aerifal.cx>
 <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com>
 <87a7m1ywni.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7m1ywni.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 04:11:45PM +0100, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
> > Thoughts ?
> >
> >   /* Unregister rseq TLS from kernel. */
> >   if (has_rseq && __rseq_unregister_current_thread ())
> >     abort();
> >
> >   advise_stack_range (pd->stackblock, pd->stackblock_size, (uintptr_t) pd,
> >                       pd->guardsize);
> >
> >   /* If the thread is detached free the TCB.  */
> >   if (IS_DETACHED (pd))
> >     /* Free the TCB.  */
> >     __free_tcb (pd);
> 
> Considering that we proceed to free the TCB, I really hope that all
> signals are blocked at this point.  (I have not checked this, though.)
> 
> Wouldn't this address your concern about access to the rseq area?

I'm not familiar with glibc's logic here, but for other reasons, I
don't think freeing it is safe until the kernel task exit futex (set
via clone or set_tid_address) has fired. I would guess __free_tcb just
sets up for it to be reclaimable when this happens rather than
immediately freeing it for reuse.

Rich
