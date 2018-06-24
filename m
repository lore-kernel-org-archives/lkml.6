Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479A7C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2CD24CF5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 03:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SKoKuMJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2CD24CF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeFXD0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 23:26:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeFXD0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 23:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=77plKqLgMLZSOb1GCSlQRUATKTO0GzAmZ/ub9aVLYl0=; b=SKoKuMJFoaDgcfhniLqsVM5mR
        PW+H1kv9VbM5VxXJqk/ka3bho5/yTkPvsGtXKU9QKk/7bARw/j9cBG1cyEAXdJC+g9KYvlbgMum1N
        ktRq92NkliB3IIPQjOn8sxuRrJc/wV42QyY1BHoM4Rolnl4mrLedgwJ3JVEu0/xHpj9+RcNxQtxcH
        RAWYL3+2Y6GGZIwEqkHGGiQhs4JWVGS1Kh62fDSq5pEznLNniFOsdNppfEEZ6BeJS+08qC9E8bf6f
        JKufcFgyNsDi4deHoOUqgMLcy7U0mmXdToBbbtDrUjmrwn1obnkpDKcZk2KCUYMtLoTxJYvxSk8iP
        NEzQKb5ig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWvfL-0008HJ-La; Sun, 24 Jun 2018 03:26:15 +0000
Date:   Sat, 23 Jun 2018 20:26:15 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
Message-ID: <20180624032615.GA32667@bombadil.infradead.org>
References: <20180622184246.GA21226@roeck-us.net>
 <20180622210519.GA18630@bombadil.infradead.org>
 <20180622223335.GA12581@roeck-us.net>
 <20180624011703.GH18630@bombadil.infradead.org>
 <a62d8a6a-0376-2cbe-a34c-13e1242f06c6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a62d8a6a-0376-2cbe-a34c-13e1242f06c6@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 07:52:35PM -0700, Guenter Roeck wrote:
> On 06/23/2018 06:17 PM, Matthew Wilcox wrote:
> > On Fri, Jun 22, 2018 at 03:33:35PM -0700, Guenter Roeck wrote:
> > > It may be odd that fs/quota/netlink.c:quota_genl_family is not word
> > > aligned, but on the other side I don't think there is a rule that
> > > the function parameter to genl_register_family() - or the second
> > > parameter of idr_alloc() - must be word aligned. Am I missing
> > > something ? After all, it could be a pointer to the nth element
> > > of a string, or the caller could on purpose allocate IDRs for
> > > (ptr), (ptr + 1), and so on.
> > 
> > This is probably going to cure the problem for you (apply on top
> > of the existing radix tree / IDR changes).
> > 
> > I realised when I was reviewing the patch that it's no good; if you
> > call idr_replace() with a radix_tree_is_internal_node(), then you'll
> > still get a crash.  I'm going to have to disable the optimisation of
> > shrinking the tree all the way into the head for the IDR.  But this
> > will probably get m68k working again.
> > 
> 
> It doesn't crash anymore, but there is still a backtrace.

