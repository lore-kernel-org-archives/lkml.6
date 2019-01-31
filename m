Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38547C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D1F218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5nOl1Zr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbfAaQZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:25:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33809 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387837AbfAaQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:25:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so3240467lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LikxHqRWe3hjXCb7z4Z2tQt/qnU/bnpFMlaXM+BoVok=;
        b=h5nOl1ZrqIDtZT5ELvlIWlWxX+VkQQvGj/ENOOkAh/20HMnikuTXkdjru37zdjcEj7
         7CakwLLnjlv5QJU7GhUSlyoMVxgaC5mBVPZ7R1WPCCi7EPZYy4ghniGfVUiBgMYc9pTw
         Om7nUSB8n39h31aqjbPLyn11T4LGTvfiWQuozCFMj9+2Jb/D8pAZhcUzfw7XrJtY6CTY
         bI6zK0lb4Oqv17oktO9wQoufGW6XgKJ/4MKcUZi4JdjEnVb4PiteH67JppZ4ytY1rowE
         vawQeP/J6oIdRUSaFFNEC+zVfHMav8WK4+peikRgXU/Tsdzdou4VREKoMstoQmRu17Fd
         wO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LikxHqRWe3hjXCb7z4Z2tQt/qnU/bnpFMlaXM+BoVok=;
        b=FO10krdpgnqNn8NrZril/i0yQMSjraGXOckeKqKEtpY6ZlqVef9KcNp/x2/wiNt1tp
         BpcfySViB648Tu305gEJvn7ZF0O8viQiJM01sk+FZzLNm/MILQ20iRAjm2CTm24LV2Ln
         2sQyY4frgI/3p+9RlzDN/2KgFYaT/O0cMeEBZ3rfFf5P6GEayFeESNQ0yfnR+Trm1b3h
         d6vSmJAj+qYI+kw4eC0DphyO2WLKRfZA4eehSHxUW7sdowxvAYbzg19Ijl/GN04b157h
         Bi5DYao3z3auriFuQnzjfg7XkUj7rtOJ7N6QfZyzCOYhzKCYb2qZ8mF+DlGiC0ci/Doc
         AasA==
X-Gm-Message-State: AHQUAuag+fZJXx8k0ACUlMV4TUYwoI2QLuHk/JOECSY7afh8vXQluTe5
        cMIKi6eK+Rq+Oa+f3Q6VygY=
X-Google-Smtp-Source: AHgI3IZHJRUGTh6+ZKgbU+SIwrVuiqL06s4+JNKdmR3XYq04b0qpQWQVV7+Dec7XRQKI99eaQXEXmQ==
X-Received: by 2002:a2e:8446:: with SMTP id u6-v6mr16709416ljh.74.1548951900903;
        Thu, 31 Jan 2019 08:25:00 -0800 (PST)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z6sm909595lfd.50.2019.01.31.08.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 08:25:00 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 1/1] mm/vmalloc: convert vmap_lazy_nr to atomic_long_t
Date:   Thu, 31 Jan 2019 17:24:52 +0100
Message-Id: <20190131162452.25879-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmap_lazy_nr variable has atomic_t type that is 4 bytes integer
value on both 32 and 64 bit systems. lazy_max_pages() deals with
"unsigned long" that is 8 bytes on 64 bit system, thus vmap_lazy_nr
should be 8 bytes on 64 bit as well.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index abe83f885069..755b02983d8d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -632,7 +632,7 @@ static unsigned long lazy_max_pages(void)
 	return log * (32UL * 1024 * 1024 / PAGE_SIZE);
 }
 
-static atomic_t vmap_lazy_nr = ATOMIC_INIT(0);
+static atomic_long_t vmap_lazy_nr = ATOMIC_LONG_INIT(0);
 
 /*
  * Serialize vmap purging.  There is no actual criticial section protected
@@ -650,7 +650,7 @@ static void purge_fragmented_blocks_allcpus(void);
  */
 void set_iounmap_nonlazy(void)
 {
-	atomic_set(&vmap_lazy_nr, lazy_max_pages()+1);
+	atomic_long_set(&vmap_lazy_nr, lazy_max_pages()+1);
 }
 
 /*
@@ -658,10 +658,10 @@ void set_iounmap_nonlazy(void)
  */
 static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 {
+	unsigned long resched_threshold;
 	struct llist_node *valist;
 	struct vmap_area *va;
 	struct vmap_area *n_va;
-	int resched_threshold;
 
 	lockdep_assert_held(&vmap_purge_lock);
 
@@ -681,16 +681,16 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	}
 
 	flush_tlb_kernel_range(start, end);
-	resched_threshold = (int) lazy_max_pages() << 1;
+	resched_threshold = lazy_max_pages() << 1;
 
 	spin_lock(&vmap_area_lock);
 	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
-		int nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
+		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 
 		__free_vmap_area(va);
-		atomic_sub(nr, &vmap_lazy_nr);
+		atomic_long_sub(nr, &vmap_lazy_nr);
 
-		if (atomic_read(&vmap_lazy_nr) < resched_threshold)
+		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
 			cond_resched_lock(&vmap_area_lock);
 	}
 	spin_unlock(&vmap_area_lock);
@@ -727,10 +727,10 @@ static void purge_vmap_area_lazy(void)
  */
 static void free_vmap_area_noflush(struct vmap_area *va)
 {
-	int nr_lazy;
+	unsigned long nr_lazy;
 
-	nr_lazy = atomic_add_return((va->va_end - va->va_start) >> PAGE_SHIFT,
-				    &vmap_lazy_nr);
+	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
+				PAGE_SHIFT, &vmap_lazy_nr);
 
 	/* After this point, we may free va at any time */
 	llist_add(&va->purge_list, &vmap_purge_list);
-- 
2.11.0

