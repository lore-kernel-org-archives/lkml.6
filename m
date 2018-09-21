Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A95ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01ED2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="arHHQRsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01ED2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390335AbeIUT3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45256 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390310AbeIUT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:50 -0400
Received: by mail-io1-f66.google.com with SMTP id e12-v6so12191870iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t41XhcCcu+sGwNEig7soNugPq9+VfgPhE6sHZdyZ9I8=;
        b=arHHQRsWgLw9a+xbYf0I699ti6n5RgDJkui6P8tuwANMwow1cB+wNvT6dO/2dkv3Rm
         5j2KRiu92BYDk583OkNHSbtZTe1kUSL+1zjiw8odH4dwQrcFhqI9/i5hsumlq69LqkGD
         3vW7IPp2NhW3fbQ5NQ+UmITXr2gsr8I3pZKPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t41XhcCcu+sGwNEig7soNugPq9+VfgPhE6sHZdyZ9I8=;
        b=ugNskS35D5yerIJWIk37Zi4typW7y5NrCwQEMpKfrs2R3tti7l29x5k2HRjDhseZMc
         sK5GbKff+l/ilHWbsDN7tUgXjWnMoXSPfUs19CaGlCPh8XA+Mp5+3BypqTD+WKAFJH9G
         W2Eua2qPFaRRSv0LAjXnSHJOaNux9P1kXR8kDBv8b3ZRxgTaJVhxMhLG2eh8EObvT3WN
         CpWK4KaYc5fr0IBT62u0DZnBybd7OO/ecZxHcUtQRuPV2VohEOpWHxWYiSZXjFK9/lfH
         KdN3+ECdAgYeWop9FYeRs/66djXDu43q+qm25H1e51eOKUY/HOYce2ULjaBhSJq4Is/Q
         k2mw==
X-Gm-Message-State: APzg51Cdq9FoujZEng8d5LwnfgguVZ2W17PoW52xWA3JJpZIrsh+eQ0a
        U5oqpg7ZoREStQEmEbUp77M0chqxuKE=
X-Google-Smtp-Source: ANB0VdZcvedZMySc1J12h8P62B58KS0m6YbObTTjind293sQSL/385fIlN612x5kRwYUqHzu1OfWVA==
X-Received: by 2002:a02:380c:: with SMTP id b12-v6mr9634597jaa.42.1537537255094;
        Fri, 21 Sep 2018 06:40:55 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:54 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 18/26] Documentation: nvmem: document cell tables and lookup entries
Date:   Fri, 21 Sep 2018 06:40:18 -0700
Message-Id: <20180921134026.4596-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Document the new nvmem kernel APIs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/nvmem/nvmem.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
index 8d8d8f58f96f..fc2fe4b18655 100644
--- a/Documentation/nvmem/nvmem.txt
+++ b/Documentation/nvmem/nvmem.txt
@@ -58,6 +58,37 @@ static int qfprom_probe(struct platform_device *pdev)
 It is mandatory that the NVMEM provider has a regmap associated with its
 struct device. Failure to do would return error code from nvmem_register().
 
+Users of board files can define and register nvmem cells using the
+nvmem_cell_table struct:
+
+static struct nvmem_cell_info foo_nvmem_cells[] = {
+	{
+		.name		= "macaddr",
+		.offset		= 0x7f00,
+		.bytes		= ETH_ALEN,
+	}
+};
+
+static struct nvmem_cell_table foo_nvmem_cell_table = {
+	.nvmem_name		= "i2c-eeprom",
+	.cells			= foo_nvmem_cells,
+	.ncells			= ARRAY_SIZE(foo_nvmem_cells),
+};
+
+nvmem_add_cell_table(&foo_nvmem_cell_table);
+
+Additionally it is possible to create nvmem cell lookup entries and register
+them with the nvmem framework from machine code as shown in the example below:
+
+static struct nvmem_cell_lookup foo_nvmem_lookup = {
+	.nvmem_name		= "i2c-eeprom",
+	.cell_name		= "macaddr",
+	.dev_id			= "foo_mac.0",
+	.con_id			= "mac-address",
+};
+
+nvmem_add_cell_lookups(&foo_nvmem_lookup, 1);
+
 NVMEM Consumers
 +++++++++++++++
 
-- 
2.19.0

