Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E277321741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOC/gCv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbfA1RGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:06:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36558 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbfA1RGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:06:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so18921482wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BJi/r8goePKYT80tTkrlzFxUlyhO/0drjRFh1r7hDY0=;
        b=jOC/gCv+ww2Yu/MYiUQUBvAFbY8ecJ0ZRWphkgrPvrPm0QMErUWDEhxbow73FDZBoV
         i8cyw74FgffAglgqLifE93t6ag0f4uPemgK+KlpTkMOyCYL15Gd2B+n2IO3aLE0pXORH
         TFN5L/uWHFFzAn2gLv3/uFQ5fN7OHdfqr+hWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BJi/r8goePKYT80tTkrlzFxUlyhO/0drjRFh1r7hDY0=;
        b=m8dWGVcDFeFu7p/ci+sfPwbI1EXahkBNAbub3T/ciqa2S3an93nkjz/nF0sng9Jkgi
         B1mcjJTLT27LBUVEGiqTUPaAqjxrdxnfZ9lwDKqFcHjsN90HK2k8uHkGW3/6kknRXAdE
         wBS0LYN8w/XnCicEWWflC43agvcUDAHOe9JS7t9vcv8Ommoy2qmHLkG7OFPA0A5BatfJ
         Q7AMcWarL+sgc3IFcx0drrfb3IQ8k8hNgN5S4Z7O/gUajksiznplBaOt+Tucm73g1/0J
         oQoZJCnIUX4Ix7DMHzlgnV1xfFgAVcoqJafi+kvbX8acNHJBIFmbQ1pvgbGrz7zTK3Of
         ztuQ==
X-Gm-Message-State: AJcUukdtvWSJZLTF8pVGo0bCdWd1bZxXS54PbV0ylgesd8jn9IxyxWWm
        FjsRzSm/tqkp6sxYHZ/njsBffrkBpCI=
X-Google-Smtp-Source: ALg8bN7/G/2tIVK3VdHNoFhN5sZkN+Wo2HxgqYv4EaEK3tvDIb7GeVVVbYalBB2nNq5mFVRXR8hNLg==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr22013357wrr.329.1548695191721;
        Mon, 28 Jan 2019 09:06:31 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id h10sm68375392wmf.44.2019.01.28.09.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 09:06:30 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>, stable@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size
Date:   Mon, 28 Jan 2019 18:00:15 +0100
Message-Id: <20190128170015.12253-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

Commit 8208d1708b88b412ca97f50a6d951242c88cbbac upstream.

The way we allocate events works fine in most cases, except
when multiple PCI devices share an ITS-visible DevID, and that
one of them is trying to use MultiMSI allocation.

In that case, our allocation is not guaranteed to be zero-based
anymore, and we have to make sure we allocate it on a boundary
that is compatible with the PCI Multi-MSI constraints.

Fix this by allocating the full region upfront instead of iterating
over the number of MSIs. MSI-X are always allocated one by one,
so this shouldn't change anything on that front.

Fixes: b48ac83d6bbc2 ("irqchip: GICv3: ITS: MSI support")
Cc: <stable@vger.kernel.org> # v4.4 - v4.9
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[ardb: rebased onto v4.9.153, should apply cleanly onto v4.4.y as well]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 25 ++++++++++----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 558c7589c329..83ca754250fb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1372,13 +1372,14 @@ static void its_free_device(struct its_device *its_dev)
 	kfree(its_dev);
 }
 
-static int its_alloc_device_irq(struct its_device *dev, irq_hw_number_t *hwirq)
+static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number_t *hwirq)
 {
 	int idx;
 
-	idx = find_first_zero_bit(dev->event_map.lpi_map,
-				  dev->event_map.nr_lpis);
-	if (idx == dev->event_map.nr_lpis)
+	idx = bitmap_find_free_region(dev->event_map.lpi_map,
+				      dev->event_map.nr_lpis,
+				      get_count_order(nvecs));
+	if (idx < 0)
 		return -ENOSPC;
 
 	*hwirq = dev->event_map.lpi_base + idx;
@@ -1464,20 +1465,20 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int err;
 	int i;
 
-	for (i = 0; i < nr_irqs; i++) {
-		err = its_alloc_device_irq(its_dev, &hwirq);
-		if (err)
-			return err;
+	err = its_alloc_device_irq(its_dev, nr_irqs, &hwirq);
+	if (err)
+		return err;
 
-		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq);
+	for (i = 0; i < nr_irqs; i++) {
+		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
 			return err;
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i,
-					      hwirq, &its_irq_chip, its_dev);
+					      hwirq + i, &its_irq_chip, its_dev);
 		pr_debug("ID:%d pID:%d vID:%d\n",
-			 (int)(hwirq - its_dev->event_map.lpi_base),
-			 (int) hwirq, virq + i);
+			 (int)(hwirq + i - its_dev->event_map.lpi_base),
+			 (int)(hwirq + i), virq + i);
 	}
 
 	return 0;
-- 
2.20.1

