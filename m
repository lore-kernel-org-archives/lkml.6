Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C113C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF1B218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbeLTU1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:27:54 -0500
Received: from www.osadl.org ([62.245.132.105]:48405 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730683AbeLTU1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:27:53 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wBKKRMa7023267;
        Thu, 20 Dec 2018 21:27:22 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chintan Pandya <cpandya@codeaurora.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Arun KS <arunks@codeaurora.org>, Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] mm: vmalloc: do not allow kzalloc to fail
Date:   Thu, 20 Dec 2018 21:23:57 +0100
Message-Id: <1545337437-673-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this is in a very early stage of the system boot and if memory
were exhausted the system has a more serious problem anyway - but still
the kzalloc here seems unsafe. Looking at the history it was previously
switched from alloc_bootmem() to kzalloc() using GFP_NOWAIT flag but
there never seems to have been a check for NULL return. So if this is
expected to never fail should it not be using | __GFP_NOFAIL here ?
Or put differently - what is the rational for GFP_NOWAIT to be safe here ?

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes 43ebdac42f16 ("vmalloc: use kzalloc() instead of alloc_bootmem()")
---

Problem was found by an experimental coccinelle script

Patch was only compile tested for x86_64_defconfig

Patch is against v4.20-rc7 (localversion-next next-20181220)

 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 871e41c..1c118d7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1258,7 +1258,7 @@ void __init vmalloc_init(void)
 
 	/* Import existing vmlist entries. */
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
-		va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
+		va = kzalloc(sizeof(*va), GFP_NOWAIT | __GFP_NOFAIL);
 		va->flags = VM_VM_AREA;
 		va->va_start = (unsigned long)tmp->addr;
 		va->va_end = va->va_start + tmp->size;
-- 
2.1.4

