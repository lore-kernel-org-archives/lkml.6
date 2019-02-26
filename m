Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E27C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A171621850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZbNfc+NC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfBZUJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:09:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38028 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfBZUJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:09:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id n125so6767052pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9bydIjkJvQeP646HWra4cnTdSBpscFlb5vRPAaztmI=;
        b=ZbNfc+NChjF8exwxjDOCpAUnKf6UTVVlnDkJYd0IL+M0KR+2UmZXNrNa6BJJHzeU0U
         TEgZ83lr6zt6rsHimxcBs/OqnlWdE5YvGhj3s4F5k+NaZWvgFM5asLo863emJM3jO/UT
         yn816JtXS5kWgbqlxD0C8pT0BoXSklVL8bdKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9bydIjkJvQeP646HWra4cnTdSBpscFlb5vRPAaztmI=;
        b=TeYJenJqyDntPCTxzt10mS4WFF3gJeHk5VyNLw9g8PtF5zFenaHwdSis+4IdC6rfW9
         E5A3eN/3IQfkmfdMcZBZTyNvNpgo7zY6OOxG+vdMh+NGmKFOFkOTs/cow1HIHorz/b+y
         OJ7CCvZ/BUTjdTi86euzE99zip488wKlGuxtAMJVfEjtJY+i1MZgR+3BW3xbM/zgK+Uu
         4t0bdkvyQTw3HBNi1UoXjEFPTDs0pBJn0n2E/QVW9MR8Vu9EE53JUuZoO139Na7ufcxT
         Z8kiawqKc9PcV+jXjznTvgKceX9eNCEwUR4oo4/CG/W3uqcULT/vd1XfTo31MiTA6sSx
         rRAQ==
X-Gm-Message-State: AHQUAubbiPbuMxsxxcR9k5RFCU00rSJkPnTGtbbuZ2dOm868A4EUCZMA
        efzGKVN2s7i9vUbaT90X6/gC9g==
X-Google-Smtp-Source: AHgI3IbSx0W3MLt5C2sSm0Km9nAgKy6Rf0rUY0CVduDlQv8ZT4uMtNVxWIsOqlXlp9aN1EBfcN3BVA==
X-Received: by 2002:a65:609a:: with SMTP id t26mr25602080pgu.411.1551211743812;
        Tue, 26 Feb 2019 12:09:03 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l5sm7637328pfi.97.2019.02.26.12.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 12:09:03 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] hci_qca: Use msleep() instead of open coding it
Date:   Tue, 26 Feb 2019 12:08:47 -0800
Message-Id: <20190226200848.154216-2-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226200848.154216-1-mka@chromium.org>
References: <20190226200848.154216-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call msleep() in qca_set_baudrate() instead of reimplementing it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 26efc2ef98d9a..703e099515f24 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -989,9 +989,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
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
2.21.0.rc2.261.ga7da99ff1b-goog

