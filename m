Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbeENOoi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:44:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753770AbeENOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:44:36 -0400
Subject: Re: [PATCH 1/1] s390: vfio-ccw: push down unsupported IDA check
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20180509173647.61367-1-pasic@linux.ibm.com>
 <20180514135554.29569999.cohuck@redhat.com>
 <d0eb5f47-bb71-f615-3780-e753a22daf5b@linux.ibm.com>
 <20180514160016.3b689728.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 14 May 2018 16:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514160016.3b689728.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18051414-0008-0000-0000-000004F65D3F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051414-0009-0000-0000-00001E8ABD3D
Message-Id: <7bd8fc8b-0500-9905-a3a0-2ec56d3fc9f2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/14/2018 04:00 PM, Cornelia Huck wrote:
> On Mon, 14 May 2018 15:37:17 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 05/14/2018 01:55 PM, Cornelia Huck wrote:
>>> On Wed,  9 May 2018 19:36:47 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    

[..]

>>>> +		/*
>>>> +		 * 2k byte block IDAWs (fmt1 or fmt2) are not yet supported.
>>>> +		 * There are however CPs that don't use IDA at all, and can
>>>> +		 * benefit from not failing until failure is eminent.
>>>
>>> The second sentence is confusing (What is 'CP' referring to here?
>>> 'Control program' or struct channel_program?)
>>
>> Control program. I was under impression that in mainframe context CP
>> mostly stands for control program.
> 
> Yes, but it is very confusing as there is also a variable named 'cp' in
> this function.
> 

Right. I was coming from the PoP side of things. But I do agree.

>>
>>>
>>> What about:
>>>
>>> "As we don't want to fail direct addressing even if the orb specified
>>> one of the unsupported formats, we defer checking for IDAWs in
>>> unsupported formats to here."
>>
>> Was the second sentence only confusing because of CP? I'm not perfectly
>> satisfied with your version either:
>> * 'fail direct addressing even if the orb specified one of the unsupported formats'
>>      I wanted to say: 'hey it does not matter what format for IDA the orb implies
>>      if the channel program does not use any IDA at all'. That could be paraphrased
>>      as channel programs using direct addressing exclusively. But failing the direct
>>      addressing does not fit for me.
> 
> But that's effectively what happens now, no? We reject the orb out of
> hand due to unsupported flags that do not have any relevance for the
> channel program in that case.

Yes, that's what happens now, except that we make the whole channel program fail,
and not the direct addressing. But the comment should describe what happens
with the patch applied.

> 
> Or maybe 'channel programs using direct addressing only'?
> 
>> * 'defer' is IMHO trivial from the perspective that we used to fence the unsupported
>>      scenarios earlier (by just looking at the orb). But if one just reads the new code
>>      defer does not make much sense to me.
> 
> I think it still makes sense if you look at how the functions are
> called.
> 
>>
>> But no strong opinions here. If you think your version is the way to go I
>> will just take it.
> 
> I certainly don't want to dictate things :)
> 

No problem. I'm aware of my limitations when it comes to producing readable
text. In particular, my judgment about well readable or not is not trustworthy.
So your input is highly appreciated. I will take your version, unless there
is development.

>>
>>>    
>>>> +		 */
>>>> +		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw))
>>>> +			return -EOPNOTSUPP;
>>>> +
>>>>    		if ((!ccw_is_chain(ccw)) && (!ccw_is_tic(ccw)))
>>>>    			break;
>>>>    
>>>> @@ -656,10 +667,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>>>>    	/*
>>>>    	 * XXX:
>>>>    	 * Only support prefetch enable mode now.
>>>> -	 * Only support 64bit addressing idal.
>>>> -	 * Only support 4k IDAW.
>>>>    	 */
>>>> -	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k)
>>>> +	if (!orb->cmd.pfch)
>>>>    		return -EOPNOTSUPP;
>>>>    
>>>>    	INIT_LIST_HEAD(&cp->ccwchain_list);
>>>> @@ -688,6 +697,10 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
>>>>    	ret = ccwchain_loop_tic(chain, cp);
>>>>    	if (ret)
>>>>    		cp_unpin_free(cp);
>>>> +	/* It is safe to force: if not set but idals used
>>>> +	 * ccwchain_calc_length returns an error.
>>>
>>> s/returns/already returned/ ?
>>>    
>>
>> Yes we can do that. I think returns is also grammatical. Present simple
>> can be used for expressing something that is always true.
> 
> I think it makes it clearer that we already checked earlier in the call
> sequence.
> 

Will do.

>>
>>>> +	 */
>>>> +	cp->orb.cmd.c64 = 1;
>>>>    
>>>>    	return ret;
>>>>    }
>>>
>>> The patch looks sane, I have only issues with the description/comments.
>>>    
>>
>> Thanks for having a look. Please give me short feedback about the one
>> open point and I will respin with the requested changes.
> 
> Does anybody else have feedback?
> 

Will wait a day or so. Dong Jia and Jason have already seen the patch, and
they only complained about the text. Since that spin was mainly for the
tested-by tags, and I stated that any substantial discussion should happen
upstream, I ignored those complaints.

So yes I will wait a bit so everybody can chime in.

Regards,
Halil
