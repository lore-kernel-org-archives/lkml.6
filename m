Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3C1E7C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F5E20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F5E20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934918AbeFMKZZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:25:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45504 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754096AbeFMKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:25:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C38A780D;
        Wed, 13 Jun 2018 03:25:23 -0700 (PDT)
Received: from [10.1.207.70] (e112298-lin.cambridge.arm.com [10.1.207.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDFDB3F25D;
        Wed, 13 Jun 2018 03:25:19 -0700 (PDT)
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613083419.GS12258@hirez.programming.kicks-ass.net>
 <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
 <alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de>
 <344b838e-81e3-97d8-f90d-315fed7879c1@arm.com>
 <alpine.DEB.2.21.1806131149410.2280@nanos.tec.linutronix.de>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <5c52d916-e405-e689-8fa1-d2dfb28ab3fd@arm.com>
Date:   Wed, 13 Jun 2018 11:25:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806131149410.2280@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/06/18 10:57, Thomas Gleixner wrote:
> On Wed, 13 Jun 2018, Julien Thierry wrote:
>> On 13/06/18 10:20, Thomas Gleixner wrote:
>>> Adding NMI delivery support at low level architecture irq chip level is
>>> perfectly fine, but the exposure of that needs to be restricted very
>>> much. Adding it to the generic interrupt control interfaces is not going to
>>> happen. That's doomed to begin with and a complete abuse of the interface
>>> as the handler can not ever be used for that.
>>>
>>
>> Understood, however the need would be to provide a way for a driver to request
>> an interrupt to be delivered as an NMI (if irqchip supports it).
> 
> s/driver/specialized code written by people who know what they are doing/
> 
>> But from your response this would be out of the question (in the
>> interrupt/irq/irqchip definitions).
> 
> Adding some magic to the irq chip is fine, because that's where the low
> level integration needs to be done, but exposing it through the generic
> interrupt subsystem is a NONO for obvious reasons.
> 
>> Or somehow the concerned irqchip informs the arch it supports NMI delivery and
>> it is up to the interested drivers to query the arch whether NMI delivery is
>> supported by the system?
> 
> Yes, we need some infrastructure for that, but that needs to be separate
> and with very limited exposure.
> 

Right, makes sense. I'll check with Marc how such an infrastructure 
should be introduced.

Thanks,

-- 
Julien Thierry
