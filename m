Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964938AbeBMNfb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:35:31 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:51630 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964776AbeBMNfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:35:30 -0500
X-Google-Smtp-Source: AH8x2272ioqiNcj/U35EF9BMHT7Y4hf6fpYwA120mmJ7kziG2U2hy0FncLeeUr1xFk63FgmIH84pbA==
Message-ID: <1518528926.3715.173.camel@gmail.com>
Subject: Re: lost connection to test machine (4)
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Tejun Heo <tj@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: dennisszhou@gmail.com, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Date: Tue, 13 Feb 2018 05:35:26 -0800
In-Reply-To: <20180212200548.GG695913@devbig577.frc2.facebook.com>
References: <001a113f8734783e94056505f8fd@google.com>
         <CACT4Y+ZBHw7VZBFOeqLmrpmzgn4owW88qvP5v=xnr9966hbM_Q@mail.gmail.com>
         <00c45ca8-305d-1818-e974-a9903c8494b8@iogearbox.net>
         <20180212170325.GW695913@devbig577.frc2.facebook.com>
         <20180212200548.GG695913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-12 at 12:05 -0800, Tejun Heo wrote:
> On Mon, Feb 12, 2018 at 09:03:25AM -0800, Tejun Heo wrote:
> > Hello, Daniel.
> > 
> > On Mon, Feb 12, 2018 at 06:00:13PM +0100, Daniel Borkmann wrote:
> > > [ +Dennis, +Tejun ]
> > > 
> > > Looks like we're stuck in percpu allocator with key/value size of 4 bytes
> > > each and large number of entries (max_entries) in the reproducer in above
> > > link.
> > > 
> > > Could we have some __GFP_NORETRY semantics and let allocations fail instead
> > > of triggering OOM killer?
> > 
> > For some part, maybe, but not generally.  The virt area allocation
> > goes down to page table allocation which is hard coded to use
> > GFP_KERNEL in arch mm code.
> 
> So, the following should convert majority of allocations to use
> __GFP_NORETRY.  It doesn't catch everything but should significantly
> lower the probability of hitting this and put this on the same footing
> as vmalloc.  Can you see whether this is enough?
> 
> Note that this patch isn't upstreamable.  We definitely want to
> restrict this to the rebalance path, but it should be good enough for
> testing.
> 
> Thanks.
> 
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index 9158e5a..0b4739f 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -81,7 +81,7 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
>  static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
>  			    struct page **pages, int page_start, int page_end)
>  {
> -	const gfp_t gfp = GFP_KERNEL | __GFP_HIGHMEM;
> +	const gfp_t gfp = GFP_KERNEL | __GFP_HIGHMEM | __GFP_NORETRY;
>  	unsigned int cpu, tcpu;
>  	int i;
>  

Also I would consider using this fix as I had warnings of cpus being
stuck there for more than 50 ms :


diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 9158e5a81391ced4e268e3d5dd9879c2bc7280ce..6309b01ceb357be01e857e5f899429403836f41f 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -92,6 +92,7 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
 			*pagep = alloc_pages_node(cpu_to_node(cpu), gfp, 0);
 			if (!*pagep)
 				goto err;
+			cond_resched();
 		}
 	}
 	return 0;
