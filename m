Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16571C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F0C2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F0C2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeJLWA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:00:26 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:49600 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeJLWA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:00:26 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9CEPFi9025556;
        Fri, 12 Oct 2018 15:25:15 +0100
Date:   Fri, 12 Oct 2018 15:25:15 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
Message-ID: <20181012152515.1d816906@alans-desktop>
In-Reply-To: <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com>
References: <20181011185458.10186-1-kristen@linux.intel.com>
        <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>
        <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
        <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But this really needs to be clarified.  Alan said that a bunch of the
> "yet another Spectre variant" attacks would have been mitigated by
> this patch.  An explanation of *how* would be in order.

Today you have the situation where something creates a speculative
disclosure gadget. So we run around and we try and guess where to fix
them all with lfence. If you miss one then it leaves a trace in the L1D
cache, which is what you measure.

In almost every case we have looked at when you leave a footprint in the
L1D you resolve to an error path so the syscall errors.

In other words every time we fail to find a

                if (foo < limit) {
                        gadget(array[foo]);
 		} else
			return -EINVAL;

we turn that from being an easy to use gadget into something really
tricky because by the time the code flow has gotten back to the caller
the breadcrumbs have been eaten by the L1D flush.

The current process of trying to find them all with smatch and the like
is a game of whack-a-mole that will go on for a long long time. In the
meantime (and until the tools get better) it's nice to have an option
that takes a totally non-hot path (the fast path change is a single test
for >= 0) and provides additional defence in depth.

They are not hot paths: when I started playing with this idea I did
indeed strace my entire desktop for a day. There are couple of other
cases I would add to the pass list (EAGAIN, EWOULDBLOCK)). Tracing
other stuff you see the same - real world workloads simply don't generate
vast spews of erroring syscalls.

Look just how many examples we are still committing like
de916736aaaadddbd6061472969f667b14204aa9
7b6924d94a60c6b8c1279ca003e8744e6cd9e8b1
46feb6b495f7628a6dbf36c4e6d80faf378372d4
55690c07b44a82cc3359ce0c233f4ba7d80ba145


This approach turns the ones we miss into

                if (type > = 

                [speculatively create breadcrumb]

                condition resolves, return -EINVAL

                L1D flush

		No breadcrumbs

At best you have a microscopic window to attack it on the SMT pair.

Alan
