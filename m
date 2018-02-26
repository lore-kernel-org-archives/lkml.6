Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeBZLCP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:02:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752379AbeBZLCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:02:13 -0500
Date: Mon, 26 Feb 2018 12:02:09 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        sergei.shtylyov@cogentembedded.com, christoffer.dall@linaro.org,
        brouer@redhat.com
Subject: Re: [PATCH V4 net 2/3] tuntap: disable preemption during XDP
 processing
Message-ID: <20180226120209.3c3b172b@redhat.com>
In-Reply-To: <1519443146-9089-2-git-send-email-jasowang@redhat.com>
References: <1519443146-9089-1-git-send-email-jasowang@redhat.com>
        <1519443146-9089-2-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Feb 2018 11:32:25 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Except for tuntap, all other drivers' XDP was implemented at NAPI
> poll() routine in a bh. This guarantees all XDP operation were done at
> the same CPU which is required by e.g BFP_MAP_TYPE_PERCPU_ARRAY. But

There is a typo in the defined name "BFP_MAP_TYPE_PERCPU_ARRAY".
Besides it is NOT a requirement that comes from the map type
BPF_MAP_TYPE_PERCPU_ARRAY.

The requirement comes from the bpf_redirect_map helper (and only partly
devmap + cpumap types), as the BPF helper/program stores information in
the per-cpu redirect_info struct (see filter.c), that is used by
xdp_do_redirect() and xdp_do_flush_map().

 struct redirect_info {
	u32 ifindex;
	u32 flags;
	struct bpf_map *map;
	struct bpf_map *map_to_flush;
	unsigned long   map_owner;
 };
 static DEFINE_PER_CPU(struct redirect_info, redirect_info);

 [...]
 void xdp_do_flush_map(void)
 { 
	struct redirect_info *ri = this_cpu_ptr(&redirect_info);
	struct bpf_map *map = ri->map_to_flush;
 [...]

Notice the same redirect_info is used by the TC clsbpf system...


> for tuntap, we do it in process context and we try to protect XDP
> processing by RCU reader lock. This is insufficient since
> CONFIG_PREEMPT_RCU can preempt the RCU reader critical section which
> breaks the assumption that all XDP were processed in the same CPU.
> 
> Fixing this by simply disabling preemption during XDP processing.

I guess, this could pamper over the problem...

But I generally find it problematic that the tuntap is not invoking XDP
from NAPI poll() routine in BH-context, as that context provided us
with some protection that allow certain kind of optimizations (like
this flush API).  I hope this will not limit us in the future, that
tuntap driver violate the XDP call context.

> Fixes: 761876c857cb ("tap: XDP support")

$ git describe --contains 761876c857cb
v4.14-rc1~130^2~270^2
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
