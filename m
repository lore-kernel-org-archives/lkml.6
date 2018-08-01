Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4473EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA76120894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA76120894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbeHAKk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:40:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33372 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbeHAKk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:40:28 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkmuj-00028U-Ap; Wed, 01 Aug 2018 10:55:25 +0200
Date:   Wed, 1 Aug 2018 10:55:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH 6/7] x86/vdso: Add vDSO functions for user wait
 instructions
In-Reply-To: <CALCETrUZdbvo+FPrcKP2vbORAZmeaXvMiGm5r6Hxn+3GkSQTdw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808011050340.2501@nanos.tec.linutronix.de>
References: <1532350557-98388-1-git-send-email-fenghua.yu@intel.com> <1532350557-98388-7-git-send-email-fenghua.yu@intel.com> <2267fbe6-37e8-7063-d48f-1879f31d3258@kernel.org> <alpine.DEB.2.21.1807312220490.1713@nanos.tec.linutronix.de>
 <CALCETrUZdbvo+FPrcKP2vbORAZmeaXvMiGm5r6Hxn+3GkSQTdw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018, Andy Lutomirski wrote:
> On Tue, Jul 31, 2018 at 2:22 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> u64 start = __vdso_read_art_ns();
> >
> > Errm. No. You can't read ART. ART is only used by decives to which it is
> > distributed. You can only read TSC here and convert that to nsecs.
> 
> Bah.
> 
> But my point remains -- I think that the user (non-vDSO) code should
> think in nanoseconds, not TSC ticks.  That we have have a much better
> chance of getting migration right.

Agreed. And we should not create new interfaces for that. We already have
clock_gettime() which is the right thing to use.

> > A possible solution would be to use CLOCK_MOTONIC_RAW which is not affected
> > by NTP/PTP adjustments. But that still has the issue of TSC not being the
> > timekeeping clocksource. Bah, the whole TSC deadline mode sucks. I have no
> > idea what's wrong with simple down counters. They Just Work.
> 
> I think it's not totally crazy to declare UMWAIT on a system with a
> non-TSC clocksource to be unsupported.

Sure, the information is already available in the VDSO gtod data.

Thanks,

	tglx

