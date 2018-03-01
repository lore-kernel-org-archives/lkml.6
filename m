Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966887AbeCAJXv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:23:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965026AbeCAJXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:23:46 -0500
Subject: Re: [PATCH net-next 0/2] virtio-net: re enable XDP_REDIRECT for
 mergeable buffer
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
 <20180301101038.4253424d@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b0f55100-183d-a507-8510-3c67f6106031@redhat.com>
Date: Thu, 1 Mar 2018 17:23:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301101038.4253424d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月01日 17:10, Jesper Dangaard Brouer wrote:
> On Thu,  1 Mar 2018 11:19:03 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> This series tries to re-enable XDP_REDIRECT for mergeable buffer which
>> was removed since commit 7324f5399b06 ("virtio_net: disable
>> XDP_REDIRECT in receive_mergeable() case"). Main concerns are:
>>
>> - not enough tailroom was reserved which breaks cpumap
> To address this at a more fundamental level, I would suggest that we/you
> instead extend XDP to know it's buffers "frame" size/end.  (The
> assumption use to be, xdp_buff->data_hard_start + PAGE_SIZE, but
> ixgbe+virtio_net broke that assumption).
>
> It should actually be fairly easy to implement:
>   * Simply extend xdp_buff with a "data_hard_end" pointer.

Right, and then cpumap can warn and drop packets with insufficient 
tailroom. But it should be a patch on top of this I think.

Thanks

>
> Now cpumap is more safe... instead of crashing, it can now know/see when
> it is safe to create an SKB using build_skb (could fallback to
> dev_alloc_skb).
>
