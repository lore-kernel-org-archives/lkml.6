Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC70C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29292086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29292086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbeJLWgi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:36:38 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:49928 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbeJLWgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:36:37 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9CF2KE6027233;
        Fri, 12 Oct 2018 16:02:20 +0100
Date:   Fri, 12 Oct 2018 16:02:19 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
Message-ID: <20181012160219.7d16ef59@alans-desktop>
In-Reply-To: <77F59E25-5244-4CBC-A3CB-DCF863803CD2@amacapital.net>
References: <20181011185458.10186-1-kristen@linux.intel.com>
        <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>
        <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
        <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com>
        <20181012152515.1d816906@alans-desktop>
        <77F59E25-5244-4CBC-A3CB-DCF863803CD2@amacapital.net>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> My understanding is that the standard “breadcrumb” is that a cache line is fetched into L1D, and that the cacheline in question will go into L1D even if it was previously not cached at all. So flushing L1D will cause the timing from a probe to be different, but the breadcrumb is still there, and the attack will still work.

Flush not write back. The L1D is empty (or full of other stuff the way
the prototype I tested did it as x86 lacked a true L1 flushing primitive)
 
> > At best you have a microscopic window to attack it on the SMT pair.  
> 
> So only the extra clever attackers will pull it off. This isn’t all that reassuring.

It's going to be very hard for them to do that. You don't really have the
timing control in userspace to do that sort of thing easily.

At the end of the day it's an additional hardenening not a fix. It's
designed to provide extra protection for the cases we don't know about
until we find them and lfence them. All of this (and all sidechannel of
any kind) is merely about reducing the bandwidth an attacker can achieve.

The idea is that it's cheap enough that it's worth doing.

> Or I would get a fancy new CPU and use UMONITOR and, unless UMONITOR is much cleverer than I suspect it is, the gig is up.  The time window for the attack could be as small as you want, and UMONITOR will catch it.

That would be an interesting line of attack. You would still have to
navigate a fair bit of noise.

Alan
