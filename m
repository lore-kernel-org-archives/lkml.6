Return-Path: <kernel-hardening-return-13089-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrnZwwUzJvEi45e4SAVqo5BfoKAR9nU92GCk3yQs4bG45lt4m9EZNH4WU9RdBGIcJ9+nzJo
ARC-Seal: i=1; a=rsa-sha256; t=1524488151; cv=none;
        d=google.com; s=arc-20160816;
        b=L0yPY6TyOsqJ0kWx4EyecjY/rAYUGmycAucvS+bKuL3SyPdfLrv1HjgrhqyPWGe4QI
         YecSulnsgXFRDKwh+bUjqI5moXeyXqDfI+6eKweUZysOb9hv3eMvfZU3RWaKmxDChkdI
         qlTsvtkvT5uBN0Wd8XzPV8IocTfr0bPRFLGQEUFYTG3DT8BiG9YMHlIhz712wedgZcp5
         ZSphhQDsajq7QSLYbMCR8FM5Ml4bJt4thHBGDrG2vahLfm+S41SMFiiAVA4wkOkvAf1f
         7EdWjeFZhvmO+apmxEhDTxLv7BW1s587B3k/dHuE8oxOBtm8iKhgb7PpEElAgadBwmZ/
         t3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=EibkUN8IJIqpJJK5IsXHteb/ZHMrTxt39Z45b4pq1jo=;
        b=ES1jxmA2EpJIpNAn3TJVbTbo3JRM8c3meMYzSncpEd84/xZCvgFBp+hQEJWJsxNsX0
         ikF/Hjmzzmx9QDBHXJeMoP8DyAmgeJ03I5mitg5liAJIeI7SJvEYL1JICjGUNqBAb4R1
         aBtLc5wqIG++kHbtt6mFZrl+qe1nP3MdpMF2OsWPa6UV3aXZC5AVeHkM9k0P14wDVp86
         kaHugij5Vg9qSGhGzN67f4WNy4CDkEWER6giqg/wvfK+OU0woMctdT+DTxlHbLNUZmnH
         OY+X86QfFUPXPUJHyAOMMtMRrVQUxcjrmHKvEs8fi8Miho8Ir2YicOPJ8bxGgk1Y6sPx
         CweQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KJhnLgxc;
       spf=pass (google.com: domain of kernel-hardening-return-13089-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13089-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KJhnLgxc;
       spf=pass (google.com: domain of kernel-hardening-return-13089-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13089-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH 1/9] struct page: add field for vm_struct
Date: Mon, 23 Apr 2018 16:54:50 +0400
Message-Id: <20180423125458.5338-2-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180423125458.5338-1-igor.stoppa@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541687545170981?=
X-GMAIL-MSGID: =?utf-8?q?1598541687545170981?=
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
index 21612347d311..c74e2aa9a48b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -86,6 +86,7 @@ struct page {
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
