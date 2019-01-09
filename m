Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0E2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC70E20675
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="a4IKljUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfAIEnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:43:22 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43712 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIEnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:43:22 -0500
Received: by mail-qt1-f173.google.com with SMTP id i7so7020436qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 20:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qlVeLefOx9oW6ksIJLiXdRUlk904SxBn+Ogp27oY2OU=;
        b=a4IKljUfpeqXKX16RLbepOWUBWWIEQkulpzx2d9I/YXvcJsfipno7UTWMKxtxhyGGH
         tUUvPhBFdjWXmxwXCDMEkp1UB1aO5kcILAX/NlJEuq8jO7E4VS6PY4TKmB4vi0pJ3zLd
         aW+G9bJCkkA6XQBoeYvHwqoevepYY415ECd85TDzKpdkO6ywAtF+3M07e/G1XBrOE4Ja
         DBgyevoBI2dlmg05y44IFogI1qt+fdsTFSeM22pFPc70p37+KAFqtvK9HXeEpVwQoWz6
         pS2tbYrLcCZ0GwCXGqvT7yuRp1KOpWGPIHXjJ6rRAoGQYOG39NJXCvqDC51nYEGvCSan
         Ctgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qlVeLefOx9oW6ksIJLiXdRUlk904SxBn+Ogp27oY2OU=;
        b=Hx1sjjKNZyLk6typx09tH/oV4hfiEdFTPKHb2bSR8gV/BcxOat+iRsqPfaB7QsMGSP
         I+GBLTHspPhsdj/DFMBgg9TWcJMXfD1YRKk4lhO4oueTShmL5ei/fvVLQx4XkUk+x2jT
         7DeRn708OkZMHcmXcnk/IDEsDlM5LPV1HyrovUv0+RyPgs48wWl0A2KnGlrpZSMpW49d
         x4Ehm/qQmcagTcDzJGGN4QaTjuyrLkauR5isP9JzUSsaEuTrPjKTAx+lBGWvYePerOap
         wIUQQl89fiRzbqa9LLLc3qbJ7VPZlRP/oi70B+aNQKzbXasmRjntzBT5PF3jNmgFoO+3
         x/7w==
X-Gm-Message-State: AJcUukdXDWfxUBpdo1x9FwcK/QgGkpzn24QjQCsifze5RhEGZK3WEWca
        +NwDw+CzaOYb21bch4px2koHTw==
X-Google-Smtp-Source: ALg8bN4tXVP+1HaPtYkmav2VtVKux8VX1NOMFLmq70ewUtp2EtEsCHUf0zslxtNiS8ZTqC7/aB0MNQ==
X-Received: by 2002:ac8:25d0:: with SMTP id f16mr4331354qtf.129.1547009000853;
        Tue, 08 Jan 2019 20:43:20 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s36sm49184581qth.17.2019.01.08.20.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 20:43:20 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
Subject: lockdep warning while reading sysfs
To:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <2c9aaa31-d0b7-bc20-f109-751a2fccfb88@lca.pw>
Date:   Tue, 8 Jan 2019 23:43:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP: starting read_all_sys (read_all -d /sys -q -r 10 -e /sys/power/wakeup_count)

Suppose this simply by reading files in /sys/kernel/slab/* would trigger this.
Basically, it acquired kn->count#69 in kernfs_seq_start():

mutex_lock(&of->mutex);
if (!kernfs_get_active(of->kn))

in kernfs_get_active():

if (kernfs_lockdep(kn))
	rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);

Then, it will acquires mem_hotplug_lock.rw_sem in show_slab_objects() ->
get_online_mems()

Then, another CPU acquired mem_hotplug_lock.rw_sem, and then calls
secondary_startup() I guess it it from the CPU hotplug path to trigger a deadlock.

======================================================
WARNING: possible circular locking dependency detected
5.0.0-rc1+ #60 Not tainted
------------------------------------------------------
read_all/7952 is trying to acquire lock:
0000000019f12603 (mem_hotplug_lock.rw_sem){++++}, at: show_slab_objects+0x16c/0x450

but task is already holding lock:
000000008804717f (kn->count#69){++++}, at: kernfs_seq_start+0x79/0x170

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (kn->count#69){++++}:
       __lock_acquire+0x728/0x1200
       lock_acquire+0x269/0x5a0
       __kernfs_remove+0x72f/0x9a0
       kernfs_remove_by_name_ns+0x45/0x90
       sysfs_remove_link+0x3c/0xa0
       sysfs_slab_add+0x1bd/0x330
       __kmem_cache_create+0x166/0x1c0
       create_cache+0xcf/0x1f0
       kmem_cache_create_usercopy+0x1aa/0x270
       kmem_cache_create+0x16/0x20
       mlx5_init_fs+0x195/0x1a10 [mlx5_core]
       mlx5_load_one+0x1106/0x1e90 [mlx5_core]
       init_one+0x864/0xd60 [mlx5_core]
       local_pci_probe+0xda/0x190
       work_for_cpu_fn+0x56/0xa0
       process_one_work+0xad7/0x1b80
       worker_thread+0x8ff/0x1370
       kthread+0x32c/0x3f0
       ret_from_fork+0x27/0x50

-> #2 (slab_mutex){+.+.}:
       __lock_acquire+0x728/0x1200
       lock_acquire+0x269/0x5a0
       __mutex_lock+0x168/0x1730
       mutex_lock_nested+0x1b/0x20
       kmem_cache_create_usercopy+0x45/0x270
       kmem_cache_create+0x16/0x20
       ptlock_cache_init+0x24/0x2d
       start_kernel+0x40e/0x7e0
       x86_64_start_reservations+0x24/0x26
       x86_64_start_kernel+0xef/0xf6
       secondary_startup_64+0xb6/0xc0

-> #1 (memcg_cache_ids_sem){++++}:
       ptlock_cache_init+0x24/0x2d
       start_kernel+0x40e/0x7e0
       x86_64_start_reservations+0x24/0x26
       x86_64_start_kernel+0xef/0xf6
       secondary_startup_64+0xb6/0xc0

-> #0 (mem_hotplug_lock.rw_sem){++++}:
       validate_chain.isra.14+0x11af/0x3b50
       __lock_acquire+0x728/0x1200
       lock_acquire+0x269/0x5a0
       get_online_mems+0x3d/0x80
       show_slab_objects+0x16c/0x450
       total_objects_show+0x13/0x20
       slab_attr_show+0x1e/0x30
       sysfs_kf_seq_show+0x1d5/0x470
       kernfs_seq_show+0x1fa/0x2c0
       seq_read+0x3f7/0x1050
       kernfs_fop_read+0x126/0x650
       __vfs_read+0xeb/0xf20
       vfs_read+0x103/0x290
       ksys_read+0xfa/0x260
       __x64_sys_read+0x73/0xb0
       do_syscall_64+0x18f/0xd23
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  mem_hotplug_lock.rw_sem --> slab_mutex --> kn->count#69

 Possible unsafe locking scenario:

       CPU0                    CPU1
       CPU0                    CPU1
       ----                    ----
  lock(kn->count#69);
                               lock(slab_mutex);
                               lock(kn->count#69);
  lock(mem_hotplug_lock.rw_sem);


3 locks held by read_all/7952:
 #0: 0000000005c4ddec (&p->lock){+.+.}, at: seq_read+0x6b/0x1050
 #1: 00000000c2f2e854 (&of->mutex){+.+.}, at: kernfs_seq_start+0x4f/0x170
 #2: 000000008804717f (kn->count#69){++++}, at: kernfs_seq_start+0x79/0x170


