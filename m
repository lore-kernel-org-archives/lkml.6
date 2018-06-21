Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A870C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C2C21AA6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C2C21AA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933447AbeFUUiG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:38:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933119AbeFUUiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:38:04 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fW6L3-0004Il-Rp; Thu, 21 Jun 2018 22:37:54 +0200
Date:   Thu, 21 Jun 2018 22:37:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 04/16] x86/split_lock: Use non locked bit set
 instruction in set_cpu_cap
In-Reply-To: <20180621195540.GC13636@worktop.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806212237390.1591@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <1527435965-202085-5-git-send-email-fenghua.yu@intel.com> <20180621195540.GC13636@worktop.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018, Peter Zijlstra wrote:

> On Sun, May 27, 2018 at 08:45:53AM -0700, Fenghua Yu wrote:
> > set_bit() called by set_cpu_cap() is a locked bit set instruction for
> > atomic operation.
> > 
> > Since the c->x86_capability can span two cache lines depending on kernel
> > configuration and building evnironment, the locked bit set instruction may
> > cause #AC exception when #AC exception for split lock is enabled.
> 
> That doesn't make sense. Sure the bitmap may be longer, but depending on
> if the argument is an immediate or not we either use a byte instruction
> (which can never cross a cacheline boundary) or a 'word' aligned BTS.
> And the bitmap really _should_ be 'unsigned long' aligned.
> 
> If it is not aligned, fix that too.
> 
> /me looks at cpuinfo_x86 and finds x86_capability is in fact a __u32
> array.. see that's broken and needs fixing first.

Ditto for the next patch. ...

