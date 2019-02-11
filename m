Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCFDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9775721855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="BgQ1ovA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbfBKPuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:50:54 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46179 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfBKPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:50:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so1197864edy.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=H8O2ji7eoCfVIIQ2UDhxHCJpSPjNVRuur7TWt3y0Zyo=;
        b=BgQ1ovA38ynogaU+HY5DzzjQtYKGLcOXUHk6YKYcCrGJCPDJk2KBptC754VY5D/YMY
         MAu+e5glyeABGKaLnqLQi6iMHeLit16ek9k3p3ODpek/sb2q3yrUBKHaOW/2xe0sEelu
         0VqhxE+f3q27w+9dtB2SJOmHQsLWZVWnx8DNm9MUFGtxByLY0ykI53g94gcqcsgclG9N
         gMyo0tFwSzU0bmzr/B6a+V8CExZhVTBxTep1otNfuC98yHnHGYYDieiOJQe5KxybDY0C
         26FTeFGHPVNgWdvFL8umZCMb9iJxNhsdyegsXufPcj/zVKKykr0dsBuBlSdy9Gi+Putz
         LX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H8O2ji7eoCfVIIQ2UDhxHCJpSPjNVRuur7TWt3y0Zyo=;
        b=FloYvkwIzBwdYwXvbJ9grKfR+MXLlyZtAhERhm3t0SqW7AtTTzHQ97+xd2hb8UMuqV
         iZNaDsV/ygmH7gC5wR6yScPEMVxU7cbOFR/0gqUHhtaEJz2rTqhPqr9cd6+lFMnAWMJ7
         xzXIwgSZvNd/pgbWX7xUvfqsyUnIRiKjhQ+EqlVKD8K9TjskIH2dNnUZZa9alZ4ryMur
         L5f8frQrJL5qUtFn+8j4OxwkDGhOoVPnRM/pUikt7MkKSbUIBIhuMGn1DWERsjOdcWGd
         xfTsq58CpgMPAPgTVHntXx2JivMcNYliYFW6WawnbMVZG0HjIffeQnZlr5AcGl0YrBcU
         m84Q==
X-Gm-Message-State: AHQUAuZzEitmXA3R1dfvKnDawsd0nOFJMfwTajERcaMNTQ47zPe2OXQg
        3lvvpq8pIoDZ2bT7KCWJwm2Agg==
X-Google-Smtp-Source: AHgI3Iac0a3uU7QGlWDuyjvPQW2YpTMPaeT7f5cg2/yDaaOSCMrpt6e2ebm4J8c3xvG2gxw2z7E+1Q==
X-Received: by 2002:a50:81e4:: with SMTP id 91mr4084833ede.274.1549900250335;
        Mon, 11 Feb 2019 07:50:50 -0800 (PST)
Received: from localhost.localdomain ([80.233.32.169])
        by smtp.gmail.com with ESMTPSA id j16sm1949902edt.81.2019.02.11.07.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:50:49 -0800 (PST)
From:   Tom Murphy <murphyt7@tcd.ie>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix flush_tlb_all typo
Date:   Mon, 11 Feb 2019 15:50:33 +0000
Message-Id: <20190211155033.7850-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo, flush_tlb_all should be flush_iotlb_all

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a1d28f42cb77..bb4bf1269e5d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -167,7 +167,7 @@ struct iommu_resv_region {
  * @detach_dev: detach device from an iommu domain
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
- * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
+ * @flush_iotlb_all: Synchronously flush all hardware TLBs for this domain
  * @tlb_range_add: Add a given iova range to the flush queue for this domain
  * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
  *            queue
-- 
2.17.1

