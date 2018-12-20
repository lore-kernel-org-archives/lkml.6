Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4F2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FCC217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbeLTPvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:51:15 -0500
Received: from ns360863.ovh.net ([91.121.165.116]:37120 "EHLO ns360863.ovh.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbeLTPvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:51:15 -0500
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Dec 2018 10:51:13 EST
Received: from [192.168.0.16] (HSI-KBW-046-005-005-080.hsi8.kabel-badenwuerttemberg.de [46.5.5.80])
        by ns360863.ovh.net (Postfix) with ESMTPSA id 98A32401BA;
        Thu, 20 Dec 2018 16:47:54 +0100 (CET)
Subject: Re: [PATCH v5 05/15] KVM: s390: unify pending_irqs() and
 pending_irqs_no_gisa()
To:     mimu@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-6-mimu@linux.ibm.com>
 <20181220120614.65acacac.cohuck@redhat.com>
 <62bf4bcf-585f-ddfc-e7a5-18fc946819d9@linux.ibm.com>
 <20181220132130.33a417fa.cohuck@redhat.com>
 <83553348-0b10-8bcc-34b0-c87a0e2f95ac@linux.ibm.com>
From:   pierre morel <pmorel@mnis.fr>
Organization: MNIS
Message-ID: <3944cf13-130a-d4ea-8d14-f8b055506339@mnis.fr>
Date:   Thu, 20 Dec 2018 16:43:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <83553348-0b10-8bcc-34b0-c87a0e2f95ac@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/20/18 à 13:33, Michael Mueller a écrit :
> 
> 
> On 20.12.18 13:21, Cornelia Huck wrote:
>> On Thu, 20 Dec 2018 12:49:56 +0100
>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>
>>> On 20.12.18 12:06, Cornelia Huck wrote:
>>>> On Wed, 19 Dec 2018 20:17:46 +0100
>>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>>> Use a single function with parameter irq_flags to differentiate
>>>>> between cases.
>>>>>
...snip
>>>>>    }
>>>>> -static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu 
>>>>> *vcpu)
>>>>> +static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu, 
>>>>> u16 irq_flags)
>>>>
>>>> Any deeper reason why this is a u16? 16 bits should be enough for
>>>> everyone? :)
>>>
>>> I want to use the 8 bits for the IRQ type and the other 8 for additional
>>> controls, see: "KVM: s390: restore IAM in get_ipm() when IPM is clean"
>>
>> Still need to look at that patch, but my question mainly was "why only
>> 16 bits"? I would think making this local variable larger is cheap.
>>

+1

> 
> I will enlarge the flag mask to u32 with 16 bits for the IRQ types then.

AFAIK CPU generally work better with int (or long)
Is there any hardware reason to restrict the size?

> 
>>>
>>>>>    {
>>>>> -    return vcpu->kvm->arch.float_int.pending_irqs |
>>>>> -        vcpu->arch.local_int.pending_irqs;
>>>>> -}
>>
> 
