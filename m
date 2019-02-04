Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1790DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95AE2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfBDPPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:15:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56889 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfBDPPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:15:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8B5DC087321;
        Mon,  4 Feb 2019 15:15:52 +0000 (UTC)
Received: from [10.67.116.77] (ovpn-116-77.sin2.redhat.com [10.67.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B18A252FC1;
        Mon,  4 Feb 2019 15:15:45 +0000 (UTC)
Subject: Re: [PATCH v1] KVM: s390: vsie: fix Do the CRYCB validation first
To:     pmorel@linux.ibm.com, borntraeger@de.ibm.com
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <1549014725-28216-1-git-send-email-pmorel@linux.ibm.com>
 <1549014725-28216-2-git-send-email-pmorel@linux.ibm.com>
 <ccdc89cd-5299-e674-3329-74e9131dd874@redhat.com>
 <3bb397e9-d679-1152-1b42-d633682b3272@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <4d3977bf-63ec-5732-b2fc-ea8654f444e3@redhat.com>
Date:   Mon, 4 Feb 2019 16:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3bb397e9-d679-1152-1b42-d633682b3272@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 04 Feb 2019 15:15:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.19 14:37, Pierre Morel wrote:
> On 01/02/2019 11:56, David Hildenbrand wrote:
>> On 01.02.19 10:52, Pierre Morel wrote:
>>> The case when the SIE for guest3 is not setup for using
>>> encryption keys nor Adjunct processor but the guest2
>>> does use these features was not properly handled.
>>>
>>> This leads SIE entry for guest3 to crash with validity intercept
>>> because the guest2, not having the use of encryption keys nor
>>> Adjunct Processor did not initialize the CRYCB designation.
>>>
>>> In the case where none of ECA_APIE, ECB3_AES or ECB3_DEA
>>> are set in guest3 a format 0 CRYCB is allowed for guest3
>>> and the CRYCB designation in the SIE for guest3 is not checked
>>> on SIE entry.
>>>
>>> Let's allow the CRYCD designation to be ignored when the
>>> SIE for guest3 is not initialized for encryption key usage
>>> nor AP.
>>>
>>> Fixup: d6f6959 (KVM: s390: vsie: Do the CRYCB validation first)
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> ---
>>>   arch/s390/kvm/vsie.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index a153257..a748f76 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -300,6 +300,9 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>   	if (!apie_h && !key_msk)
>>>   		return 0;
>>>   
>>> +	if (!(scb_o->eca & ECA_APIE) && !(scb_o->ecb3 & (ECB3_AES | ECB3_DEA)))
>>> +		return 0;
>>> +
>>>   	if (!crycb_addr)
>>>   		return set_validity_icpt(scb_s, 0x0039U);
>>>   
>>>
>>
>> The original patch said
>>
>> "We need to handle the validity checks for the crycb, no matter what the
>>   settings for the keywrappings are. So lets move the keywrapping checks
>>   after we have done the validy checks."
>>
>> Can you explain why keywrapping now is important? These patches seem to
>> contradict.
>>
> 
> No it does not, having the flags set or not is part of the validity check.
> but, I acted too fast.
> 
> The problem seems to be even clearer:
> key_msk is defined as
>     int key_msk = test_kvm_facility(vcpu->kvm, 76);
> 
> If it is defined, as it should for a mask, as
> 	(scb_o->ecb3 & (ECB3_AES | ECB3_DEA))
> 
> all is clear..., key_msk is not use but for this test, so I do not 
> understand why it is set as facility 76.
> 
> so I think I better do:
> 
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index a153257..30843a8 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -289,7 +289,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, 
> struct vsie_page *vsie_page)
>          unsigned long *b1, *b2;
>          u8 ecb3_flags;
>          int apie_h;
> -       int key_msk = test_kvm_facility(vcpu->kvm, 76);
> +       int key_msk = scb_o->ecb3 & (ECB3_AES | ECB3_DEA);
>          int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
>          int fmt_h = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
>          int ret = 0;
> 
> 
> So just define a mask a mask.
> I verify the functionality and test on Monday  and if in between it 
> seems better to you so too I post the patch.

Without documentation at hand I cannot really judge what is the right
approach. You have to read the architecture description very carefully
and thimk about the different scenarios. I cannot help here.

test_kvm_facility(vcpu->kvm, 76) means "hardware knows key wrapping exists"

scb_o->ecb3 & (ECB3_AES | ECB3_DEA) means "key wrapping was actually
enabled for AES or DEA"

> 
> Thanks,
> Pierre
> 


-- 

Thanks,

David / dhildenb
