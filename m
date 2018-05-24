Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031526AbeEXRux (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 13:50:53 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38830 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031263AbeEXRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 13:50:43 -0400
X-Google-Smtp-Source: AB8JxZqAST1Wzn6wmBY6e408WWGnBYN/BpOiVPoN1Ol7AAAmeGyAAuPqkeZIK+81M74YJWB1V5sj7A==
From: Rob Herring <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Subject: [PATCH v2 6/8] iommu: Stop deferring probe at end of initcalls
Date: Thu, 24 May 2018 12:50:22 -0500
Message-Id: <20180524175024.19874-7-robh@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU subsystem has its own mechanism to not defer probe if driver
support is missing. Now that the driver core supports stopping deferring
probe if drivers aren't built-in (and probed), use the driver core
support so the IOMMU specific support can be removed.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b7656a..2aac8387717c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -133,7 +133,7 @@ static int of_iommu_xlate(struct device *dev,
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
 	if (!ops)
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_init_done(dev, true);
 
 	return ops->of_xlate(dev, iommu_spec);
 }
-- 
2.17.0
