Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A04C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9AF222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlI8JS96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404637AbfBPArU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:47:20 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:47096 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfBPArU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:47:20 -0500
Received: by mail-yb1-f202.google.com with SMTP id f8so6967858ybj.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 16:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=v+K6TMNtahLc4gJ0ZCwBLLluc+v3JOLiMPkTINYOUmw=;
        b=WlI8JS96VguaFuCEyuDDpmt04rjAo9gs+gO9ZBrOXWzoRUZCBV/tKGOyQPhIHDwpwe
         PKA7A1VX5WlEf7+8qFJJGOTlfOUPzqnl/+FA1iYnAJnhAztO5r6WvQf1JyP9b+JFkG1j
         tXwZE+Ux7eoNMO+U1LQyGNSpVwk3FE5ETvb7PHm9KMNJBrStka9BFF/OsI3ZhcK3uDfU
         wcY5M9FgCGpdU2zq3m7NQ9ullU1ihI53NgdnbG3WtJs9W5urX5zvJbruuqvSf2z4LTLl
         wxfwnoqd89g2eoKQAW9lcTMNwTYDaCwXQquta/IZLi5fHzRMSDMNML85n1RqFbSbg+Zh
         LMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=v+K6TMNtahLc4gJ0ZCwBLLluc+v3JOLiMPkTINYOUmw=;
        b=fOejUDKZa2oFWOiajqCO3dtCMSwpAn7AdqopPdCU0ZzPizJE70zkQ/muh75kwlPAEY
         26aTediFwimHe5putUrVMieav41D/aaLCdEx22gzJ+uxVMaDTMQTRgWvhK1dcVGSJlGD
         QVU9ZrRdOnAawZmcofm00plHODXh6poMcmvJn42oIooeqXU/6R7pVCdpGJ8QchIh3X7K
         5y3ogm0Z5WsNbuqTpj6ycjOxpkvtdEiAfjfRlUoVlA53/f2BaGnjArz8jN8+cg2bbCGc
         17m9HsUl1i71HxuK2m3zrRZqGPnLtqyoK9WBU7R93FBZoHjFY8qV8ZrUlPBAmYt9Lc5G
         VI2w==
X-Gm-Message-State: AHQUAuZ3DIjpHCOIVBFjFcOI8FC4/ehRnuYXKvzNmL+gMXxayMhVvCLg
        soHpvGRKeOe6Alh+wdbZUljx1T4W2rZ4OnG/YqUbGQ==
X-Google-Smtp-Source: AHgI3IYpL4YiRewt1xy3RfuVGsf/Htqv2YiMply8lKhrW59jaDScC3VssXap5/Ak/29yqxqeHOUO7y6oLuVdl5wAbLs0kA==
X-Received: by 2002:a25:4455:: with SMTP id r82mr5675976yba.6.1550278039069;
 Fri, 15 Feb 2019 16:47:19 -0800 (PST)
Date:   Fri, 15 Feb 2019 16:46:47 -0800
Message-Id: <20190216004647.206431-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v2] of: unittest: unflatten device tree on UML when testing
From:   Brendan Higgins <brendanhiggins@google.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com, mcgrof@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UML supports enabling OF, and is useful for running the device tree
tests, so add support for unflattening device tree blobs so we can
actually use it.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 84427384654d5..6de34d5fa0e85 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
 	}
 	of_node_put(np);
 
+	if (IS_ENABLED(CONFIG_UML))
+		unittest_unflatten_overlay_base();
+
 	pr_info("start of unittest - you will see error messages\n");
 	of_unittest_check_tree_linkage();
 	of_unittest_check_phandles();
-- 
2.21.0.rc0.258.g878e2cd30e-goog

