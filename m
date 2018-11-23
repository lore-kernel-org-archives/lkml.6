Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2825BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69FA20865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69FA20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441057AbeKXErJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:47:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbeKXErJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:47:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B52301555A;
        Fri, 23 Nov 2018 18:01:51 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-155.ams2.redhat.com [10.36.117.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 904335C236;
        Fri, 23 Nov 2018 18:01:46 +0000 (UTC)
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
References: <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com>
        <87wop5xeit.fsf@oldenburg.str.redhat.com>
        <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com>
        <87k1l5xd33.fsf@oldenburg.str.redhat.com>
        <20181122171010.GH23599@brightrain.aerifal.cx>
        <871s7cvt1l.fsf@oldenburg.str.redhat.com>
        <20181123142843.GJ23599@brightrain.aerifal.cx>
        <1150466925.11664.1542992720871.JavaMail.zimbra@efficios.com>
        <20181123173019.GK23599@brightrain.aerifal.cx>
        <87zhtzsngn.fsf@oldenburg.str.redhat.com>
        <20181123174438.GL23599@brightrain.aerifal.cx>
Date:   Fri, 23 Nov 2018 19:01:38 +0100
In-Reply-To: <20181123174438.GL23599@brightrain.aerifal.cx> (Rich Felker's
        message of "Fri, 23 Nov 2018 12:44:38 -0500")
Message-ID: <871s7bsmf1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 23 Nov 2018 18:01:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rich Felker:

> On Fri, Nov 23, 2018 at 06:39:04PM +0100, Florian Weimer wrote:
>> * Rich Felker:
>> 
>> > On Fri, Nov 23, 2018 at 12:05:20PM -0500, Mathieu Desnoyers wrote:
>> >> There has been presumptions about signals being blocked when the thread
>> >> exits throughout this email thread. Out of curiosity, what code is
>> >> responsible for disabling signals in this situation ? Related to this,
>> >> is it valid to access a IE model TLS variable from a signal handler at
>> >> _any_ point where the signal handler nests over thread's execution ?
>> >> This includes early start and just before invoking the exit system call.
>> >
>> > It should be valid to access *any* TLS object like this, but the
>> > standards don't cover it well.
>> 
>> C++ makes it undefined:
>> 
>>   <http://eel.is/c++draft/support.signal#def:evaluation,signal-safe>
>
> C also leaves access to pretty much anything from a signal handler
> undefined, but that makes signals basically useless.

Access to atomic variables of thread storage duration is defined,
though.

Thanks,
Florian
