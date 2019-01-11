Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8593EC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F65820874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ9gfhsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbfAKPEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:04:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36822 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389000AbfAKPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:04:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so6422981pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WzAQwD4CMcNjfYojTjRfy8sqfmAAp9apVnphS+7qE5M=;
        b=HQ9gfhspvagPH29Me3BRhdtcdpJ1ppAkZvxlrEmPYgRip1IdthcKcOCiWAVY5Z895Z
         PTA3IoN+JoobjwcMS/8b83st4Y+6eHz3yTWfKmWq6hBWZF2NZmmXzgF2mJsADBChdpWa
         BlzbeMjQsitVUoC0lUosclfzkAMgMA1uWDH4Q+jXZ0a8BMEvbSD4/3aYiYIx2RYsqrV/
         uREttfKnl7dDB92r8GsoONQTcYXgxNyBsHnbW/433SZk5GGTnHZxA7gQrkXu0wYSvHer
         Vv27TCONFgJ3EJ2dLRQBnpmyzs3Y3diG7h3yFHd0GF6Ho2Vfd1jpkcOJiHFErnXjtg9V
         WdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WzAQwD4CMcNjfYojTjRfy8sqfmAAp9apVnphS+7qE5M=;
        b=otzgPlZhcHZI+8WQ23axDco7iONhcs3IafdZm5151MphLHh6EqjGEmf4HMtY/jmxlf
         IJy+ga6tDfRveVJvSQGSSVfnJ5kJk0c0d4ku/zq7p11G9nx6vDld3BjB1G1joHKP+Z37
         7xqcwc8oG/X0aH1X1TNQ5zZ76xRXOS1Fkho0r8WqF05JkijxE4Dx92AbAss0cpnoeyAB
         AbSZJZabX5xjkUm20nZxqalBRLRaCsy/oKubpYP/FlMP36KtSWk6hFrBDyU089iOQ5ZV
         DkBLM8QPpQOEMPsI60RgUzztziErxMfXMT9PhX0W9DcY+T8gtW8QRqiydTSrxdlRON1J
         Eg9g==
X-Gm-Message-State: AJcUukdGBU9zqcQ0/Xq2TnJmdqTx33Bt8zWJ8PKmxcwd9NkoU6a0KJDM
        CLAtFlk9X7anQD00GKu8ePE=
X-Google-Smtp-Source: ALg8bN4zxdDRP2GvwoCa51Ol8AZWOsPmTHbzznH1GTkRyiMejwb4Tfr2KDpSzH8Z6TaZw/NFHZFS/w==
X-Received: by 2002:a62:1c86:: with SMTP id c128mr15538564pfc.54.1547219040807;
        Fri, 11 Jan 2019 07:04:00 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
        by smtp.gmail.com with ESMTPSA id i62sm92403752pge.44.2019.01.11.07.03.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 07:03:59 -0800 (PST)
Date:   Fri, 11 Jan 2019 20:38:01 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        linux@armlinux.org.uk, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org,
        m.szyprowski@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/9] arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
Message-ID: <20190111150801.GA2714@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 78de138..5334391 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1582,31 +1582,21 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
 	struct page **pages = __iommu_get_pages(cpu_addr, attrs);
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
+	int err;
 
 	if (!pages)
 		return -ENXIO;
 
-	if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
+	if (vma->vm_pgoff >= nr_pages)
 		return -ENXIO;
 
-	pages += off;
-
-	do {
-		int ret = vm_insert_page(vma, uaddr, *pages++);
-		if (ret) {
-			pr_err("Remapping memory failed: %d\n", ret);
-			return ret;
-		}
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
+	err = vm_insert_range(vma, pages, nr_pages);
+	if (err)
+		pr_err("Remapping memory failed: %d\n", err);
 
-	return 0;
+	return err;
 }
 static int arm_iommu_mmap_attrs(struct device *dev,
 		struct vm_area_struct *vma, void *cpu_addr,
-- 
1.9.1

