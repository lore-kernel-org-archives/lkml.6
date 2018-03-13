Return-Path: <kernel-hardening-return-12556-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs1IhJF5xyRAnNjJlIPFb8/QpZ9I8eK10esWuIVI9jOqVktQMl2i3ZE+5s2W5EhWCFuuuRg
ARC-Seal: i=1; a=rsa-sha256; t=1520977862; cv=none;
        d=google.com; s=arc-20160816;
        b=t+nfSwC6TDh1T4JMikzvp7RseRpPG7uXi4V3vNqtQOrGW4HXz2g+PrCSUMBEXcdupr
         7hQkIpjJdtfVqqcGM3GZifgSeFHKY6VKTOamAKGGxtRPn9iVteYNA7FI9w+votV2arcO
         16JH+XL3YbW5gQI+0QKS3ArIJJgupBRn16jz/miBlutqqNWqNOss1/jncPKT3mn9+tQn
         EylPuucV7zy0GmXoBFCXYLLAt2xYQltEgbfkxXpnaVbesW544OiOpVIDbPxteEIiY8d0
         0quTqSrM87Xk9EeCau2WbW8B1v5f+9vNLxCzVjCDpc3OzX01n/FfRvD8V3BucvCBqRdt
         OgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=0ZPkcyfim2K9mLs2OIErsKfhv9YVlWEcOMnBP2fHwcA=;
        b=I/55a7uFu+l0eKy5QPAWFlMMg79uTvFsnwPr/vRQJpqKSVANzKn+O3bmeCVs2mTrBp
         D/CYQLPxRSZMuUE9fjyFddG0N/3Mdy/38VcT+PS24tqp+HF3LGhKlXXHBZxx/SZoRR9A
         VSyf+8QNQ0E9K8+0fOXuodhc7JtkaqA1rEn+CMq2yDye02JE+8Sz/CuV3YXCAQfNXmxA
         AFWUTFK0XLDrPSUj4dHRa9vEAfDfB/Vr6tQTwM/nl47569HPkaKP0EWq8Vr6Zm9ysEUB
         J8Q/IP+XTsVug2WdHiM1DulmX9Mia1nA2kvx7o8JicRonhMwcKrrNPkdlJEFHcicT8r3
         43aw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12556-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12556-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12556-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12556-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
To: <david@fromorbit.com>, <willy@infradead.org>, <rppt@linux.vnet.ibm.com>,
	<keescook@chromium.org>, <mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>, Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 4/8] struct page: add field for vm_struct
Date: Tue, 13 Mar 2018 23:45:50 +0200
Message-ID: <20180313214554.28521-5-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180313214554.28521-1-igor.stoppa@huawei.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860882497845479?=
X-GMAIL-MSGID: =?utf-8?q?1594860882497845479?=
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
 mm/vmalloc.c             | 2 ++
 2 files changed, 3 insertions(+)

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
index ebff729cc956..61a1ca22b0f6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1536,6 +1536,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
+			page->area = NULL;
 			__free_pages(page, 0);
 		}
 
@@ -1705,6 +1706,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			area->nr_pages = i;
 			goto fail;
 		}
+		page->area = area;
 		area->pages[i] = page;
 		if (gfpflags_allow_blocking(gfp_mask|highmem_mask))
 			cond_resched();
-- 
2.14.1
