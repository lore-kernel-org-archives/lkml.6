Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AD3760263
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932150AbeFFDtE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Tue, 5 Jun 2018 23:49:04 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9314 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932089AbeFFDtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 23:49:03 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="40784484"
Subject: Re: [patch 3/8] x86/apic: Provide apic_ack_irq()
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>, <stable@vger.kernel.org>
References: <20180604162224.471925894@linutronix.de>
 <94117bd8-352b-1077-e8ae-8722d7ec213f@cn.fujitsu.com>
 <alpine.DEB.2.21.1806051339020.1591@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <de96585f-9b8d-4536-a9d5-32a718e3eb4d@cn.fujitsu.com>
Date: Wed, 6 Jun 2018 11:48:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806051339020.1591@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 8DBF44B41E79.AE35F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

At 06/05/2018 07:41 PM, Thomas Gleixner wrote:
> On Tue, 5 Jun 2018, Dou Liyang wrote:
>>> +{
>>> +	if (unlikely(irqd_is_setaffinity_pending(irqd)))
>>
>> Affinity pending is also judged in
>>
>>> +		irq_move_irq(irqd);
>>
>> If we can remove the if(...) statement here
> 
> That requires to fix all call sites in ia64 and that's why I didn't.  But

I didn't express clearly, I meant remove the if(...) statement from
apic_ack_irq(), it doesn't require to fix the call sites in ia64.

+void apic_ack_irq(struct irq_data *irqd)
+{
+	irq_move_irq(irqd);
+	ack_APIC_irq();
+}

BTW, If apic_ack_irq() can accept _any_ irq_data when hierarchical
irqdomains are enabled[1]? If it is true, If there is a situation in
the original code that we should avoid:

   If the top-level irq_data has the IRQD_SETAFFINITY_PENDING state, but
   non-top-level irq_data state not, when using non-top-level irq_data in
   apic_ack_irq(), we may skip the irq_move_irq() which we should call.

[1] commit 77ed42f18edd("genirq: Prevent crash in irq_move_irq()")

> we can make irq_move_irq() an inline function and have the check in the
> inline.
> 

I don't know why do we need to make irq_move_irq() an inline function.

And, yes, irq_move_irq() has already had the check

         ...
   	if (likely(!irqd_is_setaffinity_pending(idata)))
		return;
         ...

Thanks,
	dou
