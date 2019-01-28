Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACCEC282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1832220989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gsfsUrM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfA1JnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:43:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45202 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfA1JnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:43:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so7736735pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YM2ZHNQI2khAjcv6Vrmdn4cezBg7JA0PyCO1gIR5Rdg=;
        b=gsfsUrM+Ys1mCAS8vqjbU9AehXt68gUQkd/v3xwBGDuIrTzo+C2bDx20C3AJZLS3jh
         awLrzMvau3Nbl5Enr0SF1+KaWkB4EZVW4FTSXZrewBZOtU4BJ8uxjWXszS39gikVd8AQ
         et0lI1c2QnAjTdm1rSXy6L5e5mAX/i+WDZWm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YM2ZHNQI2khAjcv6Vrmdn4cezBg7JA0PyCO1gIR5Rdg=;
        b=H6jTKqSuIBEWA9xKHdTHbr6bemu3snl7YVUOcHssBxVmTW/G2+gPSQecSLtsXsGVIK
         HWCzlwK/O8fCc6jZpzGLpr7sNPV2wZUxdy0zT6qA8TEwEIj3qZShUiEGyyy5WkuqpLzx
         b71wH/lhTN2wEX+zJ4eVNFW0B92TaxEgdHOpeaCbdwh+dz8/84jEkAc8ezPOtZU1n7o6
         iFbqDhMzehbRXXnoyD+1khnPIb9GGOf1vqOtNA9j4ytOY4AgF37YVZg23dOlvengzsez
         Gtm1/cnoL/lKHk91Aspnh6YlpFUxIXWPOqoyZKpmckfbH2OlQMwLui54Bpp/UpXb1wyH
         WjAg==
X-Gm-Message-State: AJcUukfiijgaTdSM9eClsggOhdY8UJ7kAE89LFlN5hI+MJaUNDX67toz
        l+2X+grcj4m8Etse45osKZi5FddflzQy7A==
X-Google-Smtp-Source: ALg8bN4aTzsOlosWumNEebFd04aodLTvqDjvOLmNR6Bo/r+RA3UdqdxtE+N+7+teRckjTgs+OuamwA==
X-Received: by 2002:a63:4745:: with SMTP id w5mr19611608pgk.377.1548668592103;
        Mon, 28 Jan 2019 01:43:12 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id v72sm56998027pfd.163.2019.01.28.01.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:43:11 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org
Subject: [PATCH] iommu/io-pgtable-arm-v7s: only kmemleak_ignore L2 tables
Date:   Mon, 28 Jan 2019 17:43:01 +0800
Message-Id: <20190128094301.151252-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L1 tables are allocated with __get_dma_pages, and therefore already
ignored by kmemleak.

Without this, the kernel would print this error message on boot,
when the first L1 table is allocated:

[    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
[    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
[    2.831227] Workqueue: events deferred_probe_work_func
[    2.836353] Call trace:
...
[    2.852532]  paint_ptr+0xa0/0xa8
[    2.855750]  kmemleak_ignore+0x38/0x6c
[    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
[    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
[    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
...

Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

I only tested this on top of my other series
(https://patchwork.kernel.org/patch/10720495/), but I think the same fix
applies. I'm still a bit confused as to why this only shows up now, as IIUC,
the kmemleak_ignore call was always wrong with L1 tables.

 drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index cec29bf45c9bd7..98a4a4a0dfb0c1 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -217,7 +217,8 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		if (dma != phys)
 			goto out_unmap;
 	}
-	kmemleak_ignore(table);
+	if (lvl == 2)
+		kmemleak_ignore(table);
 	return table;
 
 out_unmap:
-- 
2.20.1.495.gaa96b0ce6b-goog

