Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B826C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3271520874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbeL1RPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:15:38 -0500
Received: from dliviu.plus.com ([80.229.23.120]:44826 "EHLO smtp.dudau.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729154AbeL1RPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:15:37 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Dec 2018 12:15:37 EST
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 8F4FC41080C1;
        Fri, 28 Dec 2018 17:10:20 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Fri, 28 Dec 2018 17:10:20 +0000
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chintan Pandya <cpandya@codeaurora.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Liviu Dudau <liviu@dudau.co.uk>
Subject: [PATCH] mm/vmalloc.c: don't dereference possible NULL pointer in __vunmap.
Date:   Fri, 28 Dec 2018 17:10:09 +0000
Message-Id: <20181228171009.22269-1-liviu@dudau.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_vmap_area() can return a NULL pointer and we're going to dereference
it without checking it first. Use the existing find_vm_area() function
which does exactly what we want and checks for the NULL pointer.

Fixes: f3c01d2f3ade ("mm: vmalloc: avoid racy handling of debugobjects
in vunmap")

Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 871e41c55e239..806047d7fda3c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1505,7 +1505,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			addr))
 		return;
 
-	area = find_vmap_area((unsigned long)addr)->vm;
+	area = find_vm_area(addr);
 	if (unlikely(!area)) {
 		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
 				addr);
-- 
2.20.1

