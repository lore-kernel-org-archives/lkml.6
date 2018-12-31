Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3085C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58B521738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeLaLyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 06:54:53 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:46570 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbeLaLyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 06:54:52 -0500
Received: from sf.home (trofi-1-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:a0f::2])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id DD92E335C07;
        Mon, 31 Dec 2018 11:54:50 +0000 (UTC)
Received: by sf.home (Postfix, from userid 1000)
        id F2BF022F2B8EC; Mon, 31 Dec 2018 11:54:45 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        stable@vger.kernel.org
Subject: [PATCH v2] alpha: fix page fault handling for r16-r18 targets
Date:   Mon, 31 Dec 2018 11:53:55 +0000
Message-Id: <20181231115355.32051-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181231014515.GA13296@altlinux.org>
References: <20181231014515.GA13296@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix page fault handling code to fixup r16-r18 registers.
Before the patch code had off-by-two registers bug.
This bug caused overwriting of ps,pc,gp registers instead
of fixing intended r16,r17,r18 (see `struct pt_regs`).

More details:

Initially Dmitry noticed a kernel bug as a failure
on strace test suite. Test passes unmapped userspace
pointer to io_submit:

```c
    #include <err.h>
    #include <unistd.h>
    #include <sys/mman.h>
    #include <asm/unistd.h>
    int main(void)
    {
        unsigned long ctx = 0;
        if (syscall(__NR_io_setup, 1, &ctx))
            err(1, "io_setup");
        const size_t page_size = sysconf(_SC_PAGESIZE);
        const size_t size = page_size * 2;
        void *ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if (MAP_FAILED == ptr)
            err(1, "mmap(%zu)", size);
        if (munmap(ptr, size))
            err(1, "munmap");
        syscall(__NR_io_submit, ctx, 1, ptr + page_size);
        syscall(__NR_io_destroy, ctx);
        return 0;
    }
```

Running this test causes kernel to crash when handling page fault:

```
    Unable to handle kernel paging request at virtual address ffffffffffff9468
    CPU 3
    aio(26027): Oops 0
    pc = [<fffffc00004eddf8>]  ra = [<fffffc00004edd5c>]  ps = 0000    Not tainted
    pc is at sys_io_submit+0x108/0x200
    ra is at sys_io_submit+0x6c/0x200
    v0 = fffffc00c58e6300  t0 = fffffffffffffff2  t1 = 000002000025e000
    t2 = fffffc01f159fef8  t3 = fffffc0001009640  t4 = fffffc0000e0f6e0
    t5 = 0000020001002e9e  t6 = 4c41564e49452031  t7 = fffffc01f159c000
    s0 = 0000000000000002  s1 = 000002000025e000  s2 = 0000000000000000
    s3 = 0000000000000000  s4 = 0000000000000000  s5 = fffffffffffffff2
    s6 = fffffc00c58e6300
    a0 = fffffc00c58e6300  a1 = 0000000000000000  a2 = 000002000025e000
    a3 = 00000200001ac260  a4 = 00000200001ac1e8  a5 = 0000000000000001
    t8 = 0000000000000008  t9 = 000000011f8bce30  t10= 00000200001ac440
    t11= 0000000000000000  pv = fffffc00006fd320  at = 0000000000000000
    gp = 0000000000000000  sp = 00000000265fd174
    Disabling lock debugging due to kernel taint
    Trace:
    [<fffffc0000311404>] entSys+0xa4/0xc0
```

Here `gp` has invalid value. `gp is s overwritten by a fixup for the
following page fault handler in `io_submit` syscall handler:

```
    __se_sys_io_submit
    ...
        ldq     a1,0(t1)
        bne     t0,4280 <__se_sys_io_submit+0x180>
```

After a page fault `t0` should contain -EFALUT and `a1` is 0.
Instead `gp` was overwritten in place of `a1`.

This happens due to a off-by-two bug in `dpf_reg()` for `r16-r18`
(aka `a0-a2`).

I think the bug went unnoticed for a long time as `gp` is one
of scratch registers. Any kernel function call would re-calculate `gp`.

Dmitry tracked down the bug origin back to 2.1.32 kernel version
where trap_a{0,1,2} fields were inserted into struct pt_regs.
And even before that `dpf_reg()` contained off-by-one error.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reported-and-reviewed-by: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: stable@vger.kernel.org # v2.1.32+
Bug: https://bugs.gentoo.org/672040
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
Changes since V1:
- expanded bug origin tracked down by Dmitry
- added proper Dmitry's email and reviwed by tags

 arch/alpha/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index d73dc473fbb9..188fc9256baf 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -78,7 +78,7 @@ __load_new_mm_context(struct mm_struct *next_mm)
 /* Macro for exception fixup code to access integer registers.  */
 #define dpf_reg(r)							\
 	(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-16 :	\
-				 (r) <= 18 ? (r)+8 : (r)-10])
+				 (r) <= 18 ? (r)+10 : (r)-10])
 
 asmlinkage void
 do_page_fault(unsigned long address, unsigned long mmcsr,
-- 
2.20.1

