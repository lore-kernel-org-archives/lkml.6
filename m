Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeCNOj2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:39:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33481 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeCNOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:38:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jessica Yu <jeyu@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org
Subject: [PATCH 09/16] mm: remove blackfin MPU support
Date: Wed, 14 Mar 2018 15:37:38 +0100
Message-Id: <20180314143755.1508262-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180314143755.1508262-1-arnd@arndb.de>
References: <20180314143755.1508262-1-arnd@arndb.de>
X-Provags-ID: V03:K0:CnlTzpX4YdC1sk25A0/ROJCOoFFVmzEhidwSpmAGULdQJa0bydF
 sUWTmgF1RhTa9qliPKEzMkaQfwbddv5tl8PBMhPodi3MoqiylHDXOqAh+gUrU1qomhbP+wO
 G5bfNw2R6fHAA7sXeSDYSdqSJW3NijQW1q5hXYi/+QYyB4Dqlp5l/fSe3Ngl3fU+JmdT4+G
 DhviGGjHmCecdswdResWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jY0fXn0uOVg=:PMlVAXbLQ90agxwUIND85n
 nr8hiT9Xyb1WjBGg64De7mWUNZqg7q+snnF90ZC/gr5fukyiGhOPNO0nSO43gOIfXdrln/owq
 OYwDkvQpze3iuV2CysOC9/q/fObUT7Fhn6D7sHXGsFdXX5D8miRj9wMU1SzG0iWwtfKpT4rdN
 ThU5Olj3REOQrnvr6+xFbR+itSvhrfnE+r0lhgGPeG+48Um1O4UkXKUeB5Sdtn0YlWIcjOY++
 r/mn8k+JZpBkGAmK8b0P8bExXmzc/9GELtartMNDz66tBS4kMUXmnLYMU7kERy6o0MXO7Cp9z
 JleSXoMTTh4gdKJOw6PjS3SKu80wlml5Gbk3C41yzC00X8xslhHRgwDXZBPK9dDIEb7hFCaTo
 ug+RnCfgGKtTmqyGRql1AKFD3o08m2kWwuZ6EYEDqKXWs37WQHXv6EZutbAH159TzeB2RLA1K
 nqYmdLvIKBXFHdkPV0oc/h0U00Xludw4Q8B5drCcy2bZOQoClANqajv2vUx9zXANfU9sEHfof
 40QWLBkh3rWhmxMdcjbwbldUsQ5p9Ein/zvmP947K402350v5in3Uu0S5vLQ+SvTigNWTX7EX
 kNLbxkRumi7ssfkmKByrxZjtB8qF9pvzaRC/9QCqvRblKR1Skvr07A5+jE1xfvbOaaPHgpWA0
 QRQakldOH0kKuCLDpXz2L7/iS+0XlqDZTJJJj584dKihaT73MU+AF9ZyDvMWS0lnVhkWAUlmW
 fRhe0RACgireODKSUXEOTzdZzH6CyjggznTvkA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_MPU option was only defined on blackfin, and that architecture
is now being removed, so the respective code can be simplified.

A lot of other microcontrollers have an MPU, but I suspect that if we
want to bring that support back, we'd do it differently anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/module.c |  4 ----
 mm/nommu.c      | 20 --------------------
 2 files changed, 24 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index ad2d420024f6..2c1df850029b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2181,10 +2181,6 @@ static void free_module(struct module *mod)
 	/* Finally, free the core (containing the module structure) */
 	disable_ro_nx(&mod->core_layout);
 	module_memfree(mod->core_layout.base);
-
-#ifdef CONFIG_MPU
-	update_protections(current->mm);
-#endif
 }
 
 void *__symbol_get(const char *symbol)
diff --git a/mm/nommu.c b/mm/nommu.c
index ebb6e618dade..838a8fdec5c2 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -663,22 +663,6 @@ static void put_nommu_region(struct vm_region *region)
 }
 
 /*
- * update protection on a vma
- */
-static void protect_vma(struct vm_area_struct *vma, unsigned long flags)
-{
-#ifdef CONFIG_MPU
-	struct mm_struct *mm = vma->vm_mm;
-	long start = vma->vm_start & PAGE_MASK;
-	while (start < vma->vm_end) {
-		protect_page(mm, start, flags);
-		start += PAGE_SIZE;
-	}
-	update_protections(mm);
-#endif
-}
-
-/*
  * add a VMA into a process's mm_struct in the appropriate place in the list
  * and tree and add to the address space's page tree also if not an anonymous
  * page
@@ -695,8 +679,6 @@ static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 	mm->map_count++;
 	vma->vm_mm = mm;
 
-	protect_vma(vma, vma->vm_flags);
-
 	/* add the VMA to the mapping */
 	if (vma->vm_file) {
 		mapping = vma->vm_file->f_mapping;
@@ -757,8 +739,6 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
 	struct mm_struct *mm = vma->vm_mm;
 	struct task_struct *curr = current;
 
-	protect_vma(vma, 0);
-
 	mm->map_count--;
 	for (i = 0; i < VMACACHE_SIZE; i++) {
 		/* if the vma is cached, invalidate the entire cache */
-- 
2.9.0
