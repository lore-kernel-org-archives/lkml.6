Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 665E4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD19208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD19208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934999AbeFMJVB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:21:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43850 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934533AbeFMJU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:20:59 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fT1xF-0003zv-OO; Wed, 13 Jun 2018 11:20:37 +0200
Date:   Wed, 13 Jun 2018 11:20:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Julien Thierry <julien.thierry@arm.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Doug Berger <opendmb@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
In-Reply-To: <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
Message-ID: <alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com> <20180613083419.GS12258@hirez.programming.kicks-ass.net>
 <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018, Julien Thierry wrote:
> On 13/06/18 09:34, Peter Zijlstra wrote:
> > On Tue, Jun 12, 2018 at 05:57:23PM -0700, Ricardo Neri wrote:
> > > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > > index 5426627..dbc5e02 100644
> > > --- a/include/linux/interrupt.h
> > > +++ b/include/linux/interrupt.h
> > > @@ -61,6 +61,8 @@
> > >    *                interrupt handler after suspending interrupts. For
> > > system
> > >    *                wakeup devices users need to implement wakeup
> > > detection in
> > >    *                their interrupt handlers.
> > > + * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as
> > > non-maskable, if
> > > + *                supported by the chip.
> > >    */
> > 
> > NAK on the first 6 patches. You really _REALLY_ don't want to expose
> > NMIs to this level.
> > 
> 
> I've been working on something similar on arm64 side, and effectively the one
> thing that might be common to arm64 and intel is the interface to set an
> interrupt as NMI. So I guess it would be nice to agree on the right approach
> for this.
> 
> The way I did it was by introducing a new irq_state and let the irqchip driver
> handle most of the work (if it supports that state):
> 
> https://lkml.org/lkml/2018/5/25/181
>
> This has not been ACKed nor NAKed. So I am just asking whether this is a more
> suitable approach, and if not, is there any suggestions on how to do this?

I really didn't pay attention to that as it's burried in the GIC/ARM series
which is usually Marc's playground.

Adding NMI delivery support at low level architecture irq chip level is
perfectly fine, but the exposure of that needs to be restricted very
much. Adding it to the generic interrupt control interfaces is not going to
happen. That's doomed to begin with and a complete abuse of the interface
as the handler can not ever be used for that.

Thanks,

	tglx
