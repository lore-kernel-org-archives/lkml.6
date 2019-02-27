Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BB0C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE54621850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551300809;
	bh=1JAwDBZcOb1VDs6/iQjeHOWU6iugQDsPvWoeUF70/rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V24V5CceXvKIb1QqJm5WcnkL15ojwWh4DuM/grwIMoIqjuqNSsdRPdRkxEM80A4jg
	 ENvZeElLtm0W0D/sIWJyPREz/dJMczbcR2217Gm6HEhpmsgO/uV3fH9BUouv53EDA2
	 cmSqHabYEyCklRYPQVcvcMPRiIxjug+PDp9oeEoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbfB0Ux2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbfB0Ux1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:53:27 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEEE217F5;
        Wed, 27 Feb 2019 20:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551300806;
        bh=1JAwDBZcOb1VDs6/iQjeHOWU6iugQDsPvWoeUF70/rM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y2zus7rKTTFTDjAavytKsf7pcM9XO+haY1J6mSL9jKDcG288nnGXM4un2f4LgNc9q
         0TclnAGh0xx1OlanaN25scOCK9pcqg5Co0uxpAdkZW0jWT1trd0wfsbDbmhdjQVm0Y
         Zoe/5WY+d0juzy9XtwuyFabv1Rh4aKkniRSMJSLA=
Date:   Wed, 27 Feb 2019 12:53:24 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+2cd2887ea471ed6e6995@syzkaller.appspotmail.com>,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, nborisov@suse.com,
        rppt@linux.vnet.ibm.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        willy@infradead.org, joel@joelfernandes.org,
        Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: BUG: Bad page state (5)
Message-ID: <20190227205323.GA186986@gmail.com>
References: <0000000000006a12bd0581ca4145@google.com>
 <20190213122331.632a4eb1a12b738ef9633855@linux-foundation.org>
 <20190226182129.GA218103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226182129.GA218103@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:21:30AM -0800, Eric Biggers wrote:
