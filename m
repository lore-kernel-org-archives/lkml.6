Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC93C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67229208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu/6yKl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67229208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeKHUt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:49:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41110 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHUt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:49:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so3154396pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 03:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=jXMgqzrD82Pyq8PXL0u594vnzsK0yylMSPpdc5zEYZg=;
        b=fu/6yKl5IsotFVlW0ym5LWQwxnDB9/8MrsSRivPR1+eU0/ykQRaJcVTitcfQ6EZofF
         ZoUvGi35Ocm6mQeD6FbNuXbQyzZRMcvOcBRoE+yqzoYuKYNhJrzJxwNEokjBpiULRYT1
         0c6g3XnCvmAeMIBDHZV1AymjT7kkVjWkBbBQwHsuxhi23jWqd0Z8iODQGnxseG4BzzlM
         QY8Kac80I6uVev5EvV2gSB6Mw+HOFpZoZ4Zr5wK4eUgg7j91up9J64ZOxq6C2Yzldh2W
         d/TihvgrDk4TuW5DRRLFyfab5gFuKl5ALqx/0WbkDGBMybs7u3LD3QWgTspxuAQheIRg
         MgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=jXMgqzrD82Pyq8PXL0u594vnzsK0yylMSPpdc5zEYZg=;
        b=MxL6n9Ty1Vys975EY6UmLRLHDpsB6GLgY+uRGWcXvbgdcez/sC9sRsr8MoJ8HXKd7R
         hbXW4aAzb0TTv1JWdw0P2+DWJn7XmplENrHiGK/yeq74oE/xKkVkYIzYchCZqjGHdxok
         aTIN83bz5bn65KC5AL3RS2gSCUySGiE4L5C7qI+H9z0SXRGwjIcdgcpAA7ryqQzqKJFm
         HfSHZ4//NmGetCETUBp8P6tm5UMJgVtOeYn/mghRkL1A513ahJduFL6t1iKD6zxzjJUo
         VX5/4do+mnZNOTM6Z7CduuhAAui4k9QIDlvT76o5OBWY+0PoJTxRUV/9aN8KFM32T5Ph
         NCUg==
X-Gm-Message-State: AGRZ1gJtXN+2oppdEyRoQfvS6fq2ZAmUoHLFsLrmosBPJ6C3f5P6KCT+
        mnojVVOaFdCaToQuUXTHy+0=
X-Google-Smtp-Source: AJdET5e6QfAITH2kt4oX/AjrJvbdfpKeTRTXJ8IMF4viAsgNQ2cwskVHeXPn3vgG6CIxvNFY/C4m4g==
X-Received: by 2002:a63:ac46:: with SMTP id z6mr3442553pgn.162.1541675699021;
        Thu, 08 Nov 2018 03:14:59 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w3sm3227926pge.8.2018.11.08.03.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 03:14:58 -0800 (PST)
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
To:     Chintan Pandya <cpandya@codeaurora.org>,
        David Rientjes <rientjes@google.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm:vmalloc add vm_struct for vm_map_ram
Date:   Thu,  8 Nov 2018 19:14:49 +0800
Message-Id: <1541675689-13363-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

There is no caller and pages information etc for the area which is
created by vm_map_ram as well as the page count > VMAP_MAX_ALLOC.
Add them on in this commit.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmalloc.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index cfea25b..819b690 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -45,7 +45,8 @@ struct vfree_deferred {
 static DEFINE_PER_CPU(struct vfree_deferred, vfree_deferred);
 
 static void __vunmap(const void *, int);
-
+static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
+			      unsigned long flags, const void *caller);
 static void free_work(struct work_struct *w)
 {
 	struct vfree_deferred *p = container_of(w, struct vfree_deferred, wq);
@@ -1138,6 +1139,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	BUG_ON(!va);
 	debug_check_no_locks_freed((void *)va->va_start,
 				    (va->va_end - va->va_start));
+	kfree(va->vm);
 	free_unmap_vmap_area(va);
 }
 EXPORT_SYMBOL(vm_unmap_ram);
@@ -1170,6 +1172,8 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
 		addr = (unsigned long)mem;
 	} else {
 		struct vmap_area *va;
+		struct vm_struct *area;
+
 		va = alloc_vmap_area(size, PAGE_SIZE,
 				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
 		if (IS_ERR(va))
@@ -1177,11 +1181,17 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
 
 		addr = va->va_start;
 		mem = (void *)addr;
+		area = kzalloc_node(sizeof(*area), GFP_KERNEL, node);
+		if (likely(area)) {
+			setup_vmalloc_vm(area, va, 0, __builtin_return_address(0));
+			va->flags &= ~VM_VM_AREA;
+		}
 	}
 	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
 		vm_unmap_ram(mem, count);
 		return NULL;
 	}
+
 	return mem;
 }
 EXPORT_SYMBOL(vm_map_ram);
@@ -2688,19 +2698,19 @@ static int s_show(struct seq_file *m, void *p)
 	 * s_show can encounter race with remove_vm_area, !VM_VM_AREA on
 	 * behalf of vmap area is being tear down or vm_map_ram allocation.
 	 */
-	if (!(va->flags & VM_VM_AREA)) {
-		seq_printf(m, "0x%pK-0x%pK %7ld %s\n",
-			(void *)va->va_start, (void *)va->va_end,
-			va->va_end - va->va_start,
-			va->flags & VM_LAZY_FREE ? "unpurged vm_area" : "vm_map_ram");
-
+	if (!(va->flags & VM_VM_AREA) && !va->vm)
 		return 0;
-	}
 
 	v = va->vm;
 
-	seq_printf(m, "0x%pK-0x%pK %7ld",
-		v->addr, v->addr + v->size, v->size);
+	if (!(va->flags & VM_VM_AREA))
+		seq_printf(m, "0x%pK-0x%pK %7ld %s\n",
+				(void *)va->va_start, (void *)va->va_end,
+				va->va_end - va->va_start,
+				va->flags & VM_LAZY_FREE ? "unpurged vm_area" : "vm_map_ram");
+	else
+		seq_printf(m, "0x%pK-0x%pK %7ld",
+				v->addr, v->addr + v->size, v->size);
 
 	if (v->caller)
 		seq_printf(m, " %pS", v->caller);
-- 
1.9.1

