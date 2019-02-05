Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95262C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710692175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfBEUVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:21:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfBEUVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:21:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B9398E59E;
        Tue,  5 Feb 2019 20:21:36 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-71.brq.redhat.com [10.40.204.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2683C1167420;
        Tue,  5 Feb 2019 20:21:33 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/mm: move a KERN_WARNING message to pr_debug()
Date:   Tue,  5 Feb 2019 21:21:33 +0100
Message-Id: <20190205202133.5048-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 05 Feb 2019 20:21:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resize_hpt_for_hotplug() reports a warning when it cannot
increase the hash page table ("Unable to resize hash page
table to target order") but this is not blocking and
can make user thinks something has not worked properly.
As we move the message to the debug area, report again the
ENODEV error.

If the operation cannot be done the real error message
will be reported by arch_add_memory() if create_section_mapping()
fails.

Fixes: 7339390d772dd
       powerpc/pseries: Don't give a warning when HPT resizing isn't available
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2:
     - use pr_debug instead of printk(KERN_DEBUG
     - remove check for ENODEV

 arch/powerpc/mm/hash_utils_64.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0cc7fbc3bd1c..6a0cc4eb2c83 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -777,10 +777,9 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
 		int rc;
 
 		rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
-		if (rc && (rc != -ENODEV))
-			printk(KERN_WARNING
-			       "Unable to resize hash page table to target order %d: %d\n",
-			       target_hpt_shift, rc);
+		if (rc)
+			pr_debug("Unable to resize hash page table to target order %d: %d\n",
+				 target_hpt_shift, rc);
 	}
 }
 
-- 
2.20.1

