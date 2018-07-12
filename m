Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50145ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172F6205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172F6205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeGLULp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:11:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45877 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbeGLULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:11:45 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fdhlB-0004mm-Vd; Thu, 12 Jul 2018 22:00:18 +0200
Date:   Thu, 12 Jul 2018 22:00:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [PATCH v2 1/4] x86/split_lock: Enumerate #AC exception for split
 locked access feature
In-Reply-To: <ef07e047-e928-49a8-b08b-cb4c691db16a@intel.com>
Message-ID: <alpine.DEB.2.21.1807122153170.1597@nanos.tec.linutronix.de>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com> <1530282807-66555-2-git-send-email-fenghua.yu@intel.com> <b0267bb2-7d1f-c1d6-cff8-addf358009b3@intel.com> <alpine.DEB.2.21.1806291813570.1595@nanos.tec.linutronix.de>
 <20180704200742.GD7451@localhost.localdomain> <20180710184506.GA37857@romley-ivt3.sc.intel.com> <ea23cde0-f999-0ed8-a3bc-e798511467bd@intel.com> <alpine.DEB.2.21.1807102140050.1588@nanos.tec.linutronix.de> <ef07e047-e928-49a8-b08b-cb4c691db16a@intel.com>
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

On Wed, 11 Jul 2018, Dave Hansen wrote:

> On 07/10/2018 12:47 PM, Thomas Gleixner wrote:
> > And please tell your hardware people that they should stop creating
> > features which are not enumerated in one way or the other. That's just a
> > pain all over the place. Boot code, kernel, virt, tools ....
> 
> Assuming it's too late to get CPUID or MSR enumeration... (I haven't
> given up on this yet, btw)

Given the fact that they can add cpuid bits and msr and msr bits within no
time via ucode, assuming too late is the wrong approach.

As this is not yet existing silicon, the ucode patch space should be more
than sufficient for that. Or is it already reserved for the next
speculation disaster?

Btw, when is this going to be real silicon?

> How about we #define a Linux-defined X86_FEATURE_SPLIT_LOCK_AC (or
> whatever) for now.  When the hardware that has this bit for real shows
> up, we move the #define to the "correct" place, like if it is a part of
> an existing cpufeature leaf.
> 
> We also do a new setcpuid= boot option that behaves like the existing
> clearcpuid=.  That option is used by the obscure, specialized split lock
> detectino users to set the software cpufeature bit.
> 
> That way, we can merged this code *with* CPUID detection, and the only
> thing we have to do in the future is move the X86_FEATURE_SPLIT_LOCK_AC
> define to a better place.
> 
> It might be nice to make the setcpuid= thing use strings instead of
> numbers that _can_ change from kernel-to-kernel, but that's kinda an
> implementation detail.  If we have strings, maybe we can start using
> clearcpuid=pku instead of our endless list of (new) boot parameters like
> nopku, nosmap, nosmep, etc...

I might be persuaded to accept the setcpuid= magic if, and only if the
CPUID leaf and bit is documented upfront and going to stay the same.

If that's not the case we just open the door for the HW folks to ignore
proper enumeration forever.

Thanks,

	tglx


