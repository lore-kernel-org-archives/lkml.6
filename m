Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeB1G22 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:28:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751646AbeB1G21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:28:27 -0500
Subject: Re: [RFC PATCH v2] ptr_ring: linked list fallback
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>
References: <1519607771-20613-1-git-send-email-mst@redhat.com>
 <01aff5eb-a92f-2170-05f7-664220985070@redhat.com>
 <20180226223252-mutt-send-email-mst@kernel.org>
 <0316016a-717b-9d3f-5aef-dccaf34d0fae@redhat.com>
 <20180227190703-mutt-send-email-mst@kernel.org>
 <b73c7c1e-4a63-45c0-cef5-0ec8f1195eca@redhat.com>
 <20180228060845-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <11ef5721-1a4c-f216-9f46-08a0ad0ca49d@redhat.com>
Date: Wed, 28 Feb 2018 14:28:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228060845-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月28日 12:09, Michael S. Tsirkin wrote:
>>> Or we can add plist to a union:
>>>
>>>
>>> struct sk_buff {
>>>           union {
>>>                   struct {
>>>                           /* These two members must be first. */
>>>                           struct sk_buff          *next;
>>>                           struct sk_buff          *prev;
>>>                           union {
>>>                                   struct net_device       *dev;
>>>                                   /* Some protocols might use this space to store information,
>>>                                    * while device pointer would be NULL.
>>>                                    * UDP receive path is one user.
>>>                                    */
>>>                                   unsigned long           dev_scratch;
>>>                           };
>>>                   };
>>>                   struct rb_node  rbnode; /* used in netem & tcp stack */
>>> +		struct plist plist; /* For use with ptr_ring */
>>>           };
>>>
>> This look ok.
>>
>>>> For XDP, we need to embed plist in struct xdp_buff too,
>>> Right - that's pretty straightforward, isn't it?
>> Yes, it's not clear to me this is really needed for XDP consider the lock
>> contention it brings.
>>
>> Thanks
> The contention is only when the ring overflows into the list though.
>

Right, but there's usually a mismatch of speed between producer and 
consumer. In case of a fast producer, we may get this contention very 
frequently.

Thanks
