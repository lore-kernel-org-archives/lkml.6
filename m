Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A108C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5850218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjItMP5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeLZNKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:10:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38449 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeLZNKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:10:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so7543409plb.5;
        Wed, 26 Dec 2018 05:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0I4s3GxOOwCcZbSPSFDvUZhd+6NotTcCuPivJ0ciKF0=;
        b=rjItMP5XTwDbEusoGqHChM3X8+fhzKwas1QOEIGc47vk0QOF7T4eIce1o0yf+UcBTl
         UIvmBuCRNmMnEQR9fKZNJuYArW0i9N4u321iY5IW3Bzvi4Nsdh/KWNU3N3LPg2aInqeV
         WmLvEjiR9ky9nmNemCw6ilaOisjdoJdAr0DOueARtDlWmZdI842awXsos7sYh580R6VB
         PJPGjBVbs/AQ9PA2SBsuYPHzGzhHoHOjA0Hmx1v6fP0t2uMvK0f4g7sYiB4Ol8rk5M8O
         4EKXoUV27/JNe/EFVul+rYzFSxHItLab/dOIjBeK237A2EI3XQia7QhxPzQwL4L+vFE9
         QgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0I4s3GxOOwCcZbSPSFDvUZhd+6NotTcCuPivJ0ciKF0=;
        b=XHx4km0bnkvrRxuLgBOACOx+GRsaWVG0/u4WPzAvthSI537P4EDhi3N3ENCQQbfNZy
         hCoQZd0FNgraet3W2StXEztNgUUMmqmVkwzr46TfRqpO03rPLzLv/3kZ0sUeApKpiRaN
         /8CKuLzlShFBhHDnM3wxFdKRfDoVRF2XgJ4nzWpYoDtoAA7SFHrdoiavovuPtg3Xqi3m
         W6xga5R8AxLORCiJkXyUrWyzEnjaQLAdGs3MUnWsu+0Y5iKDxxKA7yhf3jazNCLPXivh
         nNMBiy/fORvrA8UiXvNPqkPMrQoy8OYPwXcyLNVRXEPc3vBwfaZq3zu6Igr6y2su3BDq
         L5kg==
X-Gm-Message-State: AJcUukf100B+6Sg2KHz5m5dCNg0LGUiheBqJ/g4h9SsTrz4ya7/2jQyw
        cbyxS198tH6pnzI37ZcimTA=
X-Google-Smtp-Source: ALg8bN5ia4R6Mp5tvr0ajVSfJL6f6wv+TJ5QfqF/JIAmQI3nIJjXPLx5otq2LhQG9T0b1F4MaPTcTQ==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr19746813plk.203.1545829805323;
        Wed, 26 Dec 2018 05:10:05 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id k15sm58740215pfb.147.2018.12.26.05.10.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:10:04 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: highbank: fix refcount leak in hb_clk_init()
Date:   Wed, 26 Dec 2018 08:10:01 -0500
Message-Id: <20181226131001.4285-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/clk-highbank.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
index 727ed8e1bb72..8e4581004695 100644
--- a/drivers/clk/clk-highbank.c
+++ b/drivers/clk/clk-highbank.c
@@ -293,6 +293,7 @@ static __init struct clk *hb_clk_init(struct device_node *node, const struct clk
 	/* Map system registers */
 	srnp = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
 	hb_clk->reg = of_iomap(srnp, 0);
+	of_node_put(srnp);
 	BUG_ON(!hb_clk->reg);
 	hb_clk->reg += reg;
 
-- 
2.17.0

