Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71702086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u02JgrKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71702086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeIKF4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:56:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeIKF4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:56:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B0xj2Y077213;
        Tue, 11 Sep 2018 01:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Unlfp95VRYdh0zaKiyB62CoToWdwSBQEhoPttxdHTH0=;
 b=u02JgrKpOKciZh4jINL64Aaced2qCB6CUVl7FrYZy0RUveF/au1rTGvHhRN2hYrSsqOX
 mXpPg69Smv9wvL83jQoBnTjZJj4hZz253cFDZPKyfZCOtuCRENLSBnkuT+xeN5YHz2vQ
 B/N0a4cFKrl2nldUy5awBHcgytQ4KygmvGdPSD0Jz06RAKEYki474Cy771pcDccz4iWH
 MSB6ULzQLLW9EDbpw+ifT2JW/lD/3JeMGOYUME4df8C9o2RMIWfmihKrs9kdMArxIAh6
 tcuiuuEPeSJOoNNvDbDwBSGKg8C8sQmtXFESclhP+bjKeedhWMGcts5RHE+aW6I8mV3p cA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mc5ut94ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 01:00:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8B101Na005446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 01:00:01 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8B0xxqM020122;
        Tue, 11 Sep 2018 01:00:00 GMT
Received: from localhost.localdomain (/73.143.71.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 17:59:59 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        dave.dice@oracle.com, dave.hansen@linux.intel.com,
        hannes@cmpxchg.org, levyossi@icloud.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mhocko@kernel.org, Pavel.Tatashin@microsoft.com,
        steven.sistare@oracle.com, tim.c.chen@intel.com,
        vdavydov.dev@gmail.com, ying.huang@intel.com
Subject: [RFC PATCH v2 6/8] mm: splice local lists onto the front of the LRU
Date:   Mon, 10 Sep 2018 20:59:47 -0400
Message-Id: <20180911005949.5635-3-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180911004240.4758-1-daniel.m.jordan@oracle.com>
References: <20180911004240.4758-1-daniel.m.jordan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The add-to-front LRU path currently adds one page at a time to the front
of an LRU.  This is slow when using the concurrent algorithm described
in the next patch because the LRU head node will be locked for every
page that's added.

Instead, prepare local lists of pages, grouped by LRU, to be added to a
given LRU in a single splice operation.  The batching effect will reduce
the amount of time that the LRU head is locked per page added.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/swap.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 4 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index b1030eb7f459..07b951727a11 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -865,8 +865,52 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
-				 void *arg)
+#define	MAX_LRU_SPLICES 4
+
+struct lru_splice {
+	struct list_head list;
+	struct list_head *lru;
+	struct pglist_data *pgdat;
+};
+
+/*
+ * Adds a page to a local list for splicing, or else to the singletons
+ * list for individual processing.
+ *
+ * Returns the new number of splices in the splices list.
+ */
+static size_t add_page_to_splice(struct page *page, struct pglist_data *pgdat,
+				 struct lru_splice *splices, size_t nr_splices,
+				 struct list_head *singletons,
+				 struct list_head *lru)
+{
+	int i;
+
+	for (i = 0; i < nr_splices; ++i) {
+		if (splices[i].lru == lru) {
+			list_add(&page->lru, &splices[i].list);
+			return nr_splices;
+		}
+	}
+
+	if (nr_splices < MAX_LRU_SPLICES) {
+		INIT_LIST_HEAD(&splices[nr_splices].list);
+		splices[nr_splices].lru = lru;
+		splices[nr_splices].pgdat = pgdat;
+		list_add(&page->lru, &splices[nr_splices].list);
+		++nr_splices;
+	} else {
+		list_add(&page->lru, singletons);
+	}
+
+	return nr_splices;
+}
+
+static size_t pagevec_lru_add_splice(struct page *page, struct lruvec *lruvec,
+				     struct pglist_data *pgdat,
+				     struct lru_splice *splices,
+				     size_t nr_splices,
+				     struct list_head *singletons)
 {
 	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
@@ -916,8 +960,12 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 			count_vm_event(UNEVICTABLE_PGCULLED);
 	}
 
-	add_page_to_lru_list(page, lruvec, lru);
+	nr_splices = add_page_to_splice(page, pgdat, splices, nr_splices,
+					singletons, &lruvec->lists[lru]);
+	update_lru_size(lruvec, lru, page_zonenum(page), hpage_nr_pages(page));
 	trace_mm_lru_insertion(page, lru);
+
+	return nr_splices;
 }
 
 /*
@@ -926,7 +974,74 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, NULL);
+	int i;
+	struct pglist_data *pagepgdat, *pgdat = NULL;
+	unsigned long flags = 0;
+	struct lru_splice splices[MAX_LRU_SPLICES];
+	size_t nr_splices = 0;
+	LIST_HEAD(singletons);
+	struct page *page;
+	struct lruvec *lruvec;
+	enum lru_list lru;
+
+	/*
+	 * Sort the pages into local lists to splice onto the LRU.  In the
+	 * common case there should be few of these local lists.
+	 */
+	for (i = 0; i < pagevec_count(pvec); ++i) {
+		page = pvec->pages[i];
+		pagepgdat = page_pgdat(page);
+
+		/*
+		 * Take lru_lock now so that setting PageLRU and setting the
+		 * local list's links appear to happen atomically.
+		 */
+		if (pagepgdat != pgdat) {
+			if (pgdat)
+				write_unlock_irqrestore(&pgdat->lru_lock, flags);
+			pgdat = pagepgdat;
+			write_lock_irqsave(&pgdat->lru_lock, flags);
+		}
+
+		lruvec = mem_cgroup_page_lruvec(page, pagepgdat);
+
+		nr_splices = pagevec_lru_add_splice(page, lruvec, pagepgdat,
+						    splices, nr_splices,
+						    &singletons);
+	}
+
+	for (i = 0; i < nr_splices; ++i) {
+		struct lru_splice *splice = &splices[i];
+
+		if (splice->pgdat != pgdat) {
+			if (pgdat)
+				write_unlock_irqrestore(&pgdat->lru_lock, flags);
+			pgdat = splice->pgdat;
+			write_lock_irqsave(&pgdat->lru_lock, flags);
+		}
+		list_splice(&splice->list, splice->lru);
+	}
+
+	while (!list_empty(&singletons)) {
+		page = list_first_entry(&singletons, struct page, lru);
+		list_del(singletons.next);
+		pagepgdat = page_pgdat(page);
+
+		if (pagepgdat != pgdat) {
+			if (pgdat)
+				write_unlock_irqrestore(&pgdat->lru_lock, flags);
+			pgdat = pagepgdat;
+			write_lock_irqsave(&pgdat->lru_lock, flags);
+		}
+
+		lruvec = mem_cgroup_page_lruvec(page, pgdat);
+		lru = page_lru(page);
+		list_add(&page->lru, &lruvec->lists[lru]);
+	}
+	if (pgdat)
+		write_unlock_irqrestore(&pgdat->lru_lock, flags);
+	release_pages(pvec->pages, pvec->nr);
+	pagevec_reinit(pvec);
 }
 EXPORT_SYMBOL(__pagevec_lru_add);
 
-- 
2.18.0

