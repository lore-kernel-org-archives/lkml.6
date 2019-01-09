Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A47C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1499520859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XAJN8qsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfAINhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:37:33 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:35270 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfAINhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:37:32 -0500
Received: by mail-qt1-f173.google.com with SMTP id v11so8300530qtc.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 05:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZGZpB+vsfUpFk6bDAaBFLRr08cSkzQGRicfdJN+iSYU=;
        b=XAJN8qsAadZ2fBQs0WY8BJjZ/96/L3qdfmM2lMwNjpP0y6vGWJ72ti6F0RPIpibU5v
         EpWF7sk8opT5yVA/Eeylbs0Ebbl3tEWNDiOhU1zFBmXR0y3ImLEqyTbvsPfj4iK7iYdF
         7/q/YeEMLWlyacYYBajoLBy04y7yh1IyCb5G8gzH+g2VqC1wDfjJjMY4zYqhTQmrvAe9
         pHwGg8LZ9SYz0NUQV4nXWDHgfSbF/6MImJ3MUWyQfi68P8iEUMsRjiegHkH6WYcmD9C4
         D0eeNTEMjIhyo2Rb/B8X5/zA5wOCfeLDr550NhRkzmCKyd6djpfA+BSSVCUg1ew77sKG
         /crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZGZpB+vsfUpFk6bDAaBFLRr08cSkzQGRicfdJN+iSYU=;
        b=lX83eKngtnezpDDqlY54qPHkVYGgHfvn4ToSM+DVOIS/OMVz5xVTAspn7s8QmT5xw8
         l2klz3tt4JRAuJCn+ayibOGF9hZhYwqvoebHzb5tOzCL8YVtDT+RDwjoQsOu8g/+2Qxo
         Evy8JrT+q1FOSq2aaI56zjwRfys3Ru53hw3bD7dhyDwagZt0OWv1QkBm+Js2lwEBIHXg
         +O3ikNPwNWBRBpz1udJjljsrxlUGSt/xw8UdI3AJMCtkxn3CEW7s1AewdcL8T/ol/ai7
         qjjX0g5V75vQQ58EKsnKiu+aI4Rwhy8++efYDGZ47/zmQ8v0EPTMoZQ+67j9gdF6BPs9
         stzw==
X-Gm-Message-State: AJcUuke2pGwY3sH4UAcAHZTmaGk3zb9eJRyeUPKriHd8JzLulMf/uH/O
        dim0i4nqwlk+sDVqt4F8XZRN5Q==
X-Google-Smtp-Source: ALg8bN68XfJHdegVvvptPzZE1DUAf6+goOQZtO75TVsFougIrnDsrzPZjCneN5Po2K74met9U+8cmQ==
X-Received: by 2002:aed:2fc4:: with SMTP id m62mr5352669qtd.8.1547041051628;
        Wed, 09 Jan 2019 05:37:31 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b20sm42520585qkb.17.2019.01.09.05.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 05:37:31 -0800 (PST)
Subject: Re: lockdep warning while reading sysfs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
References: <2c9aaa31-d0b7-bc20-f109-751a2fccfb88@lca.pw>
 <20190109084441.GF1900@hirez.programming.kicks-ass.net>
From:   Qian Cai <cai@lca.pw>
Message-ID: <b7c543ce-6a2c-ac58-83f5-fd9816b77026@lca.pw>
Date:   Wed, 9 Jan 2019 08:37:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190109084441.GF1900@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> You stripped out the stack trace at the bottom that shows the inversion
> :/
> 

Sorry, I thought it is the same as in #0, but here it is the whole thing.

WARNING: possible circular locking dependency detected
5.0.0-rc1+ #60 Not tainted
------------------------------------------------------
read_all/2954 is trying to acquire lock:
00000000c63ff499 (mem_hotplug_lock.rw_sem){++++}, at: show_slab_objects+0x16c/0x450

but task is already holding lock:
0000000047ae17d7 (kn->count#70){++++}, at: kernfs_seq_start+0x79/0x170

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (kn->count#70){++++}:
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
       __lock_acquire+0x728/0x1200
       lock_acquire+0x269/0x5a0
       down_read+0x92/0x130
       memcg_get_cache_ids+0x15/0x20
       kmem_cache_create_usercopy+0x37/0x270
       kmem_cache_create+0x16/0x20
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
  lock(kn->count#70);
                               lock(slab_mutex);
                               lock(kn->count#70);
  lock(mem_hotplug_lock.rw_sem);

 *** DEADLOCK ***

3 locks held by read_all/2954:
 #0: 00000000e8745902 (&p->lock){+.+.}, at: seq_read+0x6b/0x1050
 #1: 00000000bb9fa87a (&of->mutex){+.+.}, at: kernfs_seq_start+0x4f/0x170
 #2: 0000000047ae17d7 (kn->count#70){++++}, at: kernfs_seq_start+0x79/0x170

stack backtrace:
CPU: 100 PID: 2954 Comm: read_all Kdump: loaded Not tainted 5.0.0-rc1+ #60
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 09/07/2018
Call Trace:
 dump_stack+0xe0/0x19a
 print_circular_bug.isra.10.cold.34+0x2f4/0x435
 check_prev_add.constprop.19+0xca1/0x15f0
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
RIP: 0033:0x7f01b0000b12
Code: 94 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0f 1f 80 00 00 00 00 f3
0f 1e fa 8b 05 36 d9 20 00 85 c0 75 12 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 56 c3
0f 1f 44 00 00 41 54 49 89 d4 55 48 89
RSP: 002b:00007ffd480fc058 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007ffd480fc100 RCX: 00007f01b0000b12
RDX: 00000000000003ff RSI: 00007ffd480fc500 RDI: 0000000000000003
RBP: 00007f01b040f000 R08: 0000000000000020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffd480fc500 R14: 0000000000000028 R15: 0000000000000003
