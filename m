Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052C0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A700A2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A700A2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeH2XCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:02:17 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37130 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeH2XCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:02:17 -0400
Received: by mail-oi0-f67.google.com with SMTP id p84-v6so11094351oic.4;
        Wed, 29 Aug 2018 12:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fHkN3TqHBib3toXib2eGl+qoStY0IuzSkewJYyGXkFs=;
        b=dspjeeq8i/7U3sYAQ9SGg1CChvx4Tb5KqFZVdl09T9bE2IVaXNJvEqZy9/cbh9lGBi
         tcfJHRnsSwomfXz+nRAyzVUyH0w2wB/ogUjqqspmqrAtmPMQGl/0NxMM5J+1g0wheuGs
         i3eHKO/qSWVguDFO22nJAbUccml/sWlP/NQJdSoZHGV6S4HiEQG111F6Ae71ciFx0GW6
         GogkqJ69Jcms4MS2xD6NYKquxCWu4qyGlojuBMthgwVrFpTy1q/mHfPRqGX6+EwmUgOv
         LCqdxdLJ/4YSYFo34sw9TZvvbZXb2ZKOXmbL+ffObMY1A8InXvL8QgRd5uhS4heTrkTw
         hufA==
X-Gm-Message-State: APzg51Cy05m1pwNhv88zf17o3izJK2aMo5z5JJtX9oGPE1kG1Mv4e+dZ
        ddRNE3KGgcEzSX/0vTmDTw==
X-Google-Smtp-Source: ANB0VdbMMV+sh0Ms25eABwmZdKK9k1dhB0cnFmPGQov54x/qXqi8wkIHtwL548iPIlZ75U/OrqyiKQ==
X-Received: by 2002:aca:c257:: with SMTP id s84-v6mr4241744oif.104.1535569442095;
        Wed, 29 Aug 2018 12:04:02 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s133-v6sm6004326oie.4.2018.08.29.12.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 12:04:01 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] of: make PowerMac cache node search conditional on CONFIG_PPC_PMAC
Date:   Wed, 29 Aug 2018 14:04:00 -0500
Message-Id: <20180829190400.23146-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache nodes under the cpu node(s) is PowerMac specific according to the
comment above, so make the code enforce that.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 466e3c8582f0..cadcb470198a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1963,7 +1963,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
 	/* OF on pmac has nodes instead of properties named "l2-cache"
 	 * beneath CPU nodes.
 	 */
-	if (!strcmp(np->type, "cpu"))
+	if (IS_ENABLED(CONFIG_PPC_PMAC) && !strcmp(np->type, "cpu"))
 		for_each_child_of_node(np, child)
 			if (!strcmp(child->type, "cache"))
 				return child;
-- 
2.17.1

