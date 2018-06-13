Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EE896C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD4D208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD4D208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935193AbeFMJ5n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:57:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44010 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934279AbeFMJ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:57:41 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fT2Wn-0004SO-UR; Wed, 13 Jun 2018 11:57:22 +0200
Date:   Wed, 13 Jun 2018 11:57:21 +0200 (CEST)
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
In-Reply-To: <344b838e-81e3-97d8-f90d-315fed7879c1@arm.com>
Message-ID: <alpine.DEB.2.21.1806131149410.2280@nanos.tec.linutronix.de>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com> <20180613083419.GS12258@hirez.programming.kicks-ass.net> <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
 <alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de> <344b838e-81e3-97d8-f90d-315fed7879c1@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018, Julien Thierry wrote:
> On 13/06/18 10:20, Thomas Gleixner wrote:
> > Adding NMI delivery support at low level architecture irq chip level is
> > perfectly fine, but the exposure of that needs to be restricted very
> > much. Adding it to the generic interrupt control interfaces is not going to
> > happen. That's doomed to begin with and a complete abuse of the interface
> > as the handler can not ever be used for that.
> > 
> 
> Understood, however the need would be to provide a way for a driver to request
> an interrupt to be delivered as an NMI (if irqchip supports it).

s/driver/specialized code written by people who know what they are doing/

> But from your response this would be out of the question (in the
> interrupt/irq/irqchip definitions).

Adding some magic to the irq chip is fine, because that's where the low
level integration needs to be done, but exposing it through the generic
interrupt subsystem is a NONO for obvious reasons.

> Or somehow the concerned irqchip informs the arch it supports NMI delivery and
> it is up to the interested drivers to query the arch whether NMI delivery is
> supported by the system?

Yes, we need some infrastructure for that, but that needs to be separate
and with very limited exposure.

Thanks,

	tglx


