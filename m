Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeB0C1x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:27:53 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35916 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbeB0C1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:27:51 -0500
X-Google-Smtp-Source: AG47ELtfMpa3SMHXzD/zusxYaVxboawihZk0IUED2dyH9O25Vs2hHM+nChnIg37IdmvWXXMt1Fi+Gw==
Date: Tue, 27 Feb 2018 03:27:41 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] riscv/barrier: Define __smp_{mb,rmb,wmb}
Message-ID: <20180227022741.GA19333@andrea>
References: <20180226103552.GA9138@andrea>
 <mhng-48f70f62-ce5a-4093-914b-626c204b493e@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-48f70f62-ce5a-4093-914b-626c204b493e@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 05:28:53PM -0800, Palmer Dabbelt wrote:
> On Mon, 26 Feb 2018 02:35:52 PST (-0800), parri.andrea@gmail.com wrote:
> >On Thu, Feb 22, 2018 at 03:14:52PM -0800, Palmer Dabbelt wrote:
> >>On Tue, 20 Feb 2018 02:17:28 PST (-0800), parri.andrea@gmail.com wrote:
> >>>Introduce __smp_{mb,rmb,wmb}, and rely on the generic definitions
> >>>for smp_{mb,rmb,wmb}. A first consequence is that smp_{mb,rmb,wmb}
> >>>map to a compiler barrier on !SMP (while their definition remains
> >>>unchanged on SMP). As a further consequence, smp_load_acquire and
> >>>smp_store_release have "fence rw,rw" instead of "fence iorw,iorw".
> >>>
> >>>Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> >>>---
> >>> arch/riscv/include/asm/barrier.h | 6 +++---
> >>> 1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>>diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
> >>>index c0319cbf1eec5..5510366d169ae 100644
> >>>--- a/arch/riscv/include/asm/barrier.h
> >>>+++ b/arch/riscv/include/asm/barrier.h
> >>>@@ -34,9 +34,9 @@
> >>> #define wmb()		RISCV_FENCE(ow,ow)
> >>>
> >>> /* These barriers do not need to enforce ordering on devices, just memory. */
> >>>-#define smp_mb()	RISCV_FENCE(rw,rw)
> >>>-#define smp_rmb()	RISCV_FENCE(r,r)
> >>>-#define smp_wmb()	RISCV_FENCE(w,w)
> >>>+#define __smp_mb()	RISCV_FENCE(rw,rw)
> >>>+#define __smp_rmb()	RISCV_FENCE(r,r)
> >>>+#define __smp_wmb()	RISCV_FENCE(w,w)
> >>>
> >>> /*
> >>>  * This is a very specific barrier: it's currently only used in two places in
> >>
> >>Thanks!  I'm going to take this for the next RC.
> >
> >Thank you, Palmer.  I'm planning to post more changes to the file,
> >but I'd like to build on top of this change: could you point me to
> >the appropriate branch/repo for this?
> 
> Here's the canonical RISC-V Linux git repo
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git/
> 
> Your branch is now the HEAD of the "for-linus" branch, which means it'll be
> sent to Linus the next time I send patches.  I generate and tag "for-linus"
> on Monday mornings and then send it out on Wednesday mornings, just to make
> sure everything has time to bake.
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git/
> 
> Additionally, I mantain a "for-next" branch that contains everything that's
> been sufficiently reviewed to be made part of Linux, but that is being
> staged for a bit longer than what's in for-linus for one reason or another
> (usually it's just not RC material and is targeted for the next merge
> window).  There is also a RISC-V integration branch named "riscv-all" that
> contains all our work in progress patches.  This is likely to be unstable,
> but it's best to check there to see if anything interesting is going on
> related to what you're working on to avoid duplicating work.
> 
> These branches are all generated from my personal git tree
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/
> 
> There's a bunch of branches in here tracking each change set (yours is
> called "fix-smp_mb", to indicate it can go in during an RC) that's still in
> flight.  There's some scripts to generate some of these branches, but the
> commits I actually send upstream are merged by hand
> 
>    https://github.com/riscv/riscv-linux-infra
> 
> "for-next" and "riscv-all" are rebased regularly, so it's probably best to
> track commits back to their original WIP branch and work from there to avoid
> major headaches.

Thank you for the info.  I've just sent one more patch on top of your
'for-linus' (there appeared to be no conflict with 'riscv-all').

  Andrea
