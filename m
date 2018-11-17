Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D92BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D512087C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+GsUtDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D512087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbeKQLsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:48:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55964 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbeKQLsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:48:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAH1UYqX173181;
        Sat, 17 Nov 2018 01:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ejcndncUAuINuK2x9z8Dyx3ipAq0g5bK/NgRT7pR8n0=;
 b=O+GsUtDQZ5Nx+CW1M2PYdkTcC4SlnjtvcIljw8mrAII3rp9F9gr8IBJwa2vYRl6uY0Ix
 82bZJQ+CJxhqvHAFWBEtqJ5KVUIQLpfFkAB1nWVgvD7b7zkzT8zCjizVurvoVYUSXWp8
 rl2kVTzrmEHs3/rVS3ip1p5ggyxHZg9End8pcveugUQIUwuFxywQPqnGD/2hFrmz/avH
 3n2+gud9bc0n7YuMoBysD9lWGCY6GhK2KuqKoG/aZiM+kPkBrizREdo3smsxyV6uw4aj
 cUlAqVLMYuY+L5WQmFy5AfwaTnfLSmULhhiGUTwitD1C82HpnjBMBoNDOqn/+jUZNQ+i 8Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nr7cshwyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Nov 2018 01:33:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAH1Xdmh004522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Nov 2018 01:33:39 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAH1XcPn028976;
        Sat, 17 Nov 2018 01:33:38 GMT
Received: from oracle.com (/10.211.52.31)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Nov 2018 17:33:38 -0800
From:   Wengang Wang <wen.gang.wang@oracle.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     wen.gang.wang@oracle.com
Subject: [PATCH] mm: use this_cpu_cmpxchg_double in put_cpu_partial
Date:   Fri, 16 Nov 2018 17:33:35 -0800
Message-Id: <20181117013335.32220-1-wen.gang.wang@oracle.com>
X-Mailer: git-send-email 2.9.5
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9079 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=833
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811170011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The this_cpu_cmpxchg makes the do-while loop pass as long as the
s->cpu_slab->partial as the same value. It doesn't care what happened to
that slab. Interrupt is not disabled, and new alloc/free can happen in the
interrupt handlers. Theoretically, after we have a reference to the it,
stored in _oldpage_, the first slab on the partial list on this CPU can be
moved to kmem_cache_node and then moved to different kmem_cache_cpu and
then somehow can be added back as head to partial list of current
kmem_cache_cpu, though that is a very rare case. If that rare case really
happened, the reading of oldpage->pobjects may get a 0xdead0000
unexpectedly, stored in _pobjects_, if the reading happens just after
another CPU removed the slab from kmem_cache_node, setting lru.prev to
LIST_POISON2 (0xdead000000000200). The wrong _pobjects_(negative) then
prevents slabs from being moved to kmem_cache_node and being finally freed.

We see in a vmcore, there are 375210 slabs kept in the partial list of one
kmem_cache_cpu, but only 305 in-use objects in the same list for
kmalloc-2048 cache. We see negative values for page.pobjects, the last page
with negative _pobjects_ has the value of 0xdead0004, the next page looks
good (_pobjects is 1).

For the fix, I wanted to call this_cpu_cmpxchg_double with
oldpage->pobjects, but failed due to size difference between
oldpage->pobjects and cpu_slab->partial. So I changed to call
this_cpu_cmpxchg_double with _tid_. I don't really want no alloc/free
happen in between, but just want to make sure the first slab did expereince
a remove and re-add. This patch is more to call for ideas.

Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
---
 mm/slub.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e3629cd..26539e6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2248,6 +2248,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct page *oldpage;
+	unsigned long tid;
 	int pages;
 	int pobjects;
 
@@ -2255,8 +2256,12 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 	do {
 		pages = 0;
 		pobjects = 0;
-		oldpage = this_cpu_read(s->cpu_slab->partial);
 
+		tid = this_cpu_read(s->cpu_slab->tid);
+		/* read tid before reading oldpage */
+		barrier();
+
+		oldpage = this_cpu_read(s->cpu_slab->partial);
 		if (oldpage) {
 			pobjects = oldpage->pobjects;
 			pages = oldpage->pages;
@@ -2283,8 +2288,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 		page->pobjects = pobjects;
 		page->next = oldpage;
 
-	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
-								!= oldpage);
+		/* we dont' change tid, but want to make sure it didn't change
+		 * in between. We don't really hope alloc/free not happen on
+		 * this CPU, but don't want the first slab be removed from and
+		 * then re-added as head to this partial list. If that case
+		 * happened, pobjects may read 0xdead0000 when this slab is just
+		 * removed from kmem_cache_node by other CPU setting lru.prev
+		 * to LIST_POISON2.
+		 */
+	} while (this_cpu_cmpxchg_double(s->cpu_slab->partial, s->cpu_slab->tid,
+					 oldpage, tid, page, tid) == 0);
+
 	if (unlikely(!s->cpu_partial)) {
 		unsigned long flags;
 
-- 
2.9.5

