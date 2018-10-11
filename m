Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8122C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD152087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD152087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJLDyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:54:31 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:45406 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbeJLDya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:54:30 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9BKP41V003858;
        Thu, 11 Oct 2018 21:25:04 +0100
Date:   Thu, 11 Oct 2018 21:25:04 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
Message-ID: <20181011212504.012c3ece@alans-desktop>
In-Reply-To: <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com>
References: <20181011185458.10186-1-kristen@linux.intel.com>
        <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ugh.
> 
> What exactly is this trying to protect against?  And how many cycles

Most attacks by speculation rely upon leaving footprints in the L1 cache.
They also almost inevitably resolve non speculatively to errors. If you
look through all the 'yet another potential spectre case' patches people
have found they would have been rendered close to useless by this change.

It's a way to deal with the ones we don't know about, all the ones the
tools won't find and it has pretty much zero cost

(If you are bored strace an entire days desktop session, bang it through
a script or two to extract the number of triggerig error returns and do
the maths...)

> should we expect L1D_FLUSH to take?

More to the point you pretty much never trigger it. Errors are not the
normal path in real code. The original version of this code emptied the
L1 the hard way - and even then it was in the noise for real workloads we
tried.

You can argue that the other thread could be some evil task that
deliberately triggers flushes, but it can already thrash the L1 on
processors that share L1 between threads using perfectly normal memory
instructions.

Alan

