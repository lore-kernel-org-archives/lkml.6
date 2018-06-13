Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 23CA9C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89BB20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89BB20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934963AbeFMI7Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:59:25 -0400
Received: from foss.arm.com ([217.140.101.70]:44440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934436AbeFMI7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:59:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63C3380D;
        Wed, 13 Jun 2018 01:59:22 -0700 (PDT)
Received: from [10.1.207.70] (e112298-lin.cambridge.arm.com [10.1.207.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71F743F557;
        Wed, 13 Jun 2018 01:59:18 -0700 (PDT)
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
To:     Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
Date:   Wed, 13 Jun 2018 09:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613083419.GS12258@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Ricardo,

On 13/06/18 09:34, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 05:57:23PM -0700, Ricardo Neri wrote:
>> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
>> index 5426627..dbc5e02 100644
>> --- a/include/linux/interrupt.h
>> +++ b/include/linux/interrupt.h
>> @@ -61,6 +61,8 @@
>>    *                interrupt handler after suspending interrupts. For system
>>    *                wakeup devices users need to implement wakeup detection in
>>    *                their interrupt handlers.
>> + * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as non-maskable, if
>> + *                supported by the chip.
>>    */
> 
> NAK on the first 6 patches. You really _REALLY_ don't want to expose
> NMIs to this level.
> 

I've been working on something similar on arm64 side, and effectively 
the one thing that might be common to arm64 and intel is the interface 
to set an interrupt as NMI. So I guess it would be nice to agree on the 
right approach for this.

The way I did it was by introducing a new irq_state and let the irqchip 
driver handle most of the work (if it supports that state):

https://lkml.org/lkml/2018/5/25/181

This has not been ACKed nor NAKed. So I am just asking whether this is a 
more suitable approach, and if not, is there any suggestions on how to 
do this?

Thanks,

-- 
Julien Thierry
