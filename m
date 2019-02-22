Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B92C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CFE20645
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FonEQvjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfBVWyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:54:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37920 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfBVWx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:53:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id n125so1743433pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOmkR54mk1YiaV2P4+fXimG34BV3NNX5X3QQIlvQVZg=;
        b=FonEQvjFE8rinSdK0+YhsK7NSIKGCnlG0bsqQ8t7MJflKAQnIFi7Bzwkh0rYge72WM
         zgb/8P2VCLv4otyxW9sV36wHKm9BUynifaYI2f04CljuU+ExEsK+ON7RwyP3JlbWQkB7
         P5ccE83/ZjI3ZXxk17E7ff9sISh959aqZuu7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nOmkR54mk1YiaV2P4+fXimG34BV3NNX5X3QQIlvQVZg=;
        b=XS5nifqBNyMUn9JCdCg8cm8QU4iTshBmf0V+1lNHYJooyNaFb2LB0m8P1WwlQ16/Dk
         nj/JSpDScz+ErnLMzh0hm4DUe9uX6k8LTe8fpNCCix9FxriAKDvrwAhJFzxnRrDmkh0e
         wAkk5UwC4wfHpvaPCb5lfgvGgxetuoqLnvN6ZX2ywT7nlO8MMJnq9CgCBfqBr4Ts8gkU
         U59uYDzvDIoQaxAhqFrZjzDA6Ltr3GZ9gqIllkL+3nNH0LJWS9LET/j/NYAGef0EwDe5
         X4jvCw9Oare296lwefqQj3Xh3iFdfSu6ev5qhUG/sVgQXePDZMXDo4xTbwaKHQM5Ep3G
         Kxfw==
X-Gm-Message-State: AHQUAuaZXKS9OOrOb99kmXMweiR+b4v7xK6lGJBgbctPV0+waP2ViuSa
        udwu7qSGiPA/xae2fgcBYfdYvQ==
X-Google-Smtp-Source: AHgI3IbX30eBxxMnWiJnPiqgNTaN6UZxyKS5qylYNv4mkQAyTqVyKBdygA2Woo5vLcKqD2q0qeQRaQ==
X-Received: by 2002:a62:d448:: with SMTP id u8mr6554991pfl.105.1550876039259;
        Fri, 22 Feb 2019 14:53:59 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id g185sm3994995pfc.174.2019.02.22.14.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:53:58 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible properties
Date:   Fri, 22 Feb 2019 14:53:43 -0800
Message-Id: <20190222225345.69084-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may need to specify a GPIO wake pin for this device, so add a
compatible property for it.

There are at least to USB PID/VID variations of this chip: one with a
Lite-On ID and one with an Atheros ID.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
v2:
 * drop leading zeroes from VID, per documented binding
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 470ee68555d9..54cb5f583b1d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
 
 static const struct of_device_id btusb_match_table[] = {
 	{ .compatible = "usb1286,204e" },
+	{ .compatible = "usbcf3,e300" }, /* QCA6174A */
+	{ .compatible = "usb4ca,301a" }, /* QCA6174A (Lite-On) */
 	{ }
 };
 MODULE_DEVICE_TABLE(of, btusb_match_table);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

