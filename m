Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5613C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8378F208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8378F208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeHWMIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:08:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729534AbeHWMIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:08:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D35A27A7E9;
        Thu, 23 Aug 2018 08:40:17 +0000 (UTC)
Received: from [10.36.117.65] (ovpn-117-65.ams2.redhat.com [10.36.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BAD22026DE4;
        Thu, 23 Aug 2018 08:40:15 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] KVM: s390: vsie: Do the CRYCB validation first
To:     Janosch Frank <frankja@linux.ibm.com>, pmorel@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-6-git-send-email-pmorel@linux.ibm.com>
 <e985a036-1b19-0feb-e50c-d55dec3dc9e7@redhat.com>
 <01047750-cdc6-b462-1e4f-c79c1036ab94@linux.ibm.com>
 <18c65e67-c5e6-9c2f-e7ab-962376427369@redhat.com>
 <ea1dad6d-a698-5d0d-2c41-c08c46068e96@linux.ibm.com>
 <1e8abcfe-19f7-f250-77c4-35e14d181cd1@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <f4b17f4e-281e-71df-6c6e-d62a69ae179c@redhat.com>
Date:   Thu, 23 Aug 2018 10:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1e8abcfe-19f7-f250-77c4-35e14d181cd1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 08:40:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 23 Aug 2018 08:40:17 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.2018 10:34, Janosch Frank wrote:
> On 23.08.2018 10:01, Pierre Morel wrote:
>> On 23/08/2018 09:31, David Hildenbrand wrote:
>>> On 23.08.2018 09:17, Pierre Morel wrote:
>>>> On 22/08/2018 19:15, David Hildenbrand wrote:
>>>>> On 22.08.2018 18:51, Pierre Morel wrote:
>>>>>> When entering the SIE the CRYCB validation better
>>>>>> be done independently of the instruction's
>>>>>> availability.
>>>>>>
>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>>> ---
>>>>>>    arch/s390/kvm/vsie.c | 11 ++++++-----
>>>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>>>> index 7ee4329..fca25aa 100644
>>>>>> --- a/arch/s390/kvm/vsie.c
>>>>>> +++ b/arch/s390/kvm/vsie.c
>>>>>> @@ -164,17 +164,18 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>>>    	/* format-1 is supported with message-security-assist extension 3 */
>>>>>>    	if (!test_kvm_facility(vcpu->kvm, 76))
>>>>>>    		return 0;
>>>>>> -	/* we may only allow it if enabled for guest 2 */
>>>>>> -	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>>>> -		     (ECB3_AES | ECB3_DEA);
>>>>>> -	if (!ecb3_flags)
>>>>>> -		return 0;
>>>>>>    
>>>>>>    	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
>>>>>>    		return set_validity_icpt(scb_s, 0x003CU);
>>>>>>    	if (!crycb_addr)
>>>>>>    		return set_validity_icpt(scb_s, 0x0039U);
>>>>>>    
>>>>>> +	/* we may only allow it if enabled for guest 2 */
>>>>>> +	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>>>> +		     (ECB3_AES | ECB3_DEA);
>>>>>> +	if (!ecb3_flags)
>>>>>> +		return 0;
>>>>>> +
>>>>>>    	/* copy only the wrapping keys */
>>>>>>    	if (read_guest_real(vcpu, crycb_addr + 72,
>>>>>>    			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>>>>>
>>>>>
>>>>> That makes sense, especially if ECB3_AES is used but effectively turned
>>>>> off by us.
>>>>>
>>>>> What is the expected behavior if ECB3_AES | ECB3_DEA are not set by g2
>>>>> for g3?
>>>>>
>>>>
>>>> The use of functions PCKMO-Encrypt-DEA/AES induce a specification error.
>>>>
>>>> However other MSA3 function will continue to be usable.
>>>
>>> No, I meant which checks should be performed here.
>>
>> The SIE should check the validity of the CRYCB.
>>
>> However since we do not copy the key masks we do not
>> expect any access error on crycb_o
>>
>> So it is more a philosophical problem, should the
>> hypervizor enforce an error here to act as the firmware?
> 
> No it's not philosophical, that's actually regulated in the SIE
> documentation for the validity intercepts.
> 
> CRYCB is checked if (any of these is true): ECA.28, CRYCB Format is one,
> APXA installed and CRYCB Format field is three.

So independent of setting of ECB3 AES/DEA by g2. That's what I wanted to
know, thanks :)

> 
> ECB3 AES/DEA bits are handled like the matrix, i.e. they are ANDed over
> the different levels.
> 
> If that's still not what David meant to ask, then I must apologize for
> my caffeine deprived brain.


-- 

Thanks,

David / dhildenb
