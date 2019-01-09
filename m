Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF06EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837E8217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="nmScwUZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAIWPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:15:18 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:36928 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAIWPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:15:17 -0500
Received: by mail-ed1-f44.google.com with SMTP id h15so8606637edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=esQ+QckP/gRbUhbDBxadSvJKhQOjQqSw19ASNUYnT2s=;
        b=nmScwUZrsVCzpeBf9CuFLHdO2BZ3g6itFFwbTylRLLqmQAxcH+tLuGz3KlvNc7o2qd
         j5xUhOpM7RDvT+oOAj/ElSPRkRs1yNPYjKAts/wOmQm+Y96NMi9kHLQ0WNyMTgMVx9Qz
         fH74u7VWAxASzuKs0rqofeUljmRGohyo+0dLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=esQ+QckP/gRbUhbDBxadSvJKhQOjQqSw19ASNUYnT2s=;
        b=KNWWEA24h6skqR6gXH7uBcFGfTHQBQ1vChx9utL0iIT4E0acEgPucsPGaEo/sO1ZH4
         4IwmJYogXe3JsOetxnrTDQZkKZGXk059UKQ8qJe9X5QnXty87TivDXVWOVQqYFgRs/oH
         u5cflXtHs85B4tF48Rb/CSDZOhepGXTy1HCT+bGUlxd88txs2DmMT9qOOf1rAnfnO2Kq
         klY3SqdB2eJX61+R4JtJQU232wBSJb9veWzteFE1+WVCdBMm6QlkedJ5pbKBrf5QhKdg
         GnF25/YdOl2eiQV+q2+DOnb1n+3jqIS4XmEosQeoF77ZSLSz3tTErTStuW12Lik6enTv
         oQyw==
X-Gm-Message-State: AJcUukfUoGYP5v4RVWcXoylTZUDN08Gcac9fFqxBJpw/nPf3Q4rTPxUk
        GjG/DXy0yNEgW2KeB/V5I3ifh8zM9q5YiU0ZGjQp+obUp5s=
X-Google-Smtp-Source: ALg8bN4H5eActP/Px44H//GvzCa2AO46I4IhFHC8qPbN+qHARldd9TRBICKCderQHYh6XRrf0SDsCLdL/DTvr6JGAzw=
X-Received: by 2002:a17:906:5c9:: with SMTP id t9-v6mr6612882ejt.111.1547072114911;
 Wed, 09 Jan 2019 14:15:14 -0800 (PST)
MIME-Version: 1.0
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Wed, 9 Jan 2019 14:14:38 -0800
Message-ID: <CAMp4zn-w8y7ubvWoqTGSUycFJTd9ir5OikE9F4TiM_FtG4XdXQ@mail.gmail.com>
Subject: Crash in list_add_leaf_cfs_rq due to bad tmp_alone_branch
To:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Gabriel Hartmann <ghartmann@netflix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix
infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
and put it on top of 4.19.13. In addition to this, I uninlined
list_add_leaf_cfs_rq for debugging.

This revealed a new bug that we didn't get to because we kept getting
crashes from the previous issue. When we are running with cgroups that
are rapidly changing, with CFS bandwidth control, and in addition
using the cpusets cgroup, we see this crash. Specifically, it seems to
occur with cgroups that are throttled and we change the allowed
cpuset.

