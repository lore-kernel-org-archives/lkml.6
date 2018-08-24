Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CCDC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C53221564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C53221564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeHXTBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:01:34 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35346 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:01:34 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so15983883oic.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 08:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=57dRHTQn427mhHXpuBgiWI88kOyTDzrTdbLvs4H5kZE=;
        b=Ks4tRd+01XM2kbdTyBDpcksB3Bz/AgVV5TsmtyoXjUbu+K/nAghjbwFmSA4diE/5b4
         jAn43CuVv9rdelBIeMmKcNJ3nlmjaaqoXBqDv9fGU7j5+pGuYKkZd2YoYDt0mM4jTZv/
         ZnsVs6yhgLXC7dmfxIYECE60K7fimPijVmilfNQaaoT1ZNhOYpxo/sdVmIxaw5GSmwI6
         xaH8DwinmlCIxUWfdP4gipxfomVT1FVAcKLWAJjIhbOXNE3EC9k7vLxU9yCMBQGXFLRd
         O/is8SrtQR1PgjC5Ch+B1pHbZ5A5FTujOAUOyvA+KuX6G2v06k5JUYbkaayaQs5LVDl5
         cQ5A==
X-Gm-Message-State: APzg51A79RFmB7wAPNUig6e9lgBHBxIO9EsicT1W2U9vKyptWtA8DQlL
        z8fhPTRkfDgfiTyflRbpsxB8lQ==
X-Google-Smtp-Source: ANB0Vdap5KmiE6mRaP6d3UcyKNyf9Z0ryXiIYYLG2E/bm8/DevNRgeUROfbXhB2U8hc+0yPuwHMzOA==
X-Received: by 2002:aca:5b88:: with SMTP id p130-v6mr1877963oib.247.1535124386960;
        Fri, 24 Aug 2018 08:26:26 -0700 (PDT)
Received: from localhost ([130.164.62.204])
        by smtp.gmail.com with ESMTPSA id b125-v6sm6626121oia.38.2018.08.24.08.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 08:26:26 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     hao.wu@intel.com, atull@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/2] fpga: of-fpga-region: Use platform_set_drvdata
Date:   Fri, 24 Aug 2018 08:25:12 -0700
Message-Id: <20180824152513.8336-1-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use platform_set_drvdata rather than dev_set_drvdata
to match the platform_get_drvdata in the _remove()
function of the platform driver.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/of-fpga-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 35fabb8083fb..8c6120e30930 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_free;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
-	dev_set_drvdata(dev, region);
+	platform_set_drvdata(pdev, region);
 
 	dev_info(dev, "FPGA Region probed\n");
 
-- 
2.18.0

