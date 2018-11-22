Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A32DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76C920838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76C920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392206AbeKWFnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:43:05 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58466 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbeKWFnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:43:05 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gPuER-0005bl-00; Thu, 22 Nov 2018 19:01:43 +0000
Date:   Thu, 22 Nov 2018 14:01:43 -0500
From:   Rich Felker <dalias@libc.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Florian Weimer <fweimer@redhat.com>, nd <nd@arm.com>,
        carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
Message-ID: <20181122190143.GI23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com>
 <20181122143603.GD23599@brightrain.aerifal.cx>
 <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com>
 <87a7m1ywni.fsf@oldenburg.str.redhat.com>
 <20181122151710.GF23599@brightrain.aerifal.cx>
 <875zwpyw81.fsf@oldenburg.str.redhat.com>
 <1306224240.10055.1542900799576.JavaMail.zimbra@efficios.com>
 <7032ab45-8314-b85d-5b4d-f83b41dab5b6@arm.com>
 <1602745030.10426.1542911744479.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602745030.10426.1542911744479.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:35:44PM -0500, Mathieu Desnoyers wrote:
> ----- On Nov 22, 2018, at 11:24 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
> 
> > On 22/11/18 15:33, Mathieu Desnoyers wrote:
> >> ----- On Nov 22, 2018, at 10:21 AM, Florian Weimer fweimer@redhat.com wrote:
> >>> Right, but in case of user-supplied stacks, we actually free TLS memory
> >>> at this point, so signals need to be blocked because the TCB is
> >>> (partially) gone after that.
> >> 
> >> Unfortuntately, disabling signals is not enough.
> >> 
> >> With rseq registered, the kernel accesses the rseq TLS area when returning to
> >> user-space after _preemption_ of user-space, which can be triggered at any
> >> point by an interrupt or a fault, even if signals are blocked.
> >> 
> >> So if there are cases where the TLS memory is freed while the thread is still
> >> running, we _need_ to explicitly unregister rseq beforehand.
> > 
> > i think the man page should point this out.
> 
> Yes, I should add this to the proposed rseq(2) man page.
> 
> > 
> > the memory of a registered rseq object must not be freed
> > before thread exit. (either unregister it or free later)
> > 
> > and ideally also point out that c language thread storage
> > duration does not provide this guarantee: it may be freed
> > by the implementation before thread exit (which is currently
> > not observable, but with the rseq syscall it is).
> 
> How about the following wording ?
> 
>   Memory of a registered rseq object must not be freed before the
>   thread exits. Reclaim of rseq object's memory must only be
>   done after either an explicit rseq unregistration is performed
>   or after the thread exit. Keep in mind that the implementation
>   of the Thread-Local Storage (C language __thread) lifetime does
>   not guarantee existence of the TLS area up until the thread exits.

This is all really ugly for application/library code to have to deal
with. Maybe if the man page is considered as documenting the syscall
only, and not something you can use, it's okay, but "until the thread
exits" is not well-defined in the sense you want it here. It's more
like "until the kernel task for the thread exits", and the whole point
is that there is some interval in time between the abstract thread
exit and the kernel task exit that is not observable without rseq but
is observable if the rseq is wrongly left installed.

Rich
