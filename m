Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5046C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A797A20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A797A20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeH3AB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:01:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46514 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH3AB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:01:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id y207-v6so11339070oie.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 13:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hGXmEZMAuav9e4w9TdAfIopv7HbS/hsmurNf2ijiRPY=;
        b=qDIc9j4dIUTKIC0NS56e1GhoQOYRy9yBHpKxh8cUvGebsrnDSqiZuCwx3pm3oZdXi0
         YFse+60UXkU8GcZ4r0LZJM9ptGMX5+PvAGh0sjRjYJ8d5Q55KfRO69JE3Xl4FrRqYQ8B
         ERs2beP0o8jyZCvFmtvc/9prlBaWo2hIYoiCu7xh3yp3I4xkVPfrrcsJHtYEsKw78Jbn
         wfPYEgY1HBaqPnhOs+iuI7Z1EBmD9THEFtK7Ht9nokIo+gZCiIO0f2AXCwF9PW9fTYcX
         HxJCoBHQZSJ7+QQsAwLQ3WggbQhPvTje+MkRqj6ORE/HDqTf+5tlmOdPs83BVyz8hzmw
         oH6A==
X-Gm-Message-State: APzg51DnK/uFED3vOHnqgxVgoRsXTFON+oNTNhXeyoYgWLRexyyMvnl6
        LL3JObS+K/XVxBG7LxT1qw==
X-Google-Smtp-Source: ANB0Vdbpc27acNkXeMGHu5qtw3Kjj0mkecYWjfCrsbZRqMWffF2O8x5t8aQtqQjs/+PGKj4wiU2WVQ==
X-Received: by 2002:aca:ac54:: with SMTP id v81-v6mr4028335oie.1.1535572979789;
        Wed, 29 Aug 2018 13:02:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id i132-v6sm3515814oif.20.2018.08.29.13.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:02:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] bus: imx-weim: drop unnecessary DT node name NULL check
Date:   Wed, 29 Aug 2018 15:02:58 -0500
Message-Id: <20180829200258.14463-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the child node names is pointless as the DT node name can
never be NULL, so remove it.

Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/imx-weim.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 6a94aa6a22c2..d84996a4528e 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -156,9 +156,6 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	}
 
 	for_each_available_child_of_node(pdev->dev.of_node, child) {
-		if (!child->name)
-			continue;
-
 		ret = weim_timing_setup(child, base, devtype);
 		if (ret)
 			dev_warn(&pdev->dev, "%pOF set timing failed.\n",
-- 
2.17.1

