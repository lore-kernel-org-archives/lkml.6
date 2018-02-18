Return-Path: <robert.m.harris@oracle.com>
X-Google-Smtp-Source: AH8x224IAQVWZ+l5FH/nRYm0zthtqFRCeiOBWWTMI4M2327dIBSyDGI1ptl3G1k4uUreXGP2RUzN
ARC-Seal: i=1; a=rsa-sha256; t=1518972360; cv=none;
        d=google.com; s=arc-20160816;
        b=pVombmVfcCjznpCjv9+4YCQeRCddZUG8Zgyj63T925zIWouJ04O5+P9tWUn1FrrP/w
         rFQw3QR2Oshk8ztsauSFaIqQ6kRUbvcb7uymIjV18pVKHVK7pN1Z5BvKU7CCiBzdsq2r
         mTp/zlQi2lhaqkdlIXZ6mAvTXk8sbF/RncZS4PpmZev7KxdYPqxYg81DatXPMJtNpuOZ
         Oc1iR75uvO4iNsMTKc4isxmCYPebkAcnSZqi3LnMdSkrekhLWD2RujaPB3o6Wjbjtqce
         /Ub6EhxOmzQNNnrXdMUG1V8Dg8ja3I0yE1n3UJVUbhwlL1G8kLp8I7ykgoSo9n2ndllg
         Ck2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=2ubzK0IiMhcSLkPCQ4U1JFmq0KSjA4m0JnrLGx9t9cA=;
        b=xqnXZ6WbFptAOvstpgzEZRtkQPXHdu2vxbI4Dex0t2A+of/zH7aLqU9n+nfoz+4/fR
         fuUqiJlnTmqtrbh9bfcNcWerHNSF4VQXoRKrfVlaVNNPhLso/Pn8WU/UKAHgf4DIdEco
         EHhwKGpPkiFh7kxn7fU8miB/NRD6wGxfUFTmkmGlfmWQt7IyWJiG1vPR99H7CrGLTGCL
         maTYC4sO33sXGww5p05IDzITNLs7uWyD5uOh0ADj+zyPN86dYqCp+rIXrh0lMmrBPH93
         fX5TnQlYHqAQOKn8hDDpLSQ8EW/LaOeKpntNIZp9ccRghtZsHgTuhQIYFCM30o/UbWKc
         MiJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QRPhyt/t;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QRPhyt/t;
       spf=pass (google.com: domain of robert.m.harris@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=robert.m.harris@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: robert.m.harris@oracle.com
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kangmin Park <l4stpr0gr4m@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Robert M. Harris" <robert.m.harris@oracle.com>
Subject: [PATCH 1/1] mm, compaction: correct the bounds of __fragmentation_index()
Date: Sun, 18 Feb 2018 16:47:55 +0000
Message-Id: <1518972475-11340-2-git-send-email-robert.m.harris@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
References: <1518972475-11340-1-git-send-email-robert.m.harris@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8808 signatures=668674
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802180225
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592757962533260207?=
X-GMAIL-MSGID: =?utf-8?q?1592757962533260207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Robert M. Harris" <robert.m.harris@oracle.com>

__fragmentation_index() calculates a value used to determine whether
compaction should be favoured over page reclaim in the event of allocation
failure.  The calculation itself is opaque and, on inspection, does not
match its existing description.  The function purports to return a value
between 0 and 1000, representing units of 1/1000.  Barring the case of a
pathological shortfall of memory, the lower bound is instead 500.  This is
significant because it is the default value of sysctl_extfrag_threshold,
i.e. the value below which compaction should be avoided in favour of page
reclaim for costly pages.

This patch implements and documents a modified version of the original
expression that returns a value in the range 0 <= index < 1000.  It amends
the default value of sysctl_extfrag_threshold to preserve the existing
behaviour.

Signed-off-by: Robert M. Harris <robert.m.harris@oracle.com>
---
 Documentation/sysctl/vm.txt |  2 +-
 mm/compaction.c             |  2 +-
 mm/vmstat.c                 | 47 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
index 5025ff9..384a78b 100644
--- a/Documentation/sysctl/vm.txt
+++ b/Documentation/sysctl/vm.txt
@@ -237,7 +237,7 @@ of memory, values towards 1000 imply failures are due to fragmentation and -1
 implies that the allocation will succeed as long as watermarks are met.
 
 The kernel will not compact memory in a zone if the
-fragmentation index is <= extfrag_threshold. The default value is 500.
+fragmentation index is <= extfrag_threshold. The default value is 0.
 
 ==============================================================
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 10cd757..9db6ef4 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1730,7 +1730,7 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
 	return ret;
 }
 
