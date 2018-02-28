Return-Path: <kernel-hardening-return-12049-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsZ4VSeEUHHRFVlSOQZGTm3xJJCrZmo1ToOVjQG+7XhcwxfbTjRztlYyNpEp/Nq036ez5+t
ARC-Seal: i=1; a=rsa-sha256; t=1519848523; cv=none;
        d=google.com; s=arc-20160816;
        b=InXQeOckMFEDxFlup2ncQfsmePiJMdfAmZp5+Dqt/99EX/eaj4oneuPQEh7U8agx40
         8/rCrlfglFNelDrS/WJwC+YzaEztLQFy5vI4uqqQOA+DbSuUAeGxgqLDxGtw4qdFNhV+
         tjLZ6wTNE+0BmAhswElhW6WUYkI1yKVJz82PWJgd6VcZM5yceSO8SIcAWutHFe5EaJc4
         66zwhuNKzSg2u5SGO0+RRYU2wdA7T/+6eHDJKoSCyBfOMyOe5kxBSkZ/hsDXlfsfjoAn
         81NfoQCZllTB43gbGAc3z2qEHgmcZ7XifNTYDC+QAnp9YQ6K/tk//XCU+BlHmlHa5PO5
         S4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=0ZPkcyfim2K9mLs2OIErsKfhv9YVlWEcOMnBP2fHwcA=;
        b=z5A/KzV8u0dEnW6UpLIjcKX1CLrmoP9XLdw7hisL4DXcLoi8Gp37p6myqWD1Nr5yby
         9w1019ABGF7uuWHeReDVuQx4FOTMtLeYS5jiTTmdJSVAe7Arw1H7trxurfuopwmp9Z+W
         OGVhI7cqD9w2vOnBRIzOpWygi04rJU2PUwqbcDODM+Hs2CrQhbP5vYYWFw8iEYZLPbEp
         wKeZ9I8/C4DL1RPYMHDxMeZaGXG6iz6oI6uqe/noxWsLqX8BOxyxH8eQlxZFb58BiBS5
         X5BKVFoXvcO7eSV+3vMBLxxMRgukBLWh0s1EAeILZZlFlP0O919AFGqVtT05DboW3mpI
         QCAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12049-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12049-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12049-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12049-gregkh=linuxfoundation.org@lists.openwall.com
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
Date: Wed, 28 Feb 2018 22:06:16 +0200
Message-ID: <20180228200620.30026-4-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228200620.30026-1-igor.stoppa@huawei.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676685422778336?=
X-GMAIL-MSGID: =?utf-8?q?1593676685422778336?=
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
