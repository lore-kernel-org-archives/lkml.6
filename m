Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04743C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC64D2571B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC64D2571B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936079AbeF1Uol (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:44:41 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38001 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754882AbeF1Un5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:43:57 -0400
Received: by mail-yb0-f195.google.com with SMTP id f12-v6so2534100ybp.5;
        Thu, 28 Jun 2018 13:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BYYywmjJp5embejeIhk/VCtDXRH+EcxILfGn2mhUR6c=;
        b=E7mrKQng8nfrPI6QYbHVaMEIHHiB6fieiNXdyXzTVHxzO2ml+MOGsnMoMfchDhrNC/
         PA9U4eW6xwk+knjmhbhX4esOIVOHyC19YK8Is/vvgWvTrSQI+ApPRTJovq0JMBNelosG
         E91MJFhYywsxICMjWW/x5qF4J+9AiyWCy3Z5V5yWKDtFu9f/xRvx6umtDvT93WQhNMuq
         o3Dt3hk42TszWIL2rrsqNVvrGt/AZLtfVnJCPyWfWzJs2DpZwQ5GW5SPbrm0x5iJbh4W
         kCigvTmG913CZro8tvGKn7eGUhWmzzKRXddX2cjlRufac7GVs9jQ0+6o3mk1O4vRrb7v
         V85w==
X-Gm-Message-State: APt69E3zrbnZzT0rk8dCHzi8Nk5wwUuep82aq0I8F5XRZ1Q2OLUx5NWB
        bHuFsS50Wl6kWHV+s0w/jA==
X-Google-Smtp-Source: ADUXVKIomTVFkcvIVYGC7D7JmJLUKa7yR7LKexF8VtpSsC6al7KyDomFcolZ0OTKIinPcqpqT4Cyfw==
X-Received: by 2002:a25:2d43:: with SMTP id s3-v6mr5985146ybe.108.1530218636717;
        Thu, 28 Jun 2018 13:43:56 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm427913ywi.32.2018.06.28.13.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 13:43:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v3 4/6] iommu: Stop deferring probe at end of initcalls
Date:   Thu, 28 Jun 2018 14:43:42 -0600
Message-Id: <20180628204344.13973-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628204344.13973-1-robh@kernel.org>
References: <20180628204344.13973-1-robh@kernel.org>
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
v3:
  - Update to new function name

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
