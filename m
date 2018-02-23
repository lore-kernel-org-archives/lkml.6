Return-Path: <kernel-hardening-return-11921-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvuHHSjAimFJ4RAJCJsCuvxuvf4y6yKPtCsjxtilsjko+h9KzekzgabZ3Zq+tjp5xGJ1bCf
ARC-Seal: i=1; a=rsa-sha256; t=1519397451; cv=none;
        d=google.com; s=arc-20160816;
        b=JcCFXILpubmX5zOTke1KQVIGcR6WfoWUrIJIKfJ/gV4GZFzSv20F6PkaORZxGpt+aa
         Ujkjc5wBk9cHGC5XgRM5KFDHF3pmI15P3bkAT+QXDq2F+g/7bhiZxNcNsGR4z+tKYVBt
         LiuEBkoz8T95smuCWf1QeW1aJQp9IMVdiPZGaV64RHyEUHVY4sV0PtqMGbBk7OA4L0ZL
         /topOCSot6MpXFkOJjbTyrIBJ2hCVrP88aQpartACokYGLw4LvjHsOKQT1O3X1YW21T8
         GMF7Bretf0QyG07/v6R4KMEsoaqdBvemCrfn5wguQqTl17WkkrFWrqZ0JzqkzlW0ix6t
         beSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=yKdl6MhVWb2FNujOe3mQuq0D1OlBFAmrIWxlwtnp5bk=;
        b=MlTXNhX9z6IRclAdJybDfByEi2W8+HSNflOMrt8bmqVs0U0bMZHDQSqFKq62udtGYM
         3JJk3wbh0ktBUurBB3ldor+GsygfgRGeZPSCVAy8IRwDrldUZYVZevw4nCeRX0QPupw+
         T3FVHjgwUXMiIvZHkvN2WBY9gU4uOPNrOIufN6U+gILnPodzyLUkrv+tn3h9+NkO2iDI
         00eTJSqsbSZPzEDANeVrHFFfp/sdrqkoLHmeZ0Wc2FfttRPImOjrDJUhVJoGI6Crf5ZN
         8I6bmG1Q65Sz9o393dmRe7bbqMadO1DNPUOGT+it+UHmw9BxUt+AckNRW8dce54CaCCn
         P87Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11921-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11921-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11921-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11921-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <david@fromorbit.com>, <willy@infradead.org>, <keescook@chromium.org>,
	<mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 3/7] struct page: add field for vm_struct
Date: Fri, 23 Feb 2018 16:48:03 +0200
Message-ID: <20180223144807.1180-4-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223144807.1180-1-igor.stoppa@huawei.com>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203701882872070?=
X-GMAIL-MSGID: =?utf-8?q?1593203701882872070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a page is used for virtual memory, it is often necessary to obtain
a handler to the corresponding vm_struct, which refers to the virtually
continuous area generated when invoking vmalloc.

The struct page has a "mapping" field, which can be re-used, to store a
pointer to the parent area.

This will avoid more expensive searches, later on.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
---
 include/linux/mm_types.h | 1 +
 mm/vmalloc.c             | 5 +++++
 2 files changed, 6 insertions(+)

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
index 673942094328..14d99ed22397 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1536,6 +1536,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
+			page->area = NULL;
 			__free_pages(page, 0);
 		}
 
@@ -1744,6 +1745,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			const void *caller)
 {
 	struct vm_struct *area;
+	unsigned int i;
 	void *addr;
 	unsigned long real_size = size;
 
@@ -1769,6 +1771,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 
 	kmemleak_vmalloc(area, size, gfp_mask);
 
+	for (i = 0; i < area->nr_pages; i++)
+		area->pages[i]->area = area;
+
 	return addr;
 
 fail:
-- 
2.14.1
