Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCEEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEB820672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEB820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410034AbeKXANp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:13:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405583AbeKXANp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:13:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 219713082A20;
        Fri, 23 Nov 2018 13:29:33 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-155.ams2.redhat.com [10.36.117.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2A3518233;
        Fri, 23 Nov 2018 13:29:26 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Rich Felker <dalias@libc.org>, carlos <carlos@redhat.com>,
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
        <20181122151444.GE23599@brightrain.aerifal.cx>
        <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com>
        <87wop5xeit.fsf@oldenburg.str.redhat.com>
        <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com>
        <87k1l5xd33.fsf@oldenburg.str.redhat.com>
        <644835950.10383.1542907783295.JavaMail.zimbra@efficios.com>
Date:   Fri, 23 Nov 2018 14:29:18 +0100
In-Reply-To: <644835950.10383.1542907783295.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 22 Nov 2018 12:29:43 -0500
        (EST)")
Message-ID: <87sgzrvs5t.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 23 Nov 2018 13:29:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

>>>> I don't think you need unregistering if the memory is initial-exec TLS
>>>> memory.  Initial-exec TLS memory is tied directly to the TCB and cannot
>>>> be freed while the thread is running, so it should be safe to put the
>>>> rseq area there even if glibc knows nothing about it.
>>>
>>> Is it true for user-supplied stacks as well ?
>> 
>> I'm not entirely sure because the glibc terminology is confusing, but I
>> think it places intial-exec TLS into the static TLS area (so that it has
>> a fixed offset from the TCB).  The static TLS area is placed on the
>> user-supplied stack.
>
> You said earlier in the email thread that user-supplied stack can be
> reclaimed by __free_tcb () while the thread still runs, am I correct ?
> If so, then we really want to unregister the rseq TLS before that.

No, dynamic TLS can be reclaimed.  Static TLS (which I assume includes
initial-exec TLS) is not deallocated.

> I notice that __free_tcb () calls __deallocate_stack (), which invokes
> _dl_deallocate_tls (). Accessing the TLS from the kernel upon preemption
> would appear fragile after this call.

_dl_deallocate_tls only covers dynamic TLS.

Thanks,
Florian
