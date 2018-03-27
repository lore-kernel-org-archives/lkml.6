Return-Path: <kernel-hardening-return-12746-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuKRgOxUS1Z8yo48b2xhBmrAoK1Ztu62m3gsHcEuAtgwwv2xeQHBDkKWx0BRHRT0UWb18+8
ARC-Seal: i=1; a=rsa-sha256; t=1522115805; cv=none;
        d=google.com; s=arc-20160816;
        b=km8eer1IorH+Biu0L/a2yHp5dnvK43wmnCEuO2mlQgpCMErnweMk+8I7rCKt7WtWMl
         B3F5Dl+Rdh9UKhrIFCJC/yNMgLgulxEJRQds3MUjqRQfZdOTUdV5UYDQNm12qO1Bf9Sd
         Y2Nxiys7zyFOfA+rohmeXlZoLyUW6sdidBtTpIgnbKXUSzKHHhgbUtGd1MlWUXhNh/WN
         RkL8w3YL/Dq70mxtxnXIhwlVuRzSlqLV5ce1EejII6yzC4cokCsiQMwc+AozQyOA7vSH
         LSt/pPQrVOXU/EqwxbRFFpnT/dbYrOboBgsECmPOjQqrHFVnl13i7x2njEj0duHfQ3YO
         2vLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=mGM+7v4xVS3k0Tk3Ep0PWpElsuoh2K4CsHpwOqlMKxk=;
        b=ID5m1kF7cEKyZWIVNWRktpPgmQUp/94thWMbZnbBYOSXdjeJg8YqXIDceSQn8a+gjc
         jxhPXsAHanfQNM9wAxWyTihAZsBWYXvO0/LsRCvb+/wng2DB/SlGaLyv0GlmiXhQRZoD
         5YIjkuIO1+8TfgRhF35Mt6DwfzAthiawpLU2w3gO3b22V4IeQZ6b9nLb9YB1v4A7C3Df
         t4OKZhOCZD0NWUgkOz4YIiJqECdsePEKJXPOSYh4bTOaSa+uVHcGCuoupabmcySY3CA8
         YuHNaN/HrC2SW6ZRZajX4nxzvl0T9oce9hm3raBmSaKIZlyCT1XHXYzBBQS6iPR5rXs7
         ZWAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12746-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12746-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12746-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12746-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCH 1/6] struct page: add field for vm_struct
Date: Tue, 27 Mar 2018 04:55:19 +0300
Message-ID: <20180327015524.14318-2-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327015524.14318-1-igor.stoppa@huawei.com>
References: <20180327015524.14318-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596054102912654020?=
X-GMAIL-MSGID: =?utf-8?q?1596054102912654020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a page is used for virtual memory, it is often necessary to obtain
a handler to the corresponding vm_struct, which refers to the virtually
continuous area generated when invoking vmalloc.

The struct page has a "mapping" field, which can be re-used, to store a
pointer to the parent area.

This will avoid more expensive searches, later on.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
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
