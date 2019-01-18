Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC4C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F229B20896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfARRRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:17:23 -0500
Received: from foss.arm.com ([217.140.101.70]:35168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbfARRRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:17:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3D1080D;
        Fri, 18 Jan 2019 09:17:22 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03A873F7BE;
        Fri, 18 Jan 2019 09:17:20 -0800 (PST)
Subject: Re: [PATCH v8 09/26] arm64: Unmask PMR before going idle
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        daniel.thompson@linaro.org, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        joel@joelfernandes.org
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-10-git-send-email-julien.thierry@arm.com>
 <20190118162336.GH118707@arrakis.emea.arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <edc99513-3169-7238-f93b-d5ae9e1c8b4c@arm.com>
Date:   Fri, 18 Jan 2019 17:17:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118162336.GH118707@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2019 16:23, Catalin Marinas wrote:
> On Tue, Jan 08, 2019 at 02:07:27PM +0000, Julien Thierry wrote:
>> CPU does not received signals for interrupts with a priority masked by
>> ICC_PMR_EL1. This means the CPU might not come back from a WFI
>> instruction.
>>
>> Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.
>>
>> Since the logic of cpu_do_idle is becoming a bit more complex than just
>> two instructions, lets turn it from ASM to C.
> 
> I haven't checked all the call paths, so asking here: does the core code
> normally call arch_cpu_idle() with IRQs off?
> 

If you look at do_idle() in kernel/sched/idle.c, it does:

	while (!need_resched()) {
		[...]
		local_irq_disable();
		arch_cpu_idle_enter();

		[...]
		} else {
			cpuidle_idle_call();
		}
	}


Then cpuidle_idle_call() will call default_idle_call() (which calls
arch_cpu_idle()) either directly or via the cpuidle driver. My
understanding is that it always does the call with interrupts disabled.

Thanks,

-- 
Julien Thierry
