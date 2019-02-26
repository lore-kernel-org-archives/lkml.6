Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B87C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239EC21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c60oDsKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfBZTrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:47:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42368 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfBZTrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:47:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so6689084pgl.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W8vR9DkaPXB+C+IikuSa0lzVAR7OK914V7l/PlRnyfQ=;
        b=c60oDsKFAky12phibB7pjWRevCrSjI2/XqQSOlDoBNaGBUf2yIBmJ101++lYFrAi8T
         MOdcQmcbT5wf+aonYpsC9fqtkgN7Ls8DZxvlOsm4gJBFtwAMsfz2gKeEcmpM5VIKoQxr
         toLh3nZ6svPNAW51gE8d7jpM2CAglwSXsYVpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W8vR9DkaPXB+C+IikuSa0lzVAR7OK914V7l/PlRnyfQ=;
        b=hqbdNLAfQrureCikQL7k2jDuiSl4ObXwmmUpXE4qgbAnhLf6RVkwXzAFCgCuqRbYB+
         nCrF9mutljHHYJPC3jefMKofh4asdXYFWUTLbWc4gWU4toinvCfcocZoB4vHIoFJPx4b
         bjiexHtlTvCsur+AcAMDVTldsVSsrbTsdVMQaZXMmXa7JC02HDe0wL6PG5YqZ7wRErui
         jWf6cGH/oLNqMsy1eq6Na7BDntcNYAXdmhffSq/f81jhN8GjSroOLj+A170b8VPO8xW+
         Mg8dwO9Ix+Bkw49Z2eVfcEnqbBLfFQH6f5E1NOeNNewW/acKqnBkMkm2We10E7cErfka
         bmVg==
X-Gm-Message-State: AHQUAubkaoPjGBYw2g4W7ya8/ayiAZS1fd/JTi5PLR6Au6LHXQix2cr2
        xUK7MmVRgPC/b9PL1JEYgyJGMw==
X-Google-Smtp-Source: AHgI3IYfIIvhODUPUWXMm8gpx4N5NuoQu4b0tFHwZr6XHEtDefeAK84XMtpyuqLI5htVIEsEoB/0dg==
X-Received: by 2002:a63:3fc8:: with SMTP id m191mr26189247pga.240.1551210423461;
        Tue, 26 Feb 2019 11:47:03 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r6sm15766498pgk.91.2019.02.26.11.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 11:47:02 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 2/3] Bluetooth: hci_qca: Move boot delay to qca_send_power_pulse()
Date:   Tue, 26 Feb 2019 11:46:46 -0800
Message-Id: <20190226194647.146078-3-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226194647.146078-1-mka@chromium.org>
References: <20190226194647.146078-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After sending a power on pulse the driver has a delay of 100ms
to allow the host controller to boot. Move the delay into
qca_send_power_pulse(), since it is directly related with the
power-on pulse.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v2:
- added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
---
 drivers/bluetooth/hci_qca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e4128774e9686..eacc108c422d0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1036,6 +1036,9 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 	usleep_range(100, 200);
 	hci_uart_set_flow_control(hu, false);
 
+	if (on)
+		msleep(100);
+
 	return 0;
 }
 
@@ -1148,9 +1151,6 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 	if (ret)
 		return ret;
 
-	/* Wait for 100 ms for SoC to boot */
-	msleep(100);
-
 	/* Now the device is in ready state to communicate with host.
 	 * To sync host with device we need to reopen port.
 	 * Without this, we will have RTS and CTS synchronization
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

