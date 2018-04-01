Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeDAVEr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 17:04:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35880 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeDAVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 17:04:45 -0400
X-Google-Smtp-Source: AIpwx4/eFtJf2EJMySsaEkQWp2Vp62pz1DQafVahTzKHImH5cKNCnOxna0F7SQRiE+LXmmQ9sMj97A==
Date: Sun, 1 Apr 2018 14:05:08 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: syzbot <syzbot+f3bd89a5ab3266b10540@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: corrupted list in __dentry_kill
Message-ID: <20180401210508.GA743@sol.localdomain>
References: <001a11447acaa9eec40568bd5438@google.com>
 <20180401033519.GZ30522@ZenIV.linux.org.uk>
 <20180401200531.GA30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180401200531.GA30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2018 at 09:05:31PM +0100, Al Viro wrote:
> On Sun, Apr 01, 2018 at 04:35:19AM +0100, Al Viro wrote:
> > On Sat, Mar 31, 2018 at 04:01:02PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot hit the following crash on bpf-next commit
> > > 7828f20e3779e4e85e55371e0e43f5006a15fb41 (Sat Mar 31 00:17:57 2018 +0000)
> > > Merge branch 'bpf-cgroup-bind-connect'
> > > syzbot dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=f3bd89a5ab3266b10540
> > > 
> > > So far this crash happened 22 times on bpf-next, upstream.
> > > C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6290970458980352
> > > syzkaller reproducer:
> > > https://syzkaller.appspot.com/x/repro.syz?id=6577156880596992
> > > Raw console output:
> > > https://syzkaller.appspot.com/x/log.txt?id=5107570603720704
> > > Kernel config:
> > > https://syzkaller.appspot.com/x/.config?id=5909223872832634926
> > > compiler: gcc (GCC) 7.1.1 20170620
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+f3bd89a5ab3266b10540@syzkaller.appspotmail.com
> > > It will help syzbot understand when the bug is fixed. See footer for
> > > details.
> > > If you forward the report, please keep this part and the footer.
> > > 
> > > RBP: 00007ffd1bbb3ae0 R08: 0000000020000200 R09: 0000000300000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> > > R13: 0000000000000003 R14: 0000000000001380 R15: 00007ffd1bbb3378
> > > list_del corruption. prev->next should be 00000000a8104008, but was
> > > 00000000081c6144
> > 
> > Lovely...  I'll look into that tomorrow morning.
> 
> Can't reproduce - it reproducer had been running for several hours, with
> that kernel and that config (gcc 6.3, not 7.1, though), no oopsen...
> 
> If somebody can reproduce that thing, I'd appreciate having it bisected
> a bit...
> 

Apparently the reproducer wants to inject a fault into a specific memory
allocation, and something is causing the memory allocations to be different.  It
works for me in ~10 seconds after applying the below patch to the C reproducer.
(I also did 'echo 0 | tee /sys/kernel/debug/fail*/verbose' beforehand to quiet
all the fault injection messages.)  I'm guessing the bug is in the error
handling in "rpc_pipefs", but not sure exactly what yet.  The last messages in
the kernel log before the BUG() were:

[   42.965515] net/sunrpc/rpc_pipe.c: __rpc_create_common failed to allocate inode for dentry blocklayout
[   42.967234] net/sunrpc/rpc_pipe.c: rpc_mkpipe_dentry() failed to create pipe nfs/blocklayout (errno = -12)

diff --git a/syz_dentry_kill.c b/syz_dentry_kill.c
index e38ee57..8c6a76e 100644
--- a/syz_dentry_kill.c
+++ b/syz_dentry_kill.c
@@ -723,6 +723,7 @@ static void loop()
       }
       if (symlink(cgroupdir_net, "./cgroup.net")) {
       }
+      srand(getpid());
       execute_one();
       doexit(0);
     }
@@ -786,7 +787,7 @@ void execute_one()
          48);
   write_file("/sys/kernel/debug/failslab/ignore-gfp-wait", "N");
   write_file("/sys/kernel/debug/fail_futex/ignore-private", "N");
-  inject_fault(60);
+  inject_fault(rand() % 500);
   syscall(__NR_mount, 0x20000300, 0x20000140, 0x200002c0, 0, 0x20000200);
 }
 
