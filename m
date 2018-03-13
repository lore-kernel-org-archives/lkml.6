Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeCMSfM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:35:12 -0400
Received: from foss.arm.com ([217.140.101.70]:43122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752164AbeCMSfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:35:09 -0400
Subject: Re: [PATCH 0/3] irqchip: GIC kexec/kdump improvement and workarounds
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
References: <20180313172103.24281-1-marc.zyngier@arm.com>
 <20180313175156.gmncij4rnqcdl5ie@lakrids.cambridge.arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <72c7a6d2-a4c4-26b2-2982-c1d1ffb39b81@arm.com>
Date: Tue, 13 Mar 2018 18:35:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313175156.gmncij4rnqcdl5ie@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/18 17:51, Mark Rutland wrote:
> On Tue, Mar 13, 2018 at 05:21:00PM +0000, Marc Zyngier wrote:
>> As kexec and kdump are getting used a bit more intensively, I've been
>> made aware of a number of shortcomings.
>>
>> The main gripe is from folks trying to launch a kdump kernel from
>> within an interrupt handler. If using EOImode==1, things work as
>> expected. If using EOImode==0 (such as in a guest), the secondary
>> kernel hangs as the previous interrupt hasn't been EOI'd, and the
>> active priority is still set. The first two patches are addressing
>> this situation for both GICv2 and GICv3 by reseting the APRs to their
>> default value.
> 
> As a more general thing, if irqchip drivers have state that needs to be
> reset in their init code, can we live all this irqchip reset to the
> crashdump kernel, and kill machine_kexec_mask_interrupts() entirely?

We could, once we know for sure that all the potential irqchips have
been fixed. Or we could just remove it immediately, and see what breaks.

> That would avoid some work (including pointer chasing on potentially
> corrupt memory) in the kernel that crashed, making it more likely that
> we get to the crashkernel intact...

Seems perfectly sensible to me.

	M.
-- 
Jazz is not dead. It just smells funny...
