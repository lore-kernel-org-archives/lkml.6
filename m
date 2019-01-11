Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB49C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F202084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390727AbfAKURU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:17:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34625 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387847AbfAKURT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:17:19 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gi3Eu-0003av-Eh; Fri, 11 Jan 2019 21:17:12 +0100
Date:   Fri, 11 Jan 2019 21:17:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Drake <drake@endlessm.com>
cc:     suresh.b.siddha@intel.com,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: APIC timer checked before it is set up, boot fails on Connex
 L1430
In-Reply-To: <CAD8Lp468JYCGn6Qbc5720wy3JfO2SwQTD-SQWi4RK_9_dBwtbA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901112054220.1661@nanos.tec.linutronix.de>
References: <CAD8Lp46R2oQxKv5gmC09Zb=WL=nV6o0CGZ3K=JZ80QYm0DJ9QQ@mail.gmail.com> <CAD8Lp468JYCGn6Qbc5720wy3JfO2SwQTD-SQWi4RK_9_dBwtbA@mail.gmail.com>
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

On Mon, 7 Jan 2019, Daniel Drake wrote:
> I asked the motherboard vendor if they have any idea why the 8254 is
> not ticking and they sent me a new BIOS where it is now working. So we
> can probably consider this a non issue, although there are a few other
> curious points to mention:
> 
> 1. Other platforms with the same Intel N3350 SoC use the HPET timer
> instead of PIC during early boot; on this platform there is no HPET
> ACPI table though, so it uses PIT instead.

Right. PIT is the ultimate fallback.

> 2. It does seem a little redundant that the Linux APIC code goes to
> these lengths to check that the legacy 8254 timer interrupt is working
> before it then gets disabled a bit later during boot (when
> setup_APIC_timer happens, the clocksource layer disables the previous
> timer source, in this case the PIT or HPET). Although I can see this
> is not a trivial patch to write.

Well, it'd be trivial if we could rely on the APIC timer being functional
on all CPUs and if we could figure out the APIC timer frequency without
calibrating it against the PIT/HPET on older CPUs. Plus a gazillion of
other issues (e.g. APIC stops in C states ....)

> 3. Windows 10 boots fine with no HPET & no 8254 timer ticks, so if we
> find more platforms that appear in this state, we may want to look for
> how to work around this strange situation on the Linux side.

Under certain conditions we actually might avoid touching PIT/HPET and
solely rely on the CPUID/MSR calibration values. Needs quite some thought
though.

Thanks,

	tglx
