Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18296C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44A521773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MGCHXsMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfBSUGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:06:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35179 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbfBSUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:06:41 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so10644002pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MGRqrQVQyGxNdC0m/ka/+qbw93u2w5weT+n7xzWmAE=;
        b=MGCHXsMuQhEMMd9ZBxmbrkDRdkAXXBb/JzKjhF9HXQQ/iSK7NFzv7n0CKTQIuE0gN4
         Qo4CqkZ1L9d685fVgwB+/OrQga0zWK127qyNlVOnA4LP8y6TBllhRpU73K9Uvno+nIcj
         oOht0W67VJ2SuZatfOxE5QZ+YKGhnzJFKIKAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MGRqrQVQyGxNdC0m/ka/+qbw93u2w5weT+n7xzWmAE=;
        b=AfPrA3sdnidH+5ZJJGq2UpiP5eMKLM7u2u2rw3Yrr/iOia0/rgPxrJB3UjcoYq/2DA
         mfUhKjvsNtUdNdFDhwRMO1//aiai46Lj2RYPk3/qy4VYDHNWmdyhD6oLelJC4uxdvSOF
         5cI/U0v7fhZ7Uqlsm3uHu4bP2DYBW7ewA+BX6ZyPbncJftSrh/gzCoCuUE+AqXjecE2W
         CHjx9K4iGj4YyFs2Y7XPgWzRFIzSzPUwp8+eG06y5iyYk8oKC/ZoVXTFvRhUXxRo2Iq3
         rHzNhIxxsPoIdLU4UxlIGPyf9VymjtP8Er2s6h7u6W/gyHkfJFIR3Wt3ukcYwHNvtg5k
         sGbQ==
X-Gm-Message-State: AHQUAuYeo7p9exi3Q5l4I8dGG+OzUQ1q7d5d/SpUE1LfIs1vd2OputPh
        hHZDr7+oCLEgIDo9j/h1SjK0Ug==
X-Google-Smtp-Source: AHgI3IZMzNWSjtlVr2uHHYnEEE5obv1ZzRRJYI/Mtn30+B4JCJhqFoNy+GKO8EWlZdy0Jc7HHPG3iw==
X-Received: by 2002:aa7:8508:: with SMTP id v8mr30999719pfn.14.1550606800766;
        Tue, 19 Feb 2019 12:06:40 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s73sm50115476pfi.124.2019.02.19.12.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 12:06:40 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 3/3] Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990
Date:   Tue, 19 Feb 2019 12:05:59 -0800
Message-Id: <20190219200559.13079-4-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190219200559.13079-1-mka@chromium.org>
References: <20190219200559.13079-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set quirk for wcn3990 to read BD_ADDR from a firmware node property.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v4:
-none

Changes in v3:
- none

Changes in v2:
- patch added to the series
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5e03504c4e0ca..26efc2ef98d9a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1192,6 +1192,7 @@ static int qca_setup(struct hci_uart *hu)
 		 * setup for every hci up.
 		 */
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hu->hdev->shutdown = qca_power_off;
 		ret = qca_wcn3990_init(hu);
 		if (ret)
-- 
2.21.0.rc0.258.g878e2cd30e-goog

