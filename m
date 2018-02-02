Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeBBO6G (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:58:06 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:33899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeBBO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:57:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bpetkov@suse.de>, Andy Lutomirski <luto@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/3] x86: dumpstack: avoid uninitlized variable
Date: Fri,  2 Feb 2018 15:56:17 +0100
Message-Id: <20180202145634.200291-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202145434.100626-1-arnd@arndb.de>
References: <20180202145434.100626-1-arnd@arndb.de>
X-Provags-ID: V03:K0:OBwUf4QSOATtDVAGSb/zLNEa0IAeFLQ6QyLjeOZWxEQEmnUTJIX
 N5sxta6kI6QU1jjgMBvoyb+IvCpmRcwlsFBmY0QKZB2WQIiqg9Ia1WFohBTSIwZiOFq0T5r
 xqyeI0NVPBxRxu4hLR7VoX5UPB1Ju5UEO/71ke/Enbif8jc27uv9r/AIG2FRpgKLoloCh98
 vMLjqRDotZ0nBwO8/8AFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7KtvD9bgc0Q=:7g0m8CZGeOjztxVRnaTyuw
 +mPk/Yj9f6fAFQW75bqySsUQfSi5mjKPiuoUo+ORW0czozxVRYpoiX9VwRZVpq8sliesngvvl
 TiAgUiTTyV8G9VcJgu0h0u72+lz/sBuAVl2tmP5d2m0ltGYnVHMz6ANPNLHD+xllfobBCXci7
 9wA8ghjJzfGHHQ9IvZJkDupZLukXzQ9XpqPDtcMHmGgSEmhDKdfxIaaf5WWOQmbKqdItQihAd
 Gxtl1p1lKKFEaHQ4S+4vRr+L/8LU47DuRPnUVBvy7x2QUYGBdcmp01H9dzu1z7PxE6tWqufoW
 eRft7Vk6KtcjIZu64esWh1YZwWDoT3pMDLe2A9oL64yhdhMOPsFsONEbTL1+5mnwUpLsOnchQ
 g6CcMz08yLccvY+IPigNCc/D8XvHetpcizjL/CnFgq8orW6nM2Li8FVC6BpbVxVbtofz8HTX3
 /J0k6fgLLy2vWnqbdz3qdIyNzm0xMCX3CEyeNP3v1SVZiDL4tnFU83ahcM9E/RdSiAnaNiWqN
 qWBdVuhXVFGlUjynkyuv0qqdFKydYRQy+Vk0LHNhkOKQqRWCOMH/gfqfeY11ekKb9nwh/vZNn
 kHWMhjY8XpGVuPG8m5sChVJQdsVsCcpRiPbV2DiRNU+1FWwIFgVYVXZeDlrhLyEQBkuPigWkO
 f0s4TBz5xRPXZ/9lXJTgaMMGIVV5SGtp29/NKy1DQu/7lNH7KRl0hxZoAyfYPdomO1uYI0qIu
 dqg3+xQ25HMcoBRdbTZ3exJR88BLJYXiHMCThQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configurations, 'partial' does not get initialized,
as shown by this gcc-8 warning:

arch/x86/kernel/dumpstack.c: In function 'show_trace_log_lvl':
arch/x86/kernel/dumpstack.c:156:4: error: 'partial' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    show_regs_if_on_stack(&stack_info, regs, partial);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This initializes it to false, to get the previous behavior in
this case.

a9cdbe72c4e8 ("x86/dumpstack: Fix partial register dumps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/dumpstack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index afbecff161d1..a2d8a3908670 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -109,7 +109,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	struct stack_info stack_info = {0};
 	unsigned long visit_mask = 0;
 	int graph_idx = 0;
-	bool partial;
+	bool partial = false;
 
 	printk("%sCall Trace:\n", log_lvl);
 
-- 
2.9.0
