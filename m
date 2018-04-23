Return-Path: <kernel-hardening-return-13090-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48Ww16tIeI8/L+XQdd0lKTEsRVan+yJKUbCcc4popmzKqyBIL34PJzq+q8QgCgXhlcshNak
ARC-Seal: i=1; a=rsa-sha256; t=1524488177; cv=none;
        d=google.com; s=arc-20160816;
        b=p4ctZfvV6635RHqTuMqybgeOiEugtasIzZ6dWi4un7G3aEOBcNPm0fcy41tFhRZuvH
         zRaZRnZh/shp5LmhVGixkuh/IVSnmrHU/3LgR6XocPoVIrZdhWVWuw+tHqR5PPrHnSe3
         1+K00PCv7h2yaqBmKrYIxy/7kNlghmmd5/gNQnd9qDKAbzXR9mbJ5Mb0o90WozjrPf09
         z8B/1iZSWQ5hyGssRCPQ6H6yAWGrzPCKIsjLQKK9U9b8V34k5kmrwg4rt68b5KPnjLiu
         keNrsRbnSOMhcuAicjTw4rI++hCRBg2pUXxUwQc8ZRSW/sXFB2+AeHBiaYNOLF8UGBI+
         vGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=OYIHO1E2FYttMwneu+ZKZ5RJfEzIKDHgu84G5IWf0uw=;
        b=1JKnYn47x8bZUQBjUjFeTDu+Vtx6yWBCC02cV7UKuC5SJ5/WJbnVOj5r0Am+vr5fHS
         FB19en16YvhI2ve6eS/eepMd7nR56z9tg/oin7fk06ObwZGhoVS8oUeKkYQkii1vwV3g
         R3Ye0lPRtzlFgU9aLesMW1btzhrHc/6O1iZnEKfB9PLerotUZrVFUgxJFC/574TgdrSe
         CZdPrNyHjMmmTMEP4nYJXN052J30DVPDSkOjqsxrTHbeH/exdB4XD3MueBi2njPPz33x
         UdN1PP6pfnipVLltVMcZsB6+IhWaa3ndTE+IHF4ZNbbKozxA7dkUAW+sazPY06tQ4fb5
         FxjA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bZQvmXOv;
       spf=pass (google.com: domain of kernel-hardening-return-13090-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13090-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bZQvmXOv;
       spf=pass (google.com: domain of kernel-hardening-return-13090-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13090-gregkh=linuxfoundation.org@lists.openwall.com;
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
	paul@paul-moore.com,
	sds@tycho.nsa.gov,
	mhocko@kernel.org,
	corbet@lwn.net
Cc: labbott@redhat.com,
	linux-cc=david@fromorbit.com,
	--cc=rppt@linux.vnet.ibm.com,
	--security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	igor.stoppa@gmail.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 2/9] vmalloc: rename llist field in vmap_area
Date: Mon, 23 Apr 2018 16:54:51 +0400
Message-Id: <20180423125458.5338-3-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180423125458.5338-1-igor.stoppa@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541715433898811?=
X-GMAIL-MSGID: =?utf-8?q?1598541715433898811?=
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
