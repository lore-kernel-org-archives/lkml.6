Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B338BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D14208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="gxwP766P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D14208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966134AbeFOTgY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:36:24 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:57192 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965768AbeFOTgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:36:23 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.22/8.16.0.22) with SMTP id w5FJW5aL002284;
        Fri, 15 Jun 2018 20:36:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=GXs6SaHOKCgS1b8VBAGZ0rIlWQvlU9i9NNLtY/Hm8RY=;
 b=gxwP766PS2vStYKo8mqgeEcmlyYo4eh5BVUIaUORJgiz3aOP60HSygiTgAzggb367yEB
 U5vooxsL7x62qreLa8ovphLsj9h/ObMs1iagNGQQ7Vi0JQjr7UtvaR9+z1fl2Y+PmEma
 +g1Y5Z+JeQUrE/6ntpJJOVaOh6h/5jrMfPEWb04tzlBsHnjKVb9KcU80suIS0Bqu9dsd
 UDKtavbcGgzMdw7mXhWjPJlz+vh5RxCKNl9+l1B6MXH8Ir614P4q8nCUAea3Amg/HNSv
 dskIDMhBAeoP4AtnAiKBCSc8YiKMFKZES7sGQTKhf332iTd6BO/+87+xnuUsYu+TIwLQ pQ== 
Received: from prod-mail-ppoint3 (a96-6-114-86.deploy.static.akamaitechnologies.com [96.6.114.86] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2jmc2f99js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jun 2018 20:36:09 +0100
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w5FJa8Iq031209;
        Fri, 15 Jun 2018 15:36:09 -0400
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2jjp74ttq9-1;
        Fri, 15 Jun 2018 15:36:08 -0400
Received: from [172.28.13.175] (bos-lpjec.kendall.corp.akamai.com [172.28.13.175])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id 1FE3E82CD8;
        Fri, 15 Jun 2018 19:36:08 +0000 (GMT)
Subject: Re: [PATCH] mm/madvise: allow MADV_DONTNEED to free memory that is
 MLOCK_ONFAULT
To:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-api@vger.kernel.org, emunson@mgebm.net
References: <1528484212-7199-1-git-send-email-jbaron@akamai.com>
 <20180611072005.GC13364@dhcp22.suse.cz>
 <4c4de46d-c55a-99a8-469f-e1e634fb8525@akamai.com>
 <20180611150330.GQ13364@dhcp22.suse.cz>
 <775adf2d-140c-1460-857f-2de7b24bafe7@akamai.com>
 <20180612074646.GS13364@dhcp22.suse.cz>
 <5a9398f4-453c-5cb5-6bbc-f20c3affc96a@akamai.com>
 <0daccb7c-f642-c5ce-ca7a-3b3e69025a1e@suse.cz>
 <20180613071552.GD13364@dhcp22.suse.cz>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <7a671035-92dc-f9c0-aa7b-ff916d556e82@akamai.com>
Date:   Fri, 15 Jun 2018 15:36:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180613071552.GD13364@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150209
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1805220000
 definitions=main-1806150208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2018 03:15 AM, Michal Hocko wrote:
> On Wed 13-06-18 08:32:19, Vlastimil Babka wrote:
>> On 06/12/2018 04:11 PM, Jason Baron wrote:
>>>
>>>
>>> On 06/12/2018 03:46 AM, Michal Hocko wrote:
>>>> On Mon 11-06-18 12:23:58, Jason Baron wrote:
>>>>> On 06/11/2018 11:03 AM, Michal Hocko wrote:
>>>>>> So can we start discussing whether we want to allow MADV_DONTNEED on
>>>>>> mlocked areas and what downsides it might have? Sure it would turn the
>>>>>> strong mlock guarantee to have the whole vma resident but is this
>>>>>> acceptable for something that is an explicit request from the owner of
>>>>>> the memory?
>>>>>>
>>>>>
>>>>> If its being explicity requested by the owner it makes sense to me. I
>>>>> guess there could be a concern about this breaking some userspace that
>>>>> relied on MADV_DONTNEED not freeing locked memory?
>>>>
>>>> Yes, this is always the fear when changing user visible behavior.  I can
>>>> imagine that a userspace allocator calling MADV_DONTNEED on free could
>>>> break. The same would apply to MLOCK_ONFAULT/MCL_ONFAULT though. We
>>>> have the new flag much shorter so the probability is smaller but the
>>>> problem is very same. So I _think_ we should treat both the same because
>>>> semantically they are indistinguishable from the MADV_DONTNEED POV. Both
>>>> remove faulted and mlocked pages. Mlock, once applied, should guarantee
>>>> no later major fault and MADV_DONTNEED breaks that obviously.
>>
>> I think more concerning than guaranteeing no later major fault is
>> possible data loss, e.g. replacing data with zero-filled pages.
> 
> But MADV_DONTNEED is an explicit call for data loss. Or do I miss your
> point?
> 
>> The madvise manpage is also quite specific about not allowing
>> MADV_DONTNEED and MADV_FREE for locked pages.
> 
> Yeah, but that seems to describe the state of the art rather than
> explain why.
> 
>> So I don't think we should risk changing that for all mlocked pages.
>> Maybe we can risk MCL_ONFAULT, since it's relatively new and has few users?
> 
> That is what Jason wanted but I argued that the two are the same from
> MADV_DONTNEED point of view. I do not see how treating them differently
> would be less confusing or error prone. It's new so we can make it
> behave differently is certainly not an argument.
> 
>>>> So the more I think about it the more I am worried about this but I am
>>>> more and more convinced that making ONFAULT special is just a wrong way
>>>> around this.
>>>>
>>>
>>> Ok, I share the concern that there is a chance that userspace is relying
>>> on MADV_DONTNEED not free'ing locked memory. In that case, what if we
>>> introduce a MADV_DONTNEED_FORCE, which does everything that
>>> MADV_DONTNEED currently does but in addition will also free mlock areas.
>>> That way there is no concern about breaking something.
>>
>> A new niche case flag? Sad :(
>>
>> BTW I didn't get why we should allow this for MADV_DONTNEED but not
>> MADV_FREE. Can you expand on that?
> 
> Well, I wanted to bring this up as well. I guess this would require some
> more hacks to handle the reclaim path correctly because we do rely on
> VM_LOCK at many places for the lazy mlock pages culling.
> 

The point of not allowing MADV_FREE on mlock'd pages for me was that
with mlock and even MLOCK_ON_FAULT, one can always can always determine
if a page is present or not (and thus avoid the major fault). Allowing
MADV_FREE on lock'd pages breaks that assumption.

Thanks,

-Jason

