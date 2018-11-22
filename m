Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A33C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C4C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C4C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437665AbeKWCBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:01:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbeKWCBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:01:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D093E31256BE;
        Thu, 22 Nov 2018 15:21:15 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-170.ams2.redhat.com [10.36.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 507F85C21E;
        Thu, 22 Nov 2018 15:21:10 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Rich Felker <dalias@libc.org>
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
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl init and thread creation
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com>
        <20181122143603.GD23599@brightrain.aerifal.cx>
        <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com>
        <87a7m1ywni.fsf@oldenburg.str.redhat.com>
        <20181122151710.GF23599@brightrain.aerifal.cx>
Date:   Thu, 22 Nov 2018 16:21:02 +0100
In-Reply-To: <20181122151710.GF23599@brightrain.aerifal.cx> (Rich Felker's
        message of "Thu, 22 Nov 2018 10:17:10 -0500")
Message-ID: <875zwpyw81.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 22 Nov 2018 15:21:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rich Felker:

> On Thu, Nov 22, 2018 at 04:11:45PM +0100, Florian Weimer wrote:
>> * Mathieu Desnoyers:
>> 
>> > Thoughts ?
>> >
>> >   /* Unregister rseq TLS from kernel. */
>> >   if (has_rseq && __rseq_unregister_current_thread ())
>> >     abort();
>> >
>> >   advise_stack_range (pd->stackblock, pd->stackblock_size, (uintptr_t) pd,
>> >                       pd->guardsize);
>> >
>> >   /* If the thread is detached free the TCB.  */
>> >   if (IS_DETACHED (pd))
>> >     /* Free the TCB.  */
>> >     __free_tcb (pd);
>> 
>> Considering that we proceed to free the TCB, I really hope that all
>> signals are blocked at this point.  (I have not checked this, though.)
>> 
>> Wouldn't this address your concern about access to the rseq area?
>
> I'm not familiar with glibc's logic here, but for other reasons, I
> don't think freeing it is safe until the kernel task exit futex (set
> via clone or set_tid_address) has fired. I would guess __free_tcb just
> sets up for it to be reclaimable when this happens rather than
> immediately freeing it for reuse.

Right, but in case of user-supplied stacks, we actually free TLS memory
at this point, so signals need to be blocked because the TCB is
(partially) gone after that.

Thanks,
Florian
