Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeDSPex (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:34:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34758 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbeDSPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:34:51 -0400
Date: Thu, 19 Apr 2018 16:34:48 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Alexander Aring <aring@mojatatu.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [bisected] Stack overflow after fs: "switch the IO-triggering
 parts of umount to fs_pin" (was net namespaces kernel stack overflow)
Message-ID: <20180419153447.GH30522@ZenIV.linux.org.uk>
References: <CAOHTApjPwWDxHmGrfMwFvszWubfjJ7YfBgZL-DQ0mdv00UtQEQ@mail.gmail.com>
 <ef45eb94-4480-0683-ccc0-eb1efaf7e96c@virtuozzo.com>
 <d6e6f694-1bd9-7f3e-eaa8-1947c47f523f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e6f694-1bd9-7f3e-eaa8-1947c47f523f@virtuozzo.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:50:25PM +0300, Kirill Tkhai wrote:
> Hi, Al,
> 
> commit 87b95ce0964c016ede92763be9c164e49f1019e9 is the first after which the below test crashes the kernel:
> 
>     Author: Al Viro <viro@zeniv.linux.org.uk>
>     Date:   Sat Jan 10 19:01:08 2015 -0500
> 
>     switch the IO-triggering parts of umount to fs_pin
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> $modprobe dummy
> 
> $while true
>  do
>      mkdir /var/run/netns
>      touch /var/run/netns/init_net
>      mount --bind /proc/1/ns/net /var/run/netns/init_net
> 
>      ip netns add foo
>      ip netns exec foo ip link add dummy0 type dummy
>      ip netns delete foo
> done

I can reproduce that, all right, and with a stack chain that
looks like this:
[77132.414912]  pin_kill+0x81/0x150
[77132.424362]  ? finish_wait+0x80/0x80
[77132.433917]  mnt_pin_kill+0x1e/0x30
[77132.443829]  cleanup_mnt+0x6b/0x70
[77132.453477]  pin_kill+0x81/0x150
[77132.463064]  ? finish_wait+0x80/0x80
[77132.472553]  group_pin_kill+0x1a/0x30
[77132.481973]  namespace_unlock+0x6f/0x80
[77132.491801]  put_mnt_ns+0x1d/0x30
[77132.501258]  free_nsproxy+0x17/0x90
[77132.510604]  do_exit+0x2dc/0xb40
[77132.520146]  ? handle_mm_fault+0xaa/0x1e0
[77132.529725]  do_group_exit+0x3a/0xa0
[77132.539506]  SyS_exit_group+0x10/0x10
with the top 4 entries repeated a lot.  Those cleanup_mnt()
could be called from __cleanup_mnt(), delayed_mntput() or
mntput_no_expire().

__cleanup_mnt() is only fed to task_work_add(); no way in hell
would you get the call stack similar to that; it would be
called by task_work_run() from exit_task_work() from
do_exit().  Not in the evidence.

delayed_mntput() is only fed to schedule_delayed_work();
again, not a chance of having the call chain like that.

The one in mntput_no_expire() is a tail-call, with
mntput_no_expire() called from umount(2) and mntput()
(tail-calls both of them).  The former is never called
from exit(2), so that call chain reads

pin_kill -> mntput or something tail-calling mntput -> mntput_no_expire ->
cleanup_mnt -> mnt_pin_kill -> pin_kill

Now, the thing called by pin_kill must be something passed to
init_fs_pin(), i.e. acct_pin_kill() or drop_mountpoint().
acct_pin_kill() ends with
        pin_remove(pin);
        acct_put(acct);
}
with
static void acct_put(struct bsd_acct_struct *p)
{
        if (atomic_long_dec_and_test(&p->count))
                kfree_rcu(p, rcu);
}

IOW, no tail-call of mntput() in there.  OTOH,
static void drop_mountpoint(struct fs_pin *p)
{
        struct mount *m = container_of(p, struct mount, mnt_umount);
        dput(m->mnt_ex_mountpoint);
        pin_remove(p);
        mntput(&m->mnt);
}
*does* have the tail-call, so this call chain must be
pin_kill -> drop_mountpoint -> mntput -> mntput_no_expire ->
cleanup_mnt -> mnt_pin_kill -> pin_kill

So far, so good, but if you look into mntput_no_expire() you see
        if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
                struct task_struct *task = current;
                if (likely(!(task->flags & PF_KTHREAD))) {
                        init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
                        if (!task_work_add(task, &mnt->mnt_rcu, true))
                                return;
                }
                if (llist_add(&mnt->mnt_llist, &delayed_mntput_list))
                        schedule_delayed_work(&delayed_mntput_work, 1);
                return;
        }
        cleanup_mnt(mnt);

IOW, we only get there if our vfsmount was an MNT_INTERNAL one.
So we have mnt->mnt_umount of some MNT_INTERNAL mount found in
->mnt_pins of some other mount.  Which, AFAICS, means that
it used to be mounted on that other mount.  How the hell can
that happen?

It looks like you somehow get a long chain of MNT_INTERNAL mounts
stacked on top of each other, which ought to be prevented by
        mnt_flags &= ~MNT_INTERNAL_FLAGS;
in do_add_mount().  Nuts...
