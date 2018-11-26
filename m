Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ECAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632C520663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632C520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeK0EF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:05:58 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58616 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0EF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:05:58 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gRKPF-0006H9-00; Mon, 26 Nov 2018 17:10:45 +0000
Date:   Mon, 26 Nov 2018 12:10:45 -0500
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
Message-ID: <20181126171045.GQ23599@brightrain.aerifal.cx>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com>
 <20181123142843.GJ23599@brightrain.aerifal.cx>
 <1150466925.11664.1542992720871.JavaMail.zimbra@efficios.com>
 <20181123173019.GK23599@brightrain.aerifal.cx>
 <865273158.11687.1542995541389.JavaMail.zimbra@efficios.com>
 <20181123183558.GM23599@brightrain.aerifal.cx>
 <1758017676.12041.1543007347347.JavaMail.zimbra@efficios.com>
 <87bm6cqm31.fsf@oldenburg.str.redhat.com>
 <688718071.12798.1543247469553.JavaMail.zimbra@efficios.com>
 <874lc3omh5.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lc3omh5.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 05:03:02PM +0100, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
> > So let's make __rseq_abi and __rseq_refcount strong symbols then ?
> 
> Yes, please.  (But I'm still not sure we need the reference counter.)

The reference counter is needed for out-of-libc implementations
interacting and using the dtor hack. An in-libc implementation doesn't
need to inspect/honor the reference counter, but it does seem to need
to indicate that it has a reference, if you want it to be compatible
with out-of-libc implementations, so that the out-of-libc one will not
unregister the rseq before libc is done with it.

Alternatively another protocol could be chosen for this purpose, but
if has to be something stable and agreed upon, since things would
break badly if libc and the library providing rseq disagreed.

Rich
