Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE82EC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A744E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A744E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeGSI1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:27:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731215AbeGSI1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:27:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B94753AA104F;
        Thu, 19 Jul 2018 15:45:05 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 15:45:02 +0800
Subject: Re: [PATCH] net/9p/trans_virtio.c: replace mutex_lock with spin_lock
 to protect 'virtio_chan_list'
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B4EF511.7090104@huawei.com> <20180718095420.GA28377@nautica>
 <5B4FF6DB.1040101@huawei.com> <20180719033608.GA29510@nautica>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eric Van Hensbergen" <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        "Latchesar Ionkov" <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B50415C.5030605@huawei.com>
Date:   Thu, 19 Jul 2018 15:44:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180719033608.GA29510@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/19 11:36, Dominique Martinet wrote:
> piaojun wrote on Thu, Jul 19, 2018:
>>> piaojun wrote on Wed, Jul 18, 2018:
>>> That's not a fast path operation, I don't mind changing things but I'd
>>> like to understand why - these functions are only ever called at unmount
>>> time or when something happens on the virtio bus (probe will happen on
>>> probing on the pci bus and I'm not too sure on remove but probably pci
>>> removal i.e. basically never?)
>>>
>>> I don't see why this wouldn't work, but I won't take this without a
>>> (good?) reason.
>>>
>> virtio_9p_lock is responsable for protecting virtio_chan_list which has 3
>> operation:
>>
>> 1. Add a virtio chan to virtio_chan_list. This will happen when we insmod
>> 9pnet_virtio.ko:
>> p9_virtio_probe
>> --list_add_tail(&chan->chan_list, &virtio_chan_list);
>>
>> 2. Remove a virtio chan. This will happen when remnod 9pnet_virtio.ko:
>> p9_virtio_remove
>> --list_del(&chan->chan_list);
>>
>> 3. Find a unused virtio chan when mount 9p:
>> mount
>> --p9_virtio_create
>> --list_for_each_entry(chan, &virtio_chan_list, chan_list)
>>
>> Multi mount process will compete for virtio_9p_lock when finding unused
>> virtio chan, in which case mutex lock will cause process sleep and wake
>> up. I think this a waste of CPU time. So we could use spin lock to avoid
>> this.
> 
> Well, sure, that's theory; but how is that in practice?
> I actually took the time to run some tests, setting up 20 virtio mount
> points in qemu, and running this command with and without your patch:
> # time sh -c 'for i in {1..20}; do
>   sh -c "for j in {1..100}; do
>     mount -t 9p d$i d.$i;
>     umount d.$i;
>   done" &
>   done;
>   wait'
> 
> This is quick & dirty but basically, mounts and unmounts 100 times in a
> loop all 20 mount points in parallel to stress that lock.
> I get these times 5 times (one run per column),
> without patch:
> real	0m19.357s	0m19.626s	0m19.904s	0m19.926s	0m21.321s
> user	0m6.795s	0m6.874s	0m6.807s	0m6.768s	0m6.892s
> sys		0m29.936s	0m31.196s	0m31.702s	0m31.914s	0m30.791s
> 
> With patch:
> real	0m19.439s	0m19.849s	0m19.683s	0m19.600s	0m20.689s
> user	0m6.948s	0m6.582s	0m6.706s	0m6.598s	0m6.876s
> sys		0m29.364s	0m30.898s	0m30.695s	0m31.311s	0m33.391s
> 
> I honestly can't say I'm convinced with a difference either way, the
> variations look more like noise than anything to me.
> 
> 
> More to the point, while these tests ran my dmesg buffer was filled with
> errors like:
> FS-Cache: Duplicate cookie detected
> FS-Cache: O-cookie c=0000000000368cdb [p=00000000548b03c2 fl=222 nc=0 na=1]
> FS-Cache: O-cookie d=000000004cebd15f n=00000000029a0b83
> FS-Cache: O-key=[10] '34323935303838343536'
> FS-Cache: N-cookie c=00000000d4089478 [p=00000000548b03c2 fl=2 nc=0 na=1]
> FS-Cache: N-cookie d=000000004cebd15f n=00000000959d4d37
> FS-Cache: N-key=[10] '34323935303838343536'
> 
> or
> (output mangled a bit)
> 
> ==================================================================
> BUG: KASAN: use-after-free in p9_client_cb+0x14d/0x160 [9pnet]
> Read of size 8 at addr ffff88003522a088 by task systemd-udevd/492
> 
> CPU: 1 PID: 492 Comm: systemd-udevd Tainted: G           O      4.18.0-rc5+ #9
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180531_142017-buildhw-08.phx2.fedoraproject.org-1.fc28 0>
> Call Trace:
>  <IRQ>
>  dump_stack+0x7b/0xad
>  print_address_description+0x6a/0x209
>  ? p9_client_cb+0x14d/0x160 [9pnet]
>  kasan_report.cold.7+0x242/0x2fe
>  __asan_report_load8_noabort+0x19/0x20
>  p9_client_cb+0x14d/0x160 [9pnet]
>  req_done+0x22f/0x280 [9pnet_virtio]
>  ? p9_mount_tag_show+0x120/0x120 [9pnet_virtio]
>  vring_interrupt+0x108/0x1b0 [virtio_ring]
>  ? vring_map_single.constprop.23+0x350/0x350 [virtio_ring]
>  __handle_irq_event_percpu+0xec/0x460
>  handle_irq_event_percpu+0x71/0x140
>  ? __handle_irq_event_percpu+0x460/0x460
>  ? apic_ack_irq+0xa3/0xe0
>  handle_irq_event+0xb9/0x14a
>  handle_edge_irq+0x1ea/0x7a0
>  ? kasan_check_read+0x11/0x20
>  handle_irq+0x48/0x60
>  do_IRQ+0x67/0x140
>  common_interrupt+0xf/0xf
>  </IRQ>
> RIP: 0010:finish_task_switch+0x10e/0x630
> Code: e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 6d 04 00 00 41 c7 45 38 00 00 00 00 4c 89 e7 ff 14 25 28 f5 66 8e fb 66 0f >
> RSP: 0018:ffff8800633e7a60 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffd4
> RAX: 0000000000000001 RBX: ffff880036632000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88006caaac00
> RBP: ffff8800633e7aa0 R08: ffffed000cea15cd R09: ffffed000cea15cc
> R10: ffffed000cea15cc R11: ffff88006750ae63 R12: ffff88006caaac00
> R13: ffff88006558b000 R14: 0000000000000000 R15: ffff880036632000
>  ? __switch_to_asm+0x34/0x70
>  ? __switch_to_asm+0x40/0x70
>  __schedule+0x733/0x1c10
>  ? __bpf_prog_run64+0xd0/0xd0
>  ? firmware_map_remove+0x174/0x174
>  schedule+0x7a/0x1a0
>  schedule_hrtimeout_range_clock+0x306/0x3b0
>  ? kasan_check_write+0x14/0x20
>  ? hrtimer_nanosleep_restart+0x290/0x290
>  ? ep_busy_loop_end+0x110/0x110
>  schedule_hrtimeout_range+0x13/0x20
>  ep_poll+0x7a7/0xb50
>  ? __ia32_sys_epoll_ctl+0x1170/0x1170
>  ? __fget_light+0x59/0x1f0
>  ? __audit_syscall_entry+0x347/0x980
>  ? __audit_free+0x8a0/0x8a0
> 34
>  ? wake_up_q+0x100/0x100
> 39
>  ? kasan_check_read+0x11/0x20
> 3230373130'
> FS-Cache: O-key=[10] '34323934393230373131'
> FS-Cache: N-cookie c=00000000fa69c1f9 [p=00000000887326c4 fl=2 nc=0 na=1]
> FS-Cache: N-cookie d=00000000a8f143d1 n=00000000446f741a
> FS-Cache: N-key=[10] '34323934393230373131'
>  ? __fget_light+0x59/0x1f0
>  do_epoll_wait+0x129/0x160
>  __x64_sys_epoll_wait+0x97/0xf0
>  do_syscall_64+0xa5/0x260
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f9099a22317
> Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8d 05 d1 46 2c 00 41 89 ca 8b 00 85 c0 75 10 b8 e8 00 >
> RSP: 002b:00007ffff67e1f28 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
> RAX: ffffffffffffffda RBX: 0000558182d9e390 RCX: 00007f9099a22317
> RDX: 000000000000000b RSI: 00007ffff67e1f30 RDI: 000000000000000b
> RBP: 00007ffff67e20b0 R08: 0000000006c65ded R09: 00007ffff67e1f30
> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffff67e1f30 R14: ffffffffffffffff R15: 0000558182d7a4c0
> 
> Allocated by task 6390:
>  save_stack+0x43/0xd0
>  kasan_kmalloc+0xc4/0xe0
>  kasan_slab_alloc+0x12/0x20
>  kmem_cache_alloc+0xe2/0x5e0
>  p9_client_prepare_req+0xa4/0x670 [9pnet]
>  p9_client_rpc+0x133/0xd20 [9pnet]
>  p9_client_getattr_dotl+0x102/0x910 [9pnet]
>  v9fs_mount+0x5a6/0x7c0 [9p]
>  mount_fs+0x89/0x2ad
>  vfs_kern_mount.part.32+0x5d/0x390
>  do_mount+0x379/0x2bb0
>  ksys_mount+0xbf/0xe0
>  __x64_sys_mount+0xbe/0x150
>  do_syscall_64+0xa5/0x260
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Freed by task 6390:
>  save_stack+0x43/0xd0
>  __kasan_slab_free+0x118/0x170
>  kasan_slab_free+0xe/0x10
>  kmem_cache_free+0x49/0x160
>  p9_free_req+0x106/0x140 [9pnet]
>  p9_client_getattr_dotl+0x590/0x910 [9pnet]
>  v9fs_mount+0x5a6/0x7c0 [9p]
>  mount_fs+0x89/0x2ad
>  vfs_kern_mount.part.32+0x5d/0x390
>  do_mount+0x379/0x2bb0
>  ksys_mount+0xbf/0xe0
>  __x64_sys_mount+0xbe/0x150
>  do_syscall_64+0xa5/0x260
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The buggy address belongs to the object at ffff88003522a068
>  which belongs to the cache p9_req_t of size 72
> The buggy address is located 32 bytes inside of
>  72-byte region [ffff88003522a068, ffff88003522a0b0)
> The buggy address belongs to the page:
> page:ffffea0000d48a80 count:1 mapcount:0 mapping:ffff880064562580 index:0x0
> flags: 0xffffc000000100(slab)
> raw: 00ffffc000000100 ffff880035e36618 ffffea00019fa888 ffff880064562580
> raw: 0000000000000000 ffff88003522a000 0000000100000027 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff880035229f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88003522a000: fb fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb
>> ffff88003522a080: fb fb fb fb fb fb fc fc fc fc fb fb fb fb fb fb
>                       ^
>  ffff88003522a100: fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb fb
>  ffff88003522a180: fc fc fc fc fb fb fb fb fb fb fb fb fb fc fc fc
> ==================================================================
> 
> so if you're concerned about parallel mountings, I think there are
> others, more important, bugs to fix rather than replacing a hardly-used
> mutex by a spin-lock...
> 
It makes sense, and bug fix comes first. I will look into the bug you tested.

Thanks,
Jun

> 
> 
> You've done the work now so it's not like I can't take the patch, but it
> really feels pointless to me unless you can show me there is actual
> improvement.
> 
