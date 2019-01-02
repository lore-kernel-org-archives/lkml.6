Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE4BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557232171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546465349;
	bh=qCFWEKGpHF46Er6fcsgU4b8cJlpTG14JMjKXBzHrpQk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=PqsNvAuXaiPhJSIbBX7yHI8NKWPIdXWuLPdHtFYjZ9BM+6/Fkg00OGhXZTnmoJUw0
	 qetSmWZj6Mb9LK44udqmoOcwlg4Ef8Bd/ah9GnFn0/wwuyLtODn6ZhzkicoyYdQV2Z
	 wS2FeOeMu07kNmWREbhw1Sb/g7jHwlEEvTAWSLwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfABVm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfABVm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:42:27 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAED921479;
        Wed,  2 Jan 2019 21:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546465343;
        bh=qCFWEKGpHF46Er6fcsgU4b8cJlpTG14JMjKXBzHrpQk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ThRD1wnpHXCuC8daD8al9O7VJSQN9zItR5e9Disb9XfBlSIVy37AAAkBFoaOJi//R
         abMPLZnFbm6zSDW3ynO7GHNhwWcZtpL7K43XmtLH2V1Z6d2yCEiI8Qc3l7BSyq0SdX
         zEKmuo2P4HrKYpDqbmXlYn9JEeHbFOfb1YGIW/m4=
Message-ID: <248f0079f4c95b6a07e9b39f491218de685db289.camel@kernel.org>
Subject: Re: KASAN: use-after-free Read in posix_lock_inode
From:   Jeff Layton <jlayton@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+239d99847eb49ecb3899@syzkaller.appspotmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 02 Jan 2019 16:42:20 -0500
In-Reply-To: <CACT4Y+aBb1sGMoJS5+WC1CZRShuh2T-0V6mbcCKGkSjYAAGoXQ@mail.gmail.com>
References: <000000000000a415f5057e772463@google.com>
         <9546892a26b5d933132d733468550a232df60e17.camel@kernel.org>
         <CACT4Y+auMcSDNggu5GkJ==yg05Dj9zZxdsx5HO9FMSLHdvAecQ@mail.gmail.com>
         <CACT4Y+aBb1sGMoJS5+WC1CZRShuh2T-0V6mbcCKGkSjYAAGoXQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-oBM8upoW2pf+Ly432JDI"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oBM8upoW2pf+Ly432JDI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-01-02 at 19:54 +0100, Dmitry Vyukov wrote:
> On Wed, Jan 2, 2019 at 7:51 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Wed, Jan 2, 2019 at 7:20 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > On Wed, 2019-01-02 at 02:31 -0800, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot found the following crash on:
> > > > 
> > > > HEAD commit:    e1ef035d272e Merge tag 'armsoc-defconfig' of git://git.ker..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=16bb4c4b400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9c6a26e22579190b
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=239d99847eb49ecb3899
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128aa377400000
> > > > 
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+239d99847eb49ecb3899@syzkaller.appspotmail.com
> > > > 
> > > > IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
> > > > IPv6: ADDRCONF(NETDEV_UP): vxcan1: link is not ready
> > > > 8021q: adding VLAN 0 to HW filter on device batadv0
> > > > 8021q: adding VLAN 0 to HW filter on device batadv0
> > > > ==================================================================
> > > > BUG: KASAN: use-after-free in what_owner_is_waiting_for fs/locks.c:1000
> > > > [inline]
> > > > BUG: KASAN: use-after-free in posix_locks_deadlock fs/locks.c:1023 [inline]
> > > > BUG: KASAN: use-after-free in posix_lock_inode+0x1f9e/0x2750 fs/locks.c:1163
> > > > Read of size 8 at addr ffff88808791b000 by task syz-executor2/10100
> > > > 
> > > > CPU: 1 PID: 10100 Comm: syz-executor2 Not tainted 4.20.0+ #3
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > Google 01/01/2011
> > > > Call Trace:
> > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > >   dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
> > > >   print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
> > > >   kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
> > > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
> > > >   what_owner_is_waiting_for fs/locks.c:1000 [inline]
> > > >   posix_locks_deadlock fs/locks.c:1023 [inline]
> > > >   posix_lock_inode+0x1f9e/0x2750 fs/locks.c:1163
> > > >   posix_lock_file fs/locks.c:1346 [inline]
> > > >   vfs_lock_file fs/locks.c:2314 [inline]
> > > >   vfs_lock_file+0xc7/0xf0 fs/locks.c:2309
> > > >   do_lock_file_wait.part.0+0xe5/0x260 fs/locks.c:2328
> > > >   do_lock_file_wait fs/locks.c:2324 [inline]
> > > >   fcntl_setlk+0x2f1/0xfe0 fs/locks.c:2413
> > > >   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
> > > >   __do_sys_fcntl fs/fcntl.c:463 [inline]
> > > >   __se_sys_fcntl fs/fcntl.c:448 [inline]
> > > >   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
> > > >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > RIP: 0033:0x457ec9
> > > > Code: 6d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> > > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> > > > ff 0f 83 3b b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > > RSP: 002b:00007f58bbb50c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000048
> > > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457ec9
> > > > RDX: 0000000020000140 RSI: 0000000000000007 RDI: 0000000000000003
> > > > RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f58bbb516d4
> > > > R13: 00000000004be5f0 R14: 00000000004ceab0 R15: 00000000ffffffff
> > > > 
> > > > Allocated by task 10100:
> > > >   save_stack+0x45/0xd0 mm/kasan/common.c:73
> > > >   set_track mm/kasan/common.c:85 [inline]
> > > >   kasan_kmalloc mm/kasan/common.c:482 [inline]
> > > >   kasan_kmalloc+0xcf/0xe0 mm/kasan/common.c:455
> > > >   kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:397
> > > >   kmem_cache_alloc+0x12d/0x710 mm/slab.c:3541
> > > >   kmem_cache_zalloc include/linux/slab.h:730 [inline]
> > > >   locks_alloc_lock+0x8e/0x2f0 fs/locks.c:344
> > > >   fcntl_setlk+0xa9/0xfe0 fs/locks.c:2362
> > > >   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
> > > >   __do_sys_fcntl fs/fcntl.c:463 [inline]
> > > >   __se_sys_fcntl fs/fcntl.c:448 [inline]
> > > >   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
> > > >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > 
> > > > Freed by task 10100:
> > > >   save_stack+0x45/0xd0 mm/kasan/common.c:73
> > > >   set_track mm/kasan/common.c:85 [inline]
> > > >   __kasan_slab_free+0x102/0x150 mm/kasan/common.c:444
> > > >   kasan_slab_free+0xe/0x10 mm/kasan/common.c:452
> > > >   __cache_free mm/slab.c:3485 [inline]
> > > >   kmem_cache_free+0x86/0x260 mm/slab.c:3747
> > > >   locks_free_lock+0x27a/0x3f0 fs/locks.c:381
> > > >   fcntl_setlk+0x7b5/0xfe0 fs/locks.c:2439
> > > >   do_fcntl+0x843/0x12b0 fs/fcntl.c:370
> > > >   __do_sys_fcntl fs/fcntl.c:463 [inline]
> > > >   __se_sys_fcntl fs/fcntl.c:448 [inline]
> > > >   __x64_sys_fcntl+0x16d/0x1e0 fs/fcntl.c:448
> > > >   do_syscall_64+0x1a3/0x800 arch/x86/entry/common.c:290
> > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > 
> > > > The buggy address belongs to the object at ffff88808791b000
> > > >   which belongs to the cache file_lock_cache of size 264
> > > > The buggy address is located 0 bytes inside of
> > > >   264-byte region [ffff88808791b000, ffff88808791b108)
> > > > The buggy address belongs to the page:
> > > > page:ffffea00021e46c0 count:1 mapcount:0 mapping:ffff8880aa16a1c0 index:0x0
> > > > flags: 0x1fffc0000000200(slab)
> > > > raw: 01fffc0000000200 ffffea0002333508 ffffea00021d76c8 ffff8880aa16a1c0
> > > > raw: 0000000000000000 ffff88808791b000 000000010000000c 0000000000000000
> > > > page dumped because: kasan: bad access detected
> > > > 
> > > > Memory state around the buggy address:
> > > >   ffff88808791af00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
> > > >   ffff88808791af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > > ffff88808791b000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >                     ^
> > > >   ffff88808791b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >   ffff88808791b100: fb fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb
> > > > ==================================================================
> > > > 
> > > > 
> > > 
> > > I've given this a harder look and I really don't quite grok what
> > > this output is telling me:
> > > 
> > > All 3 stack traces say they come from PID 10100, but the use-after-free
> > > seems to occur well before the free could have occurred in the context
> > > of the current fcntl call.
> > 
> > Interestingly it is the case in all crashes for this bug. It may be
> > something inherent, or maybe just the particular program that
> > triggered this is such that these accesses happen in the same thread.
> > 
> > > So, I guess that leaves the possibility that we freed a lock request
> > > from an earlier fcntl call without removing it properly from the tree,
> > > but (a) I don't see how that could happen, _and_ (b) why didn't that
> > > trip the BUG_ONs in locks_free_lock?
> > > 
> > > I'll keep looking at this, but I'm a bit stumped at the moment.
> > 
> > The simplest repro for this is:
> > 
> > # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> > #{"threaded":true,"collide":true,"repeat":true,"procs":6,"sandbox":"none","fault_call":-1,"tun":true,"tmpdir":true,"cgroups":true,"netdev":true,"resetnet":true,"segv":true}
> > r0 = epoll_create1(0x0)
> > fcntl$lock(r0, 0x7, &(0x7f0000000080))
> > fcntl$lock(r0, 0x7, &(0x7f0000000140)={0x1000000000001, 0x0, 0x1000000})
> > 
> > "collide":true means that the 2 fcntl's were executed in parallel. But
> > still the alloc/free/access always happened in the same thread, so the
> > thread interaction seems to be somewhat unusual.
> 
> Looking at frequency of this crash, repro properties and some other
> signals my money are on a race/atomicity violation with a narrow
> inconsistency window. E.g. unlock something and then expect things
> have not changed after re-lock, or remove from list and reset a
> pointer few instructions later.


Thanks Dmitry,

The good news is that it's quite reproducible. I used syz-prog2c on the
reproducer and got the attached program (build with -lpthread).

I didn't have KASAN enabled on my throwaway VM, but I got a GPF and
stack trace much like the one above when I ran this on a kernel with the
thundering herd set. A kernel based on a commit from earlier in the
merge window didn't show the problem.

I tested commenting out some lockless shortcuts, but they didn't fix it.
I'll keep playing with it.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

