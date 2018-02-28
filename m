Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeB1OUp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:20:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752228AbeB1OUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:20:43 -0500
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
 <11ef5721-1a4c-f216-9f46-08a0ad0ca49d@redhat.com>
 <20180228155121-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f5c4904f-4bf1-1dc3-a57f-766a5b120d85@redhat.com>
Date: Wed, 28 Feb 2018 22:20:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228155121-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月28日 22:01, Michael S. Tsirkin wrote:
> On Wed, Feb 28, 2018 at 02:28:21PM +0800, Jason Wang wrote:
>>
>> On 2018年02月28日 12:09, Michael S. Tsirkin wrote:
>>>>> Or we can add plist to a union:
>>>>>
>>>>>
>>>>> struct sk_buff {
>>>>>            union {
>>>>>                    struct {
>>>>>                            /* These two members must be first. */
>>>>>                            struct sk_buff          *next;
>>>>>                            struct sk_buff          *prev;
>>>>>                            union {
>>>>>                                    struct net_device       *dev;
>>>>>                                    /* Some protocols might use this space to store information,
>>>>>                                     * while device pointer would be NULL.
>>>>>                                     * UDP receive path is one user.
>>>>>                                     */
>>>>>                                    unsigned long           dev_scratch;
>>>>>                            };
>>>>>                    };
>>>>>                    struct rb_node  rbnode; /* used in netem & tcp stack */
>>>>> +		struct plist plist; /* For use with ptr_ring */
>>>>>            };
>>>>>
>>>> This look ok.
>>>>
>>>>>> For XDP, we need to embed plist in struct xdp_buff too,
>>>>> Right - that's pretty straightforward, isn't it?
>>>> Yes, it's not clear to me this is really needed for XDP consider the lock
>>>> contention it brings.
>>>>
>>>> Thanks
>>> The contention is only when the ring overflows into the list though.
>>>
>> Right, but there's usually a mismatch of speed between producer and
>> consumer. In case of a fast producer, we may get this contention very
>> frequently.
>>
>> Thanks
> This is not true in my experiments.  In my experiments, ring size of 4k
> bytes is enough to see packet drops in single %s of cases.
>
> To you have workloads where rings are full most of the time?

E.g using xdp_redirect to redirect packets from ixgbe to tap. In my 
test, ixgeb can produce ~8Mpps. But vhost can only consume ~3.5Mpps.

>
> One other nice side effect of this patch is that instead of dropping
> packets quickly it slows down producer to match consumer speeds.

In some case, producer may not want to be slowed down, e.g in devmap 
which can redirect packets into several different interfaces.

> IOW, it can go either way in theory, we will need to test and see the effect.
>

Yes.

Thanks
