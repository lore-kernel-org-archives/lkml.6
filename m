Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8415C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E4B208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E4B208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933745AbeGIPnT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:43:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36365 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933298AbeGIPmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:42:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so36734191oie.3;
        Mon, 09 Jul 2018 08:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vCohodIIanHa5uBHiQc1B5XPmGoIOIBepeJZ6BKWz/A=;
        b=BB4bCSMXthArGkBcU9Np4Q1RCclRmnmhabBi/PWZIsGOGXrVCbZCctjoTA0kZ2kiVX
         bo/UNxpbalQEMY9/FnY7SiAFJ+vU2sP+OZlMNwzkw0CHw4Tia4Az5bxx2SF5oevqQrak
         HxuDo0vnwiYgf00ogrsevx+A5s5He8WU0zQOEtmQjujZPRxZI11OyKxkPlP82CVvGkAh
         vI/z7nbQx/wwwc68ZezQLZ0brJb+3zPfJR1nuEqIlReIeqxXgYhdjooua34SGDh6/DA5
         CE9l0ssklr+702Hz3UQkMZvKQIE0KW9oGyKJzA9g1A3YKRsUcLOxPhvR43Hpp3L8SLbJ
         FPng==
X-Gm-Message-State: APt69E1TMOQpSt59/4f7w9Krnf/dxGhfkvCsVcu0I84sG2p2S6bQZ+7c
        TwqtZc1GmjWS6QCKB6RCAA==
X-Google-Smtp-Source: AAOMgpcVsK9pE3GmbjoMb+sCcd2ti4BHHvjDm2ZqbwQZ9apE6LJKfhvRofBxFF7TQtPmN4mku/CCSg==
X-Received: by 2002:aca:b60a:: with SMTP id g10-v6mr24442586oif.263.1531150925929;
        Mon, 09 Jul 2018 08:42:05 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id z196-v6sm30759391oig.12.2018.07.09.08.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 08:42:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v4 4/6] iommu: Stop deferring probe at end of initcalls
Date:   Mon,  9 Jul 2018 09:41:51 -0600
Message-Id: <20180709154153.15742-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709154153.15742-1-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU subsystem has its own mechanism to not defer probe if driver
support is missing. Now that the driver core supports stopping deferring
probe if drivers aren't built-in (and probed), use the driver core
support so the IOMMU specific support can be removed.

Acked-by: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b7656a..78ddf47dd67a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -133,7 +133,7 @@ static int of_iommu_xlate(struct device *dev,
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
 	if (!ops)
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_state(dev);
 
 	return ops->of_xlate(dev, iommu_spec);
 }
-- 
2.17.1

