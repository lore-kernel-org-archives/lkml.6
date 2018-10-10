Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D23C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1C02075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1C02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJJVA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:00:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:52724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726600AbeJJVA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:00:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64BBFB0BE;
        Wed, 10 Oct 2018 13:38:12 +0000 (UTC)
Subject: Re: [PATCH 2/2] xen: make xen_qlock_wait() nestable
To:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com,
        mingo@redhat.com, bp@alien8.de, stable@vger.kernel.org,
        Waiman.Long@hp.com, peterz@infradead.org
References: <20181001071641.19282-1-jgross@suse.com>
 <20181001071641.19282-3-jgross@suse.com>
 <47686a61dfc06aa5afb05a893b9a56e6eb46763d.camel@infradead.org>
 <alpine.DEB.2.21.1810101426080.10278@nanos.tec.linutronix.de>
 <eb9250d00cf9095913a7ecc3a2c575b9ed40fd6f.camel@infradead.org>
 <alpine.DEB.2.21.1810101445530.10278@nanos.tec.linutronix.de>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <35f0d72b-c4b9-3557-6348-25a8646c6995@suse.com>
Date:   Wed, 10 Oct 2018 15:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810101445530.10278@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2018 14:47, Thomas Gleixner wrote:
> On Wed, 10 Oct 2018, David Woodhouse wrote:
>> On Wed, 2018-10-10 at 14:30 +0200, Thomas Gleixner wrote:
>>> On Wed, 10 Oct 2018, David Woodhouse wrote:
>>>
>>>> On Mon, 2018-10-01 at 09:16 +0200, Juergen Gross wrote:
>>>>> -       /* If irq pending already clear it and return. */
>>>>> +       /* Guard against reentry. */
>>>>> +       local_irq_save(flags);
>>>>> +
>>>>> +       /* If irq pending already clear it. */
>>>>>         if (xen_test_irq_pending(irq)) {
>>>>>                 xen_clear_irq_pending(irq);
>>>>> -               return;
>>>>> +       } else if (READ_ONCE(*byte) == val) {
>>>>> +               /* Block until irq becomes pending (or a spurious wakeup) */
>>>>> +               xen_poll_irq(irq);
>>>>>         }
>>>>
>>>>
>>>> Does this still allow other IRQs to wake it from xen_poll_irq()?
>>>>
>>>> In the case where process-context code is spinning for a lock without
>>>> disabling interrupts, we *should* allow interrupts to occur still...
>>>> does this?
>>>
>>> Yes. Look at it like idle HLT or WFI. You have to disable interrupt before
>>> checking the condition and then the hardware or in this case the hypervisor
>>> has to bring you back when an interrupt is raised.
>>>
>>> If that would not work then the check would be racy, because the interrupt
>>> could hit and be handled after the check and before going into
>>> HLT/WFI/hypercall and then the thing is out until the next interrupt comes
>>> along, which might be never.
>>
>> Right, but in this case we're calling into the hypervisor to poll for
>> one *specific* IRQ. Everything you say is true for that specific IRQ.
>>
>> My question is what happens to *other* IRQs. We want them, but are they
>> masked? I'm staring at the Xen do_poll() code and haven't quite worked
>> that out...
> 
> Ah, sorry. That of course has to come back like HLT/WFI for any interrupt,
> but I have no idea what the Xen HV is doing there.

The Xen HV is doing it right. It is blocking the vcpu in do_poll() and
any interrupt will unblock it.


Juergen

