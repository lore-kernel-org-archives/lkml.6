Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeDDIjf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:39:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53750 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeDDIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:39:33 -0400
Subject: Re: [PATCH 2/2] kfree_rcu() should use kfree_bulk() interface
From: Rao Shoaib <rao.shoaib@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        joe@perches.com, brouer@redhat.com, linux-mm@kvack.org
References: <1522776173-7190-1-git-send-email-rao.shoaib@oracle.com>
 <1522776173-7190-3-git-send-email-rao.shoaib@oracle.com>
 <20180403205822.GB30145@bombadil.infradead.org>
 <d434c58c-082b-9a17-8d15-9c66e0c1941a@oracle.com>
 <20180404022347.GA17512@bombadil.infradead.org>
 <954a9ea2-5202-4ee3-1fa2-21acf8d07cdb@oracle.com>
Message-ID: <d446938e-a3ee-04d0-ea68-96d85d632c3f@oracle.com>
Date: Wed, 4 Apr 2018 01:39:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <954a9ea2-5202-4ee3-1fa2-21acf8d07cdb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040086
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2018 12:16 AM, Rao Shoaib wrote:
>
>
> On 04/03/2018 07:23 PM, Matthew Wilcox wrote:
>> On Tue, Apr 03, 2018 at 05:55:55PM -0700, Rao Shoaib wrote:
>>> On 04/03/2018 01:58 PM, Matthew Wilcox wrote:
>>>> I think you might be better off with an IDR.  The IDR can always
>>>> contain one entry, so there's no need for this 'rbf_list_head' or
>>>> __rcu_bulk_schedule_list.  The IDR contains its first 64 entries in
>>>> an array (if that array can be allocated), so it's compatible with the
>>>> kfree_bulk() interface.
>>>>
>>> I have just familiarized myself with what IDR is by reading your 
>>> article. If
>>> I am incorrect please correct me.
>>>
>>> The list and head you have pointed are only used  if the container 
>>> can not
>>> be allocated. That could happen with IDR as well. Note that the 
>>> containers
>>> are allocated at boot time and are re-used.
>> No, it can't happen with the IDR.  The IDR can always contain one entry
>> without allocating anything.  If you fail to allocate the second entry,
>> just free the first entry.
>>
>>> IDR seems to have some overhead, such as I have to specifically add the
>>> pointer and free the ID, plus radix tree maintenance.
>> ... what?  Adding a pointer is simply idr_alloc(), and you get back an
>> integer telling you which index it has.  Your data structure has its
>> own set of overhead.
> The only overhead is a pointer that points to the head and an int to 
> keep count. If I use idr, I would have to allocate an struct idr which 
> is much larger. idr_alloc()/idr_destroy() operations are much more 
> costly than updating two pointers. As the pointers are stored in 
> slots/nodes corresponding to the id, I would  have to retrieve the 
> pointers by calling idr_remove() to pass them to be freed, the 
> slots/nodes would constantly be allocated and freed.
>
> IDR is a very useful interface for allocating/managing ID's but I 
> really do not see the justification for using it over here, perhaps 
> you can elaborate more on the benefits and also on how I can just pass 
> the array to be freed.
>
> Shoaib
>
I may have mis-understood your comment. You are probably suggesting that 
I use IDR instead of allocating following containers.

+	struct		rcu_bulk_free_container *rbf_container;
+	struct		rcu_bulk_free_container *rbf_cached_container;


IDR uses radix_tree_node which allocates following two arrays. since I 
do not need any ID's why not just use the radix_tree_node directly, but 
I do not need a radix tree either, so why not just use an array. That is 
what I am doing.

void __rcu      *slots[RADIX_TREE_MAP_SIZE];
unsigned long   tags[RADIX_TREE_MAX_TAGS][RADIX_TREE_TAG_LONGS]; ==> Not 
needed

As far as allocation failure is concerned, the allocation has to be done 
at run time. If the allocation of a container can fail, so can the 
allocation of radix_tree_node as it also requires memory.

I really do not see any advantages of using IDR. The structure I have is 
much simpler and does exactly what I need.

Shoaib
