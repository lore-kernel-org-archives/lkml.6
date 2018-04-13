Return-Path: <kernel-hardening-return-12987-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+r8Ygm1gd2ucrtMx2G1U7A9NoxpSjjkevkIvU7E5wDI/MSx2ebsupbVADvDkh2LRYrG8VT
ARC-Seal: i=1; a=rsa-sha256; t=1523627020; cv=none;
        d=google.com; s=arc-20160816;
        b=1EgkBqLDNC7Q7sgtmRwsBHx6j9RhqkS6N6V5u7Dv8L2sKN4oknyUy5TCtyLcmLrDTx
         V3w3jxLCmjKWDaz9g14M0LJuwOMpTLBsMI2xVtq7uPDxHccCjyBhBHyTP+sOqlT5SxWU
         /3H5/k9/UYv5G1HBeMc4BZZGM0cLC8mubc9UbrIbDALWNWdnNBRm/Va3VYfD03NSEers
         jXVfCE/Y5K2YkKadS6kt5GODdPi67WNRje72NvlpAMC+m5MN7BpDnzMsMtKfr4xKRhu5
         Ln7Nmrf0BXIpp1GNuRHrKzxRhgUUIh2rQlaJJg1v0IW99YScjMvvA+06Y07GeKrZOkox
         65zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=OYIHO1E2FYttMwneu+ZKZ5RJfEzIKDHgu84G5IWf0uw=;
        b=aN7CYVvPRY6HkIBHzsdF5v+RiEGewCa+FlfzGbcj08G1PjAeLdrFQ8nNreTsTO1mEW
         nLl1MQYHzSJmXYUi2Zcg0rd7kbLQcULPBYC/5GvkXnpVRN+2FMBDwJzd0ZVkKrGgiJhX
         05l6Op0Rzrx/Xk0Q9V5XeIV++wcCZR2K3j5OpULvjg8MlA+4wAYI22H6zJoSY41A2R2e
         feYgNJ96Af1Zd7jwYK1/mFgEaE55pDdE/zVf+Tx3re8A5AoQESgoUrBlLp6p+s6/+/0m
         WpoZZtKO0jRtJVE1FSx6qmI5MAsB0NkLUABtJv0cKtOPZ7OZ6Zp7rc1TazwDiNJM7I3I
         hYKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ng+NEvJa;
       spf=pass (google.com: domain of kernel-hardening-return-12987-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12987-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ng+NEvJa;
       spf=pass (google.com: domain of kernel-hardening-return-12987-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12987-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To: willy@infradead.org,
	keescook@chromium.org,
	mhocko@kernel.org,
	corbet@lwn.net
Cc: david@fromorbit.com,
	rppt@linux.vnet.ibm.com,
	labbott@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 2/6] vmalloc: rename llist field in vmap_area
Date: Fri, 13 Apr 2018 17:41:27 +0400
Message-Id: <20180413134131.4651-3-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180413134131.4651-1-igor.stoppa@huawei.com>
References: <20180413134131.4651-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597638726714823934?=
X-GMAIL-MSGID: =?utf-8?q?1597638726714823934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The vmap_area structure has a field of type struct llist_node, named
purge_list and is used when performing lazy purge of the area.

Such field is left unused during the actual utilization of the
structure.

This patch renames the field to a more generic "area_list", to allow for
utilization outside of the purging phase.

Since the purging happens after the vmap_area is dismissed, its use is
mutually exclusive with any use performed while the area is allocated.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 include/linux/vmalloc.h | 2 +-
 mm/vmalloc.c            | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 1e5d8c392f15..2d07dfef3cfd 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -47,7 +47,7 @@ struct vmap_area {
 	unsigned long flags;
 	struct rb_node rb_node;         /* address sorted rbtree */
 	struct list_head list;          /* address sorted list */
-	struct llist_node purge_list;    /* "lazy purge" list */
+	struct llist_node area_list;    /* generic list of areas */
 	struct vm_struct *vm;
 	struct rcu_head rcu_head;
 };
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 61a1ca22b0f6..1bb2233bb262 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -682,7 +682,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	lockdep_assert_held(&vmap_purge_lock);
 
 	valist = llist_del_all(&vmap_purge_list);
-	llist_for_each_entry(va, valist, purge_list) {
+	llist_for_each_entry(va, valist, area_list) {
 		if (va->va_start < start)
 			start = va->va_start;
 		if (va->va_end > end)
@@ -696,7 +696,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	flush_tlb_kernel_range(start, end);
 
 	spin_lock(&vmap_area_lock);
-	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
+	llist_for_each_entry_safe(va, n_va, valist, area_list) {
 		int nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 
 		__free_vmap_area(va);
@@ -743,7 +743,7 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 				    &vmap_lazy_nr);
 
 	/* After this point, we may free va at any time */
-	llist_add(&va->purge_list, &vmap_purge_list);
+	llist_add(&va->area_list, &vmap_purge_list);
 
 	if (unlikely(nr_lazy > lazy_max_pages()))
 		try_purge_vmap_area_lazy();
-- 
2.14.1
