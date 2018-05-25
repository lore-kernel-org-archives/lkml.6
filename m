Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935106AbeEYEu2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 00:50:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932557AbeEYEu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 00:50:27 -0400
Subject: Re: [PATCH 2/2] mm: do not warn on offline nodes unless the specific
 node is explicitly requested
To: Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <20180523125555.30039-1-mhocko@kernel.org>
 <20180523125555.30039-3-mhocko@kernel.org>
 <11e26a4e-552e-b1dc-316e-ce3e92973556@linux.vnet.ibm.com>
 <20180523140601.GQ20441@dhcp22.suse.cz>
 <094afec3-5682-f99d-81bb-230319c78d5d@linux.vnet.ibm.com>
 <20180524080011.GV20441@dhcp22.suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@techadventures.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 10:20:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180524080011.GV20441@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052504-0040-0000-0000-0000043DA539
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052504-0041-0000-0000-00002642E538
Message-Id: <c4bf7d88-5051-ba78-f6f9-ea90f6c8137e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250057
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 01:30 PM, Michal Hocko wrote:
> On Thu 24-05-18 08:52:14, Anshuman Khandual wrote:
>> On 05/23/2018 07:36 PM, Michal Hocko wrote:
>>> On Wed 23-05-18 19:15:51, Anshuman Khandual wrote:
>>>> On 05/23/2018 06:25 PM, Michal Hocko wrote:
>>>>> when adding memory to a node that is currently offline.
>>>>>
>>>>> The VM_WARN_ON is just too loud without a good reason. In this
>>>>> particular case we are doing
>>>>> 	alloc_pages_node(node, GFP_KERNEL|__GFP_RETRY_MAYFAIL|__GFP_NOWARN, order)
>>>>>
>>>>> so we do not insist on allocating from the given node (it is more a
>>>>> hint) so we can fall back to any other populated node and moreover we
>>>>> explicitly ask to not warn for the allocation failure.
>>>>>
>>>>> Soften the warning only to cases when somebody asks for the given node
>>>>> explicitly by __GFP_THISNODE.
>>>>
>>>> node hint passed here eventually goes into __alloc_pages_nodemask()
>>>> function which then picks up the applicable zonelist irrespective of
>>>> the GFP flag __GFP_THISNODE.
>>>
>>> __GFP_THISNODE should enforce the given node without any fallbacks
>>> unless something has changed recently.
>>
>> Right. I was just saying requiring given preferred node to be online
>> whose zonelist (hence allocation zone fallback order) is getting picked
>> up during allocation and warning when that is not online still makes
>> sense.
> 
> Why? We have a fallback and that is expected to be used. How does
> offline differ from depleted node from the semantical point of view?

Hmm, right. I agree. Offlined and depleted nodes are same from memory
allocation semantics point of view. It will proceed picking up next
available zones on the zonelist in the fallback order exactly in the
same fashion either way.

> 
>> We should only hide the warning if the allocation request has
>> __GFP_NOWARN.
>>
>>>
>>>> Though we can go into zones of other
>>>> nodes if the present node (whose zonelist got picked up) does not
>>>> have any memory in it's zones. So warning here might not be without
>>>> any reason.
>>>
>>> I am not sure I follow. Are you suggesting a different VM_WARN_ON?
>>
>> I am just suggesting this instead.
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index 036846fc00a6..7f860ea29ec6 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -464,7 +464,7 @@ static inline struct page *
>>  __alloc_pages_node(int nid, gfp_t gfp_mask, unsigned int order)
>>  {
>>  	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
>> -	VM_WARN_ON(!node_online(nid));
>> +	VM_WARN_ON(!(gfp_mask & __GFP_NOWARN) && !node_online(nid));
>>  
>>  	return __alloc_pages(gfp_mask, order, nid);
>>  }
> 
> I have considered that but I fail to see why should we warn about
> regular GFP_KERNEL allocations as mentioned above. Just consider an
> allocation for the preffered node. Do you want to warn just because that
> node went offline?

As you have mentioned before, the semantics is similar when the node is
offlined compared to when its depleted. Right. I tend to agree with your
approach of not warning in such situations.
