Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26644C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E0C2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iXuhemIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E0C2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeH2CVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:21:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH2CVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lp8S4hSKG3FLA0vLm4/xmg/I8M2HWqNPKRGVhxCfoXs=; b=iXuhemIl/aqHX8nTV6a3RmdOCD
        nIrQvG1iN/NB741SohCatVqqqlujnL2zxr2ZvdsdAkqGqb3YZeVc9233ApnO0QMeydTHApQJTo4le
        CR+xbPN9MaXiACgpr4eADJG5J/gt1DdfIrTCGU00wa43C1fTOPv/6msmayfQFv8ZRDUWb4zsau1I9
        WirYKRM+D0i7k1MmaENymDVLffeV914Q6TMxil1MBvW3jZlw+vJkgUY/FZbQ3SCSzpSq8ahmDGn8I
        DM8vBLZQC1EpXkDQy3EuJuShznQDncv8QutUeeJcC8sGTyWilRmRTbhnWnVecJDxbyTU/DmjxjC7o
        29kemgkA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fumSN-0008HJ-UA; Tue, 28 Aug 2018 22:27:27 +0000
Date:   Tue, 28 Aug 2018 15:27:27 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Tagged pointers in the XArray
Message-ID: <20180828222727.GD11400@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I find myself caught between two traditions.

On the one hand, the radix tree has been calling the page cache dirty &
writeback bits "tags" for over a decade.

On the other hand, using some of the bits _in a pointer_ as a tag has been
common practice since at least the 1960s.
https://en.wikipedia.org/wiki/Tagged_pointer and
https://en.wikipedia.org/wiki/31-bit

EROFS wants to use tagged pointers in the radix tree / xarray.  Right now,
they're building them by hand, which is predictably grotty-looking.
I think it's reasonable to provide this functionality as part of the
XArray API, _but_ it's confusing to have two different things called tags.

I've done my best to document my way around this, but if we want to rename
the things that the radix tree called tags to avoid the problem entirely,
now is the time to do it.  Anybody got a Good Idea?

commit e2f06dd921a072bcc021fc7224a216d2c1b88b54
Author: Matthew Wilcox <willy@infradead.org>
Date:   Tue Aug 28 14:37:22 2018 -0400

    xarray: Add support for tagged pointers
    
    EROFS wants to tag its pointers rather than use XArray tags.  This is
    a new usecase which seems reasonable to support.
    
    Signed-off-by: Matthew Wilcox <willy@infradead.org>

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index bc0c43f49efe..215bd468cae7 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -41,6 +41,12 @@ When you retrieve an entry from the XArray, you can check whether it is
 a value entry by calling :c:func:`xa_is_value`, and convert it back to
 an integer by calling :c:func:`xa_to_value`.
 
+Some users want to tag their pointers without using the tag bits described
+above.  They can call :c:func:`xa_tag_pointer` to create an entry with
+a tag, :c:func:`xa_untag_pointer` to turn a tagged entry back into an
+untagged pointer and :c:func:`xa_pointer_tag` to retrieve the tag of
+an entry.
+
 The XArray does not support storing :c:func:`IS_ERR` pointers as some
 conflict with value entries or internal entries.
 
diff --git a/drivers/staging/erofs/Kconfig b/drivers/staging/erofs/Kconfig
index 96f614934df1..663b755bf2fb 100644
--- a/drivers/staging/erofs/Kconfig
+++ b/drivers/staging/erofs/Kconfig
@@ -2,7 +2,7 @@
 
 config EROFS_FS
 	tristate "EROFS filesystem support"
