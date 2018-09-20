Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F65ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59F821534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZpq8+rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59F821534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeIUEUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:20:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeIUEUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:20:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id t84-v6so5082804pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OzhjKfIiOA92KAMHhiyw66BTMWC//bJiHP0kql6Sho=;
        b=oZpq8+rSEVJEsSdIyzjpOw8f4LdJXZPGE2k1RfY16tsWRVKgewuVDdzKTSU5t2ePEu
         jl3T+xgozy0DnE/TNAjn7ePr2bkPV4HfqDtyn3z4GFKKTYufSDlS5piAE8i+OrPTNuZN
         BnN/cCcbwaM2gte4r4Bn45SDOOTrauhbrq4tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OzhjKfIiOA92KAMHhiyw66BTMWC//bJiHP0kql6Sho=;
        b=nHtNqUxHoo5EnwmLB7FQ0UdEMIuE8dxv5JhuT1Lg5YUBGvAEPL1zVAMQLJJp4mg8C2
         MtVfdaZqsakZyXjd4kyKR/55KyytPwvUNW0av/3vs6tJfeZd1MYImARCFlUAmjW/sGuG
         wc0Yn/DO3Zm+BGkwyL//26jZPDau+uV/EyT9oHoiTOmnQ0H0iiSNAXwuFsjgQkA40nLu
         GfFk1YiKcEuDV9XnlAtG+0mBNo4du91b2b8Yu8gbHarGRmAnT2ymyp5LBIymeXLw4X49
         VxwzoqZSL+aYhGoFQHX5VbCk8J8C6qiLHkiyQQ14DMMqj8vYNt/Qq9/KlxtuchfqD50N
         2+iA==
X-Gm-Message-State: APzg51CuIhetINZEvdhISCAYtj0amxsbo1LA9dh6PFhygCKE5BvBKiJL
        FMKsXh67DeMFeGzr0g+bToyNjQ==
X-Google-Smtp-Source: ANB0VdbM4MF5WIyqYcqnEGyBw2wgwgBDdqlwK72iVuFR2V9dKrKbSl56x5CdZEWjOSTCnGS4Zyu3zA==
X-Received: by 2002:a63:b104:: with SMTP id r4-v6mr2869719pgf.442.1537482896028;
        Thu, 20 Sep 2018 15:34:56 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g11-v6sm31366696pgi.90.2018.09.20.15.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:34:55 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()
Date:   Thu, 20 Sep 2018 15:34:36 -0700
Message-Id: <20180920223436.202454-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180920223436.202454-1-mka@chromium.org>
References: <20180920223436.202454-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new API to get the BD address instead of reading it directly
from the device tree.

Also remove an unncessary pair of braces in the same area of code.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqcomsmd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 7df3eed1ef5e..1f2de6aeb3dd 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -172,11 +172,10 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	/* The local-bd-address property is usually injected by the
 	 * bootloader which has access to the allocated BD address.
 	 */
-	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
-				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
+	if (!device_get_bd_address(&pdev->dev, (u8 *)&btq->bdaddr,
+				   sizeof(bdaddr_t)))
 		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
 			 &btq->bdaddr);
-	}
 
 	hdev = hci_alloc_dev();
 	if (!hdev)
-- 
2.19.0.444.g18242da7ef-goog

