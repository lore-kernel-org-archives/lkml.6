Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A40CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB6720863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hucB6Zuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfBZUYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:24:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32903 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbfBZUYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:24:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id y10so6793108plp.0;
        Tue, 26 Feb 2019 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LHcV9KuFyIJphllsynnPnDHUrB3QRBV9lgjkjWwozRg=;
        b=hucB6ZuvoWE9TEWY2htIei8RkTzM2hmLBhHSw0+HB0nfK6vUAVOovNLWtg7WtRWL4U
         +CWVJKszW7INsKyLM2guejrQ6EiuPVBYaXVrLrzrRMAljLid6bsdVXmIPlG/CvRSOoPJ
         Igm2xYMpWa5+Fx1FOjwENpVYuhULjKb3hB2935HCXThpDE5FO1IT7klmQ/LbkvSChOnV
         fayzqbFcvyLbow1u0cquI7U4zXxrSifAGx1UAXjp1/7pvWfwitA+4hpBQ08/LVjX8nRB
         D+7Wy+/AhNiPPr9wPaEKYZKlzALBaSlZ1qyupPQltTikxKbCIZWZUipWR12K/BDpDYIj
         oBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LHcV9KuFyIJphllsynnPnDHUrB3QRBV9lgjkjWwozRg=;
        b=ldIlanVTx8KamrvgN0qp0e+uewnfy2/2jaEf166lQt+s2WLHP/CZc40REt9jpUEVpL
         dAaFj/MeUPx+2CsHdDpdSjTZedXTDG1HZpfdYkmGrEX2Rivnk257XoiZOpUaBzFXZINe
         I40R3OzeraVnordS3uwQw3kH2I/oslEaKh8xy1tdxQQo/rP2b5v/0pzChRVr57rnUOLw
         oyuZnJ/lZluh9Y/My3asvdM0gVHrqWEaTBxl+Jadp3UwQCH218ySkroKB2u5J57cLhYF
         YZkv84ahGqPuCY0g3Tp2XHx0EyMh8fPTy6PLLI9ap1h5Abd9dOqWxYpb/CzquZUOQk0h
         /nJw==
X-Gm-Message-State: AHQUAuZDjpYv9L0WgM7inVE6vaQ7K4E3VbAOlt8y4PQNjsTW9At8uVIa
        ZJatZqQ9XmbQpJICk/b22S8=
X-Google-Smtp-Source: AHgI3IZ3++oASqlaSmz7L1lvzECC+qTYDnoPN+pBRQ3likXjsPclEKW4se6zSk9ZBGyuOEpHZxt+3A==
X-Received: by 2002:a17:902:20c3:: with SMTP id v3mr7475180plg.268.1551212642071;
        Tue, 26 Feb 2019 12:24:02 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v186sm294240pfv.184.2019.02.26.12.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 12:24:01 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        tony@atomide.com
Cc:     vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] Revert "dma-contiguous: do not allocate a single page from CMA area"
Date:   Tue, 26 Feb 2019 12:23:27 -0800
Message-Id: <20190226202327.5349-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.

The original change breaks omap dss:
    omapdss_dispc 58001000.dispc:
        dispc_errata_i734_wa_init: dma_alloc_writecombine failed

Let's revert it first and then find a safer solution instead.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Tony,
	
Would you please test and verify? Thanks!

 kernel/dma/contiguous.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 09074bd04793..b2a87905846d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -186,32 +186,16 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
  *
  * This function allocates memory buffer for specified device. It uses
  * device specific contiguous memory area if available or the default
- * global one.
- *
- * However, it skips one-page size of allocations from the global area.
- * As the addresses within one page are always contiguous, so there is
- * no need to waste CMA pages for that kind; it also helps reduce the
- * fragmentations in the CMA area. So a caller should be the rebounder
- * in such case to allocate a normal page upon NULL return value.
- *
- * Requires architecture specific dev_get_cma_area() helper function.
+ * global one. Requires architecture specific dev_get_cma_area() helper
+ * function.
  */
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int align, bool no_warn)
 {
-	struct cma *cma;
-
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	if (dev && dev->cma_area)
-		cma = dev->cma_area;
-	else if (count > 1)
-		cma = dma_contiguous_default_area;
-	else
-		return NULL;
-
-	return cma_alloc(cma, count, align, no_warn);
+	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
 }
 
 /**
-- 
2.17.1

