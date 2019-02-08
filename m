Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C1C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA15F2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="Tdgm/N32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfBHOVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:21:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35779 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfBHOVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:21:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id b17so2914781eds.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=DAgIYwKOq2xL1297Nf9ol3MkywTkoXQ6PMN/xrLYgTM=;
        b=Tdgm/N32aPbU6HGCOFhzWD4+rq6P8K6FG7XouWKNMfjZfqyqyHAVB+A+H5K+glnp+M
         hG/peR1/y3EEBcrQUaKNrouKghaGcLsHQ0zsyUuIm405Qcc4BPS7k23shceGxkMM1hQ7
         nDyQBLEM9KVuJK6PED9ExW4ne1Olyp0RLAtOIt8Eum31z8N60zd15clRzLe9MwK6NoFx
         H7vEgcedRMT8tdkosVsKCmgoTcnbMYusx3cP7NYNbpBAp4c0T/mCVYPPyEPOsGM3vsrO
         LiuywNXdXZU94KX5a1FL0SWFKqLo0DpVA/EkwH/irB6sbO1Rp8Zl1I/dLYgyLNoMKP5r
         v6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DAgIYwKOq2xL1297Nf9ol3MkywTkoXQ6PMN/xrLYgTM=;
        b=G288KiSCzAVSmnPZ5+YE7lEo+INzhQWfZa65GWf3K6kVdNn+UyydE92xy94Z7vMw2C
         Zi6sPwcYy9LNq2XIF3Bs81gHhK+KeX3rL51C2aNTOUnPxJiqKTHkopW7vr5YmMrjWHsL
         qBKMfGKsFrJLikC2S1ZctknoEh49PKWdMlR77I9ZPhE2foCgqQUpm5MhwZbM2vFbcICP
         Gj9toRMcmFwFqa0FkcD8B1gdESe6wdYYE0NVk2WdXBqD/Hh2nC+4cWocABzOnD9OxAt4
         F154vNzf1JlNwKuB5tcBLkBuL9VMPouvD85mFyDxlxTcUFW5NdhWW+kuiLt+XgByftCK
         cduw==
X-Gm-Message-State: AHQUAuavElQqSBJBaLSzVnbNF4gPpMBJvZoMRFdWFn/I1FyoNobhW0g0
        MLzmHx5zoh+mcXau3Sq/qu02mA==
X-Google-Smtp-Source: AHgI3Ib8xgeILRffa538GEzskds9e344ysUFwcQSVqueDPwe0JqseGCjM1JuSM7AR1XKgeBKXR0WlA==
X-Received: by 2002:a17:906:e2d5:: with SMTP id gr21mr11160774ejb.145.1549635658938;
        Fri, 08 Feb 2019 06:20:58 -0800 (PST)
Received: from linux-ThinkPad-X1-Carbon-5th.Hitronhub.home ([80.111.101.37])
        by smtp.gmail.com with ESMTPSA id t14sm502207eju.72.2019.02.08.06.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:20:58 -0800 (PST)
From:   Tom Murphy <murphyt7@tcd.ie>
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix flush_tlb_all typo
Date:   Fri,  8 Feb 2019 14:20:44 +0000
Message-Id: <20190208142044.27732-1-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

