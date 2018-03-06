Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELs13Q+pyFeKauEFIvhcjudwKBQRZC3CdcQXHl+ceLgZOQprLU9104EfmWNnu5JvSVknGLBr
ARC-Seal: i=1; a=rsa-sha256; t=1520295968; cv=none;
        d=google.com; s=arc-20160816;
        b=yUWXsvuftbcDtXBgKY2Unaqnt8jAbvsME5ptfp8XRsNvn6p6eU6BsVLbcWISgZbmBo
         EkNvgeZE/QES308VxKHcHhe8/h3EqlPZWAyrIpRMF1ghBPMy/R1CyZIk5RqtQu1UcmIc
         LA1F0q9HX8oo27CbyI9z2Kq/kWd3bgU7NxgzALvnum2beLnagfFw1104vckQPBP96liv
         65Qc0JldWbP80Wr3JYgmpevj3LTqG44+uGHuCvAZMI2SU8KgQiXAEnMPNqWrvkCUTy7J
         NDrLm+qUNSG7fg8bqi0r1CCZApYT+6ZQieauus3vpLEw5LqsiOXACOxsik+a+Nb1zoaL
         AGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=HZrVxKT7IeiAd6dhR07u8+LeXK7g1Fntd5W+o6y2r4o=;
        b=i2r6HNcz7W+rP3tUdyrRhy2vActSR1FL2CZxC2i6sVDH5qpjoh9H3iFY0+b44g4gd4
         Q5ZY1V8AAbT1AFXseikXBZkifyf2siPZI5e32+8WVmXEU2t5cMWc1/IpjQTAl7CylhP6
         bFBHRNa6j8ONO97EmS7bwp06VI/OfZoXy5MZ6YgNkHuEs6T93J3eUOwTtQE/Q16bN+qn
         3v5Df3LcfTEsanTxf1fDghdsV47SZqA9sCq4pPvGE8RAk4EybBGMTEz9arfMhDVpANTe
         MtSTQsN2Aa/MDLBisdj339E/jNjBpbXxw4bSP1TgZJAXSe3JIbpDfuVVEWGa2JVvpP43
         BqrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=P4q5r+Zq;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=P4q5r+Zq;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 10/65] ARM: Hide finish_arch_post_lock_switch() from modules
Date: Mon,  5 Mar 2018 19:24:43 -0500
Message-Id: <20180306002538.1761-11-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145864686554015?=
X-GMAIL-MSGID: =?utf-8?q?1594145864686554015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Steven Rostedt <rostedt@goodmis.org>

commit ef0491ea17f8019821c7e9c8e801184ecf17f85a upstream.

The introduction of switch_mm_irqs_off() brought back an old bug
regarding the use of preempt_enable_no_resched:

As part of:

  62b94a08da1b ("sched/preempt: Take away preempt_enable_no_resched() from modules")

the definition of preempt_enable_no_resched() is only available in
built-in code, not in loadable modules, so we can't generally use
it from header files.

However, the ARM version of finish_arch_post_lock_switch()
calls preempt_enable_no_resched() and is defined as a static
inline function in asm/mmu_context.h. This in turn means we cannot
include asm/mmu_context.h from modules.

With today's tip tree, asm/mmu_context.h gets included from
linux/mmu_context.h, which is normally the exact pattern one would
expect, but unfortunately, linux/mmu_context.h can be included from
the vhost driver that is a loadable module, now causing this compile
time error with modular configs:

  In file included from ../include/linux/mmu_context.h:4:0,
                   from ../drivers/vhost/vhost.c:18:
  ../arch/arm/include/asm/mmu_context.h: In function 'finish_arch_post_lock_switch':
  ../arch/arm/include/asm/mmu_context.h:88:3: error: implicit declaration of function 'preempt_enable_no_resched' [-Werror=implicit-function-declaration]
     preempt_enable_no_resched();

Andy already tried to fix the bug by including linux/preempt.h
from asm/mmu_context.h, but that didn't help. Arnd suggested reordering
the header files, which wasn't popular, so let's use this
workaround instead:

The finish_arch_post_lock_switch() definition is now also hidden
inside of #ifdef MODULE, so we don't see anything referencing
preempt_enable_no_resched() from a header file. I've built a
few hundred randconfig kernels with this, and did not see any
new problems.

Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: f98db6013c55 ("sched/core: Add switch_mm_irqs_off() and use it in the scheduler")
Link: http://lkml.kernel.org/r/1463146234-161304-1-git-send-email-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit c22d4b4d1c7fcc0d9eb4d8618d86c554c48ed9c0)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/include/asm/mmu_context.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 9b32f76bb0dd..10f662498eb7 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -61,6 +61,7 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 		cpu_switch_mm(mm->pgd, mm);
 }
 
+#ifndef MODULE
 #define finish_arch_post_lock_switch \
 	finish_arch_post_lock_switch
 static inline void finish_arch_post_lock_switch(void)
@@ -82,6 +83,7 @@ static inline void finish_arch_post_lock_switch(void)
 		preempt_enable_no_resched();
 	}
 }
+#endif /* !MODULE */
 
 #endif	/* CONFIG_MMU */
 
-- 
2.16.2
