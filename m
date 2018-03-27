Return-Path: <kernel-hardening-return-12747-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs4QqA62thsufcyFyHBftSi/qVHEzAk5kwXKs3XHwkIIsUdQcREyOX6lsFYJqbmO9sAKYXa
ARC-Seal: i=1; a=rsa-sha256; t=1522115812; cv=none;
        d=google.com; s=arc-20160816;
        b=eq1JoO1L4v+PiipvWOBdhm7NlpXdup+DWxtpXLswGoDTIP/3QnLzH3uApddqqt3SG7
         t/t8U6R2X62hybslrV705l6V12hw3bIXJBan3C4tBLH0wRqCr/BQRb0vDyN+1yr0Hfdh
         dhKg50+Ro9cO1YuRDlYIbkTEa9+57X4SCCC+/T3lFGVm9R4b9ps91y+aSZjtb6JB5AFt
         aAhAIlwDcDk6j2zdyYoV+02nV4u6FNKMadyFN636HrbgEPf8vP4Cv/gPvGHynxGgcLLr
         D6f010J014SmUJdBxoO8+IWwpMhiDrewbq9Z7ZZYE5gkNHTlIHOycD4z8VyNk19reDDA
         FiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=OYIHO1E2FYttMwneu+ZKZ5RJfEzIKDHgu84G5IWf0uw=;
        b=HsUgwd4jC3cDNPVizpCaw5TSsETJYhQDZiaiYJtZE4p/xeInk4LOJ97pgYycPyBNfr
         1b44N5jFO9OpuHCia5OPag4iWF9B4Yf4MrU7BPbkEbdjaLupVwt5Nh1FrS6sneJVO8TK
         DylulWbt4dOw7uGaGKPeYXXPTQ5ytP7jqNOYxf0VG+6NOdhXG3+Q/O1xuXgqlLbWGp6v
         pe39YwlVEUnaZ9UYc70wTgfNDxZk3dxFm343vsmakr6n/hWhHC4tcLAAqPm9SsqapstB
         G3buc+hErRpEeCfottfzU/eaIIMsWxaBUcq+KJlpkz3bbpSI+l5rihsQq6YNPKVl6khJ
         UqDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12747-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12747-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12747-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12747-gregkh=linuxfoundation.org@lists.openwall.com
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
Date: Tue, 27 Mar 2018 04:55:20 +0300
Message-ID: <20180327015524.14318-3-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327015524.14318-1-igor.stoppa@huawei.com>
References: <20180327015524.14318-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596054110088397530?=
X-GMAIL-MSGID: =?utf-8?q?1596054110088397530?=
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
