Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427238AbeBORUw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:20:52 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42366 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422692AbeBORUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 12:20:48 -0500
X-Google-Smtp-Source: AH8x227Nb7kD5dBLIQKuwoxB45s1XDjZzfO+Jn8Wrqdy1ZILa6sM3VGm3lklSt+H/PZVQ/r4I1W0LTuyNQG7aWFWV0g=
MIME-Version: 1.0
In-Reply-To: <20180215170432.e4wue4osyv3vmdla@lakrids.cambridge.arm.com>
References: <20180215170432.e4wue4osyv3vmdla@lakrids.cambridge.arm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Feb 2018 09:20:45 -0800
Message-ID: <CANn89iK-7v=sR3oD3uwkC6qac=GrSDUfMGmvKo=DS6tQ6C1ZJQ@mail.gmail.com>
Subject: Re: v4.16-rc1 misaligned atomics in skb__clone / __napi_alloc_skb
To: Mark Rutland <mark.rutland@arm.com>
Cc: netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 9:04 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> While fuzzing arm64 v4.16-rc1 with Syzkaller, I've been hitting a
> misaligned atomic in __skb_clone:
>
>         atomic_inc(&(skb_shinfo(skb)->dataref));
>
> .. where dataref doesn't have the required natural alignment, and the
> atomic operation faults. e.g. i often see it aligned to a single byte
> boundary rather than a four byte boundary.
>
> AFAICT, the skb_shared_info is misaligned at the instant it's allocated
> in __napi_alloc_skb(). With the patch at the end of this mail, the
> atomic_set() (which is a WRITE_ONCE()) in __build_skb() blows up, e.g.
>
> WARNING: CPU: 0 PID: 8457 at mm/access_once.c:12 access_once_alignment_check+0x34/0x40 mm/access_once.c:12
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 0 PID: 8457 Comm: syz-executor1 Not tainted 4.16.0-rc1-00002-gb03ae7b8b0de #9
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace+0x0/0x390 arch/arm64/kernel/time.c:52
>  show_stack+0x20/0x30 arch/arm64/kernel/traps.c:151
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0xd0/0x130 lib/dump_stack.c:53
>  panic+0x220/0x3fc kernel/panic.c:183
>  __warn+0x270/0x2bc kernel/panic.c:547
>  report_bug+0x1dc/0x2d0 lib/bug.c:184
>  bug_handler+0x7c/0x128 arch/arm64/kernel/traps.c:758
>  call_break_hook arch/arm64/kernel/debug-monitors.c:305 [inline]
>  brk_handler+0x1a0/0x300 arch/arm64/kernel/debug-monitors.c:320
>  do_debug_exception+0x15c/0x408 arch/arm64/mm/fault.c:808
>  el1_dbg+0x18/0x78
>  access_once_alignment_check+0x34/0x40 mm/access_once.c:12
>  __napi_alloc_skb+0x18c/0x2b8 net/core/skbuff.c:482
>  napi_alloc_skb include/linux/skbuff.h:2643 [inline]
>  napi_get_frags+0x68/0x120 net/core/dev.c:5108
>  tun_napi_alloc_frags drivers/net/tun.c:1477 [inline]
>  tun_get_user+0x13b0/0x3fe8 drivers/net/tun.c:1820
>  tun_chr_write_iter+0xa8/0x158 drivers/net/tun.c:1988
>  call_write_iter include/linux/fs.h:1781 [inline]
>  do_iter_readv_writev+0x2f8/0x490 fs/read_write.c:653
>  do_iter_write+0x14c/0x4b0 fs/read_write.c:932
>  vfs_writev+0x130/0x288 fs/read_write.c:977
>  do_writev+0xe0/0x248 fs/read_write.c:1012
>  SYSC_writev fs/read_write.c:1085 [inline]
>  SyS_writev+0x34/0x48 fs/read_write.c:1082
>  el0_svc_naked+0x30/0x34
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x1002082
> Memory Limit: none
> Rebooting in 86400 seconds..
>
> ... I see these splats with both tun and virtio-net.
>
> I have some Syzkaller logs, and can reproduce the problem locally, but
> unfortunately the C reproducer it generated doesn't seem to work on its
> own.
>
> Any ideas as to how this could happen?
>

