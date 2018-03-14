Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeCNRLK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:11:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeCNRLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:11:09 -0400
Date: Wed, 14 Mar 2018 18:11:06 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mark Rutland <mark.rutland@arm.com>
cc: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: Re: [PATCH 0/3] irqchip: GIC kexec/kdump improvement and
 workarounds
In-Reply-To: <20180314165708.daoui66waxvicciq@lakrids.cambridge.arm.com>
Message-ID: <alpine.DEB.2.21.1803141808350.2481@nanos.tec.linutronix.de>
References: <20180313172103.24281-1-marc.zyngier@arm.com> <20180313175156.gmncij4rnqcdl5ie@lakrids.cambridge.arm.com> <72c7a6d2-a4c4-26b2-2982-c1d1ffb39b81@arm.com> <20180314165708.daoui66waxvicciq@lakrids.cambridge.arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Mark Rutland wrote:
> On Tue, Mar 13, 2018 at 06:35:07PM +0000, Marc Zyngier wrote:
> > On 13/03/18 17:51, Mark Rutland wrote:
> > > On Tue, Mar 13, 2018 at 05:21:00PM +0000, Marc Zyngier wrote:
> > >> As kexec and kdump are getting used a bit more intensively, I've been
> > >> made aware of a number of shortcomings.
> > >>
> > >> The main gripe is from folks trying to launch a kdump kernel from
> > >> within an interrupt handler. If using EOImode==1, things work as
> > >> expected. If using EOImode==0 (such as in a guest), the secondary
> > >> kernel hangs as the previous interrupt hasn't been EOI'd, and the
> > >> active priority is still set. The first two patches are addressing
> > >> this situation for both GICv2 and GICv3 by reseting the APRs to their
> > >> default value.
> > > 
> > > As a more general thing, if irqchip drivers have state that needs to be
> > > reset in their init code, can we live all this irqchip reset to the
> > > crashdump kernel, and kill machine_kexec_mask_interrupts() entirely?
> > 
> > We could, once we know for sure that all the potential irqchips have
> > been fixed. Or we could just remove it immediately, and see what breaks.
> 
> I would be very tempted to do the latter.

Makes sense. Do we have any indicator that tells us that a particular irq
chip is missing something in the init code or do we have to rely on crash
reports?

Thanks,

	tglx
