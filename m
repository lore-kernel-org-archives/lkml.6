Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AIpwx4/wHoCK7HCC5wl65gFhWWsxumNj0UUVVQEJXx3BIR175JsxZ94fCVY7aBBRZJUGtgNoutn6
ARC-Seal: i=1; a=rsa-sha256; t=1522779429; cv=none;
        d=google.com; s=arc-20160816;
        b=A3u2LAkxOvMoiYmttXwlJk7h+VhVAsEG7KI/DPnjn++D75TRn6BjuAZFpz4FXYPGlu
         0GyaE4vRwCGR+jTm1YiRJjpu91l8RmB4fPdXoR975HdcfrHGA/OPKda2dZBHbKtGntwv
         3Yx1kDS2vlA7jmmaQ9N7FPO/ab6VaRprObddGTpW2JpGFwZ7m2E0QsZ7V2eLFuy0TlnB
         nP0+iK9w5I/FSsRasXDEjZrNjOiWkElNIZQtQ0+HQywxBK2oAW1IoYKwKuN9GzZZMpd4
         Qs8Z78xgqYeaVjv9xfVeLI6uDDlYZbnCoPgHdmZXQOSTJ/TmXuc5ZHA2QxKpfAEoFISc
         o+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=JP7qA5JcT+wqOb7RVpOFDVlx2i5XyWG+Cw4itYScSU8=;
        b=kP+qfzZmruNz+olz3S0UYgT6CDLDKYgVzkckQkFQnYK1+Ie42wUshE5Nijq6f7doDz
         ikH42oNYbfjIuKxTC8Vpi5GeS/QMwF6LPpeevlGCm6U7tsQMpCZxBo5DUk3HfQLNNMs4
         GNXWweDDuXVOPJ+5jn+LLrmWnCVA/TQP0YNaKQcDhLr1n5gN8UW7nMrYgWjLE34fbdx2
         w27sEY6XQAAE38xYZYLmuUatxMAUqdfyjdvk44pu9Yi51sTE2Y685ARRRxcFjgr4urp3
         ybm8dkItkZQ+8YE5SggvxEfEibnPAYIUs5eIFf/gFWCQL3lXLlQLQYBDs++b2025ADIr
         EhJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=BvGNom9e;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=BvGNom9e;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com, alexander.levin@microsoft.com
Subject: [v6 3/6] mm: add uninitialized struct page poisoning sanity checking
Date: Tue,  3 Apr 2018 14:16:40 -0400
Message-Id: <20180403181643.28127-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180403181643.28127-1-pasha.tatashin@oracle.com>
References: <20180403181643.28127-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030185
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596749962964298725?=
X-GMAIL-MSGID: =?utf-8?q?1596749962964298725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

During boot we poison struct page memory in order to ensure that no one is
accessing this memory until the struct pages are initialized in
__init_single_page().

This patch adds more scrutiny to this checking by making sure that flags
do not equal the poison pattern when they are accessed.  The pattern is all
ones.

Since node id is also stored in struct page, and may be accessed quite
early, we add this enforcement into page_to_nid() function as well.
Note, this is applicable only when NODE_NOT_IN_PAGE_FLAGS=n

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/mm.h         |  4 +++-
 include/linux/page-flags.h | 22 +++++++++++++++++-----
 mm/debug.c                 | 14 +++++++++++---
 mm/memblock.c              |  2 +-
 4 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ccac10682ce5..7261b4745e4c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -894,7 +894,9 @@ extern int page_to_nid(const struct page *page);
 #else
 static inline int page_to_nid(const struct page *page)
 {
-	return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
+	struct page *p = (struct page *)page;
+
+	return (PF_POISONED_CHECK(p)->flags >> NODES_PGSHIFT) & NODES_MASK;
 }
 #endif
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 50c2b8786831..e34a27727b9a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -156,9 +156,18 @@ static __always_inline int PageCompound(struct page *page)
 	return test_bit(PG_head, &page->flags) || PageTail(page);
 }
 
+#define	PAGE_POISON_PATTERN	-1l
+static inline int PagePoisoned(const struct page *page)
+{
+	return page->flags == PAGE_POISON_PATTERN;
+}
+
 /*
  * Page flags policies wrt compound pages
  *
+ * PF_POISONED_CHECK
+ *     check if this struct page poisoned/uninitialized
+ *
  * PF_ANY:
  *     the page flag is relevant for small, head and tail pages.
  *
@@ -176,17 +185,20 @@ static __always_inline int PageCompound(struct page *page)
  * PF_NO_COMPOUND:
  *     the page flag is not relevant for compound pages.
  */
-#define PF_ANY(page, enforce)	page
-#define PF_HEAD(page, enforce)	compound_head(page)
+#define PF_POISONED_CHECK(page) ({					\
+		VM_BUG_ON_PGFLAGS(PagePoisoned(page), page);		\
+		page; })
+#define PF_ANY(page, enforce)	PF_POISONED_CHECK(page)
+#define PF_HEAD(page, enforce)	PF_POISONED_CHECK(compound_head(page))
 #define PF_ONLY_HEAD(page, enforce) ({					\
 		VM_BUG_ON_PGFLAGS(PageTail(page), page);		\
-		page;})
+		PF_POISONED_CHECK(page); })
 #define PF_NO_TAIL(page, enforce) ({					\
 		VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);	\
-		compound_head(page);})
+		PF_POISONED_CHECK(compound_head(page)); })
 #define PF_NO_COMPOUND(page, enforce) ({				\
 		VM_BUG_ON_PGFLAGS(enforce && PageCompound(page), page);	\
-		page;})
+		PF_POISONED_CHECK(page); })
 
 /*
  * Macros to create function definitions for page flags
diff --git a/mm/debug.c b/mm/debug.c
index 56e2d9125ea5..25d5f5560e63 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -43,12 +43,20 @@ const struct trace_print_flags vmaflag_names[] = {
 
 void __dump_page(struct page *page, const char *reason)
 {
+	bool page_poisoned = PagePoisoned(page);
+	int mapcount;
+
+	if (page_poisoned) {
+		pr_emerg("page:%px is uninitialized and poisoned", page);
+		goto hex_only;
+	}
+
 	/*
 	 * Avoid VM_BUG_ON() in page_mapcount().
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
 	 * encode own info.
 	 */
-	int mapcount = PageSlab(page) ? 0 : page_mapcount(page);
+	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
 
 	pr_emerg("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
 		  page, page_ref_count(page), mapcount,
@@ -59,7 +67,7 @@ void __dump_page(struct page *page, const char *reason)
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
 
 	pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
-
+hex_only:
 	print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
@@ -68,7 +76,7 @@ void __dump_page(struct page *page, const char *reason)
 		pr_alert("page dumped because: %s\n", reason);
 
 #ifdef CONFIG_MEMCG
-	if (page->mem_cgroup)
+	if (!page_poisoned && page->mem_cgroup)
 		pr_alert("page->mem_cgroup:%px\n", page->mem_cgroup);
 #endif
 }
diff --git a/mm/memblock.c b/mm/memblock.c
index 48376bd33274..c720881b739c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1345,7 +1345,7 @@ void * __init memblock_virt_alloc_try_nid_raw(
 					   min_addr, max_addr, nid);
 #ifdef CONFIG_DEBUG_VM
 	if (ptr && size > 0)
-		memset(ptr, 0xff, size);
+		memset(ptr, PAGE_POISON_PATTERN, size);
 #endif
 	return ptr;
 }
-- 
2.16.3