[  590.128698] list_add corruption. next->prev should be prev
(ffff8b129c904388), but was 0000000000000000. (next=ffff8b129c904200).
[  590.131971] ------------[ cut here ]------------
[  590.133248] kernel BUG at lib/list_debug.c:25!
[  590.134478] invalid opcode: 0000 [#1] SMP PTI
[  590.135673] CPU: 88 PID: 65056 Comm: runc:[2:INIT] Kdump: loaded
Tainted: G           OE     4.19.13netflixdebug-46061-gf9fd7e5-dirty
#8
[  590.138828] Hardware name: Amazon EC2 r5.24xlarge/, BIOS 1.0 10/16/2017
[  590.140574] RIP: 0010:__list_add_valid+0x38/0x70
[  590.141839] Code: 75 19 48 8b 32 48 39 f0 75 22 48 39 fa 74 34 48
39 f8 74 2f b8 01 00 00 00 5d c3 48 89 c1 48 c7 c7 d8 98 8c a9 e8 1b
88 bd ff <0f> 0b 48 89 d1 48 c7 c7 30 99 8c a9 48 89 f2 48 89 c6 e8 04
88 bd
[  590.146570] RSP: 0018:ffffaedba3f23b30 EFLAGS: 00010086
[  590.148007] RAX: 0000000000000075 RBX: ffff8b1292b93200 RCX: 0000000000000000
[  590.149878] RDX: 0000000000000000 RSI: ffff8b1577c16858 RDI: ffff8b1577c16858
[  590.151769] RBP: ffffaedba3f23b30 R08: 0000000000000000 R09: 0000000000000000
[  590.153668] R10: ffffaedba3f23b20 R11: ffffffffa870aa8f R12: ffff8b1577ce3f40
[  590.155543] R13: ffff8b1292b93388 R14: ffff8b129c904388 R15: ffff8b129c904200
[  590.157452] FS:  00007f8143856b80(0000) GS:ffff8b1577c00000(0000)
knlGS:0000000000000000
[  590.160372] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  590.162742] CR2: 000000c4202d0000 CR3: 000000bc6431c003 CR4: 00000000007606e0
[  590.165463] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  590.168202] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  590.170890] PKRU: 55555554
[  590.172514] Call Trace:
[  590.174088]  list_add_leaf_cfs_rq+0x91/0x1a0
[  590.176120]  enqueue_entity+0x177/0x5f0
[  590.178032]  ? __lock_is_held+0x5e/0xa0
[  590.179980]  enqueue_task_fair+0x94/0x1d0
[  590.181935]  activate_task+0x54/0xa0
[  590.183775]  ttwu_do_activate+0x54/0xb0
[  590.185649]  try_to_wake_up+0x225/0x510
[  590.187609]  wake_up_state+0x10/0x20
[  590.189443]  signal_wake_up_state+0x19/0x30
[  590.191418]  zap_other_threads+0x74/0x90
[  590.193327]  flush_old_exec+0x9c/0x740
[  590.195199]  load_elf_binary+0x3a1/0x1760
[  590.197220]  ? find_held_lock+0x35/0xa0
[  590.199110]  ? find_held_lock+0x35/0xa0
[  590.200998]  ? search_binary_handler+0x88/0x1d0
[  590.203082]  search_binary_handler+0x9d/0x1d0
[  590.205107]  __do_execve_file.isra.27+0x709/0xa90
[  590.207313]  __x64_sys_execve+0x39/0x50
[  590.209233]  do_syscall_64+0x65/0x1a0
[  590.211126]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  590.213341] RIP: 0033:0x5606439cea2b
[  590.215195] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7
c2 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24
08 0f 05 <48> 3d 01 f0 ff ff 76 1b 48 c7 44 24 28 ff ff ff ff 48 c7 44
24 30
[  590.222457] RSP: 002b:000000c42027d0b8 EFLAGS: 00000206 ORIG_RAX:
000000000000003b
[  590.226164] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00005606439cea2b
[  590.228883] RDX: 000000c420226c60 RSI: 000000c420214400 RDI: 000000c4202d0210
[  590.231567] RBP: 000000c42027d150 R08: 0000000000000000 R09: 0000000000000000
[  590.234237] R10: 0000000000000000 R11: 0000000000000206 R12: ffffffffffffffff
[  590.237028] R13: 0000000000000039 R14: 0000000000000038 R15: 0000000000000055

This branch that it occurs on is the last one in list_add_leaf_cfs_rq,
where The parent has not already been added, so it tries to add the
cfs_rq to tmp_alone branch.


