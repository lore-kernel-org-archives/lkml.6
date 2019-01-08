Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABECC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFCA20645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975941;
	bh=vuQMvTX01SKNqD5/GRipLVqi2FuqUpX8/PQs4i1l5QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BFmR0TfxSXB5OvNOxmHbqL/cq5Uw5rP8YGyPJ8UJ+tzLHk1CPOgL2GA4Lq8ucWoOE
	 yfS9o5eZoemLA+aBxViMRjUOFXamzfUagGbGoCwEoSSuTqAhS/YiKLzj8GjguU7yH4
	 rzB1O0qOvJfU2QlhdCJKzRki2fgcKviZ4ATtcnBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfAHTcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbfAHTcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52ED720827;
        Tue,  8 Jan 2019 19:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975937;
        bh=vuQMvTX01SKNqD5/GRipLVqi2FuqUpX8/PQs4i1l5QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeiRDVKKK90lYpjc14JG1HukEdtJWJsY80rwxgqoPzsI+tr1LrMtKk1k4ADDOc+1M
         Ah7yt5yoUZPbZK5xDc2bRvw3+OYPMyE2INZ1+epCoF4jRBjlnpjhl9t/1afkbHgmJf
         V7IkxFX6pR0XrnYDQPlpaQ/sto9MKCLEqA2lpPgI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaron Lu <aaron.lu@intel.com>, Vasily Averin <vvs@virtuozzo.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 95/97] mm/swap: use nr_node_ids for avail_lists in swap_info_struct
Date:   Tue,  8 Jan 2019 14:29:44 -0500
Message-Id: <20190108192949.122407-95-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Lu <aaron.lu@intel.com>

[ Upstream commit 66f71da9dd38af17dc17209cdde7987d4679a699 ]

Since a2468cc9bfdf ("swap: choose swap device according to numa node"),
avail_lists field of swap_info_struct is changed to an array with
MAX_NUMNODES elements.  This made swap_info_struct size increased to 40KiB
and needs an order-4 page to hold it.

This is not optimal in that:
1 Most systems have way less than MAX_NUMNODES(1024) nodes so it
  is a waste of memory;
2 It could cause swapon failure if the swap device is swapped on
  after system has been running for a while, due to no order-4
  page is available as pointed out by Vasily Averin.

Solve the above two issues by using nr_node_ids(which is the actual
possible node number the running system has) for avail_lists instead of
MAX_NUMNODES.

nr_node_ids is unknown at compile time so can't be directly used when
declaring this array.  What I did here is to declare avail_lists as zero
element array and allocate space for it when allocating space for
swap_info_struct.  The reason why keep using array but not pointer is
plist_for_each_entry needs the field to be part of the struct, so pointer
will not work.

This patch is on top of Vasily Averin's fix commit.  I think the use of
kvzalloc for swap_info_struct is still needed in case nr_node_ids is
really big on some systems.

Link: http://lkml.kernel.org/r/20181115083847.GA11129@intel.com
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Vasily Averin <vvs@virtuozzo.com>
Cc: Huang Ying <ying.huang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/swap.h | 11 ++++++++++-
 mm/swapfile.c        |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8e2c11e692ba..77221c16733a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -232,7 +232,6 @@ struct swap_info_struct {
 	unsigned long	flags;		/* SWP_USED etc: see above */
 	signed short	prio;		/* swap priority of this type */
 	struct plist_node list;		/* entry in swap_active_head */
-	struct plist_node avail_lists[MAX_NUMNODES];/* entry in swap_avail_heads */
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
@@ -273,6 +272,16 @@ struct swap_info_struct {
 					 */
 	struct work_struct discard_work; /* discard worker */
 	struct swap_cluster_list discard_clusters; /* discard clusters list */
+	struct plist_node avail_lists[0]; /*
+					   * entries in swap_avail_heads, one
+					   * entry per node.
+					   * Must be last as the number of the
+					   * array is nr_node_ids, which is not
+					   * a fixed value so have to allocate
+					   * dynamically.
+					   * And it has to be an array so that
+					   * plist_for_each_* can work.
+					   */
 };
 
 #ifdef CONFIG_64BIT
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8810a6d7d67f..08ba73eaaba2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2819,8 +2819,9 @@ static struct swap_info_struct *alloc_swap_info(void)
 	struct swap_info_struct *p;
 	unsigned int type;
 	int i;
+	int size = sizeof(*p) + nr_node_ids * sizeof(struct plist_node);
 
-	p = kvzalloc(sizeof(*p), GFP_KERNEL);
+	p = kvzalloc(size, GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.19.1

