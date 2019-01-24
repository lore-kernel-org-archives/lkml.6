Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956AAC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64327217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359603;
	bh=7wKc/LdAtcw7xzvn5r8WuIfJ+u7vGGt+s5u5Mg1trv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gBIFRNWjA9UQKgnb2zbjclQ1TP03TQ8q6niN2PsRogzpGwo/lEuLTFghkr8oLhP7h
	 t7BIjTsO+jan7/ErhD1p2WymKKx+p5Ndbnyg4k5GLkasEMOoNC6nQIvvrNlVg2Aag8
	 s1T1RpYFscAKosn+ZOU58PINWCb+NATGlK+bx3qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbfAXTiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731334AbfAXTiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:38:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0C89218FC;
        Thu, 24 Jan 2019 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358691;
        bh=7wKc/LdAtcw7xzvn5r8WuIfJ+u7vGGt+s5u5Mg1trv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErjonseoFBvUpSB6XnWhDaEqVpcKXlfFYWbMmvxE6YEO9ZthW5htUa3xzV1ZhEnis
         RAV0jBPG4nhZYhNnKrtqlvEq0aj0A56yV8FqOAspNOYx2etvsKW4a6zYXzvRzO/rcW
         +dgEg4G6CfCFwHXDe/3zM47Ph4hJ3vnbVRZpGFLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Huang Ying <ying.huang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/106] mm/swap: use nr_node_ids for avail_lists in swap_info_struct
Date:   Thu, 24 Jan 2019 20:20:54 +0100
Message-Id: <20190124190212.131462514@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 67aaf7ae22ff..340ef3177686 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2820,8 +2820,9 @@ static struct swap_info_struct *alloc_swap_info(void)
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