--=-oBM8upoW2pf+Ly432JDI
Content-Disposition: attachment; filename="repro.c"
Content-Type: text/x-csrc; name="repro.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUv
c3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGFycGEvaW5ldC5oPgoj
aW5jbHVkZSA8ZGlyZW50Lmg+CiNpbmNsdWRlIDxlbmRpYW4uaD4KI2luY2x1ZGUgPGVycm5vLmg+
CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8bmV0L2lmLmg+CiNpbmNsdWRlIDxuZXQvaWZf
YXJwLmg+CiNpbmNsdWRlIDxuZXRpbmV0L2luLmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNs
dWRlIDxzY2hlZC5oPgojaW5jbHVkZSA8c2V0am1wLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2lu
Y2x1ZGUgPHN0ZGFyZy5oPgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+
CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcu
aD4KI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUg
PHN5cy9tb3VudC5oPgojaW5jbHVkZSA8c3lzL3ByY3RsLmg+CiNpbmNsdWRlIDxzeXMvcmVzb3Vy
Y2UuaD4KI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CiNpbmNs
dWRlIDxzeXMvc3lzY2FsbC5oPgojaW5jbHVkZSA8c3lzL3RpbWUuaD4KI2luY2x1ZGUgPHN5cy90
eXBlcy5oPgojaW5jbHVkZSA8c3lzL3Vpby5oPgojaW5jbHVkZSA8c3lzL3dhaXQuaD4KI2luY2x1
ZGUgPHRpbWUuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgoKI2luY2x1ZGUgPGxpbnV4L2NhcGFiaWxp
dHkuaD4KI2luY2x1ZGUgPGxpbnV4L2Z1dGV4Lmg+CiNpbmNsdWRlIDxsaW51eC9pZl9hZGRyLmg+
CiNpbmNsdWRlIDxsaW51eC9pZl9ldGhlci5oPgojaW5jbHVkZSA8bGludXgvaWZfbGluay5oPgoj
aW5jbHVkZSA8bGludXgvaWZfdHVuLmg+CiNpbmNsdWRlIDxsaW51eC9pbjYuaD4KI2luY2x1ZGUg
PGxpbnV4L2lwLmg+CiNpbmNsdWRlIDxsaW51eC9uZWlnaGJvdXIuaD4KI2luY2x1ZGUgPGxpbnV4
L25ldC5oPgojaW5jbHVkZSA8bGludXgvbmV0bGluay5oPgojaW5jbHVkZSA8bGludXgvcnRuZXRs
aW5rLmg+CiNpbmNsdWRlIDxsaW51eC90Y3AuaD4KI2luY2x1ZGUgPGxpbnV4L3ZldGguaD4KCnVu
c2lnbmVkIGxvbmcgbG9uZyBwcm9jaWQ7CgpzdGF0aWMgX190aHJlYWQgaW50IHNraXBfc2VndjsK
c3RhdGljIF9fdGhyZWFkIGptcF9idWYgc2Vndl9lbnY7CgpzdGF0aWMgdm9pZCBzZWd2X2hhbmRs
ZXIoaW50IHNpZywgc2lnaW5mb190KiBpbmZvLCB2b2lkKiBjdHgpCnsKICB1aW50cHRyX3QgYWRk
ciA9ICh1aW50cHRyX3QpaW5mby0+c2lfYWRkcjsKICBjb25zdCB1aW50cHRyX3QgcHJvZ19zdGFy
dCA9IDEgPDwgMjA7CiAgY29uc3QgdWludHB0cl90IHByb2dfZW5kID0gMTAwIDw8IDIwOwogIGlm
IChfX2F0b21pY19sb2FkX24oJnNraXBfc2VndiwgX19BVE9NSUNfUkVMQVhFRCkgJiYKICAgICAg
KGFkZHIgPCBwcm9nX3N0YXJ0IHx8IGFkZHIgPiBwcm9nX2VuZCkpIHsKICAgIF9sb25nam1wKHNl
Z3ZfZW52LCAxKTsKICB9CiAgZXhpdChzaWcpOwp9CgpzdGF0aWMgdm9pZCBpbnN0YWxsX3NlZ3Zf
aGFuZGxlcih2b2lkKQp7CiAgc3RydWN0IHNpZ2FjdGlvbiBzYTsKICBtZW1zZXQoJnNhLCAwLCBz
aXplb2Yoc2EpKTsKICBzYS5zYV9oYW5kbGVyID0gU0lHX0lHTjsKICBzeXNjYWxsKFNZU19ydF9z
aWdhY3Rpb24sIDB4MjAsICZzYSwgTlVMTCwgOCk7CiAgc3lzY2FsbChTWVNfcnRfc2lnYWN0aW9u
LCAweDIxLCAmc2EsIE5VTEwsIDgpOwogIG1lbXNldCgmc2EsIDAsIHNpemVvZihzYSkpOwogIHNh
LnNhX3NpZ2FjdGlvbiA9IHNlZ3ZfaGFuZGxlcjsKICBzYS5zYV9mbGFncyA9IFNBX05PREVGRVIg
fCBTQV9TSUdJTkZPOwogIHNpZ2FjdGlvbihTSUdTRUdWLCAmc2EsIE5VTEwpOwogIHNpZ2FjdGlv
bihTSUdCVVMsICZzYSwgTlVMTCk7Cn0KCiNkZWZpbmUgTk9ORkFJTElORyguLi4pICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgeyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcCiAgICBfX2F0b21pY19mZXRjaF9hZGQoJnNraXBfc2VndiwgMSwgX19B
VE9NSUNfU0VRX0NTVCk7ICAgICAgICAgICAgICAgICAgICAgICBcCiAgICBpZiAoX3NldGptcChz
ZWd2X2VudikgPT0gMCkgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcCiAgICAgIF9fVkFfQVJHU19fOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICB9ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAg
ICBfX2F0b21pY19mZXRjaF9zdWIoJnNraXBfc2VndiwgMSwgX19BVE9NSUNfU0VRX0NTVCk7ICAg
ICAgICAgICAgICAgICAgICAgICBcCiAgfQoKc3RhdGljIHZvaWQgc2xlZXBfbXModWludDY0X3Qg
bXMpCnsKICB1c2xlZXAobXMgKiAxMDAwKTsKfQoKc3RhdGljIHVpbnQ2NF90IGN1cnJlbnRfdGlt
ZV9tcyh2b2lkKQp7CiAgc3RydWN0IHRpbWVzcGVjIHRzOwogIGlmIChjbG9ja19nZXR0aW1lKENM
T0NLX01PTk9UT05JQywgJnRzKSkKICAgIGV4aXQoMSk7CiAgcmV0dXJuICh1aW50NjRfdCl0cy50
dl9zZWMgKiAxMDAwICsgKHVpbnQ2NF90KXRzLnR2X25zZWMgLyAxMDAwMDAwOwp9CgpzdGF0aWMg
dm9pZCB1c2VfdGVtcG9yYXJ5X2Rpcih2b2lkKQp7CiAgY2hhciB0bXBkaXJfdGVtcGxhdGVbXSA9
ICIuL3N5emthbGxlci5YWFhYWFgiOwogIGNoYXIqIHRtcGRpciA9IG1rZHRlbXAodG1wZGlyX3Rl
bXBsYXRlKTsKICBpZiAoIXRtcGRpcikKICAgIGV4aXQoMSk7CiAgaWYgKGNobW9kKHRtcGRpciwg
MDc3NykpCiAgICBleGl0KDEpOwogIGlmIChjaGRpcih0bXBkaXIpKQogICAgZXhpdCgxKTsKfQoK
c3RhdGljIHZvaWQgdGhyZWFkX3N0YXJ0KHZvaWQqICgqZm4pKHZvaWQqKSwgdm9pZCogYXJnKQp7
CiAgcHRocmVhZF90IHRoOwogIHB0aHJlYWRfYXR0cl90IGF0dHI7CiAgcHRocmVhZF9hdHRyX2lu
aXQoJmF0dHIpOwogIHB0aHJlYWRfYXR0cl9zZXRzdGFja3NpemUoJmF0dHIsIDEyOCA8PCAxMCk7
CiAgaWYgKHB0aHJlYWRfY3JlYXRlKCZ0aCwgJmF0dHIsIGZuLCBhcmcpKQogICAgZXhpdCgxKTsK
ICBwdGhyZWFkX2F0dHJfZGVzdHJveSgmYXR0cik7Cn0KCnR5cGVkZWYgc3RydWN0IHsKICBpbnQg
c3RhdGU7Cn0gZXZlbnRfdDsKCnN0YXRpYyB2b2lkIGV2ZW50X2luaXQoZXZlbnRfdCogZXYpCnsK
ICBldi0+c3RhdGUgPSAwOwp9CgpzdGF0aWMgdm9pZCBldmVudF9yZXNldChldmVudF90KiBldikK
ewogIGV2LT5zdGF0ZSA9IDA7Cn0KCnN0YXRpYyB2b2lkIGV2ZW50X3NldChldmVudF90KiBldikK
ewogIGlmIChldi0+c3RhdGUpCiAgICBleGl0KDEpOwogIF9fYXRvbWljX3N0b3JlX24oJmV2LT5z
dGF0ZSwgMSwgX19BVE9NSUNfUkVMRUFTRSk7CiAgc3lzY2FsbChTWVNfZnV0ZXgsICZldi0+c3Rh
dGUsIEZVVEVYX1dBS0UgfCBGVVRFWF9QUklWQVRFX0ZMQUcpOwp9CgpzdGF0aWMgdm9pZCBldmVu
dF93YWl0KGV2ZW50X3QqIGV2KQp7CiAgd2hpbGUgKCFfX2F0b21pY19sb2FkX24oJmV2LT5zdGF0
ZSwgX19BVE9NSUNfQUNRVUlSRSkpCiAgICBzeXNjYWxsKFNZU19mdXRleCwgJmV2LT5zdGF0ZSwg
RlVURVhfV0FJVCB8IEZVVEVYX1BSSVZBVEVfRkxBRywgMCwgMCk7Cn0KCnN0YXRpYyBpbnQgZXZl
bnRfaXNzZXQoZXZlbnRfdCogZXYpCnsKICByZXR1cm4gX19hdG9taWNfbG9hZF9uKCZldi0+c3Rh
dGUsIF9fQVRPTUlDX0FDUVVJUkUpOwp9CgpzdGF0aWMgaW50IGV2ZW50X3RpbWVkd2FpdChldmVu
dF90KiBldiwgdWludDY0X3QgdGltZW91dCkKewogIHVpbnQ2NF90IHN0YXJ0ID0gY3VycmVudF90
aW1lX21zKCk7CiAgdWludDY0X3Qgbm93ID0gc3RhcnQ7CiAgZm9yICg7OykgewogICAgdWludDY0
X3QgcmVtYWluID0gdGltZW91dCAtIChub3cgLSBzdGFydCk7CiAgICBzdHJ1Y3QgdGltZXNwZWMg
dHM7CiAgICB0cy50dl9zZWMgPSByZW1haW4gLyAxMDAwOwogICAgdHMudHZfbnNlYyA9IChyZW1h
aW4gJSAxMDAwKSAqIDEwMDAgKiAxMDAwOwogICAgc3lzY2FsbChTWVNfZnV0ZXgsICZldi0+c3Rh
dGUsIEZVVEVYX1dBSVQgfCBGVVRFWF9QUklWQVRFX0ZMQUcsIDAsICZ0cyk7CiAgICBpZiAoX19h
dG9taWNfbG9hZF9uKCZldi0+c3RhdGUsIF9fQVRPTUlDX1JFTEFYRUQpKQogICAgICByZXR1cm4g
MTsKICAgIG5vdyA9IGN1cnJlbnRfdGltZV9tcygpOwogICAgaWYgKG5vdyAtIHN0YXJ0ID4gdGlt
ZW91dCkKICAgICAgcmV0dXJuIDA7CiAgfQp9CgpzdGF0aWMgYm9vbCB3cml0ZV9maWxlKGNvbnN0
IGNoYXIqIGZpbGUsIGNvbnN0IGNoYXIqIHdoYXQsIC4uLikKewogIGNoYXIgYnVmWzEwMjRdOwog
IHZhX2xpc3QgYXJnczsKICB2YV9zdGFydChhcmdzLCB3aGF0KTsKICB2c25wcmludGYoYnVmLCBz
aXplb2YoYnVmKSwgd2hhdCwgYXJncyk7CiAgdmFfZW5kKGFyZ3MpOwogIGJ1ZltzaXplb2YoYnVm
KSAtIDFdID0gMDsKICBpbnQgbGVuID0gc3RybGVuKGJ1Zik7CiAgaW50IGZkID0gb3BlbihmaWxl
LCBPX1dST05MWSB8IE9fQ0xPRVhFQyk7CiAgaWYgKGZkID09IC0xKQogICAgcmV0dXJuIGZhbHNl
OwogIGlmICh3cml0ZShmZCwgYnVmLCBsZW4pICE9IGxlbikgewogICAgaW50IGVyciA9IGVycm5v
OwogICAgY2xvc2UoZmQpOwogICAgZXJybm8gPSBlcnI7CiAgICByZXR1cm4gZmFsc2U7CiAgfQog
IGNsb3NlKGZkKTsKICByZXR1cm4gdHJ1ZTsKfQoKc3RhdGljIHN0cnVjdCB7CiAgY2hhciogcG9z
OwogIGludCBuZXN0aW5nOwogIHN0cnVjdCBubGF0dHIqIG5lc3RlZFs4XTsKICBjaGFyIGJ1Zlsx
MDI0XTsKfSBubG1zZzsKCnN0YXRpYyB2b2lkIG5ldGxpbmtfaW5pdChpbnQgdHlwLCBpbnQgZmxh
Z3MsIGNvbnN0IHZvaWQqIGRhdGEsIGludCBzaXplKQp7CiAgbWVtc2V0KCZubG1zZywgMCwgc2l6
ZW9mKG5sbXNnKSk7CiAgc3RydWN0IG5sbXNnaGRyKiBoZHIgPSAoc3RydWN0IG5sbXNnaGRyKilu
bG1zZy5idWY7CiAgaGRyLT5ubG1zZ190eXBlID0gdHlwOwogIGhkci0+bmxtc2dfZmxhZ3MgPSBO
TE1fRl9SRVFVRVNUIHwgTkxNX0ZfQUNLIHwgZmxhZ3M7CiAgbWVtY3B5KGhkciArIDEsIGRhdGEs
IHNpemUpOwogIG5sbXNnLnBvcyA9IChjaGFyKikoaGRyICsgMSkgKyBOTE1TR19BTElHTihzaXpl
KTsKfQoKc3RhdGljIHZvaWQgbmV0bGlua19hdHRyKGludCB0eXAsIGNvbnN0IHZvaWQqIGRhdGEs
IGludCBzaXplKQp7CiAgc3RydWN0IG5sYXR0ciogYXR0ciA9IChzdHJ1Y3QgbmxhdHRyKilubG1z
Zy5wb3M7CiAgYXR0ci0+bmxhX2xlbiA9IHNpemVvZigqYXR0cikgKyBzaXplOwogIGF0dHItPm5s
YV90eXBlID0gdHlwOwogIG1lbWNweShhdHRyICsgMSwgZGF0YSwgc2l6ZSk7CiAgbmxtc2cucG9z
ICs9IE5MTVNHX0FMSUdOKGF0dHItPm5sYV9sZW4pOwp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX25l
c3QoaW50IHR5cCkKewogIHN0cnVjdCBubGF0dHIqIGF0dHIgPSAoc3RydWN0IG5sYXR0ciopbmxt
c2cucG9zOwogIGF0dHItPm5sYV90eXBlID0gdHlwOwogIG5sbXNnLnBvcyArPSBzaXplb2YoKmF0
dHIpOwogIG5sbXNnLm5lc3RlZFtubG1zZy5uZXN0aW5nKytdID0gYXR0cjsKfQoKc3RhdGljIHZv
aWQgbmV0bGlua19kb25lKHZvaWQpCnsKICBzdHJ1Y3QgbmxhdHRyKiBhdHRyID0gbmxtc2cubmVz
dGVkWy0tbmxtc2cubmVzdGluZ107CiAgYXR0ci0+bmxhX2xlbiA9IG5sbXNnLnBvcyAtIChjaGFy
KilhdHRyOwp9CgpzdGF0aWMgaW50IG5ldGxpbmtfc2VuZChpbnQgc29jaykKewogIGlmIChubG1z
Zy5wb3MgPiBubG1zZy5idWYgKyBzaXplb2Yobmxtc2cuYnVmKSB8fCBubG1zZy5uZXN0aW5nKQog
ICAgZXhpdCgxKTsKICBzdHJ1Y3Qgbmxtc2doZHIqIGhkciA9IChzdHJ1Y3Qgbmxtc2doZHIqKW5s
bXNnLmJ1ZjsKICBoZHItPm5sbXNnX2xlbiA9IG5sbXNnLnBvcyAtIG5sbXNnLmJ1ZjsKICBzdHJ1
Y3Qgc29ja2FkZHJfbmwgYWRkcjsKICBtZW1zZXQoJmFkZHIsIDAsIHNpemVvZihhZGRyKSk7CiAg
YWRkci5ubF9mYW1pbHkgPSBBRl9ORVRMSU5LOwogIHVuc2lnbmVkIG4gPSBzZW5kdG8oc29jaywg
bmxtc2cuYnVmLCBoZHItPm5sbXNnX2xlbiwgMCwKICAgICAgICAgICAgICAgICAgICAgIChzdHJ1
Y3Qgc29ja2FkZHIqKSZhZGRyLCBzaXplb2YoYWRkcikpOwogIGlmIChuICE9IGhkci0+bmxtc2df
bGVuKQogICAgZXhpdCgxKTsKICBuID0gcmVjdihzb2NrLCBubG1zZy5idWYsIHNpemVvZihubG1z
Zy5idWYpLCAwKTsKICBpZiAobiA8IHNpemVvZihzdHJ1Y3Qgbmxtc2doZHIpICsgc2l6ZW9mKHN0
cnVjdCBubG1zZ2VycikpCiAgICBleGl0KDEpOwogIGlmIChoZHItPm5sbXNnX3R5cGUgIT0gTkxN
U0dfRVJST1IpCiAgICBleGl0KDEpOwogIHJldHVybiAtKChzdHJ1Y3Qgbmxtc2dlcnIqKShoZHIg
KyAxKSktPmVycm9yOwp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2FkZF9kZXZpY2VfaW1wbChjb25z
dCBjaGFyKiB0eXBlLCBjb25zdCBjaGFyKiBuYW1lKQp7CiAgc3RydWN0IGlmaW5mb21zZyBoZHI7
CiAgbWVtc2V0KCZoZHIsIDAsIHNpemVvZihoZHIpKTsKICBuZXRsaW5rX2luaXQoUlRNX05FV0xJ
TkssIE5MTV9GX0VYQ0wgfCBOTE1fRl9DUkVBVEUsICZoZHIsIHNpemVvZihoZHIpKTsKICBpZiAo
bmFtZSkKICAgIG5ldGxpbmtfYXR0cihJRkxBX0lGTkFNRSwgbmFtZSwgc3RybGVuKG5hbWUpKTsK
ICBuZXRsaW5rX25lc3QoSUZMQV9MSU5LSU5GTyk7CiAgbmV0bGlua19hdHRyKElGTEFfSU5GT19L
SU5ELCB0eXBlLCBzdHJsZW4odHlwZSkpOwp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2FkZF9kZXZp
Y2UoaW50IHNvY2ssIGNvbnN0IGNoYXIqIHR5cGUsIGNvbnN0IGNoYXIqIG5hbWUpCnsKICBuZXRs
aW5rX2FkZF9kZXZpY2VfaW1wbCh0eXBlLCBuYW1lKTsKICBuZXRsaW5rX2RvbmUoKTsKICBpbnQg
ZXJyID0gbmV0bGlua19zZW5kKHNvY2spOwogICh2b2lkKWVycjsKfQoKc3RhdGljIHZvaWQgbmV0
bGlua19hZGRfdmV0aChpbnQgc29jaywgY29uc3QgY2hhciogbmFtZSwgY29uc3QgY2hhciogcGVl
cikKewogIG5ldGxpbmtfYWRkX2RldmljZV9pbXBsKCJ2ZXRoIiwgbmFtZSk7CiAgbmV0bGlua19u
ZXN0KElGTEFfSU5GT19EQVRBKTsKICBuZXRsaW5rX25lc3QoVkVUSF9JTkZPX1BFRVIpOwogIG5s
bXNnLnBvcyArPSBzaXplb2Yoc3RydWN0IGlmaW5mb21zZyk7CiAgbmV0bGlua19hdHRyKElGTEFf
SUZOQU1FLCBwZWVyLCBzdHJsZW4ocGVlcikpOwogIG5ldGxpbmtfZG9uZSgpOwogIG5ldGxpbmtf
ZG9uZSgpOwogIG5ldGxpbmtfZG9uZSgpOwogIGludCBlcnIgPSBuZXRsaW5rX3NlbmQoc29jayk7
CiAgKHZvaWQpZXJyOwp9CgpzdGF0aWMgdm9pZCBuZXRsaW5rX2FkZF9oc3IoaW50IHNvY2ssIGNv
bnN0IGNoYXIqIG5hbWUsIGNvbnN0IGNoYXIqIHNsYXZlMSwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnN0IGNoYXIqIHNsYXZlMikKewogIG5ldGxpbmtfYWRkX2RldmljZV9pbXBsKCJo
c3IiLCBuYW1lKTsKICBuZXRsaW5rX25lc3QoSUZMQV9JTkZPX0RBVEEpOwogIGludCBpZmluZGV4
MSA9IGlmX25hbWV0b2luZGV4KHNsYXZlMSk7CiAgbmV0bGlua19hdHRyKElGTEFfSFNSX1NMQVZF
MSwgJmlmaW5kZXgxLCBzaXplb2YoaWZpbmRleDEpKTsKICBpbnQgaWZpbmRleDIgPSBpZl9uYW1l
dG9pbmRleChzbGF2ZTIpOwogIG5ldGxpbmtfYXR0cihJRkxBX0hTUl9TTEFWRTIsICZpZmluZGV4
Miwgc2l6ZW9mKGlmaW5kZXgyKSk7CiAgbmV0bGlua19kb25lKCk7CiAgbmV0bGlua19kb25lKCk7
CiAgaW50IGVyciA9IG5ldGxpbmtfc2VuZChzb2NrKTsKICAodm9pZCllcnI7Cn0KCnN0YXRpYyB2
b2lkIG5ldGxpbmtfZGV2aWNlX2NoYW5nZShpbnQgc29jaywgY29uc3QgY2hhciogbmFtZSwgYm9v
bCB1cCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIqIG1hc3Rl
ciwgY29uc3Qgdm9pZCogbWFjLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50
IG1hY3NpemUpCnsKICBzdHJ1Y3QgaWZpbmZvbXNnIGhkcjsKICBtZW1zZXQoJmhkciwgMCwgc2l6
ZW9mKGhkcikpOwogIGlmICh1cCkKICAgIGhkci5pZmlfZmxhZ3MgPSBoZHIuaWZpX2NoYW5nZSA9
IElGRl9VUDsKICBuZXRsaW5rX2luaXQoUlRNX05FV0xJTkssIDAsICZoZHIsIHNpemVvZihoZHIp
KTsKICBuZXRsaW5rX2F0dHIoSUZMQV9JRk5BTUUsIG5hbWUsIHN0cmxlbihuYW1lKSk7CiAgaWYg
KG1hc3RlcikgewogICAgaW50IGlmaW5kZXggPSBpZl9uYW1ldG9pbmRleChtYXN0ZXIpOwogICAg
bmV0bGlua19hdHRyKElGTEFfTUFTVEVSLCAmaWZpbmRleCwgc2l6ZW9mKGlmaW5kZXgpKTsKICB9
CiAgaWYgKG1hY3NpemUpCiAgICBuZXRsaW5rX2F0dHIoSUZMQV9BRERSRVNTLCBtYWMsIG1hY3Np
emUpOwogIGludCBlcnIgPSBuZXRsaW5rX3NlbmQoc29jayk7CiAgKHZvaWQpZXJyOwp9CgpzdGF0
aWMgaW50IG5ldGxpbmtfYWRkX2FkZHIoaW50IHNvY2ssIGNvbnN0IGNoYXIqIGRldiwgY29uc3Qg
dm9pZCogYWRkciwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBhZGRyc2l6ZSkKewog
IHN0cnVjdCBpZmFkZHJtc2cgaGRyOwogIG1lbXNldCgmaGRyLCAwLCBzaXplb2YoaGRyKSk7CiAg
aGRyLmlmYV9mYW1pbHkgPSBhZGRyc2l6ZSA9PSA0ID8gQUZfSU5FVCA6IEFGX0lORVQ2OwogIGhk
ci5pZmFfcHJlZml4bGVuID0gYWRkcnNpemUgPT0gNCA/IDI0IDogMTIwOwogIGhkci5pZmFfc2Nv
cGUgPSBSVF9TQ09QRV9VTklWRVJTRTsKICBoZHIuaWZhX2luZGV4ID0gaWZfbmFtZXRvaW5kZXgo
ZGV2KTsKICBuZXRsaW5rX2luaXQoUlRNX05FV0FERFIsIE5MTV9GX0NSRUFURSB8IE5MTV9GX1JF
UExBQ0UsICZoZHIsIHNpemVvZihoZHIpKTsKICBuZXRsaW5rX2F0dHIoSUZBX0xPQ0FMLCBhZGRy
LCBhZGRyc2l6ZSk7CiAgbmV0bGlua19hdHRyKElGQV9BRERSRVNTLCBhZGRyLCBhZGRyc2l6ZSk7
CiAgcmV0dXJuIG5ldGxpbmtfc2VuZChzb2NrKTsKfQoKc3RhdGljIHZvaWQgbmV0bGlua19hZGRf
YWRkcjQoaW50IHNvY2ssIGNvbnN0IGNoYXIqIGRldiwgY29uc3QgY2hhciogYWRkcikKewogIHN0
cnVjdCBpbl9hZGRyIGluX2FkZHI7CiAgaW5ldF9wdG9uKEFGX0lORVQsIGFkZHIsICZpbl9hZGRy
KTsKICBpbnQgZXJyID0gbmV0bGlua19hZGRfYWRkcihzb2NrLCBkZXYsICZpbl9hZGRyLCBzaXpl
b2YoaW5fYWRkcikpOwogICh2b2lkKWVycjsKfQoKc3RhdGljIHZvaWQgbmV0bGlua19hZGRfYWRk
cjYoaW50IHNvY2ssIGNvbnN0IGNoYXIqIGRldiwgY29uc3QgY2hhciogYWRkcikKewogIHN0cnVj
dCBpbjZfYWRkciBpbjZfYWRkcjsKICBpbmV0X3B0b24oQUZfSU5FVDYsIGFkZHIsICZpbjZfYWRk
cik7CiAgaW50IGVyciA9IG5ldGxpbmtfYWRkX2FkZHIoc29jaywgZGV2LCAmaW42X2FkZHIsIHNp
emVvZihpbjZfYWRkcikpOwogICh2b2lkKWVycjsKfQoKI2RlZmluZSBERVZfSVBWNCAiMTcyLjIw
LjIwLiVkIgojZGVmaW5lIERFVl9JUFY2ICJmZTgwOjolMDJoeCIKI2RlZmluZSBERVZfTUFDIDB4
MDBhYWFhYWFhYWFhCnN0YXRpYyB2b2lkIGluaXRpYWxpemVfbmV0ZGV2aWNlcyh2b2lkKQp7CiAg
Y2hhciBuZXRkZXZzaW1bMTZdOwogIHNwcmludGYobmV0ZGV2c2ltLCAibmV0ZGV2c2ltJWQiLCAo
aW50KXByb2NpZCk7CiAgc3RydWN0IHsKICAgIGNvbnN0IGNoYXIqIHR5cGU7CiAgICBjb25zdCBj
aGFyKiBkZXY7CiAgfSBkZXZ0eXBlc1tdID0gewogICAgICB7ImlwNmdyZXRhcCIsICJpcDZncmV0
YXAwIn0sIHsiYnJpZGdlIiwgImJyaWRnZTAifSwKICAgICAgeyJ2Y2FuIiwgInZjYW4wIn0sICAg
ICAgICAgICB7ImJvbmQiLCAiYm9uZDAifSwKICAgICAgeyJ0ZWFtIiwgInRlYW0wIn0sICAgICAg
ICAgICB7ImR1bW15IiwgImR1bW15MCJ9LAogICAgICB7Im5sbW9uIiwgIm5sbW9uMCJ9LCAgICAg
ICAgIHsiY2FpZiIsICJjYWlmMCJ9LAogICAgICB7ImJhdGFkdiIsICJiYXRhZHYwIn0sICAgICAg
IHsidnhjYW4iLCAidnhjYW4xIn0sCiAgICAgIHsibmV0ZGV2c2ltIiwgbmV0ZGV2c2ltfSwgICAg
eyJ2ZXRoIiwgMH0sCiAgfTsKICBjb25zdCBjaGFyKiBkZXZtYXN0ZXJzW10gPSB7ImJyaWRnZSIs
ICJib25kIiwgInRlYW0ifTsKICBzdHJ1Y3QgewogICAgY29uc3QgY2hhciogbmFtZTsKICAgIGlu
dCBtYWNzaXplOwogICAgYm9vbCBub2lwdjY7CiAgfSBkZXZpY2VzW10gPSB7CiAgICAgIHsibG8i
LCBFVEhfQUxFTn0sCiAgICAgIHsic2l0MCIsIDB9LAogICAgICB7ImJyaWRnZTAiLCBFVEhfQUxF
Tn0sCiAgICAgIHsidmNhbjAiLCAwLCB0cnVlfSwKICAgICAgeyJ0dW5sMCIsIDB9LAogICAgICB7
ImdyZTAiLCAwfSwKICAgICAgeyJncmV0YXAwIiwgRVRIX0FMRU59LAogICAgICB7ImlwX3Z0aTAi
LCAwfSwKICAgICAgeyJpcDZfdnRpMCIsIDB9LAogICAgICB7ImlwNnRubDAiLCAwfSwKICAgICAg
eyJpcDZncmUwIiwgMH0sCiAgICAgIHsiaXA2Z3JldGFwMCIsIEVUSF9BTEVOfSwKICAgICAgeyJl
cnNwYW4wIiwgRVRIX0FMRU59LAogICAgICB7ImJvbmQwIiwgRVRIX0FMRU59LAogICAgICB7InZl
dGgwIiwgRVRIX0FMRU59LAogICAgICB7InZldGgxIiwgRVRIX0FMRU59LAogICAgICB7InRlYW0w
IiwgRVRIX0FMRU59LAogICAgICB7InZldGgwX3RvX2JyaWRnZSIsIEVUSF9BTEVOfSwKICAgICAg
eyJ2ZXRoMV90b19icmlkZ2UiLCBFVEhfQUxFTn0sCiAgICAgIHsidmV0aDBfdG9fYm9uZCIsIEVU
SF9BTEVOfSwKICAgICAgeyJ2ZXRoMV90b19ib25kIiwgRVRIX0FMRU59LAogICAgICB7InZldGgw
X3RvX3RlYW0iLCBFVEhfQUxFTn0sCiAgICAgIHsidmV0aDFfdG9fdGVhbSIsIEVUSF9BTEVOfSwK
ICAgICAgeyJ2ZXRoMF90b19oc3IiLCBFVEhfQUxFTn0sCiAgICAgIHsidmV0aDFfdG9faHNyIiwg
RVRIX0FMRU59LAogICAgICB7ImhzcjAiLCAwfSwKICAgICAgeyJkdW1teTAiLCBFVEhfQUxFTn0s
CiAgICAgIHsibmxtb24wIiwgMH0sCiAgICAgIHsidnhjYW4xIiwgMCwgdHJ1ZX0sCiAgICAgIHsi
Y2FpZjAiLCBFVEhfQUxFTn0sCiAgICAgIHsiYmF0YWR2MCIsIEVUSF9BTEVOfSwKICAgICAge25l
dGRldnNpbSwgRVRIX0FMRU59LAogIH07CiAgaW50IHNvY2sgPSBzb2NrZXQoQUZfTkVUTElOSywg
U09DS19SQVcsIE5FVExJTktfUk9VVEUpOwogIGlmIChzb2NrID09IC0xKQogICAgZXhpdCgxKTsK
ICB1bnNpZ25lZCBpOwogIGZvciAoaSA9IDA7IGkgPCBzaXplb2YoZGV2dHlwZXMpIC8gc2l6ZW9m
KGRldnR5cGVzWzBdKTsgaSsrKQogICAgbmV0bGlua19hZGRfZGV2aWNlKHNvY2ssIGRldnR5cGVz
W2ldLnR5cGUsIGRldnR5cGVzW2ldLmRldik7CiAgZm9yIChpID0gMDsgaSA8IHNpemVvZihkZXZt
YXN0ZXJzKSAvIChzaXplb2YoZGV2bWFzdGVyc1swXSkpOyBpKyspIHsKICAgIGNoYXIgbWFzdGVy
WzMyXSwgc2xhdmUwWzMyXSwgdmV0aDBbMzJdLCBzbGF2ZTFbMzJdLCB2ZXRoMVszMl07CiAgICBz
cHJpbnRmKHNsYXZlMCwgIiVzX3NsYXZlXzAiLCBkZXZtYXN0ZXJzW2ldKTsKICAgIHNwcmludGYo
dmV0aDAsICJ2ZXRoMF90b18lcyIsIGRldm1hc3RlcnNbaV0pOwogICAgbmV0bGlua19hZGRfdmV0
aChzb2NrLCBzbGF2ZTAsIHZldGgwKTsKICAgIHNwcmludGYoc2xhdmUxLCAiJXNfc2xhdmVfMSIs
IGRldm1hc3RlcnNbaV0pOwogICAgc3ByaW50Zih2ZXRoMSwgInZldGgxX3RvXyVzIiwgZGV2bWFz
dGVyc1tpXSk7CiAgICBuZXRsaW5rX2FkZF92ZXRoKHNvY2ssIHNsYXZlMSwgdmV0aDEpOwogICAg
c3ByaW50ZihtYXN0ZXIsICIlczAiLCBkZXZtYXN0ZXJzW2ldKTsKICAgIG5ldGxpbmtfZGV2aWNl
X2NoYW5nZShzb2NrLCBzbGF2ZTAsIGZhbHNlLCBtYXN0ZXIsIDAsIDApOwogICAgbmV0bGlua19k
ZXZpY2VfY2hhbmdlKHNvY2ssIHNsYXZlMSwgZmFsc2UsIG1hc3RlciwgMCwgMCk7CiAgfQogIG5l
dGxpbmtfZGV2aWNlX2NoYW5nZShzb2NrLCAiYnJpZGdlX3NsYXZlXzAiLCB0cnVlLCAwLCAwLCAw
KTsKICBuZXRsaW5rX2RldmljZV9jaGFuZ2Uoc29jaywgImJyaWRnZV9zbGF2ZV8xIiwgdHJ1ZSwg
MCwgMCwgMCk7CiAgbmV0bGlua19hZGRfdmV0aChzb2NrLCAiaHNyX3NsYXZlXzAiLCAidmV0aDBf
dG9faHNyIik7CiAgbmV0bGlua19hZGRfdmV0aChzb2NrLCAiaHNyX3NsYXZlXzEiLCAidmV0aDFf
dG9faHNyIik7CiAgbmV0bGlua19hZGRfaHNyKHNvY2ssICJoc3IwIiwgImhzcl9zbGF2ZV8wIiwg
Imhzcl9zbGF2ZV8xIik7CiAgbmV0bGlua19kZXZpY2VfY2hhbmdlKHNvY2ssICJoc3Jfc2xhdmVf
MCIsIHRydWUsIDAsIDAsIDApOwogIG5ldGxpbmtfZGV2aWNlX2NoYW5nZShzb2NrLCAiaHNyX3Ns
YXZlXzEiLCB0cnVlLCAwLCAwLCAwKTsKICBmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKGRldmljZXMp
IC8gKHNpemVvZihkZXZpY2VzWzBdKSk7IGkrKykgewogICAgY2hhciBhZGRyWzMyXTsKICAgIHNw
cmludGYoYWRkciwgREVWX0lQVjQsIGkgKyAxMCk7CiAgICBuZXRsaW5rX2FkZF9hZGRyNChzb2Nr
LCBkZXZpY2VzW2ldLm5hbWUsIGFkZHIpOwogICAgaWYgKCFkZXZpY2VzW2ldLm5vaXB2Nikgewog
ICAgICBzcHJpbnRmKGFkZHIsIERFVl9JUFY2LCBpICsgMTApOwogICAgICBuZXRsaW5rX2FkZF9h
ZGRyNihzb2NrLCBkZXZpY2VzW2ldLm5hbWUsIGFkZHIpOwogICAgfQogICAgdWludDY0X3QgbWFj
YWRkciA9IERFVl9NQUMgKyAoKGkgKyAxMHVsbCkgPDwgNDApOwogICAgbmV0bGlua19kZXZpY2Vf
Y2hhbmdlKHNvY2ssIGRldmljZXNbaV0ubmFtZSwgdHJ1ZSwgMCwgJm1hY2FkZHIsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgZGV2aWNlc1tpXS5tYWNzaXplKTsKICB9CiAgY2xvc2Uoc29jayk7
Cn0Kc3RhdGljIHZvaWQgaW5pdGlhbGl6ZV9uZXRkZXZpY2VzX2luaXQodm9pZCkKewogIGludCBz
b2NrID0gc29ja2V0KEFGX05FVExJTkssIFNPQ0tfUkFXLCBORVRMSU5LX1JPVVRFKTsKICBpZiAo
c29jayA9PSAtMSkKICAgIGV4aXQoMSk7CiAgc3RydWN0IHsKICAgIGNvbnN0IGNoYXIqIHR5cGU7
CiAgICBpbnQgbWFjc2l6ZTsKICAgIGJvb2wgbm9pcHY2OwogICAgYm9vbCBub3VwOwogIH0gZGV2
dHlwZXNbXSA9IHsKICAgICAgeyJuciIsIDcsIHRydWV9LAogICAgICB7InJvc2UiLCA1LCB0cnVl
LCB0cnVlfSwKICB9OwogIHVuc2lnbmVkIGk7CiAgZm9yIChpID0gMDsgaSA8IHNpemVvZihkZXZ0
eXBlcykgLyBzaXplb2YoZGV2dHlwZXNbMF0pOyBpKyspIHsKICAgIGNoYXIgZGV2WzMyXSwgYWRk
clszMl07CiAgICBzcHJpbnRmKGRldiwgIiVzJWQiLCBkZXZ0eXBlc1tpXS50eXBlLCAoaW50KXBy
b2NpZCk7CiAgICBzcHJpbnRmKGFkZHIsICIxNzIuMzAuJWQuJWQiLCBpLCAoaW50KXByb2NpZCAr
IDEpOwogICAgbmV0bGlua19hZGRfYWRkcjQoc29jaywgZGV2LCBhZGRyKTsKICAgIGlmICghZGV2
dHlwZXNbaV0ubm9pcHY2KSB7CiAgICAgIHNwcmludGYoYWRkciwgImZlODg6OiUwMmh4OiUwMmh4
IiwgaSwgKGludClwcm9jaWQgKyAxKTsKICAgICAgbmV0bGlua19hZGRfYWRkcjYoc29jaywgZGV2
LCBhZGRyKTsKICAgIH0KICAgIGludCBtYWNzaXplID0gZGV2dHlwZXNbaV0ubWFjc2l6ZTsKICAg
IHVpbnQ2NF90IG1hY2FkZHIgPSAweGJiYmJiYiArCiAgICAgICAgICAgICAgICAgICAgICAgKCh1
bnNpZ25lZCBsb25nIGxvbmcpaSA8PCAoOCAqIChtYWNzaXplIC0gMikpKSArCiAgICAgICAgICAg
ICAgICAgICAgICAgKHByb2NpZCA8PCAoOCAqIChtYWNzaXplIC0gMSkpKTsKICAgIG5ldGxpbmtf
ZGV2aWNlX2NoYW5nZShzb2NrLCBkZXYsICFkZXZ0eXBlc1tpXS5ub3VwLCAwLCAmbWFjYWRkciwg
bWFjc2l6ZSk7CiAgfQogIGNsb3NlKHNvY2spOwp9CgojZGVmaW5lIFhUX1RBQkxFX1NJWkUgMTUz
NgojZGVmaW5lIFhUX01BWF9FTlRSSUVTIDEwCgpzdHJ1Y3QgeHRfY291bnRlcnMgewogIHVpbnQ2
NF90IHBjbnQsIGJjbnQ7Cn07CgpzdHJ1Y3QgaXB0X2dldGluZm8gewogIGNoYXIgbmFtZVszMl07
CiAgdW5zaWduZWQgaW50IHZhbGlkX2hvb2tzOwogIHVuc2lnbmVkIGludCBob29rX2VudHJ5WzVd
OwogIHVuc2lnbmVkIGludCB1bmRlcmZsb3dbNV07CiAgdW5zaWduZWQgaW50IG51bV9lbnRyaWVz
OwogIHVuc2lnbmVkIGludCBzaXplOwp9OwoKc3RydWN0IGlwdF9nZXRfZW50cmllcyB7CiAgY2hh
ciBuYW1lWzMyXTsKICB1bnNpZ25lZCBpbnQgc2l6ZTsKICB2b2lkKiBlbnRyeXRhYmxlW1hUX1RB
QkxFX1NJWkUgLyBzaXplb2Yodm9pZCopXTsKfTsKCnN0cnVjdCBpcHRfcmVwbGFjZSB7CiAgY2hh
ciBuYW1lWzMyXTsKICB1bnNpZ25lZCBpbnQgdmFsaWRfaG9va3M7CiAgdW5zaWduZWQgaW50IG51
bV9lbnRyaWVzOwogIHVuc2lnbmVkIGludCBzaXplOwogIHVuc2lnbmVkIGludCBob29rX2VudHJ5
WzVdOwogIHVuc2lnbmVkIGludCB1bmRlcmZsb3dbNV07CiAgdW5zaWduZWQgaW50IG51bV9jb3Vu
dGVyczsKICBzdHJ1Y3QgeHRfY291bnRlcnMqIGNvdW50ZXJzOwogIGNoYXIgZW50cnl0YWJsZVtY
VF9UQUJMRV9TSVpFXTsKfTsKCnN0cnVjdCBpcHRfdGFibGVfZGVzYyB7CiAgY29uc3QgY2hhciog
bmFtZTsKICBzdHJ1Y3QgaXB0X2dldGluZm8gaW5mbzsKICBzdHJ1Y3QgaXB0X3JlcGxhY2UgcmVw
bGFjZTsKfTsKCnN0YXRpYyBzdHJ1Y3QgaXB0X3RhYmxlX2Rlc2MgaXB2NF90YWJsZXNbXSA9IHsK
ICAgIHsubmFtZSA9ICJmaWx0ZXIifSwgey5uYW1lID0gIm5hdCJ9LCAgICAgIHsubmFtZSA9ICJt
YW5nbGUifSwKICAgIHsubmFtZSA9ICJyYXcifSwgICAgey5uYW1lID0gInNlY3VyaXR5In0sCn07
CgpzdGF0aWMgc3RydWN0IGlwdF90YWJsZV9kZXNjIGlwdjZfdGFibGVzW10gPSB7CiAgICB7Lm5h
bWUgPSAiZmlsdGVyIn0sIHsubmFtZSA9ICJuYXQifSwgICAgICB7Lm5hbWUgPSAibWFuZ2xlIn0s
CiAgICB7Lm5hbWUgPSAicmF3In0sICAgIHsubmFtZSA9ICJzZWN1cml0eSJ9LAp9OwoKI2RlZmlu
ZSBJUFRfQkFTRV9DVEwgNjQKI2RlZmluZSBJUFRfU09fU0VUX1JFUExBQ0UgKElQVF9CQVNFX0NU
TCkKI2RlZmluZSBJUFRfU09fR0VUX0lORk8gKElQVF9CQVNFX0NUTCkKI2RlZmluZSBJUFRfU09f
R0VUX0VOVFJJRVMgKElQVF9CQVNFX0NUTCArIDEpCgpzdHJ1Y3QgYXJwdF9nZXRpbmZvIHsKICBj
aGFyIG5hbWVbMzJdOwogIHVuc2lnbmVkIGludCB2YWxpZF9ob29rczsKICB1bnNpZ25lZCBpbnQg
aG9va19lbnRyeVszXTsKICB1bnNpZ25lZCBpbnQgdW5kZXJmbG93WzNdOwogIHVuc2lnbmVkIGlu
dCBudW1fZW50cmllczsKICB1bnNpZ25lZCBpbnQgc2l6ZTsKfTsKCnN0cnVjdCBhcnB0X2dldF9l
bnRyaWVzIHsKICBjaGFyIG5hbWVbMzJdOwogIHVuc2lnbmVkIGludCBzaXplOwogIHZvaWQqIGVu
dHJ5dGFibGVbWFRfVEFCTEVfU0laRSAvIHNpemVvZih2b2lkKildOwp9OwoKc3RydWN0IGFycHRf
cmVwbGFjZSB7CiAgY2hhciBuYW1lWzMyXTsKICB1bnNpZ25lZCBpbnQgdmFsaWRfaG9va3M7CiAg
dW5zaWduZWQgaW50IG51bV9lbnRyaWVzOwogIHVuc2lnbmVkIGludCBzaXplOwogIHVuc2lnbmVk
IGludCBob29rX2VudHJ5WzNdOwogIHVuc2lnbmVkIGludCB1bmRlcmZsb3dbM107CiAgdW5zaWdu
ZWQgaW50IG51bV9jb3VudGVyczsKICBzdHJ1Y3QgeHRfY291bnRlcnMqIGNvdW50ZXJzOwogIGNo
YXIgZW50cnl0YWJsZVtYVF9UQUJMRV9TSVpFXTsKfTsKCnN0cnVjdCBhcnB0X3RhYmxlX2Rlc2Mg
ewogIGNvbnN0IGNoYXIqIG5hbWU7CiAgc3RydWN0IGFycHRfZ2V0aW5mbyBpbmZvOwogIHN0cnVj
dCBhcnB0X3JlcGxhY2UgcmVwbGFjZTsKfTsKCnN0YXRpYyBzdHJ1Y3QgYXJwdF90YWJsZV9kZXNj
IGFycHRfdGFibGVzW10gPSB7CiAgICB7Lm5hbWUgPSAiZmlsdGVyIn0sCn07CgojZGVmaW5lIEFS
UFRfQkFTRV9DVEwgOTYKI2RlZmluZSBBUlBUX1NPX1NFVF9SRVBMQUNFIChBUlBUX0JBU0VfQ1RM
KQojZGVmaW5lIEFSUFRfU09fR0VUX0lORk8gKEFSUFRfQkFTRV9DVEwpCiNkZWZpbmUgQVJQVF9T
T19HRVRfRU5UUklFUyAoQVJQVF9CQVNFX0NUTCArIDEpCgpzdGF0aWMgdm9pZCBjaGVja3BvaW50
X2lwdGFibGVzKHN0cnVjdCBpcHRfdGFibGVfZGVzYyogdGFibGVzLCBpbnQgbnVtX3RhYmxlcywK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZmFtaWx5LCBpbnQgbGV2ZWwpCnsK
ICBzdHJ1Y3QgaXB0X2dldF9lbnRyaWVzIGVudHJpZXM7CiAgc29ja2xlbl90IG9wdGxlbjsKICBp
bnQgZmQsIGk7CiAgZmQgPSBzb2NrZXQoZmFtaWx5LCBTT0NLX1NUUkVBTSwgSVBQUk9UT19UQ1Ap
OwogIGlmIChmZCA9PSAtMSkgewogICAgc3dpdGNoIChlcnJubykgewogICAgY2FzZSBFQUZOT1NV
UFBPUlQ6CiAgICBjYXNlIEVOT1BST1RPT1BUOgogICAgICByZXR1cm47CiAgICB9CiAgICBleGl0
KDEpOwogIH0KICBmb3IgKGkgPSAwOyBpIDwgbnVtX3RhYmxlczsgaSsrKSB7CiAgICBzdHJ1Y3Qg
aXB0X3RhYmxlX2Rlc2MqIHRhYmxlID0gJnRhYmxlc1tpXTsKICAgIHN0cmNweSh0YWJsZS0+aW5m
by5uYW1lLCB0YWJsZS0+bmFtZSk7CiAgICBzdHJjcHkodGFibGUtPnJlcGxhY2UubmFtZSwgdGFi
bGUtPm5hbWUpOwogICAgb3B0bGVuID0gc2l6ZW9mKHRhYmxlLT5pbmZvKTsKICAgIGlmIChnZXRz
b2Nrb3B0KGZkLCBsZXZlbCwgSVBUX1NPX0dFVF9JTkZPLCAmdGFibGUtPmluZm8sICZvcHRsZW4p
KSB7CiAgICAgIHN3aXRjaCAoZXJybm8pIHsKICAgICAgY2FzZSBFUEVSTToKICAgICAgY2FzZSBF
Tk9FTlQ6CiAgICAgIGNhc2UgRU5PUFJPVE9PUFQ6CiAgICAgICAgY29udGludWU7CiAgICAgIH0K
ICAgICAgZXhpdCgxKTsKICAgIH0KICAgIGlmICh0YWJsZS0+aW5mby5zaXplID4gc2l6ZW9mKHRh
YmxlLT5yZXBsYWNlLmVudHJ5dGFibGUpKQogICAgICBleGl0KDEpOwogICAgaWYgKHRhYmxlLT5p
bmZvLm51bV9lbnRyaWVzID4gWFRfTUFYX0VOVFJJRVMpCiAgICAgIGV4aXQoMSk7CiAgICBtZW1z
ZXQoJmVudHJpZXMsIDAsIHNpemVvZihlbnRyaWVzKSk7CiAgICBzdHJjcHkoZW50cmllcy5uYW1l
LCB0YWJsZS0+bmFtZSk7CiAgICBlbnRyaWVzLnNpemUgPSB0YWJsZS0+aW5mby5zaXplOwogICAg
b3B0bGVuID0gc2l6ZW9mKGVudHJpZXMpIC0gc2l6ZW9mKGVudHJpZXMuZW50cnl0YWJsZSkgKyB0
YWJsZS0+aW5mby5zaXplOwogICAgaWYgKGdldHNvY2tvcHQoZmQsIGxldmVsLCBJUFRfU09fR0VU
X0VOVFJJRVMsICZlbnRyaWVzLCAmb3B0bGVuKSkKICAgICAgZXhpdCgxKTsKICAgIHRhYmxlLT5y
ZXBsYWNlLnZhbGlkX2hvb2tzID0gdGFibGUtPmluZm8udmFsaWRfaG9va3M7CiAgICB0YWJsZS0+
cmVwbGFjZS5udW1fZW50cmllcyA9IHRhYmxlLT5pbmZvLm51bV9lbnRyaWVzOwogICAgdGFibGUt
PnJlcGxhY2Uuc2l6ZSA9IHRhYmxlLT5pbmZvLnNpemU7CiAgICBtZW1jcHkodGFibGUtPnJlcGxh
Y2UuaG9va19lbnRyeSwgdGFibGUtPmluZm8uaG9va19lbnRyeSwKICAgICAgICAgICBzaXplb2Yo
dGFibGUtPnJlcGxhY2UuaG9va19lbnRyeSkpOwogICAgbWVtY3B5KHRhYmxlLT5yZXBsYWNlLnVu
ZGVyZmxvdywgdGFibGUtPmluZm8udW5kZXJmbG93LAogICAgICAgICAgIHNpemVvZih0YWJsZS0+
cmVwbGFjZS51bmRlcmZsb3cpKTsKICAgIG1lbWNweSh0YWJsZS0+cmVwbGFjZS5lbnRyeXRhYmxl
LCBlbnRyaWVzLmVudHJ5dGFibGUsIHRhYmxlLT5pbmZvLnNpemUpOwogIH0KICBjbG9zZShmZCk7
Cn0KCnN0YXRpYyB2b2lkIHJlc2V0X2lwdGFibGVzKHN0cnVjdCBpcHRfdGFibGVfZGVzYyogdGFi
bGVzLCBpbnQgbnVtX3RhYmxlcywKICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGZhbWls
eSwgaW50IGxldmVsKQp7CiAgc3RydWN0IHh0X2NvdW50ZXJzIGNvdW50ZXJzW1hUX01BWF9FTlRS
SUVTXTsKICBzdHJ1Y3QgaXB0X2dldF9lbnRyaWVzIGVudHJpZXM7CiAgc3RydWN0IGlwdF9nZXRp
bmZvIGluZm87CiAgc29ja2xlbl90IG9wdGxlbjsKICBpbnQgZmQsIGk7CiAgZmQgPSBzb2NrZXQo
ZmFtaWx5LCBTT0NLX1NUUkVBTSwgSVBQUk9UT19UQ1ApOwogIGlmIChmZCA9PSAtMSkgewogICAg
c3dpdGNoIChlcnJubykgewogICAgY2FzZSBFQUZOT1NVUFBPUlQ6CiAgICBjYXNlIEVOT1BST1RP
T1BUOgogICAgICByZXR1cm47CiAgICB9CiAgICBleGl0KDEpOwogIH0KICBmb3IgKGkgPSAwOyBp
IDwgbnVtX3RhYmxlczsgaSsrKSB7CiAgICBzdHJ1Y3QgaXB0X3RhYmxlX2Rlc2MqIHRhYmxlID0g
JnRhYmxlc1tpXTsKICAgIGlmICh0YWJsZS0+aW5mby52YWxpZF9ob29rcyA9PSAwKQogICAgICBj
b250aW51ZTsKICAgIG1lbXNldCgmaW5mbywgMCwgc2l6ZW9mKGluZm8pKTsKICAgIHN0cmNweShp
bmZvLm5hbWUsIHRhYmxlLT5uYW1lKTsKICAgIG9wdGxlbiA9IHNpemVvZihpbmZvKTsKICAgIGlm
IChnZXRzb2Nrb3B0KGZkLCBsZXZlbCwgSVBUX1NPX0dFVF9JTkZPLCAmaW5mbywgJm9wdGxlbikp
CiAgICAgIGV4aXQoMSk7CiAgICBpZiAobWVtY21wKCZ0YWJsZS0+aW5mbywgJmluZm8sIHNpemVv
Zih0YWJsZS0+aW5mbykpID09IDApIHsKICAgICAgbWVtc2V0KCZlbnRyaWVzLCAwLCBzaXplb2Yo
ZW50cmllcykpOwogICAgICBzdHJjcHkoZW50cmllcy5uYW1lLCB0YWJsZS0+bmFtZSk7CiAgICAg
IGVudHJpZXMuc2l6ZSA9IHRhYmxlLT5pbmZvLnNpemU7CiAgICAgIG9wdGxlbiA9IHNpemVvZihl
bnRyaWVzKSAtIHNpemVvZihlbnRyaWVzLmVudHJ5dGFibGUpICsgZW50cmllcy5zaXplOwogICAg
ICBpZiAoZ2V0c29ja29wdChmZCwgbGV2ZWwsIElQVF9TT19HRVRfRU5UUklFUywgJmVudHJpZXMs
ICZvcHRsZW4pKQogICAgICAgIGV4aXQoMSk7CiAgICAgIGlmIChtZW1jbXAodGFibGUtPnJlcGxh
Y2UuZW50cnl0YWJsZSwgZW50cmllcy5lbnRyeXRhYmxlLAogICAgICAgICAgICAgICAgIHRhYmxl
LT5pbmZvLnNpemUpID09IDApCiAgICAgICAgY29udGludWU7CiAgICB9CiAgICB0YWJsZS0+cmVw
bGFjZS5udW1fY291bnRlcnMgPSBpbmZvLm51bV9lbnRyaWVzOwogICAgdGFibGUtPnJlcGxhY2Uu
Y291bnRlcnMgPSBjb3VudGVyczsKICAgIG9wdGxlbiA9IHNpemVvZih0YWJsZS0+cmVwbGFjZSkg
LSBzaXplb2YodGFibGUtPnJlcGxhY2UuZW50cnl0YWJsZSkgKwogICAgICAgICAgICAgdGFibGUt
PnJlcGxhY2Uuc2l6ZTsKICAgIGlmIChzZXRzb2Nrb3B0KGZkLCBsZXZlbCwgSVBUX1NPX1NFVF9S
RVBMQUNFLCAmdGFibGUtPnJlcGxhY2UsIG9wdGxlbikpCiAgICAgIGV4aXQoMSk7CiAgfQogIGNs
b3NlKGZkKTsKfQoKc3RhdGljIHZvaWQgY2hlY2twb2ludF9hcnB0YWJsZXModm9pZCkKewogIHN0
cnVjdCBhcnB0X2dldF9lbnRyaWVzIGVudHJpZXM7CiAgc29ja2xlbl90IG9wdGxlbjsKICB1bnNp
Z25lZCBpOwogIGludCBmZDsKICBmZCA9IHNvY2tldChBRl9JTkVULCBTT0NLX1NUUkVBTSwgSVBQ
Uk9UT19UQ1ApOwogIGlmIChmZCA9PSAtMSkgewogICAgc3dpdGNoIChlcnJubykgewogICAgY2Fz
ZSBFQUZOT1NVUFBPUlQ6CiAgICBjYXNlIEVOT1BST1RPT1BUOgogICAgICByZXR1cm47CiAgICB9
CiAgICBleGl0KDEpOwogIH0KICBmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKGFycHRfdGFibGVzKSAv
IHNpemVvZihhcnB0X3RhYmxlc1swXSk7IGkrKykgewogICAgc3RydWN0IGFycHRfdGFibGVfZGVz
YyogdGFibGUgPSAmYXJwdF90YWJsZXNbaV07CiAgICBzdHJjcHkodGFibGUtPmluZm8ubmFtZSwg
dGFibGUtPm5hbWUpOwogICAgc3RyY3B5KHRhYmxlLT5yZXBsYWNlLm5hbWUsIHRhYmxlLT5uYW1l
KTsKICAgIG9wdGxlbiA9IHNpemVvZih0YWJsZS0+aW5mbyk7CiAgICBpZiAoZ2V0c29ja29wdChm
ZCwgU09MX0lQLCBBUlBUX1NPX0dFVF9JTkZPLCAmdGFibGUtPmluZm8sICZvcHRsZW4pKSB7CiAg
ICAgIHN3aXRjaCAoZXJybm8pIHsKICAgICAgY2FzZSBFUEVSTToKICAgICAgY2FzZSBFTk9FTlQ6
CiAgICAgIGNhc2UgRU5PUFJPVE9PUFQ6CiAgICAgICAgY29udGludWU7CiAgICAgIH0KICAgICAg
ZXhpdCgxKTsKICAgIH0KICAgIGlmICh0YWJsZS0+aW5mby5zaXplID4gc2l6ZW9mKHRhYmxlLT5y
ZXBsYWNlLmVudHJ5dGFibGUpKQogICAgICBleGl0KDEpOwogICAgaWYgKHRhYmxlLT5pbmZvLm51
bV9lbnRyaWVzID4gWFRfTUFYX0VOVFJJRVMpCiAgICAgIGV4aXQoMSk7CiAgICBtZW1zZXQoJmVu
dHJpZXMsIDAsIHNpemVvZihlbnRyaWVzKSk7CiAgICBzdHJjcHkoZW50cmllcy5uYW1lLCB0YWJs
ZS0+bmFtZSk7CiAgICBlbnRyaWVzLnNpemUgPSB0YWJsZS0+aW5mby5zaXplOwogICAgb3B0bGVu
ID0gc2l6ZW9mKGVudHJpZXMpIC0gc2l6ZW9mKGVudHJpZXMuZW50cnl0YWJsZSkgKyB0YWJsZS0+
aW5mby5zaXplOwogICAgaWYgKGdldHNvY2tvcHQoZmQsIFNPTF9JUCwgQVJQVF9TT19HRVRfRU5U
UklFUywgJmVudHJpZXMsICZvcHRsZW4pKQogICAgICBleGl0KDEpOwogICAgdGFibGUtPnJlcGxh
Y2UudmFsaWRfaG9va3MgPSB0YWJsZS0+aW5mby52YWxpZF9ob29rczsKICAgIHRhYmxlLT5yZXBs
YWNlLm51bV9lbnRyaWVzID0gdGFibGUtPmluZm8ubnVtX2VudHJpZXM7CiAgICB0YWJsZS0+cmVw
bGFjZS5zaXplID0gdGFibGUtPmluZm8uc2l6ZTsKICAgIG1lbWNweSh0YWJsZS0+cmVwbGFjZS5o
b29rX2VudHJ5LCB0YWJsZS0+aW5mby5ob29rX2VudHJ5LAogICAgICAgICAgIHNpemVvZih0YWJs
ZS0+cmVwbGFjZS5ob29rX2VudHJ5KSk7CiAgICBtZW1jcHkodGFibGUtPnJlcGxhY2UudW5kZXJm
bG93LCB0YWJsZS0+aW5mby51bmRlcmZsb3csCiAgICAgICAgICAgc2l6ZW9mKHRhYmxlLT5yZXBs
YWNlLnVuZGVyZmxvdykpOwogICAgbWVtY3B5KHRhYmxlLT5yZXBsYWNlLmVudHJ5dGFibGUsIGVu
dHJpZXMuZW50cnl0YWJsZSwgdGFibGUtPmluZm8uc2l6ZSk7CiAgfQogIGNsb3NlKGZkKTsKfQoK
c3RhdGljIHZvaWQgcmVzZXRfYXJwdGFibGVzKCkKewogIHN0cnVjdCB4dF9jb3VudGVycyBjb3Vu
dGVyc1tYVF9NQVhfRU5UUklFU107CiAgc3RydWN0IGFycHRfZ2V0X2VudHJpZXMgZW50cmllczsK
ICBzdHJ1Y3QgYXJwdF9nZXRpbmZvIGluZm87CiAgc29ja2xlbl90IG9wdGxlbjsKICB1bnNpZ25l
ZCBpOwogIGludCBmZDsKICBmZCA9IHNvY2tldChBRl9JTkVULCBTT0NLX1NUUkVBTSwgSVBQUk9U
T19UQ1ApOwogIGlmIChmZCA9PSAtMSkgewogICAgc3dpdGNoIChlcnJubykgewogICAgY2FzZSBF
QUZOT1NVUFBPUlQ6CiAgICBjYXNlIEVOT1BST1RPT1BUOgogICAgICByZXR1cm47CiAgICB9CiAg
ICBleGl0KDEpOwogIH0KICBmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKGFycHRfdGFibGVzKSAvIHNp
emVvZihhcnB0X3RhYmxlc1swXSk7IGkrKykgewogICAgc3RydWN0IGFycHRfdGFibGVfZGVzYyog
dGFibGUgPSAmYXJwdF90YWJsZXNbaV07CiAgICBpZiAodGFibGUtPmluZm8udmFsaWRfaG9va3Mg
PT0gMCkKICAgICAgY29udGludWU7CiAgICBtZW1zZXQoJmluZm8sIDAsIHNpemVvZihpbmZvKSk7
CiAgICBzdHJjcHkoaW5mby5uYW1lLCB0YWJsZS0+bmFtZSk7CiAgICBvcHRsZW4gPSBzaXplb2Yo
aW5mbyk7CiAgICBpZiAoZ2V0c29ja29wdChmZCwgU09MX0lQLCBBUlBUX1NPX0dFVF9JTkZPLCAm
aW5mbywgJm9wdGxlbikpCiAgICAgIGV4aXQoMSk7CiAgICBpZiAobWVtY21wKCZ0YWJsZS0+aW5m
bywgJmluZm8sIHNpemVvZih0YWJsZS0+aW5mbykpID09IDApIHsKICAgICAgbWVtc2V0KCZlbnRy
aWVzLCAwLCBzaXplb2YoZW50cmllcykpOwogICAgICBzdHJjcHkoZW50cmllcy5uYW1lLCB0YWJs
ZS0+bmFtZSk7CiAgICAgIGVudHJpZXMuc2l6ZSA9IHRhYmxlLT5pbmZvLnNpemU7CiAgICAgIG9w
dGxlbiA9IHNpemVvZihlbnRyaWVzKSAtIHNpemVvZihlbnRyaWVzLmVudHJ5dGFibGUpICsgZW50
cmllcy5zaXplOwogICAgICBpZiAoZ2V0c29ja29wdChmZCwgU09MX0lQLCBBUlBUX1NPX0dFVF9F
TlRSSUVTLCAmZW50cmllcywgJm9wdGxlbikpCiAgICAgICAgZXhpdCgxKTsKICAgICAgaWYgKG1l
bWNtcCh0YWJsZS0+cmVwbGFjZS5lbnRyeXRhYmxlLCBlbnRyaWVzLmVudHJ5dGFibGUsCiAgICAg
ICAgICAgICAgICAgdGFibGUtPmluZm8uc2l6ZSkgPT0gMCkKICAgICAgICBjb250aW51ZTsKICAg
IH0gZWxzZSB7CiAgICB9CiAgICB0YWJsZS0+cmVwbGFjZS5udW1fY291bnRlcnMgPSBpbmZvLm51
bV9lbnRyaWVzOwogICAgdGFibGUtPnJlcGxhY2UuY291bnRlcnMgPSBjb3VudGVyczsKICAgIG9w
dGxlbiA9IHNpemVvZih0YWJsZS0+cmVwbGFjZSkgLSBzaXplb2YodGFibGUtPnJlcGxhY2UuZW50
cnl0YWJsZSkgKwogICAgICAgICAgICAgdGFibGUtPnJlcGxhY2Uuc2l6ZTsKICAgIGlmIChzZXRz
b2Nrb3B0KGZkLCBTT0xfSVAsIEFSUFRfU09fU0VUX1JFUExBQ0UsICZ0YWJsZS0+cmVwbGFjZSwg
b3B0bGVuKSkKICAgICAgZXhpdCgxKTsKICB9CiAgY2xvc2UoZmQpOwp9CgojZGVmaW5lIE5GX0JS
X05VTUhPT0tTIDYKI2RlZmluZSBFQlRfVEFCTEVfTUFYTkFNRUxFTiAzMgojZGVmaW5lIEVCVF9D
SEFJTl9NQVhOQU1FTEVOIDMyCiNkZWZpbmUgRUJUX0JBU0VfQ1RMIDEyOAojZGVmaW5lIEVCVF9T
T19TRVRfRU5UUklFUyAoRUJUX0JBU0VfQ1RMKQojZGVmaW5lIEVCVF9TT19HRVRfSU5GTyAoRUJU
X0JBU0VfQ1RMKQojZGVmaW5lIEVCVF9TT19HRVRfRU5UUklFUyAoRUJUX1NPX0dFVF9JTkZPICsg
MSkKI2RlZmluZSBFQlRfU09fR0VUX0lOSVRfSU5GTyAoRUJUX1NPX0dFVF9FTlRSSUVTICsgMSkK
I2RlZmluZSBFQlRfU09fR0VUX0lOSVRfRU5UUklFUyAoRUJUX1NPX0dFVF9JTklUX0lORk8gKyAx
KQoKc3RydWN0IGVidF9yZXBsYWNlIHsKICBjaGFyIG5hbWVbRUJUX1RBQkxFX01BWE5BTUVMRU5d
OwogIHVuc2lnbmVkIGludCB2YWxpZF9ob29rczsKICB1bnNpZ25lZCBpbnQgbmVudHJpZXM7CiAg
dW5zaWduZWQgaW50IGVudHJpZXNfc2l6ZTsKICBzdHJ1Y3QgZWJ0X2VudHJpZXMqIGhvb2tfZW50
cnlbTkZfQlJfTlVNSE9PS1NdOwogIHVuc2lnbmVkIGludCBudW1fY291bnRlcnM7CiAgc3RydWN0
IGVidF9jb3VudGVyKiBjb3VudGVyczsKICBjaGFyKiBlbnRyaWVzOwp9OwoKc3RydWN0IGVidF9l
bnRyaWVzIHsKICB1bnNpZ25lZCBpbnQgZGlzdGluZ3Vpc2hlcjsKICBjaGFyIG5hbWVbRUJUX0NI
QUlOX01BWE5BTUVMRU5dOwogIHVuc2lnbmVkIGludCBjb3VudGVyX29mZnNldDsKICBpbnQgcG9s
aWN5OwogIHVuc2lnbmVkIGludCBuZW50cmllczsKICBjaGFyIGRhdGFbMF0gX19hdHRyaWJ1dGVf
XygoYWxpZ25lZChfX2FsaWdub2ZfXyhzdHJ1Y3QgZWJ0X3JlcGxhY2UpKSkpOwp9OwoKc3RydWN0
IGVidF90YWJsZV9kZXNjIHsKICBjb25zdCBjaGFyKiBuYW1lOwogIHN0cnVjdCBlYnRfcmVwbGFj
ZSByZXBsYWNlOwogIGNoYXIgZW50cnl0YWJsZVtYVF9UQUJMRV9TSVpFXTsKfTsKCnN0YXRpYyBz
dHJ1Y3QgZWJ0X3RhYmxlX2Rlc2MgZWJ0X3RhYmxlc1tdID0gewogICAgey5uYW1lID0gImZpbHRl
ciJ9LAogICAgey5uYW1lID0gIm5hdCJ9LAogICAgey5uYW1lID0gImJyb3V0ZSJ9LAp9OwoKc3Rh
dGljIHZvaWQgY2hlY2twb2ludF9lYnRhYmxlcyh2b2lkKQp7CiAgc29ja2xlbl90IG9wdGxlbjsK
ICB1bnNpZ25lZCBpOwogIGludCBmZDsKICBmZCA9IHNvY2tldChBRl9JTkVULCBTT0NLX1NUUkVB
TSwgSVBQUk9UT19UQ1ApOwogIGlmIChmZCA9PSAtMSkgewogICAgc3dpdGNoIChlcnJubykgewog
ICAgY2FzZSBFQUZOT1NVUFBPUlQ6CiAgICBjYXNlIEVOT1BST1RPT1BUOgogICAgICByZXR1cm47
CiAgICB9CiAgICBleGl0KDEpOwogIH0KICBmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKGVidF90YWJs
ZXMpIC8gc2l6ZW9mKGVidF90YWJsZXNbMF0pOyBpKyspIHsKICAgIHN0cnVjdCBlYnRfdGFibGVf
ZGVzYyogdGFibGUgPSAmZWJ0X3RhYmxlc1tpXTsKICAgIHN0cmNweSh0YWJsZS0+cmVwbGFjZS5u
YW1lLCB0YWJsZS0+bmFtZSk7CiAgICBvcHRsZW4gPSBzaXplb2YodGFibGUtPnJlcGxhY2UpOwog
ICAgaWYgKGdldHNvY2tvcHQoZmQsIFNPTF9JUCwgRUJUX1NPX0dFVF9JTklUX0lORk8sICZ0YWJs
ZS0+cmVwbGFjZSwKICAgICAgICAgICAgICAgICAgICZvcHRsZW4pKSB7CiAgICAgIHN3aXRjaCAo
ZXJybm8pIHsKICAgICAgY2FzZSBFUEVSTToKICAgICAgY2FzZSBFTk9FTlQ6CiAgICAgIGNhc2Ug
RU5PUFJPVE9PUFQ6CiAgICAgICAgY29udGludWU7CiAgICAgIH0KICAgICAgZXhpdCgxKTsKICAg
IH0KICAgIGlmICh0YWJsZS0+cmVwbGFjZS5lbnRyaWVzX3NpemUgPiBzaXplb2YodGFibGUtPmVu
dHJ5dGFibGUpKQogICAgICBleGl0KDEpOwogICAgdGFibGUtPnJlcGxhY2UubnVtX2NvdW50ZXJz
ID0gMDsKICAgIHRhYmxlLT5yZXBsYWNlLmVudHJpZXMgPSB0YWJsZS0+ZW50cnl0YWJsZTsKICAg
IG9wdGxlbiA9IHNpemVvZih0YWJsZS0+cmVwbGFjZSkgKyB0YWJsZS0+cmVwbGFjZS5lbnRyaWVz
X3NpemU7CiAgICBpZiAoZ2V0c29ja29wdChmZCwgU09MX0lQLCBFQlRfU09fR0VUX0lOSVRfRU5U
UklFUywgJnRhYmxlLT5yZXBsYWNlLAogICAgICAgICAgICAgICAgICAgJm9wdGxlbikpCiAgICAg
IGV4aXQoMSk7CiAgfQogIGNsb3NlKGZkKTsKfQoKc3RhdGljIHZvaWQgcmVzZXRfZWJ0YWJsZXMo
KQp7CiAgc3RydWN0IGVidF9yZXBsYWNlIHJlcGxhY2U7CiAgY2hhciBlbnRyeXRhYmxlW1hUX1RB
QkxFX1NJWkVdOwogIHNvY2tsZW5fdCBvcHRsZW47CiAgdW5zaWduZWQgaSwgaiwgaDsKICBpbnQg
ZmQ7CiAgZmQgPSBzb2NrZXQoQUZfSU5FVCwgU09DS19TVFJFQU0sIElQUFJPVE9fVENQKTsKICBp
ZiAoZmQgPT0gLTEpIHsKICAgIHN3aXRjaCAoZXJybm8pIHsKICAgIGNhc2UgRUFGTk9TVVBQT1JU
OgogICAgY2FzZSBFTk9QUk9UT09QVDoKICAgICAgcmV0dXJuOwogICAgfQogICAgZXhpdCgxKTsK
ICB9CiAgZm9yIChpID0gMDsgaSA8IHNpemVvZihlYnRfdGFibGVzKSAvIHNpemVvZihlYnRfdGFi
bGVzWzBdKTsgaSsrKSB7CiAgICBzdHJ1Y3QgZWJ0X3RhYmxlX2Rlc2MqIHRhYmxlID0gJmVidF90
YWJsZXNbaV07CiAgICBpZiAodGFibGUtPnJlcGxhY2UudmFsaWRfaG9va3MgPT0gMCkKICAgICAg
Y29udGludWU7CiAgICBtZW1zZXQoJnJlcGxhY2UsIDAsIHNpemVvZihyZXBsYWNlKSk7CiAgICBz
dHJjcHkocmVwbGFjZS5uYW1lLCB0YWJsZS0+bmFtZSk7CiAgICBvcHRsZW4gPSBzaXplb2YocmVw
bGFjZSk7CiAgICBpZiAoZ2V0c29ja29wdChmZCwgU09MX0lQLCBFQlRfU09fR0VUX0lORk8sICZy
ZXBsYWNlLCAmb3B0bGVuKSkKICAgICAgZXhpdCgxKTsKICAgIHJlcGxhY2UubnVtX2NvdW50ZXJz
ID0gMDsKICAgIHRhYmxlLT5yZXBsYWNlLmVudHJpZXMgPSAwOwogICAgZm9yIChoID0gMDsgaCA8
IE5GX0JSX05VTUhPT0tTOyBoKyspCiAgICAgIHRhYmxlLT5yZXBsYWNlLmhvb2tfZW50cnlbaF0g
PSAwOwogICAgaWYgKG1lbWNtcCgmdGFibGUtPnJlcGxhY2UsICZyZXBsYWNlLCBzaXplb2YodGFi
bGUtPnJlcGxhY2UpKSA9PSAwKSB7CiAgICAgIG1lbXNldCgmZW50cnl0YWJsZSwgMCwgc2l6ZW9m
KGVudHJ5dGFibGUpKTsKICAgICAgcmVwbGFjZS5lbnRyaWVzID0gZW50cnl0YWJsZTsKICAgICAg
b3B0bGVuID0gc2l6ZW9mKHJlcGxhY2UpICsgcmVwbGFjZS5lbnRyaWVzX3NpemU7CiAgICAgIGlm
IChnZXRzb2Nrb3B0KGZkLCBTT0xfSVAsIEVCVF9TT19HRVRfRU5UUklFUywgJnJlcGxhY2UsICZv
cHRsZW4pKQogICAgICAgIGV4aXQoMSk7CiAgICAgIGlmIChtZW1jbXAodGFibGUtPmVudHJ5dGFi
bGUsIGVudHJ5dGFibGUsIHJlcGxhY2UuZW50cmllc19zaXplKSA9PSAwKQogICAgICAgIGNvbnRp
bnVlOwogICAgfQogICAgZm9yIChqID0gMCwgaCA9IDA7IGggPCBORl9CUl9OVU1IT09LUzsgaCsr
KSB7CiAgICAgIGlmICh0YWJsZS0+cmVwbGFjZS52YWxpZF9ob29rcyAmICgxIDw8IGgpKSB7CiAg
ICAgICAgdGFibGUtPnJlcGxhY2UuaG9va19lbnRyeVtoXSA9CiAgICAgICAgICAgIChzdHJ1Y3Qg
ZWJ0X2VudHJpZXMqKXRhYmxlLT5lbnRyeXRhYmxlICsgajsKICAgICAgICBqKys7CiAgICAgIH0K
ICAgIH0KICAgIHRhYmxlLT5yZXBsYWNlLmVudHJpZXMgPSB0YWJsZS0+ZW50cnl0YWJsZTsKICAg
IG9wdGxlbiA9IHNpemVvZih0YWJsZS0+cmVwbGFjZSkgKyB0YWJsZS0+cmVwbGFjZS5lbnRyaWVz
X3NpemU7CiAgICBpZiAoc2V0c29ja29wdChmZCwgU09MX0lQLCBFQlRfU09fU0VUX0VOVFJJRVMs
ICZ0YWJsZS0+cmVwbGFjZSwgb3B0bGVuKSkKICAgICAgZXhpdCgxKTsKICB9CiAgY2xvc2UoZmQp
Owp9CgpzdGF0aWMgdm9pZCBjaGVja3BvaW50X25ldF9uYW1lc3BhY2Uodm9pZCkKewogIGNoZWNr
cG9pbnRfZWJ0YWJsZXMoKTsKICBjaGVja3BvaW50X2FycHRhYmxlcygpOwogIGNoZWNrcG9pbnRf
aXB0YWJsZXMoaXB2NF90YWJsZXMsIHNpemVvZihpcHY0X3RhYmxlcykgLyBzaXplb2YoaXB2NF90
YWJsZXNbMF0pLAogICAgICAgICAgICAgICAgICAgICAgQUZfSU5FVCwgU09MX0lQKTsKICBjaGVj
a3BvaW50X2lwdGFibGVzKGlwdjZfdGFibGVzLCBzaXplb2YoaXB2Nl90YWJsZXMpIC8gc2l6ZW9m
KGlwdjZfdGFibGVzWzBdKSwKICAgICAgICAgICAgICAgICAgICAgIEFGX0lORVQ2LCBTT0xfSVBW
Nik7Cn0KCnN0YXRpYyB2b2lkIHJlc2V0X25ldF9uYW1lc3BhY2Uodm9pZCkKewogIHJlc2V0X2Vi
dGFibGVzKCk7CiAgcmVzZXRfYXJwdGFibGVzKCk7CiAgcmVzZXRfaXB0YWJsZXMoaXB2NF90YWJs
ZXMsIHNpemVvZihpcHY0X3RhYmxlcykgLyBzaXplb2YoaXB2NF90YWJsZXNbMF0pLAogICAgICAg
ICAgICAgICAgIEFGX0lORVQsIFNPTF9JUCk7CiAgcmVzZXRfaXB0YWJsZXMoaXB2Nl90YWJsZXMs
IHNpemVvZihpcHY2X3RhYmxlcykgLyBzaXplb2YoaXB2Nl90YWJsZXNbMF0pLAogICAgICAgICAg
ICAgICAgIEFGX0lORVQ2LCBTT0xfSVBWNik7Cn0KCnN0YXRpYyB2b2lkIHNldHVwX2Nncm91cHMo
KQp7CiAgaWYgKG1rZGlyKCIvc3l6Y2dyb3VwIiwgMDc3NykpIHsKICB9CiAgaWYgKG1rZGlyKCIv
c3l6Y2dyb3VwL3VuaWZpZWQiLCAwNzc3KSkgewogIH0KICBpZiAobW91bnQoIm5vbmUiLCAiL3N5
emNncm91cC91bmlmaWVkIiwgImNncm91cDIiLCAwLCBOVUxMKSkgewogIH0KICBpZiAoY2htb2Qo
Ii9zeXpjZ3JvdXAvdW5pZmllZCIsIDA3NzcpKSB7CiAgfQogIHdyaXRlX2ZpbGUoIi9zeXpjZ3Jv
dXAvdW5pZmllZC9jZ3JvdXAuc3VidHJlZV9jb250cm9sIiwKICAgICAgICAgICAgICIrY3B1ICtt
ZW1vcnkgK2lvICtwaWRzICtyZG1hIik7CiAgaWYgKG1rZGlyKCIvc3l6Y2dyb3VwL2NwdSIsIDA3
NzcpKSB7CiAgfQogIGlmIChtb3VudCgibm9uZSIsICIvc3l6Y2dyb3VwL2NwdSIsICJjZ3JvdXAi
LCAwLAogICAgICAgICAgICAiY3B1c2V0LGNwdWFjY3QscGVyZl9ldmVudCxodWdldGxiIikpIHsK
ICB9CiAgd3JpdGVfZmlsZSgiL3N5emNncm91cC9jcHUvY2dyb3VwLmNsb25lX2NoaWxkcmVuIiwg
IjEiKTsKICBpZiAoY2htb2QoIi9zeXpjZ3JvdXAvY3B1IiwgMDc3NykpIHsKICB9CiAgaWYgKG1r
ZGlyKCIvc3l6Y2dyb3VwL25ldCIsIDA3NzcpKSB7CiAgfQogIGlmIChtb3VudCgibm9uZSIsICIv
c3l6Y2dyb3VwL25ldCIsICJjZ3JvdXAiLCAwLAogICAgICAgICAgICAibmV0X2NscyxuZXRfcHJp
byxkZXZpY2VzLGZyZWV6ZXIiKSkgewogIH0KICBpZiAoY2htb2QoIi9zeXpjZ3JvdXAvbmV0Iiwg
MDc3NykpIHsKICB9Cn0Kc3RhdGljIHZvaWQgc2V0dXBfYmluZm10X21pc2MoKQp7CiAgaWYgKG1v
dW50KDAsICIvcHJvYy9zeXMvZnMvYmluZm10X21pc2MiLCAiYmluZm10X21pc2MiLCAwLCAwKSkg
ewogIH0KICB3cml0ZV9maWxlKCIvcHJvYy9zeXMvZnMvYmluZm10X21pc2MvcmVnaXN0ZXIiLCAi
OnN5ejA6TTowOlx4MDE6Oi4vZmlsZTA6Iik7CiAgd3JpdGVfZmlsZSgiL3Byb2Mvc3lzL2ZzL2Jp
bmZtdF9taXNjL3JlZ2lzdGVyIiwKICAgICAgICAgICAgICI6c3l6MTpNOjE6XHgwMjo6Li9maWxl
MDpQT0MiKTsKfQoKc3RhdGljIHZvaWQgc2V0dXBfY29tbW9uKCkKewogIGlmIChtb3VudCgwLCAi
L3N5cy9mcy9mdXNlL2Nvbm5lY3Rpb25zIiwgImZ1c2VjdGwiLCAwLCAwKSkgewogIH0KICBzZXR1
cF9jZ3JvdXBzKCk7CiAgc2V0dXBfYmluZm10X21pc2MoKTsKfQoKc3RhdGljIHZvaWQgbG9vcCgp
OwoKc3RhdGljIHZvaWQgc2FuZGJveF9jb21tb24oKQp7CiAgcHJjdGwoUFJfU0VUX1BERUFUSFNJ
RywgU0lHS0lMTCwgMCwgMCwgMCk7CiAgc2V0cGdycCgpOwogIHNldHNpZCgpOwogIHN0cnVjdCBy
bGltaXQgcmxpbTsKICBybGltLnJsaW1fY3VyID0gcmxpbS5ybGltX21heCA9IDIwMCA8PCAyMDsK
ICBzZXRybGltaXQoUkxJTUlUX0FTLCAmcmxpbSk7CiAgcmxpbS5ybGltX2N1ciA9IHJsaW0ucmxp
bV9tYXggPSAzMiA8PCAyMDsKICBzZXRybGltaXQoUkxJTUlUX01FTUxPQ0ssICZybGltKTsKICBy
bGltLnJsaW1fY3VyID0gcmxpbS5ybGltX21heCA9IDEzNiA8PCAyMDsKICBzZXRybGltaXQoUkxJ
TUlUX0ZTSVpFLCAmcmxpbSk7CiAgcmxpbS5ybGltX2N1ciA9IHJsaW0ucmxpbV9tYXggPSAxIDw8
IDIwOwogIHNldHJsaW1pdChSTElNSVRfU1RBQ0ssICZybGltKTsKICBybGltLnJsaW1fY3VyID0g
cmxpbS5ybGltX21heCA9IDA7CiAgc2V0cmxpbWl0KFJMSU1JVF9DT1JFLCAmcmxpbSk7CiAgcmxp
bS5ybGltX2N1ciA9IHJsaW0ucmxpbV9tYXggPSAyNTY7CiAgc2V0cmxpbWl0KFJMSU1JVF9OT0ZJ
TEUsICZybGltKTsKICBpZiAodW5zaGFyZShDTE9ORV9ORVdOUykpIHsKICB9CiAgaWYgKHVuc2hh
cmUoQ0xPTkVfTkVXSVBDKSkgewogIH0KICBpZiAodW5zaGFyZSgweDAyMDAwMDAwKSkgewogIH0K
ICBpZiAodW5zaGFyZShDTE9ORV9ORVdVVFMpKSB7CiAgfQogIGlmICh1bnNoYXJlKENMT05FX1NZ
U1ZTRU0pKSB7CiAgfQogIHR5cGVkZWYgc3RydWN0IHsKICAgIGNvbnN0IGNoYXIqIG5hbWU7CiAg
ICBjb25zdCBjaGFyKiB2YWx1ZTsKICB9IHN5c2N0bF90OwogIHN0YXRpYyBjb25zdCBzeXNjdGxf
dCBzeXNjdGxzW10gPSB7CiAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgiLCAiMTY3Nzcy
MTYifSwKICAgICAgeyIvcHJvYy9zeXMva2VybmVsL3NobWFsbCIsICI1MzY4NzA5MTIifSwKICAg
ICAgeyIvcHJvYy9zeXMva2VybmVsL3NobW1uaSIsICIxMDI0In0sCiAgICAgIHsiL3Byb2Mvc3lz
L2tlcm5lbC9tc2dtYXgiLCAiODE5MiJ9LAogICAgICB7Ii9wcm9jL3N5cy9rZXJuZWwvbXNnbW5p
IiwgIjEwMjQifSwKICAgICAgeyIvcHJvYy9zeXMva2VybmVsL21zZ21uYiIsICIxMDI0In0sCiAg
ICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9zZW0iLCAiMTAyNCAxMDQ4NTc2IDUwMCAxMDI0In0sCiAg
fTsKICB1bnNpZ25lZCBpOwogIGZvciAoaSA9IDA7IGkgPCBzaXplb2Yoc3lzY3RscykgLyBzaXpl
b2Yoc3lzY3Rsc1swXSk7IGkrKykKICAgIHdyaXRlX2ZpbGUoc3lzY3Rsc1tpXS5uYW1lLCBzeXNj
dGxzW2ldLnZhbHVlKTsKfQoKaW50IHdhaXRfZm9yX2xvb3AoaW50IHBpZCkKewogIGlmIChwaWQg
PCAwKQogICAgZXhpdCgxKTsKICBpbnQgc3RhdHVzID0gMDsKICB3aGlsZSAod2FpdHBpZCgtMSwg
JnN0YXR1cywgX19XQUxMKSAhPSBwaWQpIHsKICB9CiAgcmV0dXJuIFdFWElUU1RBVFVTKHN0YXR1
cyk7Cn0KCnN0YXRpYyBpbnQgcmVhbF91aWQ7CnN0YXRpYyBpbnQgcmVhbF9naWQ7Cl9fYXR0cmli
dXRlX18oKGFsaWduZWQoNjQgPDwgMTApKSkgc3RhdGljIGNoYXIgc2FuZGJveF9zdGFja1sxIDw8
IDIwXTsKCnN0YXRpYyBpbnQgbmFtZXNwYWNlX3NhbmRib3hfcHJvYyh2b2lkKiBhcmcpCnsKICBz
YW5kYm94X2NvbW1vbigpOwogIHdyaXRlX2ZpbGUoIi9wcm9jL3NlbGYvc2V0Z3JvdXBzIiwgImRl
bnkiKTsKICBpZiAoIXdyaXRlX2ZpbGUoIi9wcm9jL3NlbGYvdWlkX21hcCIsICIwICVkIDFcbiIs
IHJlYWxfdWlkKSkKICAgIGV4aXQoMSk7CiAgaWYgKCF3cml0ZV9maWxlKCIvcHJvYy9zZWxmL2dp
ZF9tYXAiLCAiMCAlZCAxXG4iLCByZWFsX2dpZCkpCiAgICBleGl0KDEpOwogIGluaXRpYWxpemVf
bmV0ZGV2aWNlc19pbml0KCk7CiAgaWYgKHVuc2hhcmUoQ0xPTkVfTkVXTkVUKSkKICAgIGV4aXQo
MSk7CiAgaW5pdGlhbGl6ZV9uZXRkZXZpY2VzKCk7CiAgaWYgKG1rZGlyKCIuL3N5ei10bXAiLCAw
Nzc3KSkKICAgIGV4aXQoMSk7CiAgaWYgKG1vdW50KCIiLCAiLi9zeXotdG1wIiwgInRtcGZzIiwg
MCwgTlVMTCkpCiAgICBleGl0KDEpOwogIGlmIChta2RpcigiLi9zeXotdG1wL25ld3Jvb3QiLCAw
Nzc3KSkKICAgIGV4aXQoMSk7CiAgaWYgKG1rZGlyKCIuL3N5ei10bXAvbmV3cm9vdC9kZXYiLCAw
NzAwKSkKICAgIGV4aXQoMSk7CiAgdW5zaWduZWQgYmluZF9tb3VudF9mbGFncyA9IE1TX0JJTkQg
fCBNU19SRUMgfCBNU19QUklWQVRFOwogIGlmIChtb3VudCgiL2RldiIsICIuL3N5ei10bXAvbmV3
cm9vdC9kZXYiLCBOVUxMLCBiaW5kX21vdW50X2ZsYWdzLCBOVUxMKSkKICAgIGV4aXQoMSk7CiAg
aWYgKG1rZGlyKCIuL3N5ei10bXAvbmV3cm9vdC9wcm9jIiwgMDcwMCkpCiAgICBleGl0KDEpOwog
IGlmIChtb3VudChOVUxMLCAiLi9zeXotdG1wL25ld3Jvb3QvcHJvYyIsICJwcm9jIiwgMCwgTlVM
TCkpCiAgICBleGl0KDEpOwogIGlmIChta2RpcigiLi9zeXotdG1wL25ld3Jvb3Qvc2VsaW51eCIs
IDA3MDApKQogICAgZXhpdCgxKTsKICBjb25zdCBjaGFyKiBzZWxpbnV4X3BhdGggPSAiLi9zeXot
dG1wL25ld3Jvb3Qvc2VsaW51eCI7CiAgaWYgKG1vdW50KCIvc2VsaW51eCIsIHNlbGludXhfcGF0
aCwgTlVMTCwgYmluZF9tb3VudF9mbGFncywgTlVMTCkpIHsKICAgIGlmIChlcnJubyAhPSBFTk9F
TlQpCiAgICAgIGV4aXQoMSk7CiAgICBpZiAobW91bnQoIi9zeXMvZnMvc2VsaW51eCIsIHNlbGlu
dXhfcGF0aCwgTlVMTCwgYmluZF9tb3VudF9mbGFncywgTlVMTCkgJiYKICAgICAgICBlcnJubyAh
PSBFTk9FTlQpCiAgICAgIGV4aXQoMSk7CiAgfQogIGlmIChta2RpcigiLi9zeXotdG1wL25ld3Jv
b3Qvc3lzIiwgMDcwMCkpCiAgICBleGl0KDEpOwogIGlmIChtb3VudCgiL3N5cyIsICIuL3N5ei10
bXAvbmV3cm9vdC9zeXMiLCAwLCBiaW5kX21vdW50X2ZsYWdzLCBOVUxMKSkKICAgIGV4aXQoMSk7
CiAgaWYgKG1rZGlyKCIuL3N5ei10bXAvbmV3cm9vdC9zeXpjZ3JvdXAiLCAwNzAwKSkKICAgIGV4
aXQoMSk7CiAgaWYgKG1rZGlyKCIuL3N5ei10bXAvbmV3cm9vdC9zeXpjZ3JvdXAvdW5pZmllZCIs
IDA3MDApKQogICAgZXhpdCgxKTsKICBpZiAobWtkaXIoIi4vc3l6LXRtcC9uZXdyb290L3N5emNn
cm91cC9jcHUiLCAwNzAwKSkKICAgIGV4aXQoMSk7CiAgaWYgKG1rZGlyKCIuL3N5ei10bXAvbmV3
cm9vdC9zeXpjZ3JvdXAvbmV0IiwgMDcwMCkpCiAgICBleGl0KDEpOwogIGlmIChtb3VudCgiL3N5
emNncm91cC91bmlmaWVkIiwgIi4vc3l6LXRtcC9uZXdyb290L3N5emNncm91cC91bmlmaWVkIiwg
TlVMTCwKICAgICAgICAgICAgYmluZF9tb3VudF9mbGFncywgTlVMTCkpIHsKICB9CiAgaWYgKG1v
dW50KCIvc3l6Y2dyb3VwL2NwdSIsICIuL3N5ei10bXAvbmV3cm9vdC9zeXpjZ3JvdXAvY3B1Iiwg
TlVMTCwKICAgICAgICAgICAgYmluZF9tb3VudF9mbGFncywgTlVMTCkpIHsKICB9CiAgaWYgKG1v
dW50KCIvc3l6Y2dyb3VwL25ldCIsICIuL3N5ei10bXAvbmV3cm9vdC9zeXpjZ3JvdXAvbmV0Iiwg
TlVMTCwKICAgICAgICAgICAgYmluZF9tb3VudF9mbGFncywgTlVMTCkpIHsKICB9CiAgaWYgKG1r
ZGlyKCIuL3N5ei10bXAvcGl2b3QiLCAwNzc3KSkKICAgIGV4aXQoMSk7CiAgaWYgKHN5c2NhbGwo
U1lTX3Bpdm90X3Jvb3QsICIuL3N5ei10bXAiLCAiLi9zeXotdG1wL3Bpdm90IikpIHsKICAgIGlm
IChjaGRpcigiLi9zeXotdG1wIikpCiAgICAgIGV4aXQoMSk7CiAgfSBlbHNlIHsKICAgIGlmIChj
aGRpcigiLyIpKQogICAgICBleGl0KDEpOwogICAgaWYgKHVtb3VudDIoIi4vcGl2b3QiLCBNTlRf
REVUQUNIKSkKICAgICAgZXhpdCgxKTsKICB9CiAgaWYgKGNocm9vdCgiLi9uZXdyb290IikpCiAg
ICBleGl0KDEpOwogIGlmIChjaGRpcigiLyIpKQogICAgZXhpdCgxKTsKICBzdHJ1Y3QgX191c2Vy
X2NhcF9oZWFkZXJfc3RydWN0IGNhcF9oZHIgPSB7fTsKICBzdHJ1Y3QgX191c2VyX2NhcF9kYXRh
X3N0cnVjdCBjYXBfZGF0YVsyXSA9IHt9OwogIGNhcF9oZHIudmVyc2lvbiA9IF9MSU5VWF9DQVBB
QklMSVRZX1ZFUlNJT05fMzsKICBjYXBfaGRyLnBpZCA9IGdldHBpZCgpOwogIGlmIChzeXNjYWxs
KFNZU19jYXBnZXQsICZjYXBfaGRyLCAmY2FwX2RhdGEpKQogICAgZXhpdCgxKTsKICBjYXBfZGF0
YVswXS5lZmZlY3RpdmUgJj0gfigxIDw8IENBUF9TWVNfUFRSQUNFKTsKICBjYXBfZGF0YVswXS5w
ZXJtaXR0ZWQgJj0gfigxIDw8IENBUF9TWVNfUFRSQUNFKTsKICBjYXBfZGF0YVswXS5pbmhlcml0
YWJsZSAmPSB+KDEgPDwgQ0FQX1NZU19QVFJBQ0UpOwogIGlmIChzeXNjYWxsKFNZU19jYXBzZXQs
ICZjYXBfaGRyLCAmY2FwX2RhdGEpKQogICAgZXhpdCgxKTsKICBsb29wKCk7CiAgZXhpdCgxKTsK
fQoKI2RlZmluZSBTWVpfSEFWRV9TQU5EQk9YX05BTUVTUEFDRSAxCnN0YXRpYyBpbnQgZG9fc2Fu
ZGJveF9uYW1lc3BhY2Uodm9pZCkKewogIGludCBwaWQ7CiAgc2V0dXBfY29tbW9uKCk7CiAgcmVh
bF91aWQgPSBnZXR1aWQoKTsKICByZWFsX2dpZCA9IGdldGdpZCgpOwogIG1wcm90ZWN0KHNhbmRi
b3hfc3RhY2ssIDQwOTYsIFBST1RfTk9ORSk7CiAgcGlkID0KICAgICAgY2xvbmUobmFtZXNwYWNl
X3NhbmRib3hfcHJvYywgJnNhbmRib3hfc3RhY2tbc2l6ZW9mKHNhbmRib3hfc3RhY2spIC0gNjRd
LAogICAgICAgICAgICBDTE9ORV9ORVdVU0VSIHwgQ0xPTkVfTkVXUElELCAwKTsKICByZXR1cm4g
d2FpdF9mb3JfbG9vcChwaWQpOwp9CgojZGVmaW5lIEZTX0lPQ19TRVRGTEFHUyBfSU9XKCdmJywg
MiwgbG9uZykKc3RhdGljIHZvaWQgcmVtb3ZlX2Rpcihjb25zdCBjaGFyKiBkaXIpCnsKICBESVIq
IGRwOwogIHN0cnVjdCBkaXJlbnQqIGVwOwogIGludCBpdGVyID0gMDsKcmV0cnk6CiAgd2hpbGUg
KHVtb3VudDIoZGlyLCBNTlRfREVUQUNIKSA9PSAwKSB7CiAgfQogIGRwID0gb3BlbmRpcihkaXIp
OwogIGlmIChkcCA9PSBOVUxMKSB7CiAgICBpZiAoZXJybm8gPT0gRU1GSUxFKSB7CiAgICAgIGV4
aXQoMSk7CiAgICB9CiAgICBleGl0KDEpOwogIH0KICB3aGlsZSAoKGVwID0gcmVhZGRpcihkcCkp
KSB7CiAgICBpZiAoc3RyY21wKGVwLT5kX25hbWUsICIuIikgPT0gMCB8fCBzdHJjbXAoZXAtPmRf
bmFtZSwgIi4uIikgPT0gMCkKICAgICAgY29udGludWU7CiAgICBjaGFyIGZpbGVuYW1lW0ZJTEVO
QU1FX01BWF07CiAgICBzbnByaW50ZihmaWxlbmFtZSwgc2l6ZW9mKGZpbGVuYW1lKSwgIiVzLyVz
IiwgZGlyLCBlcC0+ZF9uYW1lKTsKICAgIHdoaWxlICh1bW91bnQyKGZpbGVuYW1lLCBNTlRfREVU
QUNIKSA9PSAwKSB7CiAgICB9CiAgICBzdHJ1Y3Qgc3RhdCBzdDsKICAgIGlmIChsc3RhdChmaWxl
bmFtZSwgJnN0KSkKICAgICAgZXhpdCgxKTsKICAgIGlmIChTX0lTRElSKHN0LnN0X21vZGUpKSB7
CiAgICAgIHJlbW92ZV9kaXIoZmlsZW5hbWUpOwogICAgICBjb250aW51ZTsKICAgIH0KICAgIGlu
dCBpOwogICAgZm9yIChpID0gMDs7IGkrKykgewogICAgICBpZiAodW5saW5rKGZpbGVuYW1lKSA9
PSAwKQogICAgICAgIGJyZWFrOwogICAgICBpZiAoZXJybm8gPT0gRVBFUk0pIHsKICAgICAgICBp
bnQgZmQgPSBvcGVuKGZpbGVuYW1lLCBPX1JET05MWSk7CiAgICAgICAgaWYgKGZkICE9IC0xKSB7
CiAgICAgICAgICBsb25nIGZsYWdzID0gMDsKICAgICAgICAgIGlmIChpb2N0bChmZCwgRlNfSU9D
X1NFVEZMQUdTLCAmZmxhZ3MpID09IDApCiAgICAgICAgICAgIGNsb3NlKGZkKTsKICAgICAgICAg
IGNvbnRpbnVlOwogICAgICAgIH0KICAgICAgfQogICAgICBpZiAoZXJybm8gPT0gRVJPRlMpIHsK
ICAgICAgICBicmVhazsKICAgICAgfQogICAgICBpZiAoZXJybm8gIT0gRUJVU1kgfHwgaSA+IDEw
MCkKICAgICAgICBleGl0KDEpOwogICAgICBpZiAodW1vdW50MihmaWxlbmFtZSwgTU5UX0RFVEFD
SCkpCiAgICAgICAgZXhpdCgxKTsKICAgIH0KICB9CiAgY2xvc2VkaXIoZHApOwogIGludCBpOwog
IGZvciAoaSA9IDA7OyBpKyspIHsKICAgIGlmIChybWRpcihkaXIpID09IDApCiAgICAgIGJyZWFr
OwogICAgaWYgKGkgPCAxMDApIHsKICAgICAgaWYgKGVycm5vID09IEVQRVJNKSB7CiAgICAgICAg
aW50IGZkID0gb3BlbihkaXIsIE9fUkRPTkxZKTsKICAgICAgICBpZiAoZmQgIT0gLTEpIHsKICAg
ICAgICAgIGxvbmcgZmxhZ3MgPSAwOwogICAgICAgICAgaWYgKGlvY3RsKGZkLCBGU19JT0NfU0VU
RkxBR1MsICZmbGFncykgPT0gMCkKICAgICAgICAgICAgY2xvc2UoZmQpOwogICAgICAgICAgY29u
dGludWU7CiAgICAgICAgfQogICAgICB9CiAgICAgIGlmIChlcnJubyA9PSBFUk9GUykgewogICAg
ICAgIGJyZWFrOwogICAgICB9CiAgICAgIGlmIChlcnJubyA9PSBFQlVTWSkgewogICAgICAgIGlm
ICh1bW91bnQyKGRpciwgTU5UX0RFVEFDSCkpCiAgICAgICAgICBleGl0KDEpOwogICAgICAgIGNv
bnRpbnVlOwogICAgICB9CiAgICAgIGlmIChlcnJubyA9PSBFTk9URU1QVFkpIHsKICAgICAgICBp
ZiAoaXRlciA8IDEwMCkgewogICAgICAgICAgaXRlcisrOwogICAgICAgICAgZ290byByZXRyeTsK
ICAgICAgICB9CiAgICAgIH0KICAgIH0KICAgIGV4aXQoMSk7CiAgfQp9CgpzdGF0aWMgdm9pZCBr
aWxsX2FuZF93YWl0KGludCBwaWQsIGludCogc3RhdHVzKQp7CiAga2lsbCgtcGlkLCBTSUdLSUxM
KTsKICBraWxsKHBpZCwgU0lHS0lMTCk7CiAgaW50IGk7CiAgZm9yIChpID0gMDsgaSA8IDEwMDsg
aSsrKSB7CiAgICBpZiAod2FpdHBpZCgtMSwgc3RhdHVzLCBXTk9IQU5HIHwgX19XQUxMKSA9PSBw
aWQpCiAgICAgIHJldHVybjsKICAgIHVzbGVlcCgxMDAwKTsKICB9CiAgRElSKiBkaXIgPSBvcGVu
ZGlyKCIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMiKTsKICBpZiAoZGlyKSB7CiAgICBmb3IgKDs7
KSB7CiAgICAgIHN0cnVjdCBkaXJlbnQqIGVudCA9IHJlYWRkaXIoZGlyKTsKICAgICAgaWYgKCFl
bnQpCiAgICAgICAgYnJlYWs7CiAgICAgIGlmIChzdHJjbXAoZW50LT5kX25hbWUsICIuIikgPT0g
MCB8fCBzdHJjbXAoZW50LT5kX25hbWUsICIuLiIpID09IDApCiAgICAgICAgY29udGludWU7CiAg
ICAgIGNoYXIgYWJvcnRbMzAwXTsKICAgICAgc25wcmludGYoYWJvcnQsIHNpemVvZihhYm9ydCks
ICIvc3lzL2ZzL2Z1c2UvY29ubmVjdGlvbnMvJXMvYWJvcnQiLAogICAgICAgICAgICAgICBlbnQt
PmRfbmFtZSk7CiAgICAgIGludCBmZCA9IG9wZW4oYWJvcnQsIE9fV1JPTkxZKTsKICAgICAgaWYg
KGZkID09IC0xKSB7CiAgICAgICAgY29udGludWU7CiAgICAgIH0KICAgICAgaWYgKHdyaXRlKGZk
LCBhYm9ydCwgMSkgPCAwKSB7CiAgICAgIH0KICAgICAgY2xvc2UoZmQpOwogICAgfQogICAgY2xv
c2VkaXIoZGlyKTsKICB9IGVsc2UgewogIH0KICB3aGlsZSAod2FpdHBpZCgtMSwgc3RhdHVzLCBf
X1dBTEwpICE9IHBpZCkgewogIH0KfQoKI2RlZmluZSBTWVpfSEFWRV9TRVRVUF9MT09QIDEKc3Rh
dGljIHZvaWQgc2V0dXBfbG9vcCgpCnsKICBpbnQgcGlkID0gZ2V0cGlkKCk7CiAgY2hhciBjZ3Jv
dXBkaXJbNjRdOwogIGNoYXIgZmlsZVsxMjhdOwogIHNucHJpbnRmKGNncm91cGRpciwgc2l6ZW9m
KGNncm91cGRpciksICIvc3l6Y2dyb3VwL3VuaWZpZWQvc3l6JWxsdSIsIHByb2NpZCk7CiAgaWYg
KG1rZGlyKGNncm91cGRpciwgMDc3NykpIHsKICB9CiAgc25wcmludGYoZmlsZSwgc2l6ZW9mKGZp
bGUpLCAiJXMvcGlkcy5tYXgiLCBjZ3JvdXBkaXIpOwogIHdyaXRlX2ZpbGUoZmlsZSwgIjMyIik7
CiAgc25wcmludGYoZmlsZSwgc2l6ZW9mKGZpbGUpLCAiJXMvbWVtb3J5LmxvdyIsIGNncm91cGRp
cik7CiAgd3JpdGVfZmlsZShmaWxlLCAiJWQiLCAyOTggPDwgMjApOwogIHNucHJpbnRmKGZpbGUs
IHNpemVvZihmaWxlKSwgIiVzL21lbW9yeS5oaWdoIiwgY2dyb3VwZGlyKTsKICB3cml0ZV9maWxl
KGZpbGUsICIlZCIsIDI5OSA8PCAyMCk7CiAgc25wcmludGYoZmlsZSwgc2l6ZW9mKGZpbGUpLCAi
JXMvbWVtb3J5Lm1heCIsIGNncm91cGRpcik7CiAgd3JpdGVfZmlsZShmaWxlLCAiJWQiLCAzMDAg
PDwgMjApOwogIHNucHJpbnRmKGZpbGUsIHNpemVvZihmaWxlKSwgIiVzL2Nncm91cC5wcm9jcyIs
IGNncm91cGRpcik7CiAgd3JpdGVfZmlsZShmaWxlLCAiJWQiLCBwaWQpOwogIHNucHJpbnRmKGNn
cm91cGRpciwgc2l6ZW9mKGNncm91cGRpciksICIvc3l6Y2dyb3VwL2NwdS9zeXolbGx1IiwgcHJv
Y2lkKTsKICBpZiAobWtkaXIoY2dyb3VwZGlyLCAwNzc3KSkgewogIH0KICBzbnByaW50ZihmaWxl
LCBzaXplb2YoZmlsZSksICIlcy9jZ3JvdXAucHJvY3MiLCBjZ3JvdXBkaXIpOwogIHdyaXRlX2Zp
bGUoZmlsZSwgIiVkIiwgcGlkKTsKICBzbnByaW50ZihjZ3JvdXBkaXIsIHNpemVvZihjZ3JvdXBk
aXIpLCAiL3N5emNncm91cC9uZXQvc3l6JWxsdSIsIHByb2NpZCk7CiAgaWYgKG1rZGlyKGNncm91
cGRpciwgMDc3NykpIHsKICB9CiAgc25wcmludGYoZmlsZSwgc2l6ZW9mKGZpbGUpLCAiJXMvY2dy
b3VwLnByb2NzIiwgY2dyb3VwZGlyKTsKICB3cml0ZV9maWxlKGZpbGUsICIlZCIsIHBpZCk7CiAg
Y2hlY2twb2ludF9uZXRfbmFtZXNwYWNlKCk7Cn0KCiNkZWZpbmUgU1laX0hBVkVfUkVTRVRfTE9P
UCAxCnN0YXRpYyB2b2lkIHJlc2V0X2xvb3AoKQp7CiAgcmVzZXRfbmV0X25hbWVzcGFjZSgpOwp9
CgojZGVmaW5lIFNZWl9IQVZFX1NFVFVQX1RFU1QgMQpzdGF0aWMgdm9pZCBzZXR1cF90ZXN0KCkK
ewogIHByY3RsKFBSX1NFVF9QREVBVEhTSUcsIFNJR0tJTEwsIDAsIDAsIDApOwogIHNldHBncnAo
KTsKICBjaGFyIGNncm91cGRpcls2NF07CiAgc25wcmludGYoY2dyb3VwZGlyLCBzaXplb2YoY2dy
b3VwZGlyKSwgIi9zeXpjZ3JvdXAvdW5pZmllZC9zeXolbGx1IiwgcHJvY2lkKTsKICBpZiAoc3lt
bGluayhjZ3JvdXBkaXIsICIuL2Nncm91cCIpKSB7CiAgfQogIHNucHJpbnRmKGNncm91cGRpciwg
c2l6ZW9mKGNncm91cGRpciksICIvc3l6Y2dyb3VwL2NwdS9zeXolbGx1IiwgcHJvY2lkKTsKICBp
ZiAoc3ltbGluayhjZ3JvdXBkaXIsICIuL2Nncm91cC5jcHUiKSkgewogIH0KICBzbnByaW50Zihj
Z3JvdXBkaXIsIHNpemVvZihjZ3JvdXBkaXIpLCAiL3N5emNncm91cC9uZXQvc3l6JWxsdSIsIHBy
b2NpZCk7CiAgaWYgKHN5bWxpbmsoY2dyb3VwZGlyLCAiLi9jZ3JvdXAubmV0IikpIHsKICB9CiAg
d3JpdGVfZmlsZSgiL3Byb2Mvc2VsZi9vb21fc2NvcmVfYWRqIiwgIjEwMDAiKTsKfQoKI2RlZmlu
ZSBTWVpfSEFWRV9SRVNFVF9URVNUIDEKc3RhdGljIHZvaWQgcmVzZXRfdGVzdCgpCnsKICBpbnQg
ZmQ7CiAgZm9yIChmZCA9IDM7IGZkIDwgMzA7IGZkKyspCiAgICBjbG9zZShmZCk7Cn0KCnN0cnVj
dCB0aHJlYWRfdCB7CiAgaW50IGNyZWF0ZWQsIGNhbGw7CiAgZXZlbnRfdCByZWFkeSwgZG9uZTsK
fTsKCnN0YXRpYyBzdHJ1Y3QgdGhyZWFkX3QgdGhyZWFkc1sxNl07CnN0YXRpYyB2b2lkIGV4ZWN1
dGVfY2FsbChpbnQgY2FsbCk7CnN0YXRpYyBpbnQgcnVubmluZzsKCnN0YXRpYyB2b2lkKiB0aHIo
dm9pZCogYXJnKQp7CiAgc3RydWN0IHRocmVhZF90KiB0aCA9IChzdHJ1Y3QgdGhyZWFkX3QqKWFy
ZzsKICBmb3IgKDs7KSB7CiAgICBldmVudF93YWl0KCZ0aC0+cmVhZHkpOwogICAgZXZlbnRfcmVz
ZXQoJnRoLT5yZWFkeSk7CiAgICBleGVjdXRlX2NhbGwodGgtPmNhbGwpOwogICAgX19hdG9taWNf
ZmV0Y2hfc3ViKCZydW5uaW5nLCAxLCBfX0FUT01JQ19SRUxBWEVEKTsKICAgIGV2ZW50X3NldCgm
dGgtPmRvbmUpOwogIH0KICByZXR1cm4gMDsKfQoKc3RhdGljIHZvaWQgZXhlY3V0ZV9vbmUodm9p
ZCkKewogIGludCBpLCBjYWxsLCB0aHJlYWQ7CiAgZm9yIChjYWxsID0gMDsgY2FsbCA8IDY7IGNh
bGwrKykgewogICAgZm9yICh0aHJlYWQgPSAwOyB0aHJlYWQgPCAoaW50KShzaXplb2YodGhyZWFk
cykgLyBzaXplb2YodGhyZWFkc1swXSkpOwogICAgICAgICB0aHJlYWQrKykgewogICAgICBzdHJ1
Y3QgdGhyZWFkX3QqIHRoID0gJnRocmVhZHNbdGhyZWFkXTsKICAgICAgaWYgKCF0aC0+Y3JlYXRl
ZCkgewogICAgICAgIHRoLT5jcmVhdGVkID0gMTsKICAgICAgICBldmVudF9pbml0KCZ0aC0+cmVh
ZHkpOwogICAgICAgIGV2ZW50X2luaXQoJnRoLT5kb25lKTsKICAgICAgICBldmVudF9zZXQoJnRo
LT5kb25lKTsKICAgICAgICB0aHJlYWRfc3RhcnQodGhyLCB0aCk7CiAgICAgIH0KICAgICAgaWYg
KCFldmVudF9pc3NldCgmdGgtPmRvbmUpKQogICAgICAgIGNvbnRpbnVlOwogICAgICBldmVudF9y
ZXNldCgmdGgtPmRvbmUpOwogICAgICB0aC0+Y2FsbCA9IGNhbGw7CiAgICAgIF9fYXRvbWljX2Zl
dGNoX2FkZCgmcnVubmluZywgMSwgX19BVE9NSUNfUkVMQVhFRCk7CiAgICAgIGV2ZW50X3NldCgm
dGgtPnJlYWR5KTsKICAgICAgZXZlbnRfdGltZWR3YWl0KCZ0aC0+ZG9uZSwgNDUpOwogICAgICBi
cmVhazsKICAgIH0KICB9CiAgZm9yIChpID0gMDsgaSA8IDEwMCAmJiBfX2F0b21pY19sb2FkX24o
JnJ1bm5pbmcsIF9fQVRPTUlDX1JFTEFYRUQpOyBpKyspCiAgICBzbGVlcF9tcygxKTsKfQoKc3Rh
dGljIHZvaWQgZXhlY3V0ZV9vbmUodm9pZCk7CgojZGVmaW5lIFdBSVRfRkxBR1MgX19XQUxMCgpz
dGF0aWMgdm9pZCBsb29wKHZvaWQpCnsKICBzZXR1cF9sb29wKCk7CiAgaW50IGl0ZXI7CiAgZm9y
IChpdGVyID0gMDs7IGl0ZXIrKykgewogICAgY2hhciBjd2RidWZbMzJdOwogICAgc3ByaW50Zihj
d2RidWYsICIuLyVkIiwgaXRlcik7CiAgICBpZiAobWtkaXIoY3dkYnVmLCAwNzc3KSkKICAgICAg
ZXhpdCgxKTsKICAgIHJlc2V0X2xvb3AoKTsKICAgIGludCBwaWQgPSBmb3JrKCk7CiAgICBpZiAo
cGlkIDwgMCkKICAgICAgZXhpdCgxKTsKICAgIGlmIChwaWQgPT0gMCkgewogICAgICBpZiAoY2hk
aXIoY3dkYnVmKSkKICAgICAgICBleGl0KDEpOwogICAgICBzZXR1cF90ZXN0KCk7CiAgICAgIGV4
ZWN1dGVfb25lKCk7CiAgICAgIHJlc2V0X3Rlc3QoKTsKICAgICAgZXhpdCgwKTsKICAgIH0KICAg
IGludCBzdGF0dXMgPSAwOwogICAgdWludDY0X3Qgc3RhcnQgPSBjdXJyZW50X3RpbWVfbXMoKTsK
ICAgIGZvciAoOzspIHsKICAgICAgaWYgKHdhaXRwaWQoLTEsICZzdGF0dXMsIFdOT0hBTkcgfCBX
QUlUX0ZMQUdTKSA9PSBwaWQpCiAgICAgICAgYnJlYWs7CiAgICAgIHNsZWVwX21zKDEpOwogICAg
ICBpZiAoY3VycmVudF90aW1lX21zKCkgLSBzdGFydCA8IDUgKiAxMDAwKQogICAgICAgIGNvbnRp
bnVlOwogICAgICBraWxsX2FuZF93YWl0KHBpZCwgJnN0YXR1cyk7CiAgICAgIGJyZWFrOwogICAg
fQogICAgcmVtb3ZlX2Rpcihjd2RidWYpOwogIH0KfQoKdWludDY0X3QgclsyXSA9IHsweGZmZmZm
ZmZmZmZmZmZmZmYsIDB4ZmZmZmZmZmZmZmZmZmZmZn07Cgp2b2lkIGV4ZWN1dGVfY2FsbChpbnQg
Y2FsbCkKewogIGxvbmcgcmVzOwogIHN3aXRjaCAoY2FsbCkgewogIGNhc2UgMDoKICAgIHJlcyA9
IHN5c2NhbGwoX19OUl9lcG9sbF9jcmVhdGUxLCAwKTsKICAgIGlmIChyZXMgIT0gLTEpCiAgICAg
IHJbMF0gPSByZXM7CiAgICBicmVhazsKICBjYXNlIDE6CiAgICBOT05GQUlMSU5HKCoodWludDE2
X3QqKTB4MjAwMDAwODAgPSAwKTsKICAgIE5PTkZBSUxJTkcoKih1aW50MTZfdCopMHgyMDAwMDA4
MiA9IDApOwogICAgTk9ORkFJTElORygqKHVpbnQ2NF90KikweDIwMDAwMDg4ID0gMCk7CiAgICBO
T05GQUlMSU5HKCoodWludDY0X3QqKTB4MjAwMDAwOTAgPSAwKTsKICAgIE5PTkZBSUxJTkcoKih1
aW50MzJfdCopMHgyMDAwMDA5OCA9IDApOwogICAgc3lzY2FsbChfX05SX2ZjbnRsLCByWzBdLCA3
LCAweDIwMDAwMDgwKTsKICAgIGJyZWFrOwogIGNhc2UgMjoKICAgIE5PTkZBSUxJTkcoKih1aW50
MTZfdCopMHgyMDAwMDE0MCA9IDEpOwogICAgTk9ORkFJTElORygqKHVpbnQxNl90KikweDIwMDAw
MTQyID0gMCk7CiAgICBOT05GQUlMSU5HKCoodWludDY0X3QqKTB4MjAwMDAxNDggPSAweDEwMDAw
MDApOwogICAgTk9ORkFJTElORygqKHVpbnQ2NF90KikweDIwMDAwMTUwID0gMCk7CiAgICBOT05G
QUlMSU5HKCoodWludDMyX3QqKTB4MjAwMDAxNTggPSAwKTsKICAgIHN5c2NhbGwoX19OUl9mY250
bCwgclswXSwgNywgMHgyMDAwMDE0MCk7CiAgICBicmVhazsKICBjYXNlIDM6CiAgICBzeXNjYWxs
KF9fTlJfYmluZCwgLTEsIDAsIDApOwogICAgYnJlYWs7CiAgY2FzZSA0OgogICAgcmVzID0gc3lz
Y2FsbChfX05SX3NvY2tldCwgMHhhLCAxLCAweDg0KTsKICAgIGlmIChyZXMgIT0gLTEpCiAgICAg
IHJbMV0gPSByZXM7CiAgICBicmVhazsKICBjYXNlIDU6CiAgICBzeXNjYWxsKF9fTlJfc2VuZHRv
LCByWzFdLCAwLCAwLCAwLCAwLCAwKTsKICAgIGJyZWFrOwogIH0KfQppbnQgbWFpbih2b2lkKQp7
CiAgc3lzY2FsbChfX05SX21tYXAsIDB4MjAwMDAwMDAsIDB4MTAwMDAwMCwgMywgMHgzMiwgLTEs
IDApOwogIGluc3RhbGxfc2Vndl9oYW5kbGVyKCk7CiAgZm9yIChwcm9jaWQgPSAwOyBwcm9jaWQg
PCA2OyBwcm9jaWQrKykgewogICAgaWYgKGZvcmsoKSA9PSAwKSB7CiAgICAgIHVzZV90ZW1wb3Jh
cnlfZGlyKCk7CiAgICAgIGRvX3NhbmRib3hfbmFtZXNwYWNlKCk7CiAgICB9CiAgfQogIHNsZWVw
KDEwMDAwMDApOwogIHJldHVybiAwOwp9Cg==


--=-oBM8upoW2pf+Ly432JDI--

