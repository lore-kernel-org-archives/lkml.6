Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D44C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9C220846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=daedalean.ai header.i=@daedalean.ai header.b="CfdPMt1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9C220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daedalean.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeFULmp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:42:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38192 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933145AbeFULmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:42:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so5430295wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daedalean.ai; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oP9Zbwd+JjG0rjfNCbdRd4dJJazZqCLTNUZeSihFmto=;
        b=CfdPMt1MsTYmbb5l4G+BHbXvoM5P4nG5hn3IuDk/aju1Bljw5wBm3OzHTPhb8KEh0n
         g1pBt8QN3xhTB8p7YeAuR4EXjhpnjtSyfjqEfHZZqOer6YWJUxWgDyM00uADCzjkcrWb
         X/i8aVR5hEllVfrVhR3Hnfqd0vGeyEj50zrK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oP9Zbwd+JjG0rjfNCbdRd4dJJazZqCLTNUZeSihFmto=;
        b=DseAgABVR9mRwlHU5AYW+ffU326uvWsXGuoC1e25xRs8gg828I1X7DKdbm/1mwqgEu
         ++jYelL0sr9mGotq+Wlq89zWylebN/MizeWi6DHuzHsoKxOd2JEOi2zB92FdXHA093+I
         5pcpyjGl9jtYK2cWtlm8eVaQGWWl98dHSc7xIrXtGk9Zm+G93R0XOMv65VeOEuUyhXH/
         zRI24rAnBS0xRCjhhtZWq5q8nQOlTfmI9BGznQuWMNKPV+JjiHEMRU5uvMgwb8Zed1zK
         rTNRrvyoGA3/bMSvDxCGtYPektYPR4PeJ6RYX9zsh+JNxNrqY4ZA2QNQCxI1Bc4OSEyO
         FEhQ==
X-Gm-Message-State: APt69E1jussbfgMIzgm9Zp+RiOOxv1tRHfmnjE/sVe2sl+EImTpTftaC
        0LlAJZOLqVPxhZFqeNtQW5fZng==
X-Google-Smtp-Source: ADUXVKIAZV3MsmBlTLDdzopUm/MJGsBW4/v1bwEsGBNjJ8YBOeaePyU65R1SVWYDdLamM3wmQsBdoA==
X-Received: by 2002:a50:b832:: with SMTP id j47-v6mr21894361ede.272.1529581360622;
        Thu, 21 Jun 2018 04:42:40 -0700 (PDT)
Received: from xps15.office-zrh.daedalean.ai ([2a02:168:2092:1:8022:cadf:eea2:cab0])
        by smtp.gmail.com with ESMTPSA id z44-v6sm4519310edb.72.2018.06.21.04.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:42:39 -0700 (PDT)
From:   Bas Vermeulen <bas@daedalean.ai>
To:     netdev@vger.kernel.org
Cc:     bas@daedalean.ai, Madalin Bucur <madalin.bucur@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fman: don't set node on dpaa-ethernet platform device
Date:   Thu, 21 Jun 2018 13:42:22 +0200
Message-Id: <20180621114222.8326-1-bas@daedalean.ai>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting dev->node to the mac_node in dpaa_eth_add_device during probe
causes the mac_probe to be called again for the dpaa-ethernet.* device
that was just added.

Fix this by not setting dev->node, as it is not needed.

Signed-off-by: Bas Vermeulen <bas@daedalean.ai>
---
 drivers/net/ethernet/freescale/fman/mac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 387eb4a88b72..9a265f862065 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -623,7 +623,6 @@ static struct platform_device *dpaa_eth_add_device(int fman_id,
 		goto no_mem;
 	}
 
-	pdev->dev.of_node = node;
 	pdev->dev.parent = priv->dev;
 	set_dma_ops(&pdev->dev, get_dma_ops(priv->dev));
 
-- 
2.17.1

