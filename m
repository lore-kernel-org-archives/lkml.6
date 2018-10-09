Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF92FC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9866B214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ZVaNL5kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9866B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJIS3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:29:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37108 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeJIS3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:29:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id j23-v6so677811pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yxaf1mybmGzjHW2HTVC+BtxyEvC4U+mpI1DZvG1cwSU=;
        b=ZVaNL5kl4PaxesA8ohd5tdpKq5FYumR49uPNceug11j2L8dLEhy+vv0ogiOZWfjjzq
         /jC5DddiW2ebCtkkUESQBGtHK3ZbGxGJQBoVq/aIs5Hf20Y8gEi38FVSxntfp6Ko4MPL
         j3odnkkGfOBf4ius6GNxO6oV/JdbR+1kO8v5wVBXzN+u/Jr2at1MiUj0PBKNWLuqx+Z7
         qAKd51viSPkLZK+JYGFZsRYyV+gyByw+MR9XJsKc4hi4MX+6AS60B9dwFIkIE18ah/Od
         YeDPlocgrDdCb28+8qFAIQhdGn3X1y3sEk9v+tIsP04YJKx4RIUR1/7whSW2wnVbutsj
         LuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yxaf1mybmGzjHW2HTVC+BtxyEvC4U+mpI1DZvG1cwSU=;
        b=OUcM/0tsgyZ23BnIYa2v8K9O1z4Y6eJIYsuwDdstWbt1cKX5zm2aAOH4VquCM/LGE1
         c10O8Qo0tXCdg8XK5exq/usLuixhs4nyO5C5ehNvvRRRl4qWu5jv0fBVt+lLIC24TlaZ
         /Vk4qrRfDzXeLkyOqFs3SuKoVDDCujmDMaaZCNO9GfUjfQNW6gtvXzzJTe3WFK78JGmx
         ci9jpA8tjj2nC/rd2Bba8ZO90Un2sIsN6ygLHlUMdwbRibcbpwMYkgbVtUNZiR7fL5A0
         xF7e7P1RQ76mFmTlyGGP/O1KoLWHgAh1lWtQZr41V6hC3nVy78PrqaBgw29ATbvMVuB0
         hVFg==
X-Gm-Message-State: ABuFfojffctPQ4pf5Nl+KQCbmGHErMJfdQRDvCV8PvRlA3mg00jktpGp
        ewUJ9VosrR2Un04dcviBWaYOqA==
X-Google-Smtp-Source: ACcGV62BHCdWuknWjktdHFLPQ8RZ2EzI4GLLNLUmwIlB6KL0uB0L4VmT4wcBtnkdo2DefwjQ0UbgXg==
X-Received: by 2002:a63:450b:: with SMTP id s11-v6mr25692732pga.301.1539083597442;
        Tue, 09 Oct 2018 04:13:17 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:16 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 01/45] lightnvm: remove dependencies on BLK_DEV_NVME and PCI
Date:   Tue,  9 Oct 2018 13:11:31 +0200
Message-Id: <20181009111215.7653-2-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to force NVMe device driver to be compiled in if the
lightnvm subsystem is selected. Also no need for PCI to be selected
as well, as it would be selected by the device driver that hooks into
the subsystem.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 439bf90d084d..a872cd720967 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,8 +4,7 @@
 
 menuconfig NVM
 	bool "Open-Channel SSD target support"
-	depends on BLOCK && PCI
-	select BLK_DEV_NVME
+	depends on BLOCK
 	help
 	  Say Y here to get to enable Open-channel SSDs.
 
-- 
2.17.1

