Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC9C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA4620839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XowBvb3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA4620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeIKF6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:58:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeIKF6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:58:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B10AU2077920;
        Tue, 11 Sep 2018 01:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=AwKU9D2DXjht3CNnkLsSPDqQZuiwRTaiUp/PfPjCECA=;
 b=XowBvb3w4t3VICbk3/jLlxwdY79KT58Jn+A1CG7G2zjjqHd7SajwL523S89WDF807jiE
 F3tVjJE6B/DQsxJ8x353mkFCpY9rTfDQvBF9u+kpoeD093vmyw79SA6QWDp97UXCbYgv
 +ZKHuUw2NrnCaHsaVucqMdtDrgwy/7WpOMT+jPV+yvrBxDHC8qpZC0vq0xD3H4pSFrTE
 tN/FDgjT4JZTTLTglzcN+eFhq4+cUDg36nR0VneX0BrOggnJd4HidnAmuoQCdc6gZ6jn
 sW1gc9DxC6fTF6s0N38R+/1NlMMY5uFd7ObkNQaj45zzswV8b1K5lvB6/lo+X7f1saZT 2A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mc5ut94fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 01:00:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8B104KL006318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 01:00:04 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8B103xP003465;
        Tue, 11 Sep 2018 01:00:03 GMT
Received: from localhost.localdomain (/73.143.71.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 18:00:03 -0700
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
Subject: [RFC PATCH v2 8/8] mm: enable concurrent LRU adds
Date:   Mon, 10 Sep 2018 20:59:49 -0400
Message-Id: <20180911005949.5635-5-daniel.m.jordan@oracle.com>
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

Switch over to holding lru_lock as reader when splicing pages onto the
front of an LRU.  The main benefit of doing this is to allow LRU adds
and removes to happen concurrently.  Before this patch, an add blocks
all removing threads.

Suggested-by: Yosef Lev <levyossi@icloud.com>
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/swap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index fe3098c09815..ccd82ef3c217 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -999,9 +999,9 @@ void __pagevec_lru_add(struct pagevec *pvec)
 		 */
 		if (pagepgdat != pgdat) {
 			if (pgdat)
-				write_unlock_irqrestore(&pgdat->lru_lock, flags);
+				read_unlock_irqrestore(&pgdat->lru_lock, flags);
 			pgdat = pagepgdat;
-			write_lock_irqsave(&pgdat->lru_lock, flags);
+			read_lock_irqsave(&pgdat->lru_lock, flags);
 		}
 
 		lruvec = mem_cgroup_page_lruvec(page, pagepgdat);
@@ -1016,12 +1016,16 @@ void __pagevec_lru_add(struct pagevec *pvec)
 
 		if (splice->pgdat != pgdat) {
 			if (pgdat)
-				write_unlock_irqrestore(&pgdat->lru_lock, flags);
+				read_unlock_irqrestore(&pgdat->lru_lock, flags);
 			pgdat = splice->pgdat;
-			write_lock_irqsave(&pgdat->lru_lock, flags);
+			read_lock_irqsave(&pgdat->lru_lock, flags);
 		}
 		smp_list_splice(&splice->list, splice->lru);
 	}
+	if (pgdat) {
+		read_unlock_irqrestore(&pgdat->lru_lock, flags);
+		pgdat = NULL;
+	}
 
 	while (!list_empty(&singletons)) {
 		page = list_first_entry(&singletons, struct page, lru);
-- 
2.18.0

