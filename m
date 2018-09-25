Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C6DECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B347206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aWIHpjva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B347206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeIZBTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:19:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33214 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeIZBT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:19:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so8947548pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R6+1q7wcqXruOMuQ5i8D8phZzRIqjo3PhmPKpv0q26k=;
        b=aWIHpjvaLB8GmKCtqWWsG2rWvD2y1WqrrIq1OdP/65GNreOU+D46LAtVyunz5Qf6BH
         NmFr9xnqLOjyuYXZqG9/FmwtZNlzY8B6FtNyV6jDxRgUCbFX4wPJXxJzgVK5SOQ8Gy7u
         jP+1YjPUff1AsZptPeN6AJEQiCjTcZFUZDwGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6+1q7wcqXruOMuQ5i8D8phZzRIqjo3PhmPKpv0q26k=;
        b=SAz/AdwJ3WnDMWnIXyBiozgkjBrgj8yote8awZ+i+WWyadSDojaNtw0/H/vXWo7rVI
         9TeV5BeLkU4Wbn3OLN22F9R3so6BpPlQkF1mXorgOZGm/VHJZUEIItaueiSfMpOkyzlJ
         EqJWLDntPA8s4cyibEsQ9l1aWR8BoYxlUz3HXBOOvWLxSInE+9RLOtal9u49BODGi4R9
         7jUkQEAO+9i9/BvGXWY8DYVPa2K6UhEry3R+fiZ9Os1CigxjtQswwcNs809m4eykNreY
         PZx9V+u2g33/luDVkDTcy3YP2zlnoxenzl2fyZUy49t6dJuzcGJh0tYa0oSx7MdZ6TfM
         nUrQ==
X-Gm-Message-State: ABuFfohUXZxUCeAlxL6bk/NWQiiP6WLTAfDwJui7muAECB1g3V3iHAbe
        FWlsdHV4RHhYPIhW2A3qMtPlkQ==
X-Google-Smtp-Source: ACcGV61xpWecUDtCTLlYv1v63LnhyNhWWG4911tnzT65aufU16mTZPXGUBrslMsMTADevO6k1zl6Ag==
X-Received: by 2002:a17:902:694a:: with SMTP id k10-v6mr2464437plt.166.1537902628276;
        Tue, 25 Sep 2018 12:10:28 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p4-v6sm5082718pgs.75.2018.09.25.12.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 12:10:27 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3.1 2/2] Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()
Date:   Tue, 25 Sep 2018 12:10:14 -0700
Message-Id: <20180925191014.85573-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180925191014.85573-1-mka@chromium.org>
References: <20180925191014.85573-1-mka@chromium.org>
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
---
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

