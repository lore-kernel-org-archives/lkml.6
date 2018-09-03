Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2EDC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE4920658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE4920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbeICVwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:52:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeICVsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:48:17 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E487AD1B;
        Mon,  3 Sep 2018 17:19:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 076/165] memcg: remove memcg_cgroup::id from IDR on mem_cgroup_css_alloc() failure
Date:   Mon,  3 Sep 2018 18:56:02 +0200
Message-Id: <20180903165658.905484831@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Tkhai <ktkhai@virtuozzo.com>

[ Upstream commit 7e97de0b033bcac4fa9a35cef72e0c06e6a22c67 ]

In case of memcg_online_kmem() failure, memcg_cgroup::id remains hashed
in mem_cgroup_idr even after memcg memory is freed.  This leads to leak
of ID in mem_cgroup_idr.

This patch adds removal into mem_cgroup_css_alloc(), which fixes the
problem.  For better readability, it adds a generic helper which is used
in mem_cgroup_alloc() and mem_cgroup_id_put_many() as well.

Link: http://lkml.kernel.org/r/152354470916.22460.14397070748001974638.stgit@localhost.localdomain
Fixes 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after many small jobs")
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4110,6 +4110,14 @@ static struct cftype mem_cgroup_legacy_f
 
 static DEFINE_IDR(mem_cgroup_idr);
 
+static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
+{
+	if (memcg->id.id > 0) {
+		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		memcg->id.id = 0;
+	}
+}
+
 static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
 {
 	VM_BUG_ON(atomic_read(&memcg->id.ref) <= 0);
@@ -4120,8 +4128,7 @@ static void mem_cgroup_id_put_many(struc
 {
 	VM_BUG_ON(atomic_read(&memcg->id.ref) < n);
 	if (atomic_sub_and_test(n, &memcg->id.ref)) {
-		idr_remove(&mem_cgroup_idr, memcg->id.id);
-		memcg->id.id = 0;
+		mem_cgroup_id_remove(memcg);
 
 		/* Memcg ID pins CSS */
 		css_put(&memcg->css);
@@ -4258,8 +4265,7 @@ static struct mem_cgroup *mem_cgroup_all
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
 fail:
-	if (memcg->id.id > 0)
-		idr_remove(&mem_cgroup_idr, memcg->id.id);
+	mem_cgroup_id_remove(memcg);
 	__mem_cgroup_free(memcg);
 	return NULL;
 }
@@ -4318,6 +4324,7 @@ mem_cgroup_css_alloc(struct cgroup_subsy
 
 	return &memcg->css;
 fail:
+	mem_cgroup_id_remove(memcg);
 	mem_cgroup_free(memcg);
 	return ERR_PTR(-ENOMEM);
 }


