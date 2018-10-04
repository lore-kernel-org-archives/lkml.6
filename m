Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516CBC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0963C2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxR9O46H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0963C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJDRBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:01:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33142 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJDRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:01:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id g26-v6so8044887edp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZtPppqn0cObkHfFqeBrroPaPD+bDud26pGAf+e3d480=;
        b=DxR9O46HwnBIfPX3F9oFvptUrwM3A7G5pfdRALBQ53/0nRfvMJgNQTc4mofz7HaBEV
         BVXWc9XCmlJdhZDqpiwfGdFcCTOWE8z608PtGK4TCJ/ER/XltzyFHw8SklBHJdQoSKyD
         yvI8cvQJSo3QrZuL0Puo/WeC6ChilgXhScacvobw/v/UETYeb4/db5+LvJ7PqqiKVcs8
         h89nhu7dWtysd3YonEgPx4q1JsL6YrNRwhLI6nNWIY87FI0zrPF+fhQKj9B9sdmNp7sO
         EEKjfJCXlOPWBCIKe8xldtwxuHa41T4tllyViBIZw5X/9ckkJDjEHHfLmFqk2BwMENlH
         hUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZtPppqn0cObkHfFqeBrroPaPD+bDud26pGAf+e3d480=;
        b=YsxEMqkMfNay+02XUD3PcjfnfS5mzqi1IRLGw0tVv2GT7OIMnCT8JlaTlohdmsRJWN
         glMB21lLHc1TV4CczNiOhBsdBSPc+Xn/9Xr6mdUP/RhQ8oYtqyO0ckBIspe3jAxOXJyX
         2p5atdCK2Gj/mn11qZwq1tjgoKQ+ZWSvcXG+wz8qtD9dTc578e4B/OjBv9ks8Kb84SsV
         rKz8xQWskrvEVZAXMKt3h9HvlCDiB1gGsomz3cIa6gaKjw8ICCWEa71wflTfl1vP0qM7
         /XtYmpjgPdzxMljC3wms6ftAu/SRUFwBOYE6kLenb62vt2mpYVUiW1wEcH4t5+IXpr24
         LIwA==
X-Gm-Message-State: ABuFfohzWNdA/Ef5qt/XgY/SJPbppBhYCru9SWh9Ww41VK1+6q56hr9n
        M01TlfJQf+gDnudJX4j4bmE=
X-Google-Smtp-Source: ACcGV62TQ1KdTv/n20Y+rnNnP0NzX6aHEZYKO52vDqfX21uRpZZMMM0KONboR5fmGp+eCTUpo3DiCQ==
X-Received: by 2002:a50:a706:: with SMTP id h6-v6mr7699457edc.290.1538647722005;
        Thu, 04 Oct 2018 03:08:42 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id c27-v6sm1409426edc.4.2018.10.04.03.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 03:08:40 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] mtd: physmap_of: Remove unused struct of_device_id
Date:   Thu,  4 Oct 2018 12:08:38 +0200
Message-Id: <20181004100838.12911-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This struct does not seem to be used anywhere on the code

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/physmap_of_gemini.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of_gemini.c b/drivers/mtd/maps/physmap_of_gemini.c
index 830b1b7e702b..9df62ca721d5 100644
--- a/drivers/mtd/maps/physmap_of_gemini.c
+++ b/drivers/mtd/maps/physmap_of_gemini.c
@@ -44,11 +44,6 @@
 
 #define FLASH_PARALLEL_HIGH_PIN_CNT	(1 << 20)	/* else low pin cnt */
 
-static const struct of_device_id syscon_match[] = {
-	{ .compatible = "cortina,gemini-syscon" },
-	{ },
-};
-
 int of_flash_probe_gemini(struct platform_device *pdev,
 			  struct device_node *np,
 			  struct map_info *map)
-- 
2.19.0

