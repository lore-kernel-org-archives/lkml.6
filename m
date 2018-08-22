Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C1E214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C1E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeHVQQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:16:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728057AbeHVQQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:16:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 362354023476;
        Wed, 22 Aug 2018 12:51:57 +0000 (UTC)
Received: from [10.36.117.196] (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81CB32026D74;
        Wed, 22 Aug 2018 12:51:55 +0000 (UTC)
Subject: Re: [PATCH] KVM: s390: vsie: Consolidate CRYCB validation
To:     pmorel@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <1534925337-18380-1-git-send-email-pmorel@linux.ibm.com>
 <c410ab24-1f83-21f3-1996-7328aeb3f408@redhat.com>
 <7de5e991-764e-dec8-648b-6acc42c141e6@linux.ibm.com>
 <f5261c1a-58f6-68f2-1736-eb13dce863b6@redhat.com>
 <0032fc9b-4328-1a09-66f5-65f485a8a42f@linux.ibm.com>
 <a6a2aec1-33cf-6299-8219-ed5043ba07be@redhat.com>
 <8afefad7-d4a5-7e02-d5ea-9a355cbed332@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <76fc3187-4e99-bd2f-5d3b-5de89ac641d1@redhat.com>
Date:   Wed, 22 Aug 2018 14:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8afefad7-d4a5-7e02-d5ea-9a355cbed332@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 22 Aug 2018 12:51:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 22 Aug 2018 12:51:57 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>>  From the host, we control the guest1 and we start it without AP
>>> by not setting ECA.28.
>>> So that the guest1 can not know if APXA is installed or not since to know
>>> this it must use a AP instruction :)
>> No AP implies no APXA. On that logical level "host".
> 
> hum.
> No seen, usable nor used APXA  on that level: yes.
> 
>>
>>> Now the guest1 is an hypervizor and wants to start a guest2.
>>> It can set ECA.28 to allow the guest2 AP instructions , just because it can,
>>> (even guest2 will not see any as it will be masked by the guest1 ECA.28
>>> that we did not set)
>> ECA.28 has no effect as G1 sees no AP facility. That is the real reason.
> 
> Not exactly, the ECA.28 field used for G2 is an effective field
> calculated from G1.ECA.28 & G2.ECA.28

That is one complexity on top, but it does not reflect what our guest
sees (see below)

> 
> G1 not having AP instructions is the consequence of G1.ECA.28=0
> 
> There is no AP Facility in the sense of STFL bits.

Yes, it is sensed differently by the guest. But the guest can detect it
by sensing instructions, right? (similar to CMM)

If AP instructions can be executed by the guest ("sense") -> "AP
facility available"

If "AP facility available" -> ECA.28 _may_ be used. It can still result
in an intercept.

If "AP facility not available" -> ECA.28 is ignored

So any user of ECA.28 _has to_ implement backup emulation code if he
wants to provide the AP facility to it's guests.

Where is that code in the current series? Imagine running nested under
z/VM where ECA.28 is not effective. Or later on nested under KVM once we
emulate devices in QEMU and have to restrict ECA.28 for our guest (which
might itself might want to make use of ECA.28)


IMHO, if ECA.28 is set, it is to be treated just like it _would be_ set
(e.g. perform checks), but it can effectively be disabled by us before
going into the SIE. But this is a small detail.

> 
>>
>>> It can also set the FORMAT2 just because it can do it.
>>> The documentation explicitly says that FORMAT2 may be used
>>> without APXA and that in this case it will be handled as a FORMAT1
>>>
>>>
>>> The question is do we want to forbid this?
>>> It is not an error.
>>> Suppose that an hypervizor always set FORMAT2 to be able to not restart
>>> its guest if the host set ECA.28 a posteriori.
>>>
>>> Anyway we have the choice:
>>> - we verify the CRYCB for FORMAT2
>>> or
>>> - we forbid FORMAT2
>>>
>>> Since we will soon (I hope) be able to use AP instructions in AP
>>> but we are not able to do it today, we could forbid FORMAT2
>>> however in the current behavior we authorize FORMAT2...
>>>
>>> What ever the choice is we must change the current implementation.
>>>
>>> I prefer to keep the current interface but make sure that the
>>> host do not crash when scheduling a FORMAT2 SIE crossing
>>> a page boundary.
>>>
>>>
>>> What do you think we should do?
>> Keep it simple. Don't mix in machine configuration. Try to make each
>> layer look consistent.
>>
>> If there is no AP/APXA on a level ("host"), FORMAT2 is ignored in SIE.
>> If there is no AP/APXA on a level ("host"), ECA.28 is ignored in SIE.
>> If there is no MSA3 on a level ("host"), ECB3_AES | ECB3_DEA is ignored
>> in SIE.
>>
>> If there is no AP/APXA/MSA3 on a level ("host"), crycbd is completely
>> ignored in SIE. (that means, no validity intercepts to be injected).
>> Please double check that in the documentation.
>>
>> If there is is AP/MSA3 and either ECA.28 | ECB3_AES | ECB3_DEA, what
>> should happen? (please verify in the documentation)
>>
>> FORMAT2 should really only be allowed if there is APXA. As we cannot
>> fake abscence for guests (as of now), guest availability always matches
>> host availability if AP is enabled for a guest.
> 
> I am not sure we can KIS.
> 
> For the SIE firmware a guest G1 or G2 or not distinguishable.
> 
> Using VSIE we let the G2 run inside a SIE Control Block installed by the 
> host.
> So if the host has AP/APXA and even if G1 has not AP/APXA
> then, if we take your first assumption, FORMAT2 is not ignored in the SIE.

That's why we sit in the middle and control what we give to HW.

We (as a hypervisor implementing nested virtualization), have to make
sure that what the guest sees and experiences is consistent.

E.g. if we fake away APXA (which can and should be supported, see my
other reply), the guest (who might be old and have no idea about APXA)
should see consistent results.

> 
> Since the test is done on SIE entry
> no need to run an instruction to get a validity interception,
> which is for me explained by the documentation stating that:
> 
> The check of APCB/CRYCB and APCB/CRYCB origin is performed
> only if any of the following is true:
> (a) ECA.28 is one
> (b) CRYCB format field (F) is one
> or
> (c) the AXPA facility is installed and the F field is three
> 
> If not having the AP instruction would be enough to avoid
> a validity interception, then there would be no need to
> have the point (c).
> 

Maybe it is really best to split this patch further up, then we can
discuss all details separately.

Having access to documentation would really be beneficial here :)

-- 

Thanks,

David / dhildenb