> On Wed, Feb 13, 2019 at 12:23:31PM -0800, Andrew Morton wrote:
> > On Wed, 13 Feb 2019 09:56:04 -0800 syzbot <syzbot+2cd2887ea471ed6e6995@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    c4f3ef3eb53f Add linux-next specific files for 20190213
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1130a124c00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=9ec67976eb2df882
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=2cd2887ea471ed6e6995
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ecdaa8c00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ebe178c00000
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+2cd2887ea471ed6e6995@syzkaller.appspotmail.com
> > 
> > It looks like a a memfd page was freed with a non-NULL ->mapping.
> > 
> > Joel touched the memfd code with "mm/memfd: add an F_SEAL_FUTURE_WRITE
> > seal to memfd" but it would be surprising if syzbot tickled that code?
> > 
> > 
> > > BUG: Bad page state in process udevd  pfn:472f0
> > > name:"memfd:"
> > > page:ffffea00011cbc00 count:0 mapcount:0 mapping:ffff88800df2ad40 index:0xf
> > > shmem_aops
> > > flags: 0x1fffc000008000c(uptodate|dirty|swapbacked)
> > > raw: 01fffc000008000c ffffea0000ac4f08 ffff8880a85af890 ffff88800df2ad40
> > > raw: 000000000000000f 0000000000000000 00000000ffffffff 0000000000000000
> > > page dumped because: non-NULL mapping
> > > Modules linked in:
> > > CPU: 1 PID: 7586 Comm: udevd Not tainted 5.0.0-rc6-next-20190213 #34
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> > > Google 01/01/2011
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > >   bad_page.cold+0xda/0xff mm/page_alloc.c:586
> > >   free_pages_check_bad+0x142/0x1a0 mm/page_alloc.c:1014
> > >   free_pages_check mm/page_alloc.c:1023 [inline]
> > >   free_pages_prepare mm/page_alloc.c:1113 [inline]
> > >   free_pcp_prepare mm/page_alloc.c:1138 [inline]
> > >   free_unref_page_prepare mm/page_alloc.c:2991 [inline]
> > >   free_unref_page_list+0x31d/0xc40 mm/page_alloc.c:3060
> > > name:"memfd:"
> > >   release_pages+0x60d/0x1940 mm/swap.c:791
> > >   pagevec_lru_move_fn+0x218/0x2a0 mm/swap.c:213
> > >   __pagevec_lru_add mm/swap.c:917 [inline]
> > >   lru_add_drain_cpu+0x2f7/0x520 mm/swap.c:581
> > >   lru_add_drain+0x20/0x60 mm/swap.c:652
> > >   exit_mmap+0x290/0x530 mm/mmap.c:3134
> > >   __mmput kernel/fork.c:1047 [inline]
> > >   mmput+0x15f/0x4c0 kernel/fork.c:1068
> > >   exec_mmap fs/exec.c:1046 [inline]
> > >   flush_old_exec+0x8d9/0x1c20 fs/exec.c:1279
> > >   load_elf_binary+0x9bc/0x53f0 fs/binfmt_elf.c:864
> > >   search_binary_handler fs/exec.c:1656 [inline]
> > >   search_binary_handler+0x17f/0x570 fs/exec.c:1634
> > >   exec_binprm fs/exec.c:1698 [inline]
> > >   __do_execve_file.isra.0+0x1394/0x23f0 fs/exec.c:1818
> > >   do_execveat_common fs/exec.c:1865 [inline]
> > >   do_execve fs/exec.c:1882 [inline]
> > >   __do_sys_execve fs/exec.c:1958 [inline]
> > >   __se_sys_execve fs/exec.c:1953 [inline]
> > >   __x64_sys_execve+0x8f/0xc0 fs/exec.c:1953
> > >   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > RIP: 0033:0x7fc7001ba207
> > > Code: Bad RIP value.
> > > RSP: 002b:00007ffe06aa13b8 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
> > > RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fc7001ba207
> > > RDX: 0000000001fd5fd0 RSI: 00007ffe06aa14b0 RDI: 00007ffe06aa24c0
> > > RBP: 0000000000625500 R08: 0000000000001c49 R09: 0000000000001c49
> > > R10: 0000000000000000 R11: 0000000000000206 R12: 0000000001fd5fd0
> > > R13: 0000000000000007 R14: 0000000001fc6250 R15: 0000000000000005
> > > BUG: Bad page state in process udevd  pfn:2b13c
> > > page:ffffea0000ac4f00 count:0 mapcount:0 mapping:ffff88800df2ad40 index:0xe
> > > shmem_aops
> > > flags: 0x1fffc000008000c(uptodate|dirty|swapbacked)
> > > raw: 01fffc000008000c ffff8880a85af890 ffff8880a85af890 ffff88800df2ad40
> > > raw: 000000000000000e 0000000000000000 00000000ffffffff 0000000000000000
> > > page dumped because: non-NULL mapping
> > > Modules linked in:
> > > CPU: 1 PID: 7586 Comm: udevd Tainted: G    B              
> > > 5.0.0-rc6-next-20190213 #34
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> > > Google 01/01/2011
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > >   bad_page.cold+0xda/0xff mm/page_alloc.c:586
> > > name:"memfd:"
> > >   free_pages_check_bad+0x142/0x1a0 mm/page_alloc.c:1014
> > >   free_pages_check mm/page_alloc.c:1023 [inline]
> > >   free_pages_prepare mm/page_alloc.c:1113 [inline]
> > >   free_pcp_prepare mm/page_alloc.c:1138 [inline]
> > >   free_unref_page_prepare mm/page_alloc.c:2991 [inline]
> > >   free_unref_page_list+0x31d/0xc40 mm/page_alloc.c:3060
> > >   release_pages+0x60d/0x1940 mm/swap.c:791
> > >   pagevec_lru_move_fn+0x218/0x2a0 mm/swap.c:213
> > >   __pagevec_lru_add mm/swap.c:917 [inline]
> > >   lru_add_drain_cpu+0x2f7/0x520 mm/swap.c:581
> > >   lru_add_drain+0x20/0x60 mm/swap.c:652
> > >   exit_mmap+0x290/0x530 mm/mmap.c:3134
> > >   __mmput kernel/fork.c:1047 [inline]
> > >   mmput+0x15f/0x4c0 kernel/fork.c:1068
> > >   exec_mmap fs/exec.c:1046 [inline]
> > >   flush_old_exec+0x8d9/0x1c20 fs/exec.c:1279
> > >   load_elf_binary+0x9bc/0x53f0 fs/binfmt_elf.c:864
> > >   search_binary_handler fs/exec.c:1656 [inline]
> > >   search_binary_handler+0x17f/0x570 fs/exec.c:1634
> > >   exec_binprm fs/exec.c:1698 [inline]
> > >   __do_execve_file.isra.0+0x1394/0x23f0 fs/exec.c:1818
> > >   do_execveat_common fs/exec.c:1865 [inline]
> > >   do_execve fs/exec.c:1882 [inline]
> > >   __do_sys_execve fs/exec.c:1958 [inline]
> > >   __se_sys_execve fs/exec.c:1953 [inline]
> > >   __x64_sys_execve+0x8f/0xc0 fs/exec.c:1953
> > >   do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > RIP: 0033:0x7fc7001ba207
> > > Code: Bad RIP value.
> > > RSP: 002b:00007ffe06aa13b8 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
> > > RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fc7001ba207
> > > RDX: 0000000001fd5fd0 RSI: 00007ffe06aa14b0 RDI: 00007ffe06aa24c0
> > > RBP: 0000000000625500 R08: 0000000000001c49 R09: 0000000000001c49
> > > R10: 0000000000000000 R11: 0000000000000206 R12: 0000000001fd5fd0
> > > R13: 0000000000000007 R14: 0000000001fc6250 R15: 0000000000000005
> > > 
> > > 
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > 
> > > syzbot will keep track of this bug report. See:
> > > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
> > > syzbot.
> > > syzbot can test patches for this bug, for details see:
> > > https://goo.gl/tpsmEJ#testing-patches
> > 
> 
> It's apparently the bug in the io_uring patchset I reported yesterday (well, I
> stole it from another open syzbot bug...) and Jens is already planning to fix:
> https://marc.info/?l=linux-api&m=155115288114046&w=2.  Reproducer is similar,
> and the crash bisects down to the same commit from the io_uring patchset:
> "block: implement bio helper to add iter bvec pages to bio".
> 

Fixed in next-20190227.  The fix was folded into "block: implement bio helper to
add iter bvec pages to bio".  Telling syzbot to invalidate this bug report:

#syz invalid

- Eric
