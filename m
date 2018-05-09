Return-Path: <tkjos@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525885027; cv=none;
        d=google.com; s=arc-20160816;
        b=LhWbLGO9FZjNIqMwbmFU9CsyEf7GK9dinLafLDybsROyJunj+vVLwGN7BWV6Md9Dv+
         kMGGfN5fQvihUjMvV5rHB5Odi/td+nwGvB8nAbLevOCJPvWVp+sst0RL9B/iXKWdRXcW
         vspdbBnQkDopq+Fe4NUs+hFxoHuABJMZmxocVGfcHOYSCCimXpKw7309MUc+fRn6EYkC
         b7viL5V/5xArQokCZSvLO4PpRfu3iZE7xDbl6FmcvGAoXwIaBvksRxGBp8tSVZyv1Bkd
         gV5Tnl9lOpQdZZDoZ/gReQ+LceaxwnDJwsKV8dKaFJg544dVJ+1zALfWzv3KpJ4OPEKt
         uVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=IhJG/BCVjDKr6ui5CISUsMQnC4Bvf925KdLVUpPcBMM=;
        b=QYwzowhy3kh4LhBf23vKKMZ2ektYlecr1aEDOzqEt5RxomwlWotappMYBBe/Mv+usb
         XPIRpr1iRard7BzJr3pO/6RF7yBl+y5GooS48rcvP6s/Nt79sAVUWH/LJ0pBmTNNQv1S
         6UkE5l9Xzlx5A0HjfiuMCYuPjmS5PLP4jbMG376Kn+RvGkP2Vc9FA1QjVLC7nriDv2VX
         e9/tsYOtzrh+I9OoLBFBbusjLeUmSQ/asWSKhGlUgii/8yRCPxxKE5B1uQREw9WTeyxb
         ijyLjy4bDu35iG6570EEaqzZttvU7YzekrkGpyypFJYG7A52dBGbM0kbpqZLVgsXwuRJ
         QEyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VsWME1X4;
       spf=pass (google.com: domain of tkjos@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tkjos@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VsWME1X4;
       spf=pass (google.com: domain of tkjos@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tkjos@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZo5n/dnQQUWcTK3gXomz3wuGsV2xWPnegpnDwO/atS+1ONYoTf2x8sQ+yy+XswhXh9Q3/daojrIepB2777C/ZQ=
MIME-Version: 1.0
References: <000000000000194520056affab14@google.com> <20180509075715.GH711@sol.localdomain>
In-Reply-To: <20180509075715.GH711@sol.localdomain>
From: Todd Kjos <tkjos@google.com>
Date: Wed, 09 May 2018 16:56:55 +0000
Message-ID: <CAHRSSEwAjrxZLRa3tPhjvz2MFiqVbCysTTgp6oKc=3Pcr1b2JQ@mail.gmail.com>
Subject: Re: possible deadlock in vfs_fallocate
To: Eric Biggers <ebiggers3@gmail.com>, Joel Fernandes <joelaf@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, linux-fsdevel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
	syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com
Content-Type: multipart/alternative; boundary="000000000000fc84f1056bc8ca6d"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599972333084763095?=
X-GMAIL-MSGID: =?utf-8?q?1600006418581588183?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000fc84f1056bc8ca6d
Content-Type: text/plain; charset="UTF-8"

+Joel Fernandes <joelaf@google.com>

On Wed, May 9, 2018 at 12:55 AM Eric Biggers <ebiggers3@gmail.com> wrote:

> [+ashmem maintainers]
>
> On Sun, Apr 29, 2018 at 10:00:03AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot hit the following crash on upstream commit
> > cdface5209349930ae1b51338763c8e029971b97 (Sun Apr 29 03:07:21 2018 +0000)
> > Merge tag 'for_linus_stable' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> > syzbot dashboard link:
> > https://syzkaller.appspot.com/bug?extid=148c2885d71194f18d28
> >
> > C reproducer:
> https://syzkaller.appspot.com/x/repro.c?id=5054004375584768
> > syzkaller reproducer:
> > https://syzkaller.appspot.com/x/repro.syz?id=6438048191479808
> > Raw console output:
> > https://syzkaller.appspot.com/x/log.txt?id=5404215203594240
> > Kernel config:
> > https://syzkaller.appspot.com/x/.config?id=7043958930931867332
> > compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the
> commit:
> > Reported-by: syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com
> > It will help syzbot understand when the bug is fixed. See footer for
> > details.
> > If you forward the report, please keep this part and the footer.
> >
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> > random: sshd: uninitialized urandom read (32 bytes read)
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 4.17.0-rc2+ #23 Not tainted
> > ------------------------------------------------------
> > syz-executor715/4492 is trying to acquire lock:
> >         (ptrval) (sb_writers#6){.+.+}, at: file_start_write
> > include/linux/fs.h:2718 [inline]
> >         (ptrval) (sb_writers#6){.+.+}, at: vfs_fallocate+0x5be/0x8d0
> > fs/open.c:318
> >
> > but task is already holding lock:
> >         (ptrval) (ashmem_mutex){+.+.}, at: ashmem_shrink_scan+0xac/0x560
> > drivers/staging/android/ashmem.c:440
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #3 (ashmem_mutex){+.+.}:
> >        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
> >        __mutex_lock+0x16d/0x17f0 kernel/locking/mutex.c:893
> >        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
> >        ashmem_mmap+0x53/0x460 drivers/staging/android/ashmem.c:361
> >        call_mmap include/linux/fs.h:1789 [inline]
> >        mmap_region+0xd13/0x1820 mm/mmap.c:1723
> >        do_mmap+0xc79/0x11d0 mm/mmap.c:1494
> >        do_mmap_pgoff include/linux/mm.h:2237 [inline]
> >        vm_mmap_pgoff+0x1fb/0x2a0 mm/util.c:357
> >        ksys_mmap_pgoff+0x4c9/0x640 mm/mmap.c:1544
> >        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
> >        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
> >        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
> >        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #2 (&mm->mmap_sem){++++}:
> >        __might_fault+0x155/0x1e0 mm/memory.c:4555
> >        _copy_to_user+0x30/0x110 lib/usercopy.c:25
> >        copy_to_user include/linux/uaccess.h:155 [inline]
> >        filldir+0x1ea/0x3a0 fs/readdir.c:196
> >        dir_emit_dot include/linux/fs.h:3378 [inline]
> >        dir_emit_dots include/linux/fs.h:3389 [inline]
> >        dcache_readdir+0x13a/0x620 fs/libfs.c:192
> >        iterate_dir+0x4b0/0x5d0 fs/readdir.c:51
> >        __do_sys_getdents fs/readdir.c:231 [inline]
> >        __se_sys_getdents fs/readdir.c:212 [inline]
> >        __x64_sys_getdents+0x293/0x4e0 fs/readdir.c:212
> >        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #1 (&sb->s_type->i_mutex_key#11){++++}:
> >        down_write+0x87/0x120 kernel/locking/rwsem.c:70
> >        inode_lock include/linux/fs.h:713 [inline]
> >        do_last fs/namei.c:3274 [inline]
> >        path_openat+0x123b/0x4e20 fs/namei.c:3501
> >        do_filp_open+0x249/0x350 fs/namei.c:3535
> >        do_sys_open+0x56f/0x740 fs/open.c:1093
> >        __do_sys_open fs/open.c:1111 [inline]
> >        __se_sys_open fs/open.c:1106 [inline]
> >        __x64_sys_open+0x7e/0xc0 fs/open.c:1106
> >        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #0 (sb_writers#6){.+.+}:
> >        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
> >        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36
> > [inline]
> >        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
> >        __sb_start_write+0x1e9/0x300 fs/super.c:1385
> >        file_start_write include/linux/fs.h:2718 [inline]
> >        vfs_fallocate+0x5be/0x8d0 fs/open.c:318
> >        ashmem_shrink_scan+0x1f1/0x560
> drivers/staging/android/ashmem.c:447
> >        ashmem_ioctl+0x3bf/0x13a0 drivers/staging/android/ashmem.c:789
> >        vfs_ioctl fs/ioctl.c:46 [inline]
> >        file_ioctl fs/ioctl.c:500 [inline]
> >        do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
> >        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
> >        __do_sys_ioctl fs/ioctl.c:708 [inline]
> >        __se_sys_ioctl fs/ioctl.c:706 [inline]
> >        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
> >        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
> >        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > other info that might help us debug this:
> >
> > Chain exists of:
> >   sb_writers#6 --> &mm->mmap_sem --> ashmem_mutex
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(ashmem_mutex);
> >                                lock(&mm->mmap_sem);
> >                                lock(ashmem_mutex);
> >   lock(sb_writers#6);
> >
> >  *** DEADLOCK ***
> >
> > 1 lock held by syz-executor715/4492:
> >  #0:         (ptrval) (ashmem_mutex){+.+.}, at:
> > ashmem_shrink_scan+0xac/0x560 drivers/staging/android/ashmem.c:440
> >
> > stack backtrace:
> > CPU: 1 PID: 4492 Comm: syz-executor715 Not tainted 4.17.0-rc2+ #23
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
> >  print_circular_bug.isra.36.cold.54+0x1bd/0x27d
> > kernel/locking/lockdep.c:1223
> >  check_prev_add kernel/locking/lockdep.c:1863 [inline]
> >  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
> >  validate_chain kernel/locking/lockdep.c:2417 [inline]
> >  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431
> >  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
> >  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36
> [inline]
> >  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
> >  __sb_start_write+0x1e9/0x300 fs/super.c:1385
> >  file_start_write include/linux/fs.h:2718 [inline]
> >  vfs_fallocate+0x5be/0x8d0 fs/open.c:318
> >  ashmem_shrink_scan+0x1f1/0x560 drivers/staging/android/ashmem.c:447
> >  ashmem_ioctl+0x3bf/0x13a0 drivers/staging/android/ashmem.c:789
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  file_ioctl fs/ioctl.c:500 [inline]
> >  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
> >  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
> >  __do_sys_ioctl fs/ioctl.c:708 [inline]
> >  __se_sys_ioctl fs/ioctl.c:706 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
> >  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x440179
> > RSP: 002b:00007ffc165d4a28 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 6873612f7665642f RCX: 0000000000440179
> > RDX: 0000000000000000 RSI: 000000000000770a RDI: 0000000000000004
> > RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000004 R11: 0000000000000217 R12: 00000000004016a0
> > R13: 0000000000401730 R14: 0000000000000000 R15: 0000000000000000
> > random: crng init done
> >
> >
> > ---
> > This bug is generated by a dumb bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for details.
> > Direct all questions to syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report.
> > If you forgot to add the Reported-by tag, once the fix for this bug is
> > merged
> > into any tree, please reply to this email with:
> > #syz fix: exact-commit-title
> > If you want to test a patch for this bug, please reply with:
> > #syz test: git://repo/address.git branch
> > and provide the patch inline or as an attachment.
> > To mark this as a duplicate of another syzbot report, please reply with:
> > #syz dup: exact-subject-of-another-report
> > If it's a one-off invalid bug report, please reply with:
> > #syz invalid
> > Note: if the crash happens again, it will cause creation of a new bug
> > report.
> > Note: all commands must start from beginning of the line in the email
> body.
>
> Looks like yet another locking bug in ashmem.  ashmem_mutex normally ranks
> below
> mmap_sem, but ashmem_shrink_scan() inverts that order, via the
> file_start_write() in vfs_fallocate().
>
> - Eric
>

--000000000000fc84f1056bc8ca6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=
=3D"mailto:joelaf@google.com" tabindex=3D"-1">+Joel Fernandes</a>=C2=A0<br>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, May 9, 2018 a=
t 12:55 AM Eric Biggers &lt;<a href=3D"mailto:ebiggers3@gmail.com">ebiggers=
3@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">[+ashmem=
 maintainers]<br>
<br>
On Sun, Apr 29, 2018 at 10:00:03AM -0700, syzbot wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; syzbot hit the following crash on upstream commit<br>
&gt; cdface5209349930ae1b51338763c8e029971b97 (Sun Apr 29 03:07:21 2018 +00=
00)<br>
&gt; Merge tag &#39;for_linus_stable&#39; of<br>
&gt; git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/tytso/=
ext4" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/linux/ker=
nel/git/tytso/ext4</a><br>
&gt; syzbot dashboard link:<br>
&gt; <a href=3D"https://syzkaller.appspot.com/bug?extid=3D148c2885d71194f18=
d28" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.com/bug=
?extid=3D148c2885d71194f18d28</a><br>
&gt; <br>
&gt; C reproducer: <a href=3D"https://syzkaller.appspot.com/x/repro.c?id=3D=
5054004375584768" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.ap=
pspot.com/x/repro.c?id=3D5054004375584768</a><br>
&gt; syzkaller reproducer:<br>
&gt; <a href=3D"https://syzkaller.appspot.com/x/repro.syz?id=3D643804819147=
9808" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.com/x/=
repro.syz?id=3D6438048191479808</a><br>
&gt; Raw console output:<br>
&gt; <a href=3D"https://syzkaller.appspot.com/x/log.txt?id=3D54042152035942=
40" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.com/x/lo=
g.txt?id=3D5404215203594240</a><br>
&gt; Kernel config:<br>
&gt; <a href=3D"https://syzkaller.appspot.com/x/.config?id=3D70439589309318=
67332" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.com/x=
/.config?id=3D7043958930931867332</a><br>
&gt; compiler: gcc (GCC) 8.0.1 20180413 (experimental)<br>
&gt; <br>
&gt; IMPORTANT: if you fix the bug, please add the following tag to the com=
mit:<br>
&gt; Reported-by: <a href=3D"mailto:syzbot%2B148c2885d71194f18d28@syzkaller=
.appspotmail.com" target=3D"_blank">syzbot+148c2885d71194f18d28@syzkaller.a=
ppspotmail.com</a><br>
&gt; It will help syzbot understand when the bug is fixed. See footer for<b=
r>
&gt; details.<br>
&gt; If you forward the report, please keep this part and the footer.<br>
&gt; <br>
&gt; random: sshd: uninitialized urandom read (32 bytes read)<br>
&gt; random: sshd: uninitialized urandom read (32 bytes read)<br>
&gt; random: sshd: uninitialized urandom read (32 bytes read)<br>
&gt; <br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
&gt; WARNING: possible circular locking dependency detected<br>
&gt; 4.17.0-rc2+ #23 Not tainted<br>
&gt; ------------------------------------------------------<br>
&gt; syz-executor715/4492 is trying to acquire lock:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ptrval) (sb_writers#6){.+.+}, at: fi=
le_start_write<br>
&gt; include/linux/fs.h:2718 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ptrval) (sb_writers#6){.+.+}, at: vf=
s_fallocate+0x5be/0x8d0<br>
&gt; fs/open.c:318<br>
&gt; <br>
&gt; but task is already holding lock:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ptrval) (ashmem_mutex){+.+.}, at: as=
hmem_shrink_scan+0xac/0x560<br>
&gt; drivers/staging/android/ashmem.c:440<br>
&gt; <br>
&gt; which lock already depends on the new lock.<br>
&gt; <br>
&gt; <br>
&gt; the existing dependency chain (in reverse order) is:<br>
&gt; <br>
&gt; -&gt; #3 (ashmem_mutex){+.+.}:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __mutex_lock_common kernel/locking/mutex.c:=
756 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __mutex_lock+0x16d/0x17f0 kernel/locking/mu=
tex.c:893<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock_nested+0x16/0x20 kernel/locking/=
mutex.c:908<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ashmem_mmap+0x53/0x460 drivers/staging/andr=
oid/ashmem.c:361<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 call_mmap include/linux/fs.h:1789 [inline]<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_region+0xd13/0x1820 mm/mmap.c:1723<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_mmap+0xc79/0x11d0 mm/mmap.c:1494<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_mmap_pgoff include/linux/mm.h:2237 [inli=
ne]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm_mmap_pgoff+0x1fb/0x2a0 mm/util.c:357<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ksys_mmap_pgoff+0x4c9/0x640 mm/mmap.c:1544<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:=
100 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:=
91 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/s=
ys_x86_64.c:91<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_syscall_64+0x1b1/0x800 arch/x86/entry/co=
mmon.c:287<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry_SYSCALL_64_after_hwframe+0x49/0xbe<br=
>
&gt; <br>
&gt; -&gt; #2 (&amp;mm-&gt;mmap_sem){++++}:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __might_fault+0x155/0x1e0 mm/memory.c:4555<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 _copy_to_user+0x30/0x110 lib/usercopy.c:25<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 copy_to_user include/linux/uaccess.h:155 [i=
nline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 filldir+0x1ea/0x3a0 fs/readdir.c:196<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 dir_emit_dot include/linux/fs.h:3378 [inlin=
e]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 dir_emit_dots include/linux/fs.h:3389 [inli=
ne]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 dcache_readdir+0x13a/0x620 fs/libfs.c:192<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 iterate_dir+0x4b0/0x5d0 fs/readdir.c:51<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __do_sys_getdents fs/readdir.c:231 [inline]=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __se_sys_getdents fs/readdir.c:212 [inline]=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __x64_sys_getdents+0x293/0x4e0 fs/readdir.c=
:212<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_syscall_64+0x1b1/0x800 arch/x86/entry/co=
mmon.c:287<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry_SYSCALL_64_after_hwframe+0x49/0xbe<br=
>
&gt; <br>
&gt; -&gt; #1 (&amp;sb-&gt;s_type-&gt;i_mutex_key#11){++++}:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 down_write+0x87/0x120 kernel/locking/rwsem.=
c:70<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 inode_lock include/linux/fs.h:713 [inline]<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_last fs/namei.c:3274 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 path_openat+0x123b/0x4e20 fs/namei.c:3501<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_filp_open+0x249/0x350 fs/namei.c:3535<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_sys_open+0x56f/0x740 fs/open.c:1093<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __do_sys_open fs/open.c:1111 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __se_sys_open fs/open.c:1106 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __x64_sys_open+0x7e/0xc0 fs/open.c:1106<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_syscall_64+0x1b1/0x800 arch/x86/entry/co=
mmon.c:287<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry_SYSCALL_64_after_hwframe+0x49/0xbe<br=
>
&gt; <br>
&gt; -&gt; #0 (sb_writers#6){.+.+}:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 lock_acquire+0x1dc/0x520 kernel/locking/loc=
kdep.c:3920<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 percpu_down_read_preempt_disable include/li=
nux/percpu-rwsem.h:36<br>
&gt; [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 percpu_down_read include/linux/percpu-rwsem=
.h:59 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __sb_start_write+0x1e9/0x300 fs/super.c:138=
5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 file_start_write include/linux/fs.h:2718 [i=
nline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfs_fallocate+0x5be/0x8d0 fs/open.c:318<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ashmem_shrink_scan+0x1f1/0x560 drivers/stag=
ing/android/ashmem.c:447<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ashmem_ioctl+0x3bf/0x13a0 drivers/staging/a=
ndroid/ashmem.c:789<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 vfs_ioctl fs/ioctl.c:46 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 file_ioctl fs/ioctl.c:500 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __do_sys_ioctl fs/ioctl.c:708 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __se_sys_ioctl fs/ioctl.c:706 [inline]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_syscall_64+0x1b1/0x800 arch/x86/entry/co=
mmon.c:287<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry_SYSCALL_64_after_hwframe+0x49/0xbe<br=
>
&gt; <br>
&gt; other info that might help us debug this:<br>
&gt; <br>
&gt; Chain exists of:<br>
&gt;=C2=A0 =C2=A0sb_writers#6 --&gt; &amp;mm-&gt;mmap_sem --&gt; ashmem_mut=
ex<br>
&gt; <br>
&gt;=C2=A0 Possible unsafe locking scenario:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 ----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ----<br>
&gt;=C2=A0 =C2=A0lock(ashmem_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lock(&amp;mm-&gt;mmap_sem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lock(ashmem_mutex);<br>
&gt;=C2=A0 =C2=A0lock(sb_writers#6);<br>
&gt; <br>
&gt;=C2=A0 *** DEADLOCK ***<br>
&gt; <br>
&gt; 1 lock held by syz-executor715/4492:<br>
&gt;=C2=A0 #0:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ptrval) (ashmem_mutex){+.+=
.}, at:<br>
&gt; ashmem_shrink_scan+0xac/0x560 drivers/staging/android/ashmem.c:440<br>
&gt; <br>
&gt; stack backtrace:<br>
&gt; CPU: 1 PID: 4492 Comm: syz-executor715 Not tainted 4.17.0-rc2+ #23<br>
&gt; Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S<br>
&gt; Google 01/01/2011<br>
&gt; Call Trace:<br>
&gt;=C2=A0 __dump_stack lib/dump_stack.c:77 [inline]<br>
&gt;=C2=A0 dump_stack+0x1b9/0x294 lib/dump_stack.c:113<br>
&gt;=C2=A0 print_circular_bug.isra.36.cold.54+0x1bd/0x27d<br>
&gt; kernel/locking/lockdep.c:1223<br>
&gt;=C2=A0 check_prev_add kernel/locking/lockdep.c:1863 [inline]<br>
&gt;=C2=A0 check_prevs_add kernel/locking/lockdep.c:1976 [inline]<br>
&gt;=C2=A0 validate_chain kernel/locking/lockdep.c:2417 [inline]<br>
&gt;=C2=A0 __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431<br>
&gt;=C2=A0 lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920<br>
&gt;=C2=A0 percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36=
 [inline]<br>
&gt;=C2=A0 percpu_down_read include/linux/percpu-rwsem.h:59 [inline]<br>
&gt;=C2=A0 __sb_start_write+0x1e9/0x300 fs/super.c:1385<br>
&gt;=C2=A0 file_start_write include/linux/fs.h:2718 [inline]<br>
&gt;=C2=A0 vfs_fallocate+0x5be/0x8d0 fs/open.c:318<br>
&gt;=C2=A0 ashmem_shrink_scan+0x1f1/0x560 drivers/staging/android/ashmem.c:=
447<br>
&gt;=C2=A0 ashmem_ioctl+0x3bf/0x13a0 drivers/staging/android/ashmem.c:789<b=
r>
&gt;=C2=A0 vfs_ioctl fs/ioctl.c:46 [inline]<br>
&gt;=C2=A0 file_ioctl fs/ioctl.c:500 [inline]<br>
&gt;=C2=A0 do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684<br>
&gt;=C2=A0 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701<br>
&gt;=C2=A0 __do_sys_ioctl fs/ioctl.c:708 [inline]<br>
&gt;=C2=A0 __se_sys_ioctl fs/ioctl.c:706 [inline]<br>
&gt;=C2=A0 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706<br>
&gt;=C2=A0 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287<br>
&gt;=C2=A0 entry_SYSCALL_64_after_hwframe+0x49/0xbe<br>
&gt; RIP: 0033:0x440179<br>
&gt; RSP: 002b:00007ffc165d4a28 EFLAGS: 00000217 ORIG_RAX: 0000000000000010=
<br>
&gt; RAX: ffffffffffffffda RBX: 6873612f7665642f RCX: 0000000000440179<br>
&gt; RDX: 0000000000000000 RSI: 000000000000770a RDI: 0000000000000004<br>
&gt; RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000<br>
&gt; R10: 0000000000000004 R11: 0000000000000217 R12: 00000000004016a0<br>
&gt; R13: 0000000000401730 R14: 0000000000000000 R15: 0000000000000000<br>
&gt; random: crng init done<br>
&gt; <br>
&gt; <br>
&gt; ---<br>
&gt; This bug is generated by a dumb bot. It may contain errors.<br>
&gt; See <a href=3D"https://goo.gl/tpsmEJ" rel=3D"noreferrer" target=3D"_bl=
ank">https://goo.gl/tpsmEJ</a> for details.<br>
&gt; Direct all questions to <a href=3D"mailto:syzkaller@googlegroups.com" =
target=3D"_blank">syzkaller@googlegroups.com</a>.<br>
&gt; <br>
&gt; syzbot will keep track of this bug report.<br>
&gt; If you forgot to add the Reported-by tag, once the fix for this bug is=
<br>
&gt; merged<br>
&gt; into any tree, please reply to this email with:<br>
&gt; #syz fix: exact-commit-title<br>
&gt; If you want to test a patch for this bug, please reply with:<br>
&gt; #syz test: git://repo/address.git branch<br>
&gt; and provide the patch inline or as an attachment.<br>
&gt; To mark this as a duplicate of another syzbot report, please reply wit=
h:<br>
&gt; #syz dup: exact-subject-of-another-report<br>
&gt; If it&#39;s a one-off invalid bug report, please reply with:<br>
&gt; #syz invalid<br>
&gt; Note: if the crash happens again, it will cause creation of a new bug<=
br>
&gt; report.<br>
&gt; Note: all commands must start from beginning of the line in the email =
body.<br>
<br>
Looks like yet another locking bug in ashmem.=C2=A0 ashmem_mutex normally r=
anks below<br>
mmap_sem, but ashmem_shrink_scan() inverts that order, via the<br>
file_start_write() in vfs_fallocate().<br>
<br>
- Eric<br>
</blockquote></div>

--000000000000fc84f1056bc8ca6d--
