Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELspwPHnlLylWW32Oag1OoTi0ci3TqUKfNdxA4gFxPcY0Fw/BgpaJfmyZ4du9/v5UPCav9rQ
ARC-Seal: i=1; a=rsa-sha256; t=1520296003; cv=none;
        d=google.com; s=arc-20160816;
        b=H2GQ0xEXh/jQpU2VOFwNRdh4uFzzXa3Nl/rGyXbeQ6WAfrG+zef8TP4XK5Lv46sJuf
         IsniMeEYstHIhYvsBkVSy/cG3gAFIxESIcCQPD8/7r+5UMv0ChlC0mhlR/uBvmglX3bd
         +T2Ay6FP9J5mo+T9V1pryTCl6cPzRZpMrCbT1JVBi1p4/0Ja3r5BTdu9vg5B/2XJs0iP
         7lcswHDLns2cwq3aJa6X4IId8J88Wr7KSRMPp/fZXHUr1XhR8Z2HaWPs70oY3PoZnSPU
         MvcxaFCDCNu1WGugR6KUB+DC3OhPIy9r6nZTAq3q6FQzZWxL0HiWf4TbqqTcQxYv67D0
         a3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=fy9j7Ex7DSbPwPal+8NDWs399/YcbCBWmlLI8T1XMkQ=;
        b=TGvC43pw1/fBGAESd7xjHqth1/CJkyxXkqRIN7VfKh9Yx+njjA5tfbQ4YhofXqIbcr
         mYcSuvLgOLVVkqD45X/BzM4M0DKypyctQNbHcF3I2cB1T7cTtWkx10ph+7PEwkz5QExA
         +406ds846aBqnTc/awss/1jRLAdHiroxA/qk9YNq5ujJ2y3DIPZ0jm+vMTU5nMa2Z02m
         B/8Djxiz0Nje7Fnc/sxUheX+h+KZSUozryaD8sg/hHG29IIqTC2VRbagoDXAv6Tq2hOj
         2z8OcXETNDBHcrNdcfkv8zj5UTMr13lJ0LSw0j+yfdXMue/orFSJmYc+WIui9KxvXvNT
         nt+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=HflhbJF+;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=HflhbJF+;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 47/65] kaiser: _pgd_alloc() without __GFP_REPEAT to avoid stalls
Date: Mon,  5 Mar 2018 19:25:20 -0500
Message-Id: <20180306002538.1761-48-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145902679480031?=
X-GMAIL-MSGID: =?utf-8?q?1594145902679480031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Synthetic filesystem mempressure testing has shown softlockups, with
hour-long page allocation stalls, and pgd_alloc() trying for order:1
with __GFP_REPEAT in one of the backtraces each time.

That's _pgd_alloc() going for a Kaiser double-pgd, using the __GFP_REPEAT
common to all page table allocations, but actually having no effect on
order:0 (see should_alloc_oom() and should_continue_reclaim() in this
tree, but beware that ports to another tree might behave differently).

Order:1 stack allocation has been working satisfactorily without
__GFP_REPEAT forever, and page table allocation only asks __GFP_REPEAT
for awkward occasions in a long-running process: it's not appropriate
at fork or exec time, and seems to be doing much more harm than good:
getting those contiguous pages under very heavy mempressure can be
hard (though even without it, Kaiser does generate more mempressure).

Mask out that __GFP_REPEAT inside _pgd_alloc().  Why not take it out
of the PGALLOG_GFP altogether, as v4.7 commit a3a9a59d2067 ("x86: get
rid of superfluous __GFP_REPEAT") did?  Because I think that might
make a difference to our page table memcg charging, which I'd prefer
not to interfere with at this time.

hughd adds: __alloc_pages_slowpath() in the 4.4.89-stable tree handles
__GFP_REPEAT a little differently than in prod kernel or 3.18.72-stable,
so it may not always be exactly a no-op on order:0 pages, as said above;
but I think still appropriate to omit it from Kaiser or non-Kaiser pgd.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit d41f46f778951b0ea851ca52b88b2549c6336b47)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/mm/pgtable.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index b0848a7e9c68..20b8438f35c0 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -6,7 +6,7 @@
 #include <asm/fixmap.h>
 #include <asm/mtrr.h>
 
-#define PGALLOC_GFP GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_ZERO
+#define PGALLOC_GFP (GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_ZERO)
 
 #ifdef CONFIG_HIGHPTE
 #define PGALLOC_USER_GFP __GFP_HIGHMEM
@@ -354,7 +354,9 @@ static inline void _pgd_free(pgd_t *pgd)
 
 static inline pgd_t *_pgd_alloc(void)
 {
-	return (pgd_t *)__get_free_pages(PGALLOC_GFP, PGD_ALLOCATION_ORDER);
+	/* No __GFP_REPEAT: to avoid page allocation stalls in order-1 case */
+	return (pgd_t *)__get_free_pages(PGALLOC_GFP & ~__GFP_REPEAT,
+					 PGD_ALLOCATION_ORDER);
 }
 
 static inline void _pgd_free(pgd_t *pgd)
-- 
2.16.2
