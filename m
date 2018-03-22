Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeCVJho (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:37:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751599AbeCVJhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:37:42 -0400
Subject: Re: [PATCH 1/4] vfio: ccw: fix cleanup if cp_prefetch fails
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com, borntraeger@de.ibm.com
References: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
 <20180321020822.86255-2-bjsdjshi@linux.vnet.ibm.com>
 <682d8b1c-5aca-7015-043b-a3f1446bf378@linux.vnet.ibm.com>
 <20180322022248.GB12194@bjsdjshi@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 10:37:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322022248.GB12194@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18032209-0044-0000-0000-0000053EAC98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032209-0045-0000-0000-0000287DB484
Message-Id: <54fd02cd-bd0b-889b-c40f-f9a32aa25d77@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803220115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2018 03:22, Dong Jia Shi wrote:
> * Halil Pasic <pasic@linux.vnet.ibm.com> [2018-03-21 13:49:54 +0100]:
>
>>
>> On 03/21/2018 03:08 AM, Dong Jia Shi wrote:
>>> From: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>
>>> If the translation of a channel program fails, we may end up attempting
>>> to clean up (free, unpin) stuff that never got translated (and allocated,
>>> pinned) in the first place.
>>>
>>> By adjusting the lengths of the chains accordingly (so the element that
>>> failed, and all subsequent elements are excluded) cleanup activities
>>> based on false assumptions can be avoided.
>>>
>>> Let's make sure cp_free works properly after cp_prefetch returns with an
>>> error by setting ch_len to 0 for the ccw chains those are not prefetched.
>> This sentence used to be:
>>
>> Let's make sure cp_free works properly after cp_prefetch returns with an
>> error.
>>
>> @Dong Jia
>> I find the 'by setting ch_len to 0 for the ccw chains those are not prefetched'
>> you added for clarification (I guess) somewhat problematic.
>> The chain in which the translation failure occurred
>> +	chain->ch_len = idx;
> I made a mistake. When rewording the message, I missed this part...
> Sorry for the problem!
>
>> is shortened so that only the translated elements (ccws) are going to
>> get cleaned up (on a per element basis) by cp_free. This may or may
>> not be the first ccw. Subsequent chains are shortened to 0 as there
>> no translation took place.
>>
>> So as a result of this change only properly translated ccws are going
>> to get (re)visited by cp_free as only those may have resources bound
>> to them which need to be released.
>>
>> I'm not against improving the commit message. But this ain't
>> an improvement to me.
> You are right. How about:
> Let's make sure cp_free works properly after cp_prefetch returns with an
> error by setting ch_len of a ccw chain to the number of the translated
> ccws on that chain.

By the way, since you will propose a new version,
you have a long description of the cp_prefetch function in the code.
I think you should modify it according to the changes and describe how and
why the ch_len field of each chain is used and changed by this function.

Something like:

"
For each chain composing the channel program:
On entry ch_len hold the count of CCW to be translated.
On exit ch_len is adjusted to the count of successfully translated CCW.

This allows cp_free to find in ch_len the count of CCW to free in a chain.
"

Could also be inside the commit message.

Pierre


>
>>> Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>> ---
>>>   drivers/s390/cio/vfio_ccw_cp.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
>>> index d9a2fffd034b..2be114db02f9 100644
>>> --- a/drivers/s390/cio/vfio_ccw_cp.c
>>> +++ b/drivers/s390/cio/vfio_ccw_cp.c
>>> @@ -749,11 +749,18 @@ int cp_prefetch(struct channel_program *cp)
>>>   		for (idx = 0; idx < len; idx++) {
>>>   			ret = ccwchain_fetch_one(chain, idx, cp);
>>>   			if (ret)
>>> -				return ret;
>>> +				goto out_err;
>>>   		}
>>>   	}
>>>
>>>   	return 0;
>>> +out_err:
>>> +	/* Only cleanup the chain elements that where actually translated. */
>>> +	chain->ch_len = idx;
>>> +	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
>>> +		chain->ch_len = 0;
>>> +	}
>>> +	return ret;
>>>   }
>>>
>>>   /**
>>>

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
