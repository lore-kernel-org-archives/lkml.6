Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446E5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20F22089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0ed5MmE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20F22089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeJQBNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeJQBNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 224062098A;
        Tue, 16 Oct 2018 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710541;
        bh=ULDMucRCk6H9QQ3NUp+4Yc0DTTkPAdSU9DooDIxqYrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ed5MmE+NeOzn7NlkF3nKaufh/AsSMjqvgok+JeXgv7Mtx/WofIMF6mjrIeUhClm9
         Lp43Ad5ze0GS/0SVJRSPy2bdLK4W5VcxTUSF8oX/44ko0++rT4LXkJxSXqr58lGgof
         d004yeIEFTRAM96SLLXIUYTTWvZHOWid3m5HjTUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 082/109] dcache: account external names as indirectly reclaimable memory
Date:   Tue, 16 Oct 2018 19:05:50 +0200
Message-Id: <20181016170529.468414477@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <guro@fb.com>

commit f1782c9bc547754f4bd3043fe8cfda53db85f13f upstream.

I received a report about suspicious growth of unreclaimable slabs on
some machines.  I've found that it happens on machines with low memory
pressure, and these unreclaimable slabs are external names attached to
dentries.

External names are allocated using generic kmalloc() function, so they
are accounted as unreclaimable.  But they are held by dentries, which
are reclaimable, and they will be reclaimed under the memory pressure.

In particular, this breaks MemAvailable calculation, as it doesn't take
unreclaimable slabs into account.  This leads to a silly situation, when
a machine is almost idle, has no memory pressure and therefore has a big
dentry cache.  And the resulting MemAvailable is too low to start a new
workload.

To address the issue, the NR_INDIRECTLY_RECLAIMABLE_BYTES counter is
used to track the amount of memory, consumed by external names.  The
counter is increased in the dentry allocation path, if an external name
structure is allocated; and it's decreased in the dentry freeing path.

To reproduce the problem I've used the following Python script:

  import os

  for iter in range (0, 10000000):
      try:
          name = ("/some_long_name_%d" % iter) + "_" * 220
          os.stat(name)
      except Exception:
          pass

Without this patch:
  $ cat /proc/meminfo | grep MemAvailable
  MemAvailable:    7811688 kB
  $ python indirect.py
  $ cat /proc/meminfo | grep MemAvailable
  MemAvailable:    2753052 kB

With the patch:
  $ cat /proc/meminfo | grep MemAvailable
  MemAvailable:    7809516 kB
  $ python indirect.py
  $ cat /proc/meminfo | grep MemAvailable
  MemAvailable:    7749144 kB

[guro@fb.com: fix indirectly reclaimable memory accounting for CONFIG_SLOB]
  Link: http://lkml.kernel.org/r/20180312194140.19517-1-guro@fb.com
[guro@fb.com: fix indirectly reclaimable memory accounting]
  Link: http://lkml.kernel.org/r/20180313125701.7955-1-guro@fb.com
Link: http://lkml.kernel.org/r/20180305133743.12746-5-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dcache.c |   38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -270,11 +270,25 @@ static void __d_free(struct rcu_head *he
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
+static void __d_free_external_name(struct rcu_head *head)
+{
+	struct external_name *name = container_of(head, struct external_name,
+						  u.head);
+
+	mod_node_page_state(page_pgdat(virt_to_page(name)),
+			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
+			    -ksize(name));
+
+	kfree(name);
+}
+
 static void __d_free_external(struct rcu_head *head)
 {
 	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
-	kfree(external_name(dentry));
-	kmem_cache_free(dentry_cache, dentry); 
+
+	__d_free_external_name(&external_name(dentry)->u.head);
+
+	kmem_cache_free(dentry_cache, dentry);
 }
 
 static inline int dname_external(const struct dentry *dentry)
@@ -305,7 +319,7 @@ void release_dentry_name_snapshot(struct
 		struct external_name *p;
 		p = container_of(name->name, struct external_name, name[0]);
 		if (unlikely(atomic_dec_and_test(&p->u.count)))
-			kfree_rcu(p, u.head);
+			call_rcu(&p->u.head, __d_free_external_name);
 	}
 }
 EXPORT_SYMBOL(release_dentry_name_snapshot);
@@ -1605,6 +1619,7 @@ EXPORT_SYMBOL(d_invalidate);
  
 struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
+	struct external_name *ext = NULL;
 	struct dentry *dentry;
 	char *dname;
 	int err;
@@ -1625,14 +1640,13 @@ struct dentry *__d_alloc(struct super_bl
 		dname = dentry->d_iname;
 	} else if (name->len > DNAME_INLINE_LEN-1) {
 		size_t size = offsetof(struct external_name, name[1]);
-		struct external_name *p = kmalloc(size + name->len,
-						  GFP_KERNEL_ACCOUNT);
-		if (!p) {
+		ext = kmalloc(size + name->len, GFP_KERNEL_ACCOUNT);
+		if (!ext) {
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
 		}
-		atomic_set(&p->u.count, 1);
-		dname = p->name;
+		atomic_set(&ext->u.count, 1);
+		dname = ext->name;
 		if (IS_ENABLED(CONFIG_DCACHE_WORD_ACCESS))
 			kasan_unpoison_shadow(dname,
 				round_up(name->len + 1,	sizeof(unsigned long)));
@@ -1675,6 +1689,12 @@ struct dentry *__d_alloc(struct super_bl
 		}
 	}
 
+	if (unlikely(ext)) {
+		pg_data_t *pgdat = page_pgdat(virt_to_page(ext));
+		mod_node_page_state(pgdat, NR_INDIRECTLY_RECLAIMABLE_BYTES,
+				    ksize(ext));
+	}
+
 	this_cpu_inc(nr_dentry);
 
 	return dentry;
@@ -2769,7 +2789,7 @@ static void copy_name(struct dentry *den
 		dentry->d_name.hash_len = target->d_name.hash_len;
 	}
 	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
-		kfree_rcu(old_name, u.head);
+		call_rcu(&old_name->u.head, __d_free_external_name);
 }
 
 static void dentry_lock_for_move(struct dentry *dentry, struct dentry *target)


