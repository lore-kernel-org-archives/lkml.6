Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755C1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAF326E1B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nc4z9nN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAF326E1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753085AbeFZRHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:07:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45270 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbeFZRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:06:57 -0400
Received: by mail-pg0-f67.google.com with SMTP id z1-v6so7890637pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6u6skc5JtH2hk815ltBe4z6R74w7GY2bpN3RFLzQA2o=;
        b=Nc4z9nN+QNPYwT5EPv6D153UPqj9B3a57SL8+jwAOKUbm5BP5bBomfOHwmXy+XSWOr
         D6MSKVz0slDEhrr7IaH9L3zQXd7N6pNrBzv4D1FeNQ3pB9pA/tUVWulH2TP07cgXal3G
         SICGabVQKxZ2/L8WKY3IsyVIYQE8MyNP8G1pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6u6skc5JtH2hk815ltBe4z6R74w7GY2bpN3RFLzQA2o=;
        b=Rg50xRrgVX32vJIpXVPO7g5cJRBN6pfKSgpN9hPaKtk8MIb5wmJ59TyE1naSpQ16RC
         Wh9ufmJG2ZbOyBvPAIJol2k7I2LmXjNqCfwVCsOVW36i2KGzFSVhyPMWxOgVQa2pMlcZ
         rmWm6dV+M8UgDu/Eyh+PEgpYoKB2YEbSVBbbaZn/IE+0nw0gpHfdcboQlnh6zq98XAD7
         O0mRIYQKs5il1Kv3oEqlt2krrBcSz4Y/UTILtoSHM36COuS61HbYE3zEI6djrfpSoy6b
         gVJ8ClxN5vN1ibZlLK7qEVGshsOHYubaGOKkVlanfHBLYgk98UqINlzJOl6n+vgwMdQz
         fBcw==
X-Gm-Message-State: APt69E2767b3gvlIrLclmL12XxQmYYNkSAWmabn3BUr3vYi7DAwq7lRU
        c7cT1eUTrQC3FtYciVHzWvz99w==
X-Google-Smtp-Source: AAOMgpdcEeBHKX6t9M86GCdQjCV68k7FhCU3hOf8qfE16iIv4zgX7JJS0nf92MV8MOAlPsewMTI5wQ==
X-Received: by 2002:a62:cc4d:: with SMTP id a74-v6mr652682pfg.200.1530032817049;
        Tue, 26 Jun 2018 10:06:57 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id u14-v6sm10664493pfd.103.2018.06.26.10.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 10:06:56 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
Subject: [PATCH] Bluetooth: hci_qca: Replace open-coded msleep()
Date:   Tue, 26 Jun 2018 10:06:54 -0700
Message-Id: <20180626170654.96831-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three lines make up what msleep() already does, i.e. setting the
task to uninterruptible, sleeping for so many jiffies, and then
schedule() already puts the task state back to TASK_RUNNING when it
returns. Make things clearer by just calling msleep() instead.

Cc: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 51790dd02afb..ef2b00bdf06d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -908,9 +908,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	 * controller will come back after they receive this HCI command
 	 * then host can communicate with new baudrate to controller
 	 */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
-	set_current_state(TASK_RUNNING);
+	msleep(BAUDRATE_SETTLE_TIMEOUT_MS);
 
 	return 0;
 }
-- 
Sent by a computer through tubes

