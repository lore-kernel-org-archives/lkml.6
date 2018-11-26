Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1F5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44A620855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44A620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbeKZTWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:22:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbeKZTWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:22:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 211A32D80B;
        Mon, 26 Nov 2018 08:28:48 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-10.ams2.redhat.com [10.36.117.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AEB931054FAE;
        Mon, 26 Nov 2018 08:28:42 +0000 (UTC)
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
        <20181122171010.GH23599@brightrain.aerifal.cx>
        <871s7cvt1l.fsf@oldenburg.str.redhat.com>
        <20181123142843.GJ23599@brightrain.aerifal.cx>
        <1150466925.11664.1542992720871.JavaMail.zimbra@efficios.com>
        <20181123173019.GK23599@brightrain.aerifal.cx>
        <865273158.11687.1542995541389.JavaMail.zimbra@efficios.com>
        <20181123183558.GM23599@brightrain.aerifal.cx>
        <1758017676.12041.1543007347347.JavaMail.zimbra@efficios.com>
Date:   Mon, 26 Nov 2018 09:28:34 +0100
In-Reply-To: <1758017676.12041.1543007347347.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 23 Nov 2018 16:09:07 -0500
        (EST)")
Message-ID: <87bm6cqm31.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 26 Nov 2018 08:28:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> Using a "weak" symbol in early adopter libraries is important, so they
> can be loaded together into the same process without causing loader
> errors due to many definitions of the same strong symbol.

This is not how ELF dynamic linking works.  If the symbol name is the
same, one definition interposes the others.

You need to ensure that the symbol has the same size everywhere, though.
There are some tricky interactions with symbol versions, too.  (The
interposing libraries must not use symbol versioning.)

Thanks,
Florian
