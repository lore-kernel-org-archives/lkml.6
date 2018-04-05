Date: Thu, 5 Apr 2018 08:34:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: syzbot <syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: kobject bug in sysfs_warn_dup
Message-ID: <20180405063444.GA5877@kroah.com>
References: <f4f5e80803d0503e760569105376@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f5e80803d0503e760569105376@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 07:02:01PM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> 3e968c9f1401088abc9a19ae6ff571644d37a355 (Wed Apr 4 21:19:24 2018 +0000)
> Merge tag 'ext4_for_linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=ff87a28e665c163aa7f5
> 
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5104666266304512
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=5683447737614336
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5104818200772608
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=9118669095563550941
> compiler: gcc (GCC) 7.1.1 20170620
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ff87a28e665c163aa7f5@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000003
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> ------------[ cut here ]------------
> kobject_add_internal failed for nodev( with -EEXIST, don't try to register
> things with the same name in the same directory.
> sysfs: cannot create duplicate filename '/fs/gfs2/nodev('
> WARNING: CPU: 1 PID: 4473 at lib/kobject.c:238
> kobject_add_internal+0x8d4/0xbc0 lib/kobject.c:235
> CPU: 0 PID: 4474 Comm: syzkaller533472 Not tainted 4.16.0+ #15
> Kernel panic - not syncing: panic_on_warn set ...
> 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x1a7/0x27d lib/dump_stack.c:53
>  sysfs_warn_dup+0x83/0xa0 fs/sysfs/dir.c:30
>  sysfs_create_dir_ns+0x178/0x1d0 fs/sysfs/dir.c:58
>  create_dir lib/kobject.c:69 [inline]
>  kobject_add_internal+0x335/0xbc0 lib/kobject.c:227
>  kobject_add_varg lib/kobject.c:364 [inline]
>  kobject_init_and_add+0xf9/0x150 lib/kobject.c:436
>  gfs2_sys_fs_add+0x1ff/0x580 fs/gfs2/sys.c:652
>  fill_super+0x86f/0x1d70 fs/gfs2/ops_fstype.c:1118
>  gfs2_mount+0x587/0x6e0 fs/gfs2/ops_fstype.c:1321

gfs2 bug, not a sysfs bug, we are correctly warning about an incorrect
usage of the api.

Now if we should turn this into a non-WARN message, that's a different
thing, I'll gladly take a patch for that.

thanks,

greg k-h