-int sysctl_extfrag_threshold = 500;
+int sysctl_extfrag_threshold;
 
 /**
  * try_to_compact_pages - Direct compact to satisfy a high-order allocation
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 40b2db6..013f1af 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1044,15 +1044,22 @@ static void fill_contig_page_info(struct zone *zone,
 }
 
 /*
- * A fragmentation index only makes sense if an allocation of a requested
- * size would fail. If that is true, the fragmentation index indicates
- * whether external fragmentation or a lack of memory was the problem.
- * The value can be used to determine if page reclaim or compaction
- * should be used
+ * If there is no block of at least the requested size, implying that an
+ * allocation would fail, then it might be possible to conjure one by
+ * compaction.  As this is expensive it is reserved for those cases in which
+ * there is a relatively high degree of fragmentation.  For low degrees, page
+ * reclaim is more appropriate since an allocation failure is more likely to be
+ * caused by a lack of memory.
+ *
+ * This function calculates an index in the range 0 to 1, expressed in units of
+ * 1/1000, indicating low and high fragmentation respectively.  The special
+ * value of -1 indicates that free blocks of sufficient size are available and
+ * that an allocation should therefore succeed.
  */
 static int __fragmentation_index(unsigned int order, struct contig_page_info *info)
 {
 	unsigned long requested = 1UL << order;
+	int result;
 
 	if (WARN_ON_ONCE(order >= MAX_ORDER))
 		return 0;
@@ -1060,17 +1067,37 @@ static int __fragmentation_index(unsigned int order, struct contig_page_info *in
 	if (!info->free_blocks_total)
 		return 0;
 
-	/* Fragmentation index only makes sense when a request would fail */
 	if (info->free_blocks_suitable)
 		return -1000;
 
 	/*
-	 * Index is between 0 and 1 so return within 3 decimal places
+	 * If the number of requested-size blocks that could be constructed if
+	 * all free blocks were compacted is
+	 *
+	 *	B = info->free_pages/requested
+	 *
+	 * then, conceptually, the number of fragments into which each
+	 * requested-size block has been split is
+	 *
+	 *	N = info->free_blocks_total/B
 	 *
-	 * 0 => allocation would fail due to lack of memory
-	 * 1 => allocation would fail due to fragmentation
+	 * In the least and most fragmented cases all free memory resides on
+	 * either the order - 1 free list or the base page free list
+	 * respecively, thus the range of this function is given by
+	 * 2 <= N <= requested.  The fragmentation index,
+	 *
+	 *	F = 1 - 2/N,
+	 *
+	 * has the more useful range of 0 < F <= 1.  In order to inhibit
+	 * compaction in the event of a pathological shortfall of memory this
+	 * function truncates and returns
+	 *
+	 *	F - 1/info->free_blocks_total
 	 */
-	return 1000 - div_u64( (1000+(div_u64(info->free_pages * 1000ULL, requested))), info->free_blocks_total);
+	result = 1000 - div_u64((1000 + (div_u64(info->free_pages * 2000ULL,
+			requested))), info->free_blocks_total);
+
+	return (result < 0) ? 0 : result;
 }
 
 /* Same as __fragmentation index but allocs contig_page_info on stack */
-- 
1.8.3.1
