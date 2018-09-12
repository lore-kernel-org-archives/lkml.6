Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B2C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C0D20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C0D20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeILTXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:23:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43983 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeILTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:23:13 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g05xO-0001pR-W6; Wed, 12 Sep 2018 16:17:27 +0200
Date:   Wed, 12 Sep 2018 16:17:26 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/vdso: Handle clock_gettime(CLOCK_TAI) in vDSO
In-Reply-To: <dde36e93-a21b-6223-8ffc-6dd11f687d38@redhat.com>
Message-ID: <alpine.DEB.2.21.1809121616040.9957@nanos.tec.linutronix.de>
References: <20180901015935.CCF0B18E20A9@virtux64.softrans.com.au> <CALCETrU4PzskO9pE6G4EkXNRRX3Mu7Vvjv1P8XgrfRMdgGDZSg@mail.gmail.com> <alpine.DEB.2.21.1809092159440.1402@nanos.tec.linutronix.de> <dde36e93-a21b-6223-8ffc-6dd11f687d38@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Florian Weimer wrote:
> On 09/09/2018 10:05 PM, Thomas Gleixner wrote:
> > See the patch below. It's integrating TAI without slowing down everything
> > and it definitely does not result in indirect calls.
> > 
> > On a HSW it slows down clock_gettime() by ~0.5ns. On a SKL I get a speedup
> > by ~0.5ns. On a AMD Epyc server it's 1.2ns speedup. So it somehow depends
> > on the uarch and I also observed compiler version dependend variations.
> 
> Does this mean glibc can keep using a single vDSO entrypoint, the one we
> have today?

We have no intention to change that.

But we surely could provide separate entry points as an extra to avoid a
bunch of conditionals.

Thanks,

	tglx

