Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86587C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D07720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D07720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeILTfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:35:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44111 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILTfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:35:06 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g069Q-00025P-Dp; Wed, 12 Sep 2018 16:29:52 +0200
Date:   Wed, 12 Sep 2018 16:29:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
In-Reply-To: <59403142-1073-3926-65dd-ac55ead357b9@redhat.com>
Message-ID: <alpine.DEB.2.21.1809121623430.9957@nanos.tec.linutronix.de>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au> <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com> <alpine.DEB.2.21.1809092159440.1402@nanos.tec.linutronix.de> <dde36e93-a21b-6223-8ffc-6dd11f687d38@redhat.com>
 <alpine.DEB.2.21.1809121616040.9957@nanos.tec.linutronix.de> <59403142-1073-3926-65dd-ac55ead357b9@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Florian Weimer wrote:
> On 09/12/2018 04:17 PM, Thomas Gleixner wrote:
> > On Wed, 12 Sep 2018, Florian Weimer wrote:
> > > Does this mean glibc can keep using a single vDSO entrypoint, the one we
> > > have today?
> > 
> > We have no intention to change that.
> 
> Okay, I was wondering because Andy seemed to have proposed just that.
> 
> > But we surely could provide separate entry points as an extra to avoid a
> > bunch of conditionals.
> 
> We could adjust to that, but the benefit would be long-term because it's an
> ABI change for glibc, and they tend to take a long time to propagate.
> 
> But I must say that clock_gettime is an odd place to start.  I would have
> expected any of the type-polymorphic multiplexer interfaces (fcntl, ioctl,
> ptrace, futex) to be a more natural starting point. 8-)

Well, the starting point of this was to provide clock_tai support in the
vdso. clock_gettime() in the vdso vs. the real syscall is a factor of 10 in
speed. clock_gettime() is a pretty hot function in some workloads.

Andy then noticed that some conditionals could be avoided entirely by using
a different entry point and offered one along with a 10% speedup. We don't
have to go there, we can.

The multiplexer interfaces need much more surgery and talking about futex,
we'd need to sit down with quite some people and identify the things they
actually care about before just splitting it up and keeping the existing
overloaded trainwreck the same.

Thanks,

	tglx



