Return-Path: <kernel-hardening-return-11728-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224L+bERDExapK6yAsGEgWEJvZON/3v+fK8CNQKgQRol7lyZ9E8xhmpJRTG1zMDJsIRLSwkV
ARC-Seal: i=1; a=rsa-sha256; t=1518454529; cv=none;
        d=google.com; s=arc-20160816;
        b=e3jrLOj56v+9a6VtVSpMLlg3AJFVwoE3nIdfT/9FPayTwzogBPS+EAy771zL9F9jLw
         Vz/uU2rDYaVKbpaCdCQHILS6s9DsE6DVhghWEs77UQ13wTA2MLMUyeAFwJBQfVOjQvbx
         9WRzcz0jFPEx8eDwmiclalScrc1+HDQImgWpxceEHNywNDUOS3beszUlwEZI3w/zftHW
         tEJk4+EWnpMCeGPAUBm4XdryMJM/GiTj9GgY+W1dagOkcnVq72QJYOKxcLyPGa9+1j9r
         Y83mOTxp9BhNuYhknWatDDt7HKVAAuD0ksrGyyatYS+x0SV4FXObSSIXpFLWQMpwuC1x
         huHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=MQdgs6ujP7LWDZGNv/WHuQlAySLcoOwNL8AuKWrbq/c=;
        b=NP3b9WE2aEeHxZJF6S2VcIUHYISH/No+enJ9FkMslEjLn6ECv6swYCfoe2GjfEY4CK
         G5Pkzu5JdkMKNFYnJRv4Xa5Fq2mXtpM2ip1PXbuFtpp4ESvINb8gDJYU7YaSdOg5AG9B
         LTomn3C7PqqC2Ks0ErbwybapT/U3/4mP+00Xqs8sEkNl5bwnqeWXPW2KbeD92c/lp8/2
         YDeRiyCYeVulqJ+SCtjXOrP/K6448kEOvsb04TKjop7bzQAtzRiFXLKc/r5cqbec8RlF
         dViQC5ETaY2sc8WviXeOPVZfj9lTtOCb6FM/nLPyaVHCnxJdEGU5Yb7rHkpIAb8F1u/5
         2bmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11728-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11728-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11728-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11728-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <willy@infradead.org>, <rdunlap@infradead.org>, <corbet@lwn.net>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<jglisse@redhat.com>, <hch@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 3/6] struct page: add field for vm_struct
Date: Mon, 12 Feb 2018 18:52:58 +0200
Message-ID: <20180212165301.17933-4-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180212165301.17933-1-igor.stoppa@huawei.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073184128407406?=
X-GMAIL-MSGID: =?utf-8?q?1592214976981334748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a page is used for virtual memory, it is often necessary to obtian
a handler to the corresponding vm_struct, which refers to the virtually
continuous area generated when invoking vmalloc.

The struct page has a "mapping" field, which can be re-used, to store a
pointer to the parent area. This will avoid more expensive searches.

As example, the function find_vm_area is reimplemented, to take advantage
of the newly introduced field.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 include/linux/mm_types.h |  1 +
 mm/vmalloc.c             | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fd1af6b9591d..c3a4825e10c0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -84,6 +84,7 @@ struct page {
 		void *s_mem;			/* slab first object */
 		atomic_t compound_mapcount;	/* first tail page */
 		/* page_deferred_list().next	 -- second tail page */
+		struct vm_struct *area;
 	};
 
 	/* Second double word */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 673942094328..9404ffd0ee98 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1466,13 +1466,16 @@ struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
  */
 struct vm_struct *find_vm_area(const void *addr)
 {
-	struct vmap_area *va;
+	struct page *page;
 
-	va = find_vmap_area((unsigned long)addr);
-	if (va && va->flags & VM_VM_AREA)
-		return va->vm;
+	if (unlikely(!is_vmalloc_addr(addr)))
+		return NULL;
 
-	return NULL;
+	page = vmalloc_to_page(addr);
+	if (unlikely(!page))
+		return NULL;
+
+	return page->area;
 }
 
 /**
@@ -1536,6 +1539,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
+			page->area = NULL;
 			__free_pages(page, 0);
 		}
 
@@ -1744,6 +1748,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			const void *caller)
 {
 	struct vm_struct *area;
+	unsigned int i;
 	void *addr;
 	unsigned long real_size = size;
 
@@ -1769,6 +1774,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 
 	kmemleak_vmalloc(area, size, gfp_mask);
 
+	for (i = 0; i < area->nr_pages; i++)
+		area->pages[i]->area = area;
+
 	return addr;
 
 fail:
-- 
2.14.1