Yes, it seems tun.c breaks the assumptions.

If it really wants to provide arbitrary fragments and alignments, it
should use a separate

Please try :

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 81e6cc951e7fc7c983919365c34842c34bcaedcf..92c6b6d02f7c18b63c42ffe1d9cb7286975e1263
100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1500,7 +1500,7 @@ static struct sk_buff
*tun_napi_alloc_frags(struct tun_file *tfile,
                }

                local_bh_disable();
-               data = napi_alloc_frag(fragsz);
+               data = napi_alloc_frag(SKB_DATA_ALIGN(fragsz));
                local_bh_enable();
                if (!data) {
                        err = -ENOMEM;



> Thanks,
> Mark.
>
> ---->8----
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index c2cc57a2f508..c06b810a3b3b 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -163,6 +163,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>
>  #include <uapi/linux/types.h>
>
> +void access_once_alignment_check(const volatile void *ptr, int size);
> +
>  #define __READ_ONCE_SIZE                                               \
>  ({                                                                     \
>         switch (size) {                                                 \
> @@ -180,6 +182,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  static __always_inline
>  void __read_once_size(const volatile void *p, void *res, int size)
>  {
> +       access_once_alignment_check(p, size);
>         __READ_ONCE_SIZE;
>  }
>
> @@ -203,6 +206,8 @@ void __read_once_size_nocheck(const volatile void *p, void *res, int size)
>
>  static __always_inline void __write_once_size(volatile void *p, void *res, int size)
>  {
> +       access_once_alignment_check(p, size);
> +
>         switch (size) {
>         case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
>         case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
> diff --git a/mm/Makefile b/mm/Makefile
> index e669f02c5a54..604d269d7d57 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the linux memory manager.
>  #
>
> +KASAN_SANITIZE_access_once.o := n
>  KASAN_SANITIZE_slab_common.o := n
>  KASAN_SANITIZE_slab.o := n
>  KASAN_SANITIZE_slub.o := n
> @@ -10,6 +11,7 @@ KASAN_SANITIZE_slub.o := n
>  # These files are disabled because they produce non-interesting and/or
>  # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
>  # free pages, or a task is migrated between nodes.
> +KCOV_INSTRUMENT_access_once.o := n
>  KCOV_INSTRUMENT_slab_common.o := n
>  KCOV_INSTRUMENT_slob.o := n
>  KCOV_INSTRUMENT_slab.o := n
> @@ -39,7 +41,7 @@ obj-y                 := filemap.o mempool.o oom_kill.o \
>                            mm_init.o mmu_context.o percpu.o slab_common.o \
>                            compaction.o vmacache.o swap_slots.o \
>                            interval_tree.o list_lru.o workingset.o \
> -                          debug.o $(mmu-y)
> +                          debug.o access_once.o $(mmu-y)
>
>  obj-y += init-mm.o
>
> diff --git a/mm/access_once.c b/mm/access_once.c
> new file mode 100644
> index 000000000000..42ee35d171c4
> --- /dev/null
> +++ b/mm/access_once.c
> @@ -0,0 +1,15 @@
> +#include <linux/bug.h>
> +#include <linux/export.h>
> +#include <linux/kernel.h>
> +
> +void access_once_alignment_check(const volatile void *ptr, int size)
> +{
> +       switch (size) {
> +       case 1:
> +       case 2:
> +       case 4:
> +       case 8:
> +               WARN_ON(!IS_ALIGNED((unsigned long)ptr, size));
> +       }
> +}
> +EXPORT_SYMBOL(access_once_alignment_check);
