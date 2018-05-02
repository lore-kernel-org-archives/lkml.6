Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeEBJGV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:06:21 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43380 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEBJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:06:18 -0400
X-Google-Smtp-Source: AB8JxZphxK8cXZwwgpk+l2t9Ls2YwgcpH5g1Ox2yjeNu6BukxPPa8glGBwsThT3xbdF1UZN11JYSOIs7phSb3MthtLk=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:5635:0:39d2:f87e:2033:9f6]
In-Reply-To: <20180430211754.GB54182@dtor-ws>
References: <20180430195649.17445-1-daniel.vetter@ffwll.ch> <20180430211754.GB54182@dtor-ws>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 2 May 2018 11:06:17 +0200
Message-ID: <CAKMK7uFDwANOAF3j43g4S0jQ4V40b-_oiX+QSy8SRkL26Zwxzg@mail.gmail.com>
Subject: Re: [PATCH] input/psmouse: Don't hold the mutex while calling ->disconnect
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Stephen Lyons <slysven@virginmedia.com>, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 11:17 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Daniel,
>
> On Mon, Apr 30, 2018 at 09:56:49PM +0200, Daniel Vetter wrote:
>> At least trackpoint_disconnect wants to remove some sysfs files, and
>> we can't remove sysfs files while holding psmouse_mutex:
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 4.16.0-rc5-g613eb885b69e-drmtip_1+ #1 Tainted: G     U
>> ------------------------------------------------------
>> kworker/0:3/102 is trying to acquire lock:
>>  (kn->count#130){++++}, at: [<000000009679748b>] kernfs_remove_by_name_ns+0x3b/0x80
>>
>> but task is already holding lock:
>>  (psmouse_mutex){+.+.}, at: [<0000000014f44bcc>] psmouse_disconnect+0x62/0x160
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #1 (psmouse_mutex){+.+.}:
>>        psmouse_attr_set_helper+0x28/0x140
>>        kernfs_fop_write+0xfe/0x180
>>        __vfs_write+0x1e/0x130
>>        vfs_write+0xbd/0x1b0
>>        SyS_write+0x40/0xa0
>>        do_syscall_64+0x65/0x1a0
>>        entry_SYSCALL_64_after_hwframe+0x42/0xb7
>>
>> -> #0 (kn->count#130){++++}:
>>        __kernfs_remove+0x243/0x2b0
>>        kernfs_remove_by_name_ns+0x3b/0x80
>>        remove_files.isra.0+0x2b/0x60
>>        sysfs_remove_group+0x38/0x80
>>        sysfs_remove_groups+0x24/0x40
>>        trackpoint_disconnect+0x2c/0x50
>>        psmouse_disconnect+0x8f/0x160
>>        serio_disconnect_driver+0x28/0x40
>>        serio_driver_remove+0xc/0x10
>>        device_release_driver_internal+0x15b/0x230
>>        serio_handle_event+0x1c8/0x260
>>        process_one_work+0x215/0x620
>>        worker_thread+0x48/0x3a0
>>        kthread+0xfb/0x130
>>        ret_from_fork+0x3a/0x50
>>
>> other info that might help us debug this:
>>
>>  Possible unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(psmouse_mutex);
>>                                lock(kn->count#130);
>>                                lock(psmouse_mutex);
>>   lock(kn->count#130);
>>
>>  *** DEADLOCK ***
>>
>> 6 locks held by kworker/0:3/102:
>>  #0:  ((wq_completion)"events_long"){+.+.}, at: [<000000002e408bfa>] process_one_work+0x191/0x620
>>  #1:  (serio_event_work){+.+.}, at: [<000000002e408bfa>] process_one_work+0x191/0x620
>>  #2:  (serio_mutex){+.+.}, at: [<00000000c8a49847>] serio_handle_event+0x23/0x260
>>  #3:  (&dev->mutex){....}, at: [<00000000b55eee75>] device_release_driver_internal+0x2f/0x230
>>  #4:  (&serio->drv_mutex){+.+.}, at: [<000000009719f997>] serio_disconnect_driver+0x16/0x40
>>  #5:  (psmouse_mutex){+.+.}, at: [<0000000014f44bcc>] psmouse_disconnect+0x62/0x160
>>
>> stack backtrace:
>> CPU: 0 PID: 102 Comm: kworker/0:3 Tainted: G     U           4.16.0-rc5-g613eb885b69e-drmtip_1+ #1
>> Hardware name: LENOVO 74591P0/74591P0, BIOS 6DET28WW (1.05 ) 07/30/2008
>> Workqueue: events_long serio_handle_event
>> Call Trace:
>>  dump_stack+0x5f/0x86
>>  print_circular_bug.isra.18+0x1d0/0x2c0
>>  __lock_acquire+0x14ae/0x1b60
>>  ? kernfs_remove_by_name_ns+0x20/0x80
>>  ? lock_acquire+0xaf/0x200
>>  lock_acquire+0xaf/0x200
>>  ? kernfs_remove_by_name_ns+0x3b/0x80
>>  __kernfs_remove+0x243/0x2b0
>>  ? kernfs_remove_by_name_ns+0x3b/0x80
>>  ? kernfs_name_hash+0xd/0x70
>>  ? kernfs_find_ns+0x7e/0x100
>>  kernfs_remove_by_name_ns+0x3b/0x80
>>  remove_files.isra.0+0x2b/0x60
>>  sysfs_remove_group+0x38/0x80
>>  sysfs_remove_groups+0x24/0x40
>>  trackpoint_disconnect+0x2c/0x50
>>  psmouse_disconnect+0x8f/0x160
>>  serio_disconnect_driver+0x28/0x40
>>  serio_driver_remove+0xc/0x10
>>  device_release_driver_internal+0x15b/0x230
>>  serio_handle_event+0x1c8/0x260
>>  process_one_work+0x215/0x620
>>  worker_thread+0x48/0x3a0
>>  ? _raw_spin_unlock_irqrestore+0x4c/0x60
>>  kthread+0xfb/0x130
>>  ? process_one_work+0x620/0x620
>>  ? _kthread_create_on_node+0x30/0x30
>>  ret_from_fork+0x3a/0x50
>>
>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> Cc: Stephen Lyons <slysven@virginmedia.com>
>> Cc: linux-input@vger.kernel.org
>> ---
>>  drivers/input/mouse/psmouse-base.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
>> index 8900c3166ebf..06ccd8e22f3c 100644
>> --- a/drivers/input/mouse/psmouse-base.c
>> +++ b/drivers/input/mouse/psmouse-base.c
>> @@ -1484,8 +1484,10 @@ static void psmouse_disconnect(struct serio *serio)
>>               psmouse_deactivate(parent);
>>       }
>>
>> +     mutex_unlock(&psmouse_mutex);
>>       if (psmouse->disconnect)
>>               psmouse->disconnect(psmouse);
>> +     mutex_lock(&psmouse_mutex);
>
> Why do you think it is proper to drop this mutex? It is introduced for a
> reason.
>
> I think the trace you are seeing is due to:
>
> commit 988cd7afb3f37598891ca70b4c6eb914c338c46a
> Author: Tejun Heo <tj@kernel.org>
> Date:   Mon Feb 3 14:02:58 2014 -0500
>
>     kernfs: remove kernfs_addrm_cxt
>
> where we started taking kernfs_mutex when adding/removing sysfs files.
> Ultimately I think we may have to change switching protocol to a work
> item to be done asynchronously from writing to sysfs attribute.


Well "holding a lock while adding/removing sysfs files and holding the
same lock from sysfs read/write callbacks" is a classic deadlock. I've
made lockdep shut up about it, I have no idea how to fix it properly.
kernfs switching it's locking doesn't change anything here.

Generally the fix is to untangle the locking: You need 1 set of locks
to protect the datastructures exposed through sysfs, and another thing
(maybe that's provided by serio already, I have no idea) to make sure
you're ordering connect/disconnect handling correct and there's not
concurrent calls to this hooks. Assuming serio does give that
guarantee then there's no need to hold the lock while unregistering
the sysfs files (we could perhaps push the lock dropping down into
trackpoint_disconnect, but that's less maintainable imo since it's not
obvious in psmouse_disconnect what's going on), and my patch is
correct.

But I didn't do a full locking audit of what exactly serio guarantees,
and what exactly psmouse_mutex needs to protect (and where
psmouse_mutex is only held because it's convenient).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
