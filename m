Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeDKAk0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 20:40:26 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:43227 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752539AbeDKAkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 20:40:25 -0400
X-Google-Smtp-Source: AIpwx4+JnIQKELKRkPy6xmC5d+3OSNncZ6dUcBlemjfGxuYEt2TPP6ckPEr7zZOlzsBn+69q55hag1bCKplTlcUxHx4=
MIME-Version: 1.0
References: <201804080259.VS5U0mKT%fengguang.wu@intel.com> <20180410005908.167976-1-gthelen@google.com>
 <55efb2c6-04c5-d2bb-738e-8308aa0eaf8f@meituan.com>
In-Reply-To: <55efb2c6-04c5-d2bb-738e-8308aa0eaf8f@meituan.com>
From: Greg Thelen <gthelen@google.com>
Date: Wed, 11 Apr 2018 00:40:11 +0000
Message-ID: <CAHH2K0aMhquqkpbxEWR3CoeDyHyZHViYK3y629U+=Hguo_vgKQ@mail.gmail.com>
Subject: Re: [PATCH v3] writeback: safer lock nesting
To: Wang Long <wanglong19@meituan.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        npiggin@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3B0eU5d011933

On Tue, Apr 10, 2018 at 1:15 AM Wang Long <wanglong19@meituan.com> wrote:

> > lock_page_memcg()/unlock_page_memcg() use spin_lock_irqsave/restore() if
> > the page's memcg is undergoing move accounting, which occurs when a
> > process leaves its memcg for a new one that has
> > memory.move_charge_at_immigrate set.
> >
> > unlocked_inode_to_wb_begin,end() use spin_lock_irq/spin_unlock_irq() if
the
> > given inode is switching writeback domains.  Switches occur when enough
> > writes are issued from a new domain.
> >
> > This existing pattern is thus suspicious:
> >      lock_page_memcg(page);
> >      unlocked_inode_to_wb_begin(inode, &locked);
> >      ...
> >      unlocked_inode_to_wb_end(inode, locked);
> >      unlock_page_memcg(page);
> >
> > If both inode switch and process memcg migration are both in-flight then
> > unlocked_inode_to_wb_end() will unconditionally enable interrupts while
> > still holding the lock_page_memcg() irq spinlock.  This suggests the
> > possibility of deadlock if an interrupt occurs before
> > unlock_page_memcg().
> >
> >      truncate
> >      __cancel_dirty_page
> >      lock_page_memcg
> >      unlocked_inode_to_wb_begin
> >      unlocked_inode_to_wb_end
> >      <interrupts mistakenly enabled>
> >                                      <interrupt>
> >                                      end_page_writeback
> >                                      test_clear_page_writeback
> >                                      lock_page_memcg
> >                                      <deadlock>
> >      unlock_page_memcg
> >
> > Due to configuration limitations this deadlock is not currently possible
> > because we don't mix cgroup writeback (a cgroupv2 feature) and
> > memory.move_charge_at_immigrate (a cgroupv1 feature).
> >
> > If the kernel is hacked to always claim inode switching and memcg
> > moving_account, then this script triggers lockup in less than a minute:
> >    cd /mnt/cgroup/memory
> >    mkdir a b
> >    echo 1 > a/memory.move_charge_at_immigrate
> >    echo 1 > b/memory.move_charge_at_immigrate
> >    (
> >      echo $BASHPID > a/cgroup.procs
> >      while true; do
> >        dd if=/dev/zero of=/mnt/big bs=1M count=256
> >      done
> >    ) &
> >    while true; do
> >      sync
> >    done &
> >    sleep 1h &
> >    SLEEP=$!
> >    while true; do
> >      echo $SLEEP > a/cgroup.procs
> >      echo $SLEEP > b/cgroup.procs
> >    done
> >
> > Given the deadlock is not currently possible, it's debatable if there's
> > any reason to modify the kernel.  I suggest we should to prevent future
> > surprises.
> This deadlock occurs three times in our environment，

> this deadlock occurs three times in our environment. It is better to cc
stable kernel and
> backport it.

That's interesting.  Are you using cgroup v1 or v2?  Do you enable
memory.move_charge_at_immigrate?
I assume you've been using 4.4 stable.  I'll look closer at it at a 4.4
stable backport.