# So, ffff8b1292b93388 is the new item, and it looks reasonable:
crash>  struct cfs_rq -l cfs_rq.leaf_cfs_rq_list ffff8b1292b93388
struct cfs_rq {
  load = {
    weight = 1048576,
    inv_weight = 0
  },
  runnable_weight = 1048576,
  nr_running = 1,
  h_nr_running = 0,
  exec_clock = 0,
  min_vruntime = 18446744073708503040,
  tasks_timeline = {
    rb_root = {
      rb_node = 0xffff8b126ec79f98
    },
    rb_leftmost = 0xffff8b126ec79f98
  },
  curr = 0x0,
  next = 0x0,
  last = 0x0,
  skip = 0x0,
  nr_spread_over = 0,
  avg = {
    last_update_time = 590128483328,
    load_sum = 188416,
    runnable_load_sum = 188416,
    util_sum = 94210,
    period_contrib = 387,
    load_avg = 4,
    runnable_load_avg = 4,
    util_avg = 2,
    util_est = {
      enqueued = 0,
      ewma = 0
    }
  },
  removed = {
    lock = {
      raw_lock = {
        {
          val = {
            counter = 0
          },
          {
            locked = 0 '\000',
            pending = 0 '\000'
          },
          {
            locked_pending = 0,
            tail = 0
          }
        }
      },
      magic = 3735899821,
      owner_cpu = 4294967295,
      owner = 0xffffffffffffffff,
      dep_map = {
        key = 0xffffffffa9da21d0,
        class_cache = {0x0, 0x0},
        name = 0xffffffffa987c66f "&cfs_rq->removed.lock"
      }
    },
    nr = 0,
    load_avg = 0,
    util_avg = 0,
    runnable_sum = 0
  },
  tg_load_avg_contrib = 4,
  propagate = 1,
  prop_runnable_sum = 184,
  h_load = 0,
  last_h_load_update = 0,
  h_load_next = 0x0,
  rq = 0xffff8b1577ce3f40,
  freed = 0,
  retired = 0,
  manipulated = 0,
  on_list = 0,
  leaf_cfs_rq_list = {
    next = 0x0,
    prev = 0x0
  },
  tg = 0xffff8b12c011d100,
  runtime_enabled = 1,
  expires_seq = 0,
  runtime_expires = 0,
  runtime_remaining = 0,
  throttled_clock = 0,
  throttled_clock_task = 589819246302,
  throttled_clock_task_time = 0,
  throttled = 0,
  throttle_count = 0,
  throttled_list = {
    next = 0xffff8b1292b933d8,
    prev = 0xffff8b1292b933d8
  }
}


Let's grab it's rq:
crash> struct cfs_rq.rq -l cfs_rq.leaf_cfs_rq_list ffff8b1292b93388
  rq = 0xffff8b1577ce3f40

The rq's leaf_cfs_rq_list looks self-consistent.
crash> struct rq.leaf_cfs_rq_list 0xffff8b1577ce3f40
  leaf_cfs_rq_list = {
    next = 0xffff8b12ea889588,
    prev = 0xffff8b1577ce4188
  }

crash> list 0xffff8b12ea889588
ffff8b12ea889588
ffff8b12e0673788
ffff8b12dd860588
ffff8b12e98a8188
ffff8b12dd63b188
ffff8b12eab16588
ffff8b12c9954388
ffff8b12eaa63188
ffff8b12ee361d88
ffff8b12e9b98188
ffff8b12c98ab388
ffff8b12c2c5b788
ffff8b12c08f6788
ffff8b12e3c4ab88
ffff8b12eaa54788
ffff8b12e9ad1b88
ffff8b12e982eb88
ffff8b12ea069b88
ffff8b12ea220388
ffff8b1577ce4188
ffff8b1577ce4940


What's our current tmp_alone branch?
crash> struct rq.tmp_alone_branch 0xffff8b1577ce3f40
  tmp_alone_branch = 0xffff8b129c904388

