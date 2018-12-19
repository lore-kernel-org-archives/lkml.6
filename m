Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1642C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFA321871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeLSIap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:30:45 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:36773 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLSIap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:30:45 -0500
X-QQ-mid: bizesmtp10t1545208226tards41r
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp10.qq.com (ESMTP) with 
        id ; Wed, 19 Dec 2018 16:30:18 +0800 (CST)
X-QQ-SSF: 01100000002000F0FG42B00A0000000
X-QQ-FEAT: 3CtJeSk7NKATdmbsBl6j6Qvwt2IXmPcQLPp5s10B9lCxNexcVF01QOCCieNs5
        DQrD0qs5UUGsDhMxFh+r+BmluveZE6inmjq1GDKcl2KMnEMaDWyv6nTujEif3tSHoMfcTpN
        3h95AGZ4KKJZJX6RdKI3WLCVzbhV3uGj7o88vkTeY9d7BSF1BJBYUN1lPfwc+kOGPz/CtYr
        N05KAlEl65dLU40sq3uZf1psWraZ4i0Itk5wv5qiNH0IFkoWME43V+B+12gfhMuTrf1ywSl
        zQV36lGL7GyvI6qiDcXvYYcTrpeeJkmMMiqg==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        stable@vger.kernel.org
Subject: [PATCH V2] scsi: lpfc: Switch memcpy_fromio() to __read32_copy()
Date:   Wed, 19 Dec 2018 16:31:14 +0800
Message-Id: <1545208274-13736-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit bc73905abf770192 ("[SCSI] lpfc 8.3.16: SLI Additions, updates,
and code cleanup"), lpfc_memcpy_to_slim() have switched memcpy_toio() to
__write32_copy() in order to prevent unaligned 64 bit copy. Recently, we
found that lpfc_memcpy_from_slim() have similar issues, so let it switch
memcpy_fromio() to __read32_copy().

As maintainer says, it seems that we can hardly see a real "unaligned 64
bit copy", but this patch is still useful. Because in our tests we found
that lpfc doesn't support 128 bit access, but some optimized memcpy()
use 128 bit access (at lease on Loongson).

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
V2: Update commit message.

 drivers/scsi/lpfc/lpfc_compat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_compat.h b/drivers/scsi/lpfc/lpfc_compat.h
index 43cf46a..0cd1e3c 100644
--- a/drivers/scsi/lpfc/lpfc_compat.h
+++ b/drivers/scsi/lpfc/lpfc_compat.h
@@ -91,8 +91,8 @@ lpfc_memcpy_to_slim( void __iomem *dest, void *src, unsigned int bytes)
 static inline void
 lpfc_memcpy_from_slim( void *dest, void __iomem *src, unsigned int bytes)
 {
-	/* actually returns 1 byte past dest */
-	memcpy_fromio( dest, src, bytes);
+	/* convert bytes in argument list to word count for copy function */
+	__ioread32_copy(dest, src, bytes / sizeof(uint32_t));
 }
 
 #endif	/* __BIG_ENDIAN */
-- 
2.7.0



