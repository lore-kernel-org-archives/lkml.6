Return-Path: <kernel-hardening-return-12768-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvL4DnB8a1IPKhbY06cJ/t6cnr8I5jO1ImblWxsKm96ZJdhaTCouGZPuMQfWC6ZVSU6qzNn
ARC-Seal: i=1; a=rsa-sha256; t=1522165201; cv=none;
        d=google.com; s=arc-20160816;
        b=LB/yvDAqmsHngUm26X1UW5uFuCSqn0zrqWqogkvdnb7DMNW2GO2YwDr8ZORPy74rCQ
         Ki8FJ5r2M85h9R8KOlN9P5O4GoBQA8LMZ9anuG5Nhf8vXC/Aq4hapxbsz246QLzt2qII
         htqaqg5ciKq59OJMcTxFgPX14fplXCQldPwMD7kNSG8g8UbaAZQNZLFj13UwQazmzTsN
         BnfhTGdux8khsPmjBBWg6bi986nc+ugORYduo4k6CqzrTvgV+UaF+AptGEGzLeL2TOWN
         8ezBsOQInxbTh7l+YHsgTxoW8etxSQtBIo5V+XwjnR3B5tXxECF8VCx7y2B4nFts3XXI
         6rqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=OYIHO1E2FYttMwneu+ZKZ5RJfEzIKDHgu84G5IWf0uw=;
        b=REStkXFJR/yDApzgMEfh/3Pmz0QxH259aQ8Dl2XMCOpCwZr1piUrx9FEuT7QkcXf4F
         TaZ//rSyTZbGMCsi9WfEeNW6DlMgLT5jWkUTgonI9WviOkVJXhAR6sxwQylohtZwOCtW
         PCpAVKL+skQGGSE4IirRjQhBKV7NMgpWoLziC9KpsyM84W+ztKuGWI9CxWQWmk34TSy7
         uAcXY7KDVZyR/Vx8w7T5pXWy5WHr4kvhI/It6JEX2hL/AWZNwWjGUMKYx1tm0tPySC7l
         ss5z26AyIblUzlmWFpkER3BZzLugUOzpS/dnEX1px/6zukiSgH3zNP0zdyS8R87WqDsw
         s5/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12768-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12768-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12768-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12768-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>,
	<igor.stoppa@gmail.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 2/6] vmalloc: rename llist field in vmap_area
Date: Tue, 27 Mar 2018 18:37:38 +0300
Message-ID: <20180327153742.17328-3-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327153742.17328-1-igor.stoppa@huawei.com>
References: <20180327153742.17328-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596105898073233516?=
X-GMAIL-MSGID: =?utf-8?q?1596105898073233516?=
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