This seems malformed:
crash> list -s cfs_rq.leaf_cfs_rq_list -l cfs_rq.leaf_cfs_rq_list
0xffff8b129c904388
ffff8b129c904388
  leaf_cfs_rq_list = {
    next = 0xffff8b129c904200,
    prev = 0xffff8b129c9043b1
  }
ffff8b129c904200
  leaf_cfs_rq_list = {
    next = 0xffff8b129c904e00,
    prev = 0x0
  }
ffff8b129c904e00
  leaf_cfs_rq_list = {
    next = 0xffff8b129c906400,
    prev = 0x0
  }
ffff8b129c906400
  leaf_cfs_rq_list = {
    next = 0xffff8b129c907400,
    prev = 0x0
  }
ffff8b129c907400
  leaf_cfs_rq_list = {
    next = 0xffff8b129c904c00,
    prev = 0x0
  }
ffff8b129c904c00
  leaf_cfs_rq_list = {
    next = 0xffff8b129c906e00,
    prev = 0x0
  }
ffff8b129c906e00
  leaf_cfs_rq_list = {
    next = 0xffff8b129c906a00,
    prev = 0x0
  }
ffff8b129c906a00
  leaf_cfs_rq_list = {
    next = 0xffff8b129c904800,
    prev = 0x0
  }
ffff8b129c904800
  leaf_cfs_rq_list = {
    next = 0xffff8b129c906600,
    prev = 0x0
  }
ffff8b129c906600
  leaf_cfs_rq_list = {
    next = 0xffff8b129c904400,
    prev = 0x0
  }
ffff8b129c904400
  leaf_cfs_rq_list = {
    next = 0xffff8b129c905200,
    prev = 0x0
  }
ffff8b129c905200
  leaf_cfs_rq_list = {
    next = 0xffff8b129c906200,
    prev = 0x0
  }
ffff8b129c906200
  leaf_cfs_rq_list = {
    next = 0xffff8b129c905400,
    prev = 0x0
  }
ffff8b129c905400
  leaf_cfs_rq_list = {
    next = 0xffff8b129c907600,
    prev = 0x0
  }
ffff8b129c907600
  leaf_cfs_rq_list = {
    next = 0xffff8b129c907000,
    prev = 0x0
  }
ffff8b129c907000
  leaf_cfs_rq_list = {
    next = 0xffff8b129c906000,
    prev = 0x0
  }
ffff8b129c906000
  leaf_cfs_rq_list = {
    next = 0xffff8b129c907c00,
    prev = 0x0
  }
ffff8b129c907c00
  leaf_cfs_rq_list = {
    next = 0xffff8b129c905c00,
    prev = 0x0
  }
ffff8b129c905c00
  leaf_cfs_rq_list = {
    next = 0xffff8b129c905e00,
    prev = 0x0
  }
ffff8b129c905e00
  leaf_cfs_rq_list = {
    next = 0xffff8b129c907e00,
    prev = 0x0
  }
ffff8b129c907e00
  leaf_cfs_rq_list = {
    next = 0xffff8b129c905000,
    prev = 0x0
  }
ffff8b129c905000
  leaf_cfs_rq_list = {
    next = 0xffff8b129c906c00,
    prev = 0x0
  }
ffff8b129c906c00
  leaf_cfs_rq_list = {
    next = 0xffff8b129c904000,
    prev = 0x0
  }
ffff8b129c904000
  leaf_cfs_rq_list = {
    next = 0x0,
    prev = 0x0
  }

--
I'm not sure what's causing this. Perhaps there's some issue if the
allowed CPU set changes under throttle. It appears that
tmp_alone_branch points to a cfs_rq that's already been freed. Since I
couldn't replicate this with KASAN on, we verified this by overwriting
the cfs_rq with 0xff in free_fair_sched_group. When we examined the
cfs_rq that the rq->tmp_alone_branch pointed to, it had this pattern.