-	depends on BROKEN
+	depends on BLOCK
 	help
 	  EROFS(Enhanced Read-Only File System) is a lightweight
 	  read-only file system with modern designs (eg. page-sized
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 595cf90af9bb..bdee9bd09f11 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -35,7 +35,6 @@ static atomic_long_t erofs_global_shrink_cnt;
 
 #ifdef CONFIG_EROFS_FS_ZIP
 
-/* radix_tree and the future XArray both don't use tagptr_t yet */
 struct erofs_workgroup *erofs_find_workgroup(
 	struct super_block *sb, pgoff_t index, bool *tag)
 {
@@ -47,9 +46,8 @@ struct erofs_workgroup *erofs_find_workgroup(
 	rcu_read_lock();
 	grp = radix_tree_lookup(&sbi->workstn_tree, index);
 	if (grp != NULL) {
-		*tag = radix_tree_exceptional_entry(grp);
-		grp = (void *)((unsigned long)grp &
-			~RADIX_TREE_EXCEPTIONAL_ENTRY);
+		*tag = xa_pointer_tag(grp);
+		grp = xa_untag_pointer(grp);
 
 		if (erofs_workgroup_get(grp, &oldcount)) {
 			/* prefer to relax rcu read side */
@@ -83,9 +81,7 @@ int erofs_register_workgroup(struct super_block *sb,
 	sbi = EROFS_SB(sb);
 	erofs_workstn_lock(sbi);
 
-	if (tag)
-		grp = (void *)((unsigned long)grp |
-			1UL << RADIX_TREE_EXCEPTIONAL_SHIFT);
+	grp = xa_tag_pointer(grp, tag);
 
 	err = radix_tree_insert(&sbi->workstn_tree,
 		grp->index, grp);
@@ -131,9 +127,7 @@ unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 
 	for (i = 0; i < found; ++i) {
 		int cnt;
-		struct erofs_workgroup *grp = (void *)
-			((unsigned long)batch[i] &
-				~RADIX_TREE_EXCEPTIONAL_ENTRY);
+		struct erofs_workgroup *grp = xa_untag_pointer(batch[i]);
 
 		first_index = grp->index + 1;
 
@@ -150,8 +144,8 @@ unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 #endif
 			continue;
 
-		if (radix_tree_delete(&sbi->workstn_tree,
-			grp->index) != grp) {
+		if (xa_untag_pointer(radix_tree_delete(&sbi->workstn_tree,
+			grp->index)) != grp) {
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 skip:
 			erofs_workgroup_unfreeze(grp, 1);
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index c74556ea4258..d1b383f3063f 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -24,7 +24,7 @@
  *
  * 00: Pointer entry
  * 10: Internal entry
- * x1: Value entry
+ * x1: Value entry or tagged pointer
  *
  * Attempting to store internal entries in the XArray is a bug.
  *
@@ -150,6 +150,54 @@ static inline int xa_err(void *entry)
 	return 0;
 }
 
+/**
+ * xa_tag_pointer() - Create an XArray entry for a tagged pointer.
+ * @p: Plain pointer.
+ * @tag: Tag value (0, 1 or 3).
+ *
+ * If the user of the XArray prefers, they can tag their pointers instead
+ * of storing value entries.  Three tags are available (0, 1 and 3).
+ * These are distinct from the xa_tag_t as they are not replicated up
+ * through the array and cannot be searched for.
+ *
+ * Context: Any context.
+ * Return: An XArray entry.
+ */
+static inline void *xa_tag_pointer(void *p, unsigned long tag)
+{
+	return (void *)((unsigned long)p | tag);
+}
+
+/**
+ * xa_untag_pointer() - Turn an XArray entry into a plain pointer.
+ * @entry: XArray entry.
+ *
+ * If you have stored a tagged pointer in the XArray, call this function
+ * to get the untagged version of the pointer.
+ *
+ * Context: Any context.
+ * Return: A pointer.
+ */
+static inline void *xa_untag_pointer(void *entry)
+{
+	return (void *)((unsigned long)entry & ~3UL);
+}
+
+/**
+ * xa_pointer_tag() - Get the tag stored in an XArray entry.
+ * @entry: XArray entry.
+ *
+ * If you have stored a tagged pointer in the XArray, call this function
+ * to get the tag of that pointer.
+ *
+ * Context: Any context.
+ * Return: A tag.
+ */
+static inline unsigned int xa_pointer_tag(void *entry)
+{
+	return (unsigned long)entry & 3UL;
+}
+
 typedef unsigned __bitwise xa_tag_t;
 #define XA_TAG_0		((__force xa_tag_t)0U)
 #define XA_TAG_1		((__force xa_tag_t)1U)