Oof.  Thank you!  Updated patch (still doesn't fix idr_replace, but does
fix the idr_for_each() problem, at least according to the tests I added
to the test-suite.

diff --git a/lib/idr.c b/lib/idr.c
index 58b88f5eb672..51ee0c6170d1 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -38,17 +38,24 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,
 	void __rcu **slot;
 	unsigned int base = idr->idr_base;
 	unsigned int id = *nextid;
+	bool advanced = false;
 
-	if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
-		return -EINVAL;
 	if (WARN_ON_ONCE(!(idr->idr_rt.xa_flags & ROOT_IS_IDR)))
 		idr->idr_rt.xa_flags |= IDR_RT_MARKER;
 
 	id = (id < base) ? 0 : id - base;
+	if (id == 0 && radix_tree_is_internal_node(ptr) && idr_is_empty(idr)) {
+		advanced = true;
+		id = 1;
+	}
 	radix_tree_iter_init(&iter, id);
 	slot = idr_get_free(&idr->idr_rt, &iter, gfp, max - base);
 	if (IS_ERR(slot))
 		return PTR_ERR(slot);
+	if (advanced) {
+		iter.index = 0;
+		slot--;
+	}
 
 	*nextid = iter.index + base;
 	/* there is a memory barrier inside radix_tree_iter_replace() */
@@ -295,8 +302,6 @@ void *idr_replace(struct idr *idr, void *ptr, unsigned long id)
 	void __rcu **slot = NULL;
 	void *entry;
 
-	if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
-		return ERR_PTR(-EINVAL);
 	id -= idr->idr_base;
 
 	entry = __radix_tree_lookup(&idr->idr_rt, id, &node, &slot);
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 101f1c28e1b6..15f34de929f5 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -562,11 +562,14 @@ static inline bool radix_tree_shrink(struct radix_tree_root *root)
 		child = rcu_dereference_raw(node->slots[0]);
 		if (!child)
 			break;
-		if (!radix_tree_is_internal_node(child) && node->shift)
+		if (!radix_tree_is_internal_node(child))
 			break;
 
-		if (radix_tree_is_internal_node(child))
+		if (radix_tree_is_internal_node(child)) {
+			if (!node->shift)
+				break;
 			entry_to_node(child)->parent = NULL;
+		}
 
 		/*
 		 * We don't need rcu_assign_pointer(), since we are simply
@@ -733,7 +736,7 @@ static void radix_tree_free_nodes(struct radix_tree_node *node)
 
 	for (;;) {
 		void *entry = rcu_dereference_raw(child->slots[offset]);
-		if (xa_is_node(entry)) {
+		if (xa_is_node(entry) && child->shift) {
 			child = entry_to_node(entry);
 			offset = 0;
 			continue;
@@ -904,6 +907,8 @@ void *__radix_tree_lookup(const struct radix_tree_root *root,
 		parent = entry_to_node(node);
 		offset = radix_tree_descend(parent, &node, index);
 		slot = parent->slots + offset;
+		if (parent->shift == 0)
+			break;
 	}
 
 	if (nodep)
@@ -977,9 +982,6 @@ static inline void replace_sibling_entries(struct radix_tree_node *node,
 static void replace_slot(void __rcu **slot, void *item,
 		struct radix_tree_node *node, int count, int values)
 {
-	if (WARN_ON_ONCE(radix_tree_is_internal_node(item)))
-		return;
-
 	if (node && (count || values)) {
 		node->count += count;
 		node->nr_values += values;
@@ -1486,7 +1488,7 @@ void __rcu **radix_tree_next_chunk(const struct radix_tree_root *root,
 			goto restart;
 		if (child == RADIX_TREE_RETRY)
 			break;
-	} while (radix_tree_is_internal_node(child));
+	} while (node->shift && radix_tree_is_internal_node(child));
 
 	/* Update the iterator state */
 	iter->index = (index &~ node_maxindex(node)) | (offset << node->shift);
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 46fc2f1142c3..ec7e8f2fb0ec 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -227,6 +227,56 @@ void idr_u32_test(int base)
 	idr_u32_test1(&idr, 0xffffffff);
 }
 
+static void idr_align_test(struct idr *idr)
+{
+	char name[] = "Motorola 68000";
+	int i, id;
+	void *entry;
+
+	for (i = 0; i < 9; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i);
+		idr_for_each_entry(idr, entry, id);
+	}
+	idr_destroy(idr);
+
+	for (i = 1; i < 10; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 1);
+		idr_for_each_entry(idr, entry, id);
+	}
+	idr_destroy(idr);
+
+	for (i = 2; i < 11; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 2);
+		idr_for_each_entry(idr, entry, id);
+	}
+	idr_destroy(idr);
+
+	for (i = 3; i < 12; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != i - 3);
+		idr_for_each_entry(idr, entry, id);
+	}
+	idr_destroy(idr);
+
+	for (i = 0; i < 8; i++) {
+		BUG_ON(idr_alloc(idr, &name[i], 0, 0, GFP_KERNEL) != 0);
+		BUG_ON(idr_alloc(idr, &name[i + 1], 0, 0, GFP_KERNEL) != 1);
+		idr_for_each_entry(idr, entry, id);
+		idr_remove(idr, 1);
+		idr_for_each_entry(idr, entry, id);
+		idr_remove(idr, 0);
+		BUG_ON(!idr_is_empty(idr));
+	}
+
+	for (i = 0; i < 8; i++) {
+		BUG_ON(idr_alloc(idr, NULL, 0, 0, GFP_KERNEL) != 0);
+		idr_for_each_entry(idr, entry, id);
+		idr_replace(idr, &name[i], 0);
+		idr_for_each_entry(idr, entry, id);
+		BUG_ON(idr_find(idr, 0) != &name[i]);
+		idr_remove(idr, 0);
+	}
+}
+
 void idr_checks(void)
 {
 	unsigned long i;
@@ -307,6 +357,7 @@ void idr_checks(void)
 	idr_u32_test(4);
 	idr_u32_test(1);
 	idr_u32_test(0);
+	idr_align_test(&idr);
 }
 
 /*
