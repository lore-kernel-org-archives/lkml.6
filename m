Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B910C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E22B214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E22B214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbeKVGkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:40:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:40074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730780AbeKVGkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:40:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDF66AEDB;
        Wed, 21 Nov 2018 20:04:34 +0000 (UTC)
Date:   Wed, 21 Nov 2018 14:04:21 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in mnt_want_write
Message-ID: <20181121200114.yqis7fvn5x7nsw6e@merlin>
References: <000000000000d03eea0571adfe83@google.com>
 <000000000000a8e163057b2f2ddf@google.com>
 <CAOQ4uxhAwdaZnPLX6+qYWaNL6NHQDMptx5TMyzo3B7CCcgWTjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhAwdaZnPLX6+qYWaNL6NHQDMptx5TMyzo3B7CCcgWTjg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:57 21/11, Amir Goldstein wrote:
> On Wed, Nov 21, 2018 at 8:33 PM syzbot
> <syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11a1426d400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1632326d400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a16ed5400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com
> >
> > IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
> > IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
> > 8021q: adding VLAN 0 to HW filter on device team0
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 4.20.0-rc1-next-20181109+ #110 Not tainted
> > ------------------------------------------------------
> > syz-executor599/5968 is trying to acquire lock:
> > 00000000e42cbf00 (sb_writers#3){.+.+}, at: sb_start_write
> > include/linux/fs.h:1607 [inline]
> > 00000000e42cbf00 (sb_writers#3){.+.+}, at: mnt_want_write+0x3f/0xc0
> > fs/namespace.c:359
> >
> > but task is already holding lock:
> > 00000000166f985a (&iint->mutex){+.+.}, at: process_measurement+0x438/0x1bf0
> > security/integrity/ima/ima_main.c:224
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #1 (&iint->mutex){+.+.}:
> >         __mutex_lock_common kernel/locking/mutex.c:925 [inline]
> >         __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
> >         mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
> >         process_measurement+0x438/0x1bf0
> > security/integrity/ima/ima_main.c:224
> >         ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
> >         do_last fs/namei.c:3422 [inline]
> >         path_openat+0x134a/0x5150 fs/namei.c:3534
> >         do_filp_open+0x255/0x380 fs/namei.c:3564
> >         do_sys_open+0x568/0x700 fs/open.c:1063
> >         __do_sys_open fs/open.c:1081 [inline]
> >         __se_sys_open fs/open.c:1076 [inline]
> >         __x64_sys_open+0x7e/0xc0 fs/open.c:1076
> >         do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > -> #0 (sb_writers#3){.+.+}:
> >         lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
> >         percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36
> > [inline]
> >         percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
> >         __sb_start_write+0x214/0x370 fs/super.c:1564
> >         sb_start_write include/linux/fs.h:1607 [inline]
> >         mnt_want_write+0x3f/0xc0 fs/namespace.c:359
> >         ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
> >         ovl_open_maybe_copy_up+0x12c/0x190 fs/overlayfs/copy_up.c:888
> >         ovl_open+0xb3/0x260 fs/overlayfs/file.c:123
> >         do_dentry_open+0x499/0x1250 fs/open.c:771
> >         vfs_open fs/open.c:880 [inline]
> >         dentry_open+0x143/0x1d0 fs/open.c:896
> >         ima_calc_file_hash+0x324/0x570
> 
> I suppose ima_calc_file_hash opens the file with write flags
> and cause overlay to try to copy up which takes mnt_want_write().
> Why does IMA need to open the file with write flags?
> 
> Isn't this commit supposed to prevent that:
> a408e4a86b36 ima: open a new file instance if no read permissions
> 

Not write, read flags. This patch re-opens the files in O_RDONLY for
files opened with O_WRONLY and cannot be read, so that the hash can be
calculated. IOW, the user opened the file in overlayfs with write flags.

The copy-up, since it is already in write mode can add the security.ima
xattrs.

-- 
Goldwyn
