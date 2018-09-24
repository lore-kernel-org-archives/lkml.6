Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0D3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA2E2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M26420oI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA2E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeIYBi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:38:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43522 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbeIYBiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:38:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id j26-v6so9488841pfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWNO2NHWP//VmQYN8e1d8FN80wkhtUktnT/RAcvUozw=;
        b=M26420oIcY+biTPMillWesqB4URZatOSKqWq2TeMl0pMN4Ln+VI/rTd6lOOvS1iwh+
         N4fNPbBmm3Pk+bOZir/kwHyb6A4OBTHhkMh1EIrPNW8/3Oka9B0/bRPvhKHoKCEr9c//
         XKs7Bc8J/OfC3Na3YGJTnit7w8lzoPTLJkzdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWNO2NHWP//VmQYN8e1d8FN80wkhtUktnT/RAcvUozw=;
        b=LWEI6YIJ8TFRv70FDcCDEQo/Y9Jur1KKk0OA9FYtv5cz7DzN6xv3nPLhZqPyQN4OBt
         UOWCJBvCVC1p21YZ9hlKG7xo9F1s2nTIb0iKH8cyDs6a1+jZBEmUTXNmLeWp00JY2zk6
         sZ2Grb2h+F4qBNJYJgn+EdO/biihBdl/jr5PjQpHqpb8lCAi1aM9WGhLGZR2szDBemR3
         +r84RxHKhsm9ExEI3dMKnKD5wx8LoxCplAPMdhz0hYbb7cj1hxmwdmwLvhV0hcvZgYqh
         nrjC+CEAcBOx/MJD8XpCCNRbzg3tLV6xaYJMRzd4j77xLky7HHp8LPQ9UMBheAfHtMH/
         fuhA==
X-Gm-Message-State: ABuFfogiz8aIA+nQRv84GFIwrVolc3dNzNC9owQRBTDqK3sVNZ6socJs
        d4P8235YzH4oO/cBYjRMbJxrjQ==
X-Google-Smtp-Source: ACcGV62YmUOTQpKZQSmAJQbloFoCiEvjEc0mh2aYco9DSOuv/Eh7WPJQzhCXHJvEk0gyDRcZYpEcjw==
X-Received: by 2002:a17:902:7001:: with SMTP id y1-v6mr224278plk.259.1537817705420;
        Mon, 24 Sep 2018 12:35:05 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 77-v6sm112234pfw.159.2018.09.24.12.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:35:04 -0700 (PDT)
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
Subject: [PATCH v2 2/2] Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()
Date:   Mon, 24 Sep 2018 12:33:52 -0700
Message-Id: <20180924193352.96335-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180924193352.96335-1-mka@chromium.org>
References: <20180924193352.96335-1-mka@chromium.org>
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
Changes in v2:
- pass bdaddr_t instead of byte pointer + len
---
 drivers/bluetooth/btqcomsmd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 7df3eed1ef5e..ff74d2c46991 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -172,11 +172,9 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	/* The local-bd-address property is usually injected by the
 	 * bootloader which has access to the allocated BD address.
 	 */
-	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
-				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
+	if (!device_get_bd_address(&pdev->dev, &btq->bdaddr))
 		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
 			 &btq->bdaddr);
-	}
 
 	hdev = hci_alloc_dev();
 	if (!hdev)
-- 
2.19.0.444.g18242da7ef-goog

