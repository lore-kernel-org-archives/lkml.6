Return-Path: <kernel-hardening-return-11565-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x22496cN2AFpRiQW8QzuX/wV7BrSjrqZUQllRhYESA48C7DFFydNwsKb6b4m3vJ8jkmZl76Cu
ARC-Seal: i=1; a=rsa-sha256; t=1517687065; cv=none;
        d=google.com; s=arc-20160816;
        b=CJV0cMHlXwflFnh6F+I1Bxd6mBOOmNMWohMf6zIGm3Q76WSlEvIh3+p0OFGs1tXeCi
         HzkWMGhBoLQM7qUYjSFdXe/mSl9VFGjCNTJ5NuQT6+TnTfCLZ3e6xACCi2wWllNI8f88
         ZAqx8gtXrPCgTslsW5U3Mzj1T/KBFY8dmK+WxBHe6ArSeXk9H51bVSfqFXmeKa9TsI/l
         hxfVuQW+sRFN+oLhWmGSiknlweyFue+VR7kOfbtSktAO7yGGJSWHS5gE7de78jO/adKC
         mB061I21NfJVQ8/4U2dyA4x1LByHRJRZVH6xGrQIso+EWS5GOJTbH9/ppElrfyHKgTpv
         z+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=GQb5G9RwL5C66VIon6xkDpjmUFYjHTJ1l1QWQZfuOGE=;
        b=KL5P38KmZP9U3S9DOvX3UtYrQS2wvefocR96ro0FvNQNfBRQU9r7msqFDNVRbp4klY
         htKad0PzqgDr2aeTNl6MmChGrubGw4iNPgci8Y4p04lFvXWXIlhD2jcQJcdzepDKCCuK
         TkpD9eBBiSbpPyweL+6Ih56UDlPO8STq3Xan5qLPEL5Y4btaaoS6LDEa95DDr4u8iNKd
         jiIrS4AZs1dx+DYxMdH1GtOO275DOzHt9bQ46hz/hYMK81v3LRo9AnAzYTdlSPRCq4/a
         FWTIXnVQHM7xzgvbLDVkZi71k4/4RNb6P2ptvIfjvmlboAPnku3iaVBPkZu7oJeTTkLM
         yd/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11565-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11565-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11565-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11565-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <jglisse@redhat.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <hch@infradead.org>, <willy@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 3/6] struct page: add field for vm_struct
Date: Sat, 3 Feb 2018 21:42:55 +0200
Message-ID: <20180203194258.28454-4-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180203194258.28454-1-igor.stoppa@huawei.com>
References: <20180203194258.28454-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591031026595146297?=
X-GMAIL-MSGID: =?utf-8?q?1591410232603028194?=
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
index cfd0ac4..2abd540 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -56,6 +56,7 @@ struct page {
 		void *s_mem;			/* slab first object */
 		atomic_t compound_mapcount;	/* first tail page */
 		/* page_deferred_list().next	 -- second tail page */
+		struct vm_struct *area;
 	};
 
 	/* Second double word */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6739420..44c5dfc 100644
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
+	unsigned int page_counter;
 	void *addr;
 	unsigned long real_size = size;
 
@@ -1769,6 +1774,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 
 	kmemleak_vmalloc(area, size, gfp_mask);
 
+	for (page_counter = 0; page_counter < area->nr_pages; page_counter++)
+		area->pages[page_counter]->area = area;
+
 	return addr;
 
 fail:
-- 
2.9.3
