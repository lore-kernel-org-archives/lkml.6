Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeBZNoD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:44:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752264AbeBZNn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:43:58 -0500
Subject: Re: [PATCH V4 net 2/3] tuntap: disable preemption during XDP
 processing
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        sergei.shtylyov@cogentembedded.com, christoffer.dall@linaro.org
References: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
 <1519443146-9089-2-git-send-email-jasowang@redhat.com>
 <20180226120209.3c3b172b@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5e46686c-7d51-2125-c279-b75d68e18fe8@redhat.com>
Date: Mon, 26 Feb 2018 21:43:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226120209.3c3b172b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月26日 19:02, Jesper Dangaard Brouer wrote:
> On Sat, 24 Feb 2018 11:32:25 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> Except for tuntap, all other drivers' XDP was implemented at NAPI
>> poll() routine in a bh. This guarantees all XDP operation were done at
>> the same CPU which is required by e.g BFP_MAP_TYPE_PERCPU_ARRAY. But
> There is a typo in the defined name "BFP_MAP_TYPE_PERCPU_ARRAY".
> Besides it is NOT a requirement that comes from the map type
> BPF_MAP_TYPE_PERCPU_ARRAY.

But it looks to me that bpf_array uses percpu structure, e.g in 
percpu_array_map_lookup_elem() it tries to access it through this_cpu_ptr().

>
> The requirement comes from the bpf_redirect_map helper (and only partly
> devmap + cpumap types), as the BPF helper/program stores information in
> the per-cpu redirect_info struct (see filter.c), that is used by
> xdp_do_redirect() and xdp_do_flush_map().
>
>   struct redirect_info {
> 	u32 ifindex;
> 	u32 flags;
> 	struct bpf_map *map;
> 	struct bpf_map *map_to_flush;
> 	unsigned long   map_owner;
>   };
>   static DEFINE_PER_CPU(struct redirect_info, redirect_info);
>
>   [...]
>   void xdp_do_flush_map(void)
>   {
> 	struct redirect_info *ri = this_cpu_ptr(&redirect_info);
> 	struct bpf_map *map = ri->map_to_flush;
>   [...]
>
> Notice the same redirect_info is used by the TC clsbpf system...
>
>
>> for tuntap, we do it in process context and we try to protect XDP
>> processing by RCU reader lock. This is insufficient since
>> CONFIG_PREEMPT_RCU can preempt the RCU reader critical section which
>> breaks the assumption that all XDP were processed in the same CPU.
>>
>> Fixing this by simply disabling preemption during XDP processing.
> I guess, this could pamper over the problem...
>
> But I generally find it problematic that the tuntap is not invoking XDP
> from NAPI poll() routine in BH-context, as that context provided us
> with some protection that allow certain kind of optimizations (like
> this flush API).  I hope this will not limit us in the future, that
> tuntap driver violate the XDP call context.

Good to see tuntap is on the radar :), it was easily forgotten. I was 
glad to test anything new in XDP for tuntap. But I do not see any thing 
that prevents us from having a similar environment that NAPI poll() can 
provides. I admit the flush is inefficient now, but it does not mean we 
can't solve it in the future. E.g for the flush, I plan to introduce the 
batching API which can accept an array of skb/XDP pointers in its 
sendmsg(). Then we can do a more efficient flush.

Note, tuntap supports NAPI (IFF_NAPI), but the main use case is kernel 
rx path hardening. Unless rx batching is enabled, it would be slower 
than non NAPI mode. Technically, it can support XDP but need more work 
(e.g work at the level of XDP buffer instead of skb).

I tend to do fixes or optimizations on the current code unless we find a 
real blocker.

>
>> Fixes: 761876c857cb ("tap: XDP support")
> $ git describe --contains 761876c857cb
> v4.14-rc1~130^2~270^2

So please let me know if you're ok with the fix.

Thanks
