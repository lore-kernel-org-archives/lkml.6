Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522CAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4D820815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfACPA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:00:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:32846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730737AbfACPAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:00:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7A05ADBD;
        Thu,  3 Jan 2019 15:00:17 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/3] mm/vmalloc: fix size check for remap_vmalloc_range_partial()
Date:   Thu,  3 Jan 2019 15:59:52 +0100
Message-Id: <20190103145954.16942-2-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103145954.16942-1-rpenyaev@suse.de>
References: <20190103145954.16942-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

area->size can include adjacent guard page but get_vm_area_size()
returns actual size of the area.

This fixes possible kernel crash when userspace tries to map area
on 1 page bigger: size check passes but the following vmalloc_to_page()
returns NULL on last guard (non-existing) page.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Joe Perches <joe@perches.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 871e41c55e23..2cd24186ba84 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2248,7 +2248,7 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
 	if (!(area->flags & VM_USERMAP))
 		return -EINVAL;
 
-	if (kaddr + size > area->addr + area->size)
+	if (kaddr + size > area->addr + get_vm_area_size(area))
 		return -EINVAL;
 
 	do {
-- 
2.19.1

