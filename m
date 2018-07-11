Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026F4C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23E32146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23E32146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbeGKVLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:11:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeGKVLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:11:01 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C132D9F;
        Wed, 11 Jul 2018 21:04:50 +0000 (UTC)
Date:   Wed, 11 Jul 2018 14:04:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+120abb1c3f7bfdc523f7@syzkaller.appspotmail.com>
Cc:     jglisse@redhat.com, kirill.shutemov@linux.intel.com,
        ldufour@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org,
        ross.zwisler@linux.intel.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, ying.huang@intel.com
Subject: Re: general protection fault in _vm_normal_page
Message-Id: <20180711140449.3702358d7e8898017e34dcfd@linux-foundation.org>
In-Reply-To: <00000000000010c9390570bc0643@google.com>
References: <00000000000010c9390570bc0643@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 09:49:01 -0700 syzbot <syzbot+120abb1c3f7bfdc523f7@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    98be45067040 Add linux-next specific files for 20180711
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12496ac2400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f3b3673fec35d01
> dashboard link: https://syzkaller.appspot.com/bug?extid=120abb1c3f7bfdc523f7
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=12a46568400000

Handy.  /dev/ion from drivers/staging/android/ion/ion.c

> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+120abb1c3f7bfdc523f7@syzkaller.appspotmail.com
> 
> R10: 0000000004000812 R11: 0000000000000246 R12: 0000000000000005
> R13: 00000000004c0565 R14: 00000000004cffb0 R15: 0000000000000005
> ion_mmap: failure mapping buffer to userspace
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 4785 Comm: syz-executor0 Not tainted 4.18.0-rc4-next-20180711+  
> #4
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> RIP: 0010:_vm_normal_page+0x1e5/0x330 mm/memory.c:828

Presumably has a NULL vma->vm_ops.  Probably one of the now-removed
checks in mm-drop-unneeded-vm_ops-checks.patch would have avoided
this.

Something for Kirill to think about ;)
