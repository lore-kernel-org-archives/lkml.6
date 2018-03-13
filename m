Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeCMRwB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:52:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42510 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751394AbeCMRwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:52:00 -0400
Date: Tue, 13 Mar 2018 17:51:56 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: Re: [PATCH 0/3] irqchip: GIC kexec/kdump improvement and workarounds
Message-ID: <20180313175156.gmncij4rnqcdl5ie@lakrids.cambridge.arm.com>
References: <20180313172103.24281-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313172103.24281-1-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 05:21:00PM +0000, Marc Zyngier wrote:
> As kexec and kdump are getting used a bit more intensively, I've been
> made aware of a number of shortcomings.
> 
> The main gripe is from folks trying to launch a kdump kernel from
> within an interrupt handler. If using EOImode==1, things work as
> expected. If using EOImode==0 (such as in a guest), the secondary
> kernel hangs as the previous interrupt hasn't been EOI'd, and the
> active priority is still set. The first two patches are addressing
> this situation for both GICv2 and GICv3 by reseting the APRs to their
> default value.

As a more general thing, if irqchip drivers have state that needs to be
reset in their init code, can we live all this irqchip reset to the
crashdump kernel, and kill machine_kexec_mask_interrupts() entirely?

That would avoid some work (including pointer chasing on potentially
corrupt memory) in the kernel that crashed, making it more likely that
we get to the crashkernel intact...

Thanks,
Mark
