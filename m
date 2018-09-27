Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A81C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1DB21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SRhFElSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1DB21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeI0HE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:04:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37449 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeI0HE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:04:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so576680pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 17:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWYnNtZ4a6D8LyJB9LjwUCYzhe7IWzyM7UwIqps5/hs=;
        b=SRhFElSocMu8D3UWzkzHzHJ3uZfTcieZLbfnUE33wZ/jqaT9n7P4DfXlelYrhJoGhn
         micCEpRenFOghg0cMhxnDPWbhTm6s1mEuWSOClzeRH+3/4rby4zBZRvdg+2X0rDs3DK+
         pGgOHFbNS5L6XZJCExxxozvMtH2VGpzXOfCO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWYnNtZ4a6D8LyJB9LjwUCYzhe7IWzyM7UwIqps5/hs=;
        b=rmDLmmNOo+BcnUuQ6x5TpfckGDluM+Ses/tO29kexqVSXagYNiFCsmd4otD7zUOCKI
         1IeCcyYzuCmb3BW0lEVSCwAXpIohpLeMB9b75JSya/rzzK1kuVhrSxWlitr9AkDEiBYd
         XYVK76PVoBQ7GiJR+T7nHrIYCAbzHi9/GSuKr76K/u/wFuyCLwrrtV6W4vQ5pdzjfqAS
         csgoig1n37CsZMeND/MUDJBtMz0z+0GCUMjMg1JH0sGd8RcDDzJuoDPRcCVWsTVqKNY0
         32lUnMhoghOHrwqQq44tbFce4LqZ2aBPluL5KzSdDlvZ4I2risAmB/t31ny2PD4y2RE9
         +8bg==
X-Gm-Message-State: ABuFfoh4HkP5l2M05I6uHslnwjOFqxCjMqPTr89//miZcviCbkb0MFXV
        OnGypthAZsMwfbDOWDRckWE3QA==
X-Google-Smtp-Source: ACcGV61eBwlDseiX1qB1V5mDs2SaQ+uJ6fdx3t/6A9CVVNdWiKkSoU2FvLO2h0SFbtGtXjSBYzKQCQ==
X-Received: by 2002:a62:9402:: with SMTP id m2-v6mr8503794pfe.3.1538009332749;
        Wed, 26 Sep 2018 17:48:52 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g3-v6sm404173pfi.9.2018.09.26.17.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 17:48:52 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 2/2] Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()
Date:   Wed, 26 Sep 2018 17:48:10 -0700
Message-Id: <20180927004810.124185-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180927004810.124185-1-mka@chromium.org>
References: <20180927004810.124185-1-mka@chromium.org>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Changes in v4:
- added 'Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>' tag

Changes in v3:
- added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag

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
2.19.0.605.g01d371f741-goog

