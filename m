Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD47C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23795219E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="sDLI8dvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23795219E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHFKvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:51:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42305 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHFKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:51:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so11520107wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=VU6e4GfG2iXdHiURflCugDBBIZkFlimblY6zlQ48LMo=;
        b=sDLI8dvWUyyV30hpoV1xxgWKwGm9AUVSbLNa/m8I5qTK/KPz/f9uSfrmAl7awGDPQP
         WqXaAW/XTCN4wdhrR/6AXoRskImAangY4TYkFE5lGnNRJ9N6UGVtB0M/j24cx6F8hSkz
         wjY8faH7QOAnwfaf0GO4w2fG1JKl/GYy0Kj12FG6YjtL6QytIGrgQH1TYKbRAvxibdrS
         oAsARehcgQP+P58DIVJFO6Ucwe8ZvqS7hSEkYQ7B/7fe081t6lhaZ0L3HyW7ESNSgvse
         zriVoxAKvRATr++o86ri7X9rQE9GVsz5Z3bR4DV0q8cr+fsimEEk3f8uHY5waMWAZx3o
         twIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=VU6e4GfG2iXdHiURflCugDBBIZkFlimblY6zlQ48LMo=;
        b=T/idOa9zY9zFHhiyXkqwWqFCKbdWA810NDigE8Rnz5CCw+QP9k/iitlSPOiVW2jcgY
         QfqhsKrSMY8HTpyvmp+803iOdo1J7BFehpMI13Q6XjtZ34vNM9pI2dnFnfMm7rjEAJrL
         9csVroG79BsV7Qmbx/sJ+BHSc2l5fCekpakVeXzrnhYMnnlWPzVZ9cYQf9uI3eezKwwx
         ABst4273tGpOl1d/CQfTT+XSrWZH99oxnExomUIFZCV3MBToll+CFWRvOKQSX40pKAFd
         G96IIXjvQiEmNLcnibjPWxNGQdye7GeB/bZmRznNVlxV46flfRBO9LpGXEPHfd2lkyfg
         PB7w==
X-Gm-Message-State: AOUpUlFyb5rTw0BE7EQ1sXxBNaCq7bvtNNhh0RXqqyi7fAJlKnfY9Sdk
        /tvaYmoSJ0zU7j8+g5LKDTtQIoo98AeCxQ==
X-Google-Smtp-Source: AAOMgpfEKxbOxU/ZiP8ilmGH32SubfU3IiuVjfQXSI+bgYaV85JObZ8wUU8gvpfaWWEkiWtaF6eRgw==
X-Received: by 2002:adf:9e84:: with SMTP id a4-v6mr8773551wrf.70.1533544991733;
        Mon, 06 Aug 2018 01:43:11 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 7-v6sm12333972wmr.16.2018.08.06.01.43.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 01:43:11 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-of-arasan: Do now show error message in case of deffered probe
Date:   Mon,  6 Aug 2018 10:43:10 +0200
Message-Id: <c9688c600633ce9f4d7b6319366116e6e7c4b97d.1533544988.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mmc-pwrseq property is passed mmc_pwrseq_alloc() can return
-EPROBE_DEFER because driver for power sequence provider is not probed
yet. Do not show error message when this situation happens.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index e3332a522a5d..e65f3bce3643 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -772,7 +772,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
-		dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
 		goto unreg_clk;
 	}
 
-- 
1.9.1

