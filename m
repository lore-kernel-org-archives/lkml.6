Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELsS2T9y6W7RKVyGk2KAYx+KhBJx62JWYJbxCsPypRkHn29DovPN8FMyLudKtMVlZWP0NB0B
ARC-Seal: i=1; a=rsa-sha256; t=1520295970; cv=none;
        d=google.com; s=arc-20160816;
        b=uqjQdhj/z6Vn4ltDrOiYixZjU4JT4FgnY7lwAtBO6kgITh6Ls27ysx2JKy8w3iuaR2
         88jbDDI/FfUPkB/6hkDXwDL4q43U1XhKdK5YbJU3oD0Leb3TBdypgq9ILzQrl+n934iv
         v2NFDlgGlr1MUXiMPd9ewxDnvfpE19261l69hvjQyV06v8nxH7OlDhMG17y2GMRCUYwY
         HvdypudTTcg8w6Dx8bYR9U01LfJQPYRlTont/eB+WL3RYC+l0S9wPIc924KeYBV3KTcT
         ZQm+ac2i032j5sAF0QmTWWHdFNfssSaZbUez0q6wA33i6dYSv5dS02c6J3L2ESjY8CXg
         BQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=ISymb/JSMqLef2glkK3eGHMRnV3nWhFiZBV5jTu+ocg=;
        b=q0tK6SAql2jcGJZ9sMA+GGqHtxKvFLssmYFsbBbVaEM51p7SGvY+sgQThQBfLnzVki
         psqpeZNbBmaJKoyTKOP2NCp5ZfGTparVu4TYxY+f5mY4EJ7QFdj68YqabO/5gTiRjXtD
         OptGIwfdbL4PSYJlsrQjM9Rc5XG1jSDXdVD6Cz94ZpD94+pKckf8JFPiDSoWs2cr/elQ
         q4Fj9wdHfCrey5YcHAIHvjbKt9poKh8tcIlZui4wHJScfW4/eDCK5bdJHxe760lY4ZVA
         pPGRUNnPX68/2Oh5B1j9BaTrNbSRJLBtBr8HWQY+S5WTzL8WFwd9sm+1zqFSYoijF+jV
         T/Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TM5eUHgp;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TM5eUHgp;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 11/65] sched/core: Idle_task_exit() shouldn't use switch_mm_irqs_off()
Date: Mon,  5 Mar 2018 19:24:44 -0500
Message-Id: <20180306002538.1761-12-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145867541737484?=
X-GMAIL-MSGID: =?utf-8?q?1594145867541737484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit 252d2a4117bc181b287eeddf848863788da733ae upstream.

idle_task_exit() can be called with IRQs on x86 on and therefore
should use switch_mm(), not switch_mm_irqs_off().

This doesn't seem to cause any problems right now, but it will
confuse my upcoming TLB flush changes.  Nonetheless, I think it
should be backported because it's trivial.  There won't be any
meaningful performance impact because idle_task_exit() is only
used when offlining a CPU.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: f98db6013c55 ("sched/core: Add switch_mm_irqs_off() and use it in the scheduler")
Link: http://lkml.kernel.org/r/ca3d1a9fa93a0b49f5a8ff729eda3640fb6abdf9.1497034141.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 18a5348d49afcfc2b95da939143c9420edd78b9e)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d253618d09c6..9c905bd94ff0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4979,7 +4979,7 @@ void idle_task_exit(void)
 	BUG_ON(cpu_online(smp_processor_id()));
 
 	if (mm != &init_mm) {
-		switch_mm_irqs_off(mm, &init_mm, current);
+		switch_mm(mm, &init_mm, current);
 		finish_arch_post_lock_switch();
 	}
 	mmdrop(mm);
-- 
2.16.2
