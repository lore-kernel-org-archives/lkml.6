Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeCVKLH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:11:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752825AbeCVKLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:11:05 -0400
Subject: Re: [PATCH 1/4] vfio: ccw: fix cleanup if cp_prefetch fails
To: Pierre Morel <pmorel@linux.vnet.ibm.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
 <20180321020822.86255-2-bjsdjshi@linux.vnet.ibm.com>
 <682d8b1c-5aca-7015-043b-a3f1446bf378@linux.vnet.ibm.com>
 <20180322022248.GB12194@bjsdjshi@linux.vnet.ibm.com>
 <54fd02cd-bd0b-889b-c40f-f9a32aa25d77@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 11:10:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <54fd02cd-bd0b-889b-c40f-f9a32aa25d77@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18032210-0040-0000-0000-000004441BFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032210-0041-0000-0000-000020E743DA
Message-Id: <04a22205-bac4-652d-d5a1-c05d7ee5bfde@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803220122
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/22/2018 10:37 AM, Pierre Morel wrote:
> On 22/03/2018 03:22, Dong Jia Shi wrote:
>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2018-03-21 13:49:54 +0100]:
>>
>>>
>>> On 03/21/2018 03:08 AM, Dong Jia Shi wrote:
>>>> From: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>
>>>> If the translation of a channel program fails, we may end up attempting
>>>> to clean up (free, unpin) stuff that never got translated (and allocated,
>>>> pinned) in the first place.
>>>>
>>>> By adjusting the lengths of the chains accordingly (so the element that
>>>> failed, and all subsequent elements are excluded) cleanup activities
>>>> based on false assumptions can be avoided.
>>>>
>>>> Let's make sure cp_free works properly after cp_prefetch returns with an
>>>> error by setting ch_len to 0 for the ccw chains those are not prefetched.
>>> This sentence used to be:
>>>
>>> Let's make sure cp_free works properly after cp_prefetch returns with an
>>> error.
>>>
>>> @Dong Jia
>>> I find the 'by setting ch_len to 0 for the ccw chains those are not prefetched'
>>> you added for clarification (I guess) somewhat problematic.
>>> The chain in which the translation failure occurred
>>> +    chain->ch_len = idx;
>> I made a mistake. When rewording the message, I missed this part...
>> Sorry for the problem!

np

>>
>>> is shortened so that only the translated elements (ccws) are going to
>>> get cleaned up (on a per element basis) by cp_free. This may or may
>>> not be the first ccw. Subsequent chains are shortened to 0 as there
>>> no translation took place.
>>>
>>> So as a result of this change only properly translated ccws are going
>>> to get (re)visited by cp_free as only those may have resources bound
>>> to them which need to be released.
>>>
>>> I'm not against improving the commit message. But this ain't
>>> an improvement to me.
>> You are right. How about:
>> Let's make sure cp_free works properly after cp_prefetch returns with an
>> error by setting ch_len of a ccw chain to the number of the translated
>> ccws on that chain.

Works with me.

> 
> By the way, since you will propose a new version,
> you have a long description of the cp_prefetch function in the code.
> I think you should modify it according to the changes and describe how and
> why the ch_len field of each chain is used and changed by this function.
> 
> Something like:
> 
> "
> For each chain composing the channel program:
> On entry ch_len hold the count of CCW to be translated.
> On exit ch_len is adjusted to the count of successfully translated CCW.
> 
> This allows cp_free to find in ch_len the count of CCW to free in a chain.
> "

Sounds good to me.

Halil
