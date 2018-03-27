Return-Path: <kernel-hardening-return-12767-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuyufApn75quQ1S1AAWGfWD2fei/hYNsBU8VWkte31EORCahrb+d9bGVbAD0SiEnnTZCWmz
ARC-Seal: i=1; a=rsa-sha256; t=1522165158; cv=none;
        d=google.com; s=arc-20160816;
        b=aoR8o5xypATBzHRhWVp8Kv/cSNCx+ZUiStqecmW7I1seF83JqPPu3eyfIchuml6psw
         2RX8PmaJu9YuO50vfy8knxXoBNpM2A7BkYvqRPBZCkRqo1MykhkOF1jwSo/FitLgO8nB
         qXrrryKmZBfcL8oHz2kfqceEoPBFOm0/FO/1mLAH3dR0kEmUlHbNDcWB631E2rladFCX
         KhXMZIOlqkPuqRL3Q9vwwBbp68BmNgoq/3vlfCDMcXmohReoFxUiSN+GYGZNQ3dCuF0S
         n9wfzdYb5AR5wYA/rvD2RvLMU0Nb3tJR9AxFZMD5oNQ+yWtRINnvnuYj1hZcuLZJmGIL
         B4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=mGM+7v4xVS3k0Tk3Ep0PWpElsuoh2K4CsHpwOqlMKxk=;
        b=S90UbMaZAHKEoaJd+1Zgl/Mow9gvVrLxbKQBa/CTk0zyj/4KXqSFZKGuR+c4G4YSn1
         yvHeEFBkADCixcejVyxu9Uemu8WF2p6eNArp1H+dkidSAi9Ko8qenTpNtqvVThWu+6jZ
         l/Y7aYhBfJEUumIpdoQg1opvuZ0zN/f/T6Gq9rNC5TbNKeQMm4H/q2KdwiXy3O/6ncUZ
         L6w6Qixb7tIHxzhIFdY4VtjFd1FS1ta+n2XaSEuzUCfY+5E2+WXs7v8Ep8bWYt5My5fY
         1t0jpXoomEnHbaPf3J8YDcZNC8HyOYZdCPyxkwhRJ0UvEo1Z/h53RYPYL/8CAZw6rt4C
         3NKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12767-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12767-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12767-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12767-gregkh=linuxfoundation.org@lists.openwall.com
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
Date: Tue, 27 Mar 2018 18:37:37 +0300
Message-ID: <20180327153742.17328-2-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180327153742.17328-1-igor.stoppa@huawei.com>
References: <20180327153742.17328-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596105853195690527?=
X-GMAIL-MSGID: =?utf-8?q?1596105853195690527?=
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
