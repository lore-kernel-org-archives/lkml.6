Return-Path: <kernel-hardening-return-12986-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+a2VYzImznOBRtXxRGM4ZSRyauiLEcKfgb0RfOXfhCRA7dcSzEW1KWmsJn5pVswpfEAT02
ARC-Seal: i=1; a=rsa-sha256; t=1523627002; cv=none;
        d=google.com; s=arc-20160816;
        b=tELXOyvq3E1iUHWSi4qN9508BkiGy4T1tTfazUbZDM2arXoI9kGfanvIvhj2aLh7tT
         TzMjUiFWCYRWHelt9gpH/7OAd0aTVMM4SDGQ/M3CphY6UVs2Pvr+p/SF/zCUYK+EH+If
         lQKvwgRKRSC4fpHULYXJM+Vz7w3ozBiC7AM/FGA9C6H4Xya2HFr19qVXsIjBZtIddu9b
         njqglFlJfYhc3JWg8YStV8OL7dNGAmAUVeJPqiB16AnrDcG8hG3fNf64d2CvFOyDDMrF
         mC9OiWLMGKHNFQhiydqHnx/3elcOyfIu0lCT394iTOS/QnT3R7OE6cHDQZpuIPmIcbo0
         6k6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=EibkUN8IJIqpJJK5IsXHteb/ZHMrTxt39Z45b4pq1jo=;
        b=cqjLUiTUw5Or9Vy99fudtvOjuCiJGyucTvvVhvCXAiZjSPgDVJkVbyJaJ1GTrOPdYt
         1pJFkIzoohe3V7QhprCHwCTs9NxBlNFnfqWR5UBTybjcTMDd0fHa5oBuZwk+AhK5w1hp
         EA41HsiPunbEVpnlcbWJxkhSr2FchEI/+B2+f/lvSQuxURb0h/bW+hQ2BNuCM01J6Yeg
         vVeS0PDmafvD5XPnEnll+fc+UuzrywKRj3FfWmoMr5vBFbSI0iMaOG5ghqA3cVIxgA6d
         x0uN/usLeDiqIK/URwQhBbcJXGNGbNjwhiG8KDIyZNaRoOCG1FqdXdqv9gA3GvNUKWVv
         vguQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iVVMelf7;
       spf=pass (google.com: domain of kernel-hardening-return-12986-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12986-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iVVMelf7;
       spf=pass (google.com: domain of kernel-hardening-return-12986-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12986-gregkh=linuxfoundation.org@lists.openwall.com;
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
	mhocko@kernel.org,
	corbet@lwn.net
Cc: david@fromorbit.com,
	rppt@linux.vnet.ibm.com,
	labbott@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: [PATCH 1/6] struct page: add field for vm_struct
Date: Fri, 13 Apr 2018 17:41:26 +0400
Message-Id: <20180413134131.4651-2-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180413134131.4651-1-igor.stoppa@huawei.com>
References: <20180413134131.4651-1-igor.stoppa@huawei.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597638707642006626?=
X-GMAIL-MSGID: =?utf-8?q?1597638707642006626?=
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
