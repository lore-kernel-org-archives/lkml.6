Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E8EC04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF9720989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 04:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kr9E7P5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF9720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeK0PrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 10:47:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33574 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeK0PrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 10:47:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so7038989pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 20:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yL4PxkCnnwRXSRf/RUNTt7B9beLsEOSxMycnGtl5vO0=;
        b=kr9E7P5rEKeJsGjS9iYegj81caGmrU5npROkRpqSUAw4FnBHH0lOiMtdPCjiPAs8zY
         MdUgB51sMj0c/MEBUK0lmVn6y4QGPh10NqwbrTX+NsJF6GFO5vdomxnk7ByLurGOzJEh
         lCsUc6mQfEFu9xbuCLNdpcP7wEn50z9BixzWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yL4PxkCnnwRXSRf/RUNTt7B9beLsEOSxMycnGtl5vO0=;
        b=mX6teoGp5IqggI8lsir8neWWXwZ16p6341hPLZJCC8v92ttXcmYjlj0hUeYRyerhgQ
         zcpiMh3ZHfhsA8VudfFg05G7c/i3kbHahFrCLmhx5rs3XRDUGjIdoPzvoY/a6Ds1IgKB
         dNq/8t9GBuGEMUHEIUAt+sBW3QgltaW6xinNP2uZ5Ix7VnEMQIS0PU/K9pYuTrcYl4jZ
         rMLCanfrLCbBB9kR1uaEpJa2RjQmQLCXD38J1LgX5LrKUJiwRluRNY0QHq0D4vZdSulu
         PMkQfe3o433gsvWLpzUpmmZ1/+hZqAXWJ9IqF5COwTVrXs5eTAw+kHqifp7w/kXQQdZd
         720w==
X-Gm-Message-State: AGRZ1gL13mIUkZuN3yGQcDHRs86LYyZS3dGXz34YF5j3OWJG0yrOfpZQ
        omeo8lgKqsS3MZj2HllrtmYv/w==
X-Google-Smtp-Source: AJdET5ceT5FmBEB9jXiY987LDEfyAHsID3c6C3zlLPkpZjogACe1zoJ5/8U1LMcTMUxOEZzAfdhQfg==
X-Received: by 2002:a62:ca9c:: with SMTP id y28mr31183704pfk.236.1543294231722;
        Mon, 26 Nov 2018 20:50:31 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id z7sm4115875pga.6.2018.11.26.20.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 20:50:31 -0800 (PST)
From:   Peter Shih <pihsun@chromium.org>
Cc:     pihsun@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: 8250_mtk: always resume the device in probe.
Date:   Tue, 27 Nov 2018 12:49:50 +0800
Message-Id: <20181127044952.45703-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

serial8250_register_8250_port calls uart_config_port, which calls
config_port on the port before it tries to power on the port. So we need
the port to be on before calling serial8250_register_8250_port. Change
the code to always do a runtime resume in probe before registering port,
and always do a runtime suspend in remove.

This basically reverts the change in commit 68e5fc4a255a ("tty: serial:
8250_mtk: use pm_runtime callbacks for enabling"), but still use
pm_runtime callbacks.

Fixes: 68e5fc4a255a ("tty: serial: 8250_mtk: use pm_runtime callbacks for enabling")
Signed-off-by: Peter Shih <pihsun@chromium.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index dd5e1cede2b58..c3f933d10295e 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -213,17 +213,17 @@ static int mtk8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		err = mtk8250_runtime_resume(&pdev->dev);
-		if (err)
-			return err;
-	}
+	err = mtk8250_runtime_resume(&pdev->dev);
+	if (err)
+		return err;
 
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0)
 		return data->line;
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 }
 
@@ -234,13 +234,11 @@ static int mtk8250_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	serial8250_unregister_port(data->line);
+	mtk8250_runtime_suspend(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		mtk8250_runtime_suspend(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

