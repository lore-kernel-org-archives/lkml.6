Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeEAULx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:11:53 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39392 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeEAULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:11:52 -0400
X-Google-Smtp-Source: AB8JxZqyaZsZLz9xMNKk7f//2yMv12Q14Gyv4lNr4rEipoNOx4DCKO0c3kT8dfFkE1eB0IjRGAAiPg==
From: Laura Abbott <labbott@redhat.com>
To: Dave Anderson <anderson@redhat.com>, Kees Cook <keescook@chromium.org>,
        akpm@linux-foundation.org
Cc: Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] proc/kcore: Don't bounds check against address 0
Date: Tue,  1 May 2018 13:11:43 -0700
Message-Id: <20180501201143.15121-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <1039518799.26129578.1525185916272.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing kcore code checks for bad addresses against
__va(0) with the assumption that this is the lowest address
on the system. This may not hold true on some systems (e.g.
arm64) and produce overflows and crashes. Switch to using
other functions to validate the address range.

Tested-by: Dave Anderson <anderson@redhat.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I took your previous comments as a tested by, please let me know if that
was wrong. This should probably just go through -mm. I don't think this
is necessary for stable but I can request it later if necessary.
---
 fs/proc/kcore.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index d1e82761de81..e64ecb9f2720 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -209,25 +209,34 @@ kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
 {
 	struct list_head *head = (struct list_head *)arg;
 	struct kcore_list *ent;
+	struct page *p;
+
+	if (!pfn_valid(pfn))
+		return 1;
+
+	p = pfn_to_page(pfn);
+	if (!memmap_valid_within(pfn, p, page_zone(p)))
+		return 1;
 
 	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
 	if (!ent)
 		return -ENOMEM;
-	ent->addr = (unsigned long)__va((pfn << PAGE_SHIFT));
+	ent->addr = (unsigned long)page_to_virt(p);
 	ent->size = nr_pages << PAGE_SHIFT;
 
-	/* Sanity check: Can happen in 32bit arch...maybe */
-	if (ent->addr < (unsigned long) __va(0))
+	if (!virt_addr_valid(ent->addr))
 		goto free_out;
 
 	/* cut not-mapped area. ....from ppc-32 code. */
 	if (ULONG_MAX - ent->addr < ent->size)
 		ent->size = ULONG_MAX - ent->addr;
 
-	/* cut when vmalloc() area is higher than direct-map area */
-	if (VMALLOC_START > (unsigned long)__va(0)) {
-		if (ent->addr > VMALLOC_START)
-			goto free_out;
+	/*
+	 * We've already checked virt_addr_valid so we know this address
+	 * is a valid pointer, therefore we can check against it to determine
+	 * if we need to trim
+	 */
+	if (VMALLOC_START > ent->addr) {
 		if (VMALLOC_START - ent->addr < ent->size)
 			ent->size = VMALLOC_START - ent->addr;
 	}
-- 
2.14.3
