Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AIpwx4/X2dloNF4BR7JnxWb/2AkLiGfDKweRVc4V97F6Wi05kr+xhYZDdcjJO3TiEkz9IWxLxyMf
ARC-Seal: i=1; a=rsa-sha256; t=1522779429; cv=none;
        d=google.com; s=arc-20160816;
        b=ZpzLUr+jxRQ4dQbPMlImSgP1OM0vIpJv76E1AfiV/iINVs7/H2AfmJ0sNAXvEf3797
         hwHqNGPQx4V5VNZ4kx45Qg+25Ybv0dJqHl7NCLw28nvQtQ2Ct1vyD5bsEwx410poK3hL
         m06hCauDBInKf997Te5pZCm6rRwCKL7UH9kkStD991klLH4vpF9KQOtmuPJd7ugkFvxQ
         AetGtl9WJ8ZUWBrGWPWGO2in5+3LD/fuMYMW5DIiNWPrng9ERKF4Z7ZQDL9MSLwMKTlX
         OTU4H4vcgU6l9Itpp0yNrLHjj8SlPPKSdRjUiKG8q5M7upWrZuRcpvv4P6qtP/TwBgiI
         brDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=1Rteudv6ASX2ROe69v6p1uIgOJF9/EU1FgMfyEh6aGs=;
        b=0RbWy8mKYCY71KITJps7BQg+hUSPc/SOeNDHTBzySGxwiC+ag02RSonCDIjOzOn6JL
         gISrCvTDyj9pyzo9oNjtGfKXQNE7BlIiLZfxIKs6mmJOM/D1SmMwAiaow/pziE1tconO
         Y7fndh43fnTr9UMilC/wqMoFOAFRbQO6h1++7t0Q4+v/qp5j4dTVMuxh5bU0+1JIONUU
         K9otFtebhe14XjjxGiX1mT9tgoARLuiC4o0D00/MHfuefNvUz1y+chY9eyq4ahAALyOf
         znCh4O0CkSZOrTzQHL1FI78T3YIRkzBtQi/5oD2rxuWHOwiZGNFPywwTcrtQKYmn9KAb
         Ga/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Ez0db2Dz;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Ez0db2Dz;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com, alexander.levin@microsoft.com
Subject: [v6 4/6] mm/memory_hotplug: optimize probe routine
Date: Tue,  3 Apr 2018 14:16:41 -0400
Message-Id: <20180403181643.28127-5-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180403181643.28127-1-pasha.tatashin@oracle.com>
References: <20180403181643.28127-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030185
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596749962767618189?=
X-GMAIL-MSGID: =?utf-8?q?1596749962767618189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When memory is hotplugged pages_correctly_reserved() is called to verify
that the added memory is present, this routine traverses through every
struct page and verifies that PageReserved() is set. This is a slow
operation especially if a large amount of memory is added.

Instead of checking every page, it is enough to simply check that the
section is present, has mapping (struct page array is allocated), and the
mapping is online.

In addition, we should not excpect that probe routine sets flags in struct
page, as the struct pages have not yet been initialized. The initialization
should be done in __init_single_page(), the same as during boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 drivers/base/memory.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index fe4b24f05f6a..deb3f029b451 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -187,13 +187,14 @@ int memory_isolate_notify(unsigned long val, void *v)
 }
 
 /*
- * The probe routines leave the pages reserved, just as the bootmem code does.
- * Make sure they're still that way.
+ * The probe routines leave the pages uninitialized, just as the bootmem code
+ * does. Make sure we do not access them, but instead use only information from
+ * within sections.
  */
-static bool pages_correctly_reserved(unsigned long start_pfn)
+static bool pages_correctly_probed(unsigned long start_pfn)
 {
-	int i, j;
-	struct page *page;
+	unsigned long section_nr = pfn_to_section_nr(start_pfn);
+	unsigned long section_nr_end = section_nr + sections_per_block;
 	unsigned long pfn = start_pfn;
 
 	/*
@@ -201,21 +202,24 @@ static bool pages_correctly_reserved(unsigned long start_pfn)
 	 * SPARSEMEM_VMEMMAP. We lookup the page once per section
 	 * and assume memmap is contiguous within each section
 	 */
-	for (i = 0; i < sections_per_block; i++, pfn += PAGES_PER_SECTION) {
+	for (; section_nr < section_nr_end; section_nr++) {
 		if (WARN_ON_ONCE(!pfn_valid(pfn)))
 			return false;
-		page = pfn_to_page(pfn);
-
-		for (j = 0; j < PAGES_PER_SECTION; j++) {
-			if (PageReserved(page + j))
-				continue;
-
-			printk(KERN_WARNING "section number %ld page number %d "
-				"not reserved, was it already online?\n",
-				pfn_to_section_nr(pfn), j);
 
+		if (!present_section_nr(section_nr)) {
+			pr_warn("section %ld pfn[%lx, %lx) not present",
+				section_nr, pfn, pfn + PAGES_PER_SECTION);
+			return false;
+		} else if (!valid_section_nr(section_nr)) {
+			pr_warn("section %ld pfn[%lx, %lx) no valid memmap",
+				section_nr, pfn, pfn + PAGES_PER_SECTION);
+			return false;
+		} else if (online_section_nr(section_nr)) {
+			pr_warn("section %ld pfn[%lx, %lx) is already online",
+				section_nr, pfn, pfn + PAGES_PER_SECTION);
 			return false;
 		}
+		pfn += PAGES_PER_SECTION;
 	}
 
 	return true;
@@ -237,7 +241,7 @@ memory_block_action(unsigned long phys_index, unsigned long action, int online_t
 
 	switch (action) {
 	case MEM_ONLINE:
-		if (!pages_correctly_reserved(start_pfn))
+		if (!pages_correctly_probed(start_pfn))
 			return -EBUSY;
 
 		ret = online_pages(start_pfn, nr_pages, online_type);
-- 
2.16.3
