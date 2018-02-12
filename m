Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeBLUFy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:05:54 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:37869 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeBLUFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:05:52 -0500
X-Google-Smtp-Source: AH8x224JPQ7AHDaXP1fXwucgrsqfdDWsV5YdJPcfCXblcYOXAKwvXHu4hZ5uHzipEcQSKkufjyW4uA==
Date: Mon, 12 Feb 2018 12:05:48 -0800
From: Tejun Heo <tj@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: dennisszhou@gmail.com, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Subject: Re: lost connection to test machine (4)
Message-ID: <20180212200548.GG695913@devbig577.frc2.facebook.com>
References: <001a113f8734783e94056505f8fd@google.com>
 <CACT4Y+ZBHw7VZBFOeqLmrpmzgn4owW88qvP5v=xnr9966hbM_Q@mail.gmail.com>
 <00c45ca8-305d-1818-e974-a9903c8494b8@iogearbox.net>
 <20180212170325.GW695913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212170325.GW695913@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 09:03:25AM -0800, Tejun Heo wrote:
> Hello, Daniel.
> 
> On Mon, Feb 12, 2018 at 06:00:13PM +0100, Daniel Borkmann wrote:
> > [ +Dennis, +Tejun ]
> > 
> > Looks like we're stuck in percpu allocator with key/value size of 4 bytes
> > each and large number of entries (max_entries) in the reproducer in above
> > link.
> > 
> > Could we have some __GFP_NORETRY semantics and let allocations fail instead
> > of triggering OOM killer?
> 
> For some part, maybe, but not generally.  The virt area allocation
> goes down to page table allocation which is hard coded to use
> GFP_KERNEL in arch mm code.

So, the following should convert majority of allocations to use
__GFP_NORETRY.  It doesn't catch everything but should significantly
lower the probability of hitting this and put this on the same footing
as vmalloc.  Can you see whether this is enough?

Note that this patch isn't upstreamable.  We definitely want to
restrict this to the rebalance path, but it should be good enough for
testing.

Thanks.

diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 9158e5a..0b4739f 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -81,7 +81,7 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
 static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
 			    struct page **pages, int page_start, int page_end)
 {
-	const gfp_t gfp = GFP_KERNEL | __GFP_HIGHMEM;
+	const gfp_t gfp = GFP_KERNEL | __GFP_HIGHMEM | __GFP_NORETRY;
 	unsigned int cpu, tcpu;
 	int i;
 
