Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E0C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB72320818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfBESDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:03:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbfBESDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:03:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E307C05093A;
        Tue,  5 Feb 2019 18:03:35 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-71.brq.redhat.com [10.40.204.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5861166C1;
        Tue,  5 Feb 2019 18:03:33 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] powerpc/mm: move a KERN_WARNING message to KERN_DEBUG
Date:   Tue,  5 Feb 2019 19:03:29 +0100
Message-Id: <20190205180329.1452-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 05 Feb 2019 18:03:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resize_hpt_for_hotplug() reports a warning when it cannot
increase the hash page table ("Unable to resize hash page
table to target order") but this is not blocking and
can make user thinks something has not worked properly.

If the operation cannot be done the real error message
will be reported by arch_add_memory() if create_section_mapping()
fails.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/mm/hash_utils_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0cc7fbc3bd1c..b762bdceb510 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -778,7 +778,7 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
 
 		rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
 		if (rc && (rc != -ENODEV))
-			printk(KERN_WARNING
+			printk(KERN_DEBUG
 			       "Unable to resize hash page table to target order %d: %d\n",
 			       target_hpt_shift, rc);
 	}
-- 
2.20.1

