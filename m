Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BECFC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B56208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B56208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeH1FoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:15 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37995 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbeH1FoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:15 -0400
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so21020oix.5;
        Mon, 27 Aug 2018 18:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KE8ECiVSMn5GwOzqAhr1hAu+EuoVhYPrDThOPf9QjjU=;
        b=JvN4QBQJObRtQetUaZ6+nVFj945Es1E42M07gVsryvW9RiR+MMn/W2pNGJ/m3QjI1E
         zcnJ1O2TuUeM7JGQMvDRKIAR8vWgmd9D/4fxNSzJA8+jNicia1eN0ifbI8/q6Zdas4Qp
         PNSCBlyyQIBwIlEiGMbOf3HVmWFHjQK4IKvBpgiWQwIiwSLvHX5UXCMZvCgilRb5K5Cs
         6SupoDe+FMjUo+kD81p9MLMR1xsPPSUu5DXRjpm6q9U22ILzifXT352glN5MJaMmNFxF
         kJJ7Y30qzavXdTiTKd3go4vORk9AQWk7GyLSXLSER/rhBIiS0H+KWBCeYOjapZ3IFh7S
         HyPg==
X-Gm-Message-State: APzg51AS2uqohWcZIjjy66f8J5TmXGaAVhWotY2FgMWXzre+xdiBMiRG
        42WFqRXfuvsPlseFBjBRWxvBjTo=
X-Google-Smtp-Source: ANB0VdYJs8LCgQUydrZ5CwGedsyxYitLRT5yySTJ4tPpj5rihV32++S8dHK3M694wTkCFGb5flMyQw==
X-Received: by 2002:aca:2111:: with SMTP id 17-v6mr970369oiz.241.1535421298953;
        Mon, 27 Aug 2018 18:54:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:58 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:33 -0500
Message-Id: <20180828015252.28511-32-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Hu Ziji <huziji@marvell.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mmc/host/sdhci-xenon-phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
index c335052d0c02..5956e90380e8 100644
--- a/drivers/mmc/host/sdhci-xenon-phy.c
+++ b/drivers/mmc/host/sdhci-xenon-phy.c
@@ -660,8 +660,8 @@ static int get_dt_pad_ctrl_data(struct sdhci_host *host,
 		return 0;
 
 	if (of_address_to_resource(np, 1, &iomem)) {
-		dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %s\n",
-			np->name);
+		dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %pOFn\n",
+			np);
 		return -EINVAL;
 	}
 
-- 
2.17.1

