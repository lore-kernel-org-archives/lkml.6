Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbeA3X3n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:29:43 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:35501 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeA3X3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:29:41 -0500
X-Google-Smtp-Source: AH8x2262UMAaInG9am3JGlOYmjXeejYsvip1kPr79POHyXrz8jDkf7YkQvAIlTzrL9S3N3SNp6rkSw==
Date: Tue, 30 Jan 2018 15:29:37 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: syzbot
        <bot+175e5d2a9ccf14eecd5874bce460d85ee3d9de8d@syzkaller.appspotmail.com>,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in find_entry
Message-ID: <20180130232937.abnxyckz2fgjcixu@gmail.com>
References: <001a113eca407a42bc0560fcf1aa@google.com>
 <20180105213104.GG22430@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105213104.GG22430@wotan.suse.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2018 at 10:31:04PM +0100, Luis R. Rodriguez wrote:
> On Fri, Dec 22, 2017 at 11:33:02PM -0800, syzbot wrote:
> > Hello,
> > 
> > syzkaller hit the following crash on
> > 6084b576dca2e898f5c101baef151f7bfdbb606d
> > git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> > compiler: gcc (GCC) 7.1.1 20170620
> > .config is attached
> > Raw console output is attached.
> > 
> > Unfortunately, I don't have any reproducer for this bug yet.
> > 
> > 
> > netlink: 13 bytes leftover after parsing attributes in process
> > `syz-executor2'.
> > general protection fault: 0000 [#1] SMP
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > Modules linked in:
> > CPU: 1 PID: 26639 Comm: syz-executor5 Not tainted 4.15.0-rc3-next-20171214+
> > #67
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > RIP: 0010:find_entry.isra.14+0x45/0xc0 fs/proc/proc_sysctl.c:119
> > RSP: 0018:ffffc90000dcba60 EFLAGS: 00010282
> > RAX: 0000000000010000 RBX: ffff1003f68e0980 RCX: ffffffff814becad
> > RDX: 000000000000674d RSI: ffffc90000fe1000 RDI: ffffc90000dcbaa8
> > RBP: ffffc90000dcba98 R08: 0000000000000001 R09: 0000000000000004
> > R10: ffffc90000dcba48 R11: 0000000000000004 R12: ffff8801fb4704d0
> > R13: ffff8801fb470400 R14: ffff8801fc7ecc00 R15: ffffc90000dcbb7d
> > FS:  00007f125b750700(0000) GS:ffff88021fd00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000001680cd8 CR3: 00000001fd3ac001 CR4: 00000000001606e0
> > DR0: 0000000020001008 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> > Call Trace:
> >  find_subdir+0x35/0x80 fs/proc/proc_sysctl.c:923
> >  get_subdir fs/proc/proc_sysctl.c:977 [inline]
> >  __register_sysctl_table+0x392/0x7c0 fs/proc/proc_sysctl.c:1327
> 
> find_subdir() accepts as part of its seconds argument a struct ctl_dir *dir,
> which we then find_subdir() then dereferences using find_entry():
> 
> struct rb_node *node = dir->root.rb_node;
> 
> The RIP however is on find_entry.isra.14+0x45/0xc0 fs/proc/proc_sysctl.c:119
> which as of linux-next is:
> 
> 	entry = &head->ctl_table[ctl_node - head->node];
> 
> So a few questions to review.
> 
> 1) Is it sensible to assume we can always reference the dir?
> 2) Is the entry computation above really safe always?
> 
> Let's try:
> 
> 1) Is it sensible to assume we can always reference the dir?
> 
> 1a) When registering a sysctl table register_sysctl() calls:
> 
>         return __register_sysctl_table(&sysctl_table_root.default_set,          
>                                         path, table); 
> 
> So the sysctl_table_root.default_set set is used. When registering
> then, the first dir used is this one. init_header() sets the
> set on the header to this one, and we use the same set for
> the first dir:
> 
>         dir = &set->dir;
> 
> Whether or not this is safe will depend on the life cycle of this root entry's
> dir pointer, and at init sysctl_table_root.default_set.dir is just a pointer
> in static memory. It cannot be freed. So on the first iteration
> the dereference should  always be safe.
> 
> On the loop, since strchr() is used we iterate over the path given
> for the target proc directory entry by first looking at the first
> pattern with '/'.
> 
> >  register_net_sysctl+0x29/0x30 net/sysctl_net.c:120
> >  neigh_sysctl_register+0x150/0x220 net/core/neighbour.c:3235
> 
> In this particular case of addrconf_sysctl_register()
> the path is something along the lines of: "net/%s/neigh/%s"
> 
> So if we had path as net/foo/neigh/bar we'd have a few iterations as
> follows:
> 
> Path: net/foo/neigh/bar
> ------------------------------------
> name: net/foo/neigh/bar
> nextname: foo/neigh/bar
> ------------------------------------
> name: foo/neigh/bar
> nextname: neigh/bar
> ------------------------------------
> name: neigh/bar
> nextname: bar
> ------------------------------------
> name: bar
> nextname: (null)
> 
> And for each one we'd call get_subdir() to ensure that
> the dir exists:
> 
>                 dir = get_subdir(dir, name, namelen);                           
>                 if (IS_ERR(dir))                                                
>                         goto fail; 
> 
> Its in these lookups where we hit an issue. Note that
> get_subdir() calls find_subdir() twice, the one we hit the
> issue with is the first call.
> 
> The loop will keep setting up dir to traverse the entire path
> ensuring we have a dir entry up to the end of the path. Each
> sub directory must have an entry in order for this
> to work.
> 
> The safety of relying on dereferencing dir will then depend on our locking
> sanity and management of the dirs here. I'm not so sure about the sanity
> on locking here yet.
> 
> 2) Is the entry computation above really safe always?
> 2A) The find_entry() call and entry lookup we are concerned with which we see
> on RIP happens off of the get_subdir() calls on the loop inspected above. The
> trace above shows its on the get_subdir() call, and this trace:
> 
> 	get_subdir fs/proc/proc_sysctl.c:977 [inline]
> 
> Tells us its the first find_subdir() call within get_subdir() where the issue
> was hit.  find_subdir() looks at the registered ctl table and looks for a
> matching directory, and if found returns it it, a struct ctl_dir pointer.
> From what I can gather this is safe so long as our locking is sane.
> 
> Not sure yet what could be wrong.. being able to reproduce would help.
> I'd recommend trying to expand on lib/test_sysctl.c with more elaborate
> entanglements and trying to register/deregister as a tests a series of
> subdirectories which some depend entries depend on.
> 

Hi Luis, this crash has only occurred once, and it was actually reported while
KASAN was accidentally disabled in the syzbot kconfig due to a change to the
kconfig menus in linux-next -- so the crash was possibly caused by slab
corruption elsewhere.

I will just invalidate the bug so that syzbot can report crashes with the same
signature again, but feel free to look into it more if you think there is still
a real problem somewhere.

#syz invalid

Thanks,

Eric
