Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeB0C3e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:29:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751878AbeB0C3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:29:33 -0500
Subject: Re: [RFC PATCH v2] ptr_ring: linked list fallback
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>
References: <1519607771-20613-1-git-send-email-mst@redhat.com>
 <01aff5eb-a92f-2170-05f7-664220985070@redhat.com>
 <20180226223252-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0316016a-717b-9d3f-5aef-dccaf34d0fae@redhat.com>
Date: Tue, 27 Feb 2018 10:29:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226223252-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月27日 04:34, Michael S. Tsirkin wrote:
> On Mon, Feb 26, 2018 at 11:15:42AM +0800, Jason Wang wrote:
>> On 2018年02月26日 09:17, Michael S. Tsirkin wrote:
>>> So pointer rings work fine, but they have a problem: make them too small
>>> and not enough entries fit.  Make them too large and you start flushing
>>> your cache and running out of memory.
>>>
>>> This is a new idea of mine: a ring backed by a linked list. Once you run
>>> out of ring entries, instead of a drop you fall back on a list with a
>>> common lock.
>>>
>>> Should work well for the case where the ring is typically sized
>>> correctly, but will help address the fact that some user try to set e.g.
>>> tx queue length to 1000000.
>>>
>>> In other words, the idea is that if a user sets a really huge TX queue
>>> length, we allocate a ptr_ring which is smaller, and use the backup
>>> linked list when necessary to provide the requested TX queue length
>>> legitimately.
>>>
>>> My hope this will move us closer to direction where e.g. fw codel can
>>> use ptr rings without locking at all.  The API is still very rough, and
>>> I really need to take a hard look at lock nesting.
>>>
>>> Compiled only, sending for early feedback/flames.
>>>
>>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>>> ---
>>>
>>> changes from v1:
>>> - added clarifications by DaveM in the commit log
>>> - build fixes
>>>
>>>    include/linux/ptr_ring.h | 64 +++++++++++++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 61 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
>>> index d72b2e7..8aa8882 100644
>>> --- a/include/linux/ptr_ring.h
>>> +++ b/include/linux/ptr_ring.h
>>> @@ -31,11 +31,18 @@
>>>    #include <asm/errno.h>
>>>    #endif
>>> +/* entries must start with the following structure */
>>> +struct plist {
>>> +	struct plist *next;
>>> +	struct plist *last; /* only valid in the 1st entry */
>>> +};
>> So I wonder whether or not it's better to do this in e.g skb_array
>> implementation. Then it can use its own prev/next field.
> XDP uses ptr ring directly, doesn't it?
>

Well I believe the main user for this is qdisc, which use skb array. And 
we can not use what implemented in this patch directly for sk_buff 
without some changes on the data structure.

For XDP, we need to embed plist in struct xdp_buff too, so it looks to 
me that the better approach is to have separated function for ptr ring 
and skb array.

Thanks
