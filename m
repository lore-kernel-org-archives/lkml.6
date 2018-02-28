Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x226W8gf0NVabIfm1zHB8IrRRr08xxWlnbaO7zcElmnVHNjjupAVP8FcMGpxWbKZzbaEE5PoV
ARC-Seal: i=1; a=rsa-sha256; t=1519787071; cv=none;
        d=google.com; s=arc-20160816;
        b=P7olacfkX8LFwU5mMVYVc4Crbf9GGFJCrh0lCmlqy6DGmOUMcC2J1NJUDMnNeV36gw
         0HoUCbNA7ndu4uoPcZJMKsXRsx4Ey0rsOcgfdYYlnydd61PeVK0MWm5/c1LVxKG4jier
         0vVF1ZTDRqlRRyU1ZPqrpmntql4MmDf6xeDjFMvVhAmUp72TV4unF8Vm1S2kRH2hiiO6
         u5vu4F9si0NmIp2lSW9lQ+eDLEFzpGL7xdExyJLMjAaHCtUEIyfESBTPPBPYcYqaHVoX
         2oYj1TOCq567HjcVxKETfp1fHIT7YugwMy602iZYSdP6hMh0SE8OnCmSqski6bKv3qRP
         qZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=hQHYPIVnOZUsy0WvDQICaa/+QkofvyLnQV5hRx/K5y4=;
        b=YL+sKhQiVeda0sCpM3za12naakHCkMEkl6CPHLfmKd8LZneOG58ZKG6LF5mAZ933om
         aFjgDFmsDFvH7MGosxUKktRmIBgmdvpUgkQHG0/FqcvWx7FtP0+tLYsUxWDYXkmm2Qs+
         c4s8zgUUqwuRTKHUptCoN4uzsjsg2CQ35kiubAaSfXdtj855l6ByKLeUJJcIBKlJ0qyF
         HzwI848INUl4PW4xn9ONZhYowpuJJKFvirBtPFkpkuOvRcIoopHqsixy7g/E7wbWiP/C
         py2yWHQOAWU+8kXvTrbYvSkChf62UtctV2iOfcs/OLP9wfDc/N8Fr99TbosPchwtinQg
         JcVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Z6oz4wtz;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Z6oz4wtz;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [v5 3/6] mm: add uninitialized struct page poisoning sanity checking
Date: Tue, 27 Feb 2018 22:03:05 -0500
Message-Id: <20180228030308.1116-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228030308.1116-1-pasha.tatashin@oracle.com>
References: <20180228030308.1116-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593612248407323654?=
X-GMAIL-MSGID: =?utf-8?q?1593612248407323654?=
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
 mm/memblock.c              |  2 +-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..ad71136a6494 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -896,7 +896,9 @@ extern int page_to_nid(const struct page *page);
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
diff --git a/mm/memblock.c b/mm/memblock.c
index 5a9ca2a1751b..d85c8754e0ce 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1373,7 +1373,7 @@ void * __init memblock_virt_alloc_try_nid_raw(
 					   min_addr, max_addr, nid);
 #ifdef CONFIG_DEBUG_VM
 	if (ptr && size > 0)
-		memset(ptr, 0xff, size);
+		memset(ptr, PAGE_POISON_PATTERN, size);
 #endif
 	return ptr;
 }
-- 
2.16.2
