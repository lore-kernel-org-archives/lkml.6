Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F0AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976F121905
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixWasXBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfBSIjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:39:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35172 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfBSIjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:39:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so9805886pgs.2;
        Tue, 19 Feb 2019 00:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cKndZmu/VDirnD3mLR0HI/K6gndqn21HrLsaSTkhG3o=;
        b=ixWasXBvAnj8I2mo480lQjHbgVkmxx+SrAov3E1aQCRevnBR5Az1QhoKVeGiKXYQLY
         TWz6s7FBWJ//pl0MQ20GvGFghD8mwp9WUG248dqUEtZoUJfIv48zswneJ1mmasW+oJvB
         O9C+/O5T8lxgasSdIwWE5q8soIaa3EEOJ89C7gKzDCeCD26XhvkAKrRz3WF3nth/3msO
         oJZSfVTbKWPnQ13E8sZSlTyVHhQUrtFZUe0Czi2Z8UVayDbRgJEEYuh8L/H04jRF2No3
         OUKmj2XunBLgKhfMpiHSrSv6WX9A0Ps4OZObQQmcmGluseGdziywIfYPGyFkCGK25uHC
         y8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cKndZmu/VDirnD3mLR0HI/K6gndqn21HrLsaSTkhG3o=;
        b=s7y6CiQEWo61DxSrKlNnZtDBhYA8QkWKdi5oRyOvMr1HBAf04QILUfJVnZ2TCrZqsJ
         cNKUMjCE42BbpyUzT7C6NhjEwRLac4mWIl5BCC8ILdMZQ1LYPLXRGFRvUaDCl50cEUGp
         AFwTgOvyF9mzX1T0lehBsfvY01Mb6H+M2SOQhknZF+DGRTCB0TvAGtrL7PguP9YfAgHC
         1Sv2OcXUdqAIXykYKhiAMYEtWGZAEh+rZ4O12ZxgRdQSh4al6bGdaqwq8dMid04svYax
         YWVZ6vMiR2irOenx9EsxOspdZgr+Q/vS6OWcoiE9lMdM85cEYJ8++MmuuC/ZTCDDWeoN
         PpsA==
X-Gm-Message-State: AHQUAuZVk46raQaqLfkywVTKMGWnpM+XMHS+GvsWK7yZzEjQsa8/y+78
        hlD1WlXYDJ1bXkDPPe7X4fE=
X-Google-Smtp-Source: AHgI3IYxEImWJzxtqmwVdWfLGcOtnl+88T7g0cYX6n6T0nFIut7Rg8BPy/EgqkPkJ2agQ5t9ORI2CQ==
X-Received: by 2002:aa7:8186:: with SMTP id g6mr9419140pfi.138.1550565583693;
        Tue, 19 Feb 2019 00:39:43 -0800 (PST)
Received: from localhost.localdomain (ppp-110-168-248-116.revip5.asianet.co.th. [110.168.248.116])
        by smtp.gmail.com with ESMTPSA id i74sm31520393pfi.33.2019.02.19.00.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 00:39:42 -0800 (PST)
From:   Alexey Roslyakov <alexey.roslyakov@gmail.com>
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Roslyakov <alexey.roslyakov@gmail.com>
Subject: [PATCH] rtc: pcf85063: remove dead code
Date:   Tue, 19 Feb 2019 15:39:29 +0700
Message-Id: <20190219083929.24585-1-alexey.roslyakov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of defines are not in use since
7b5768486a910532885f01b9d2dad4818c8b3be1. Remove it to make the code
easier to read and understand.

Signed-off-by: Alexey Roslyakov <alexey.roslyakov@gmail.com>
---
 drivers/rtc/rtc-pcf85063.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 283c2335b01b..0a00d39eb877 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -28,16 +28,9 @@
 
 #define PCF85063_REG_CTRL1		0x00 /* status */
 #define PCF85063_REG_CTRL1_STOP		BIT(5)
-#define PCF85063_REG_CTRL2		0x01
 
 #define PCF85063_REG_SC			0x04 /* datetime */
 #define PCF85063_REG_SC_OS		0x80
-#define PCF85063_REG_MN			0x05
-#define PCF85063_REG_HR			0x06
-#define PCF85063_REG_DM			0x07
-#define PCF85063_REG_DW			0x08
-#define PCF85063_REG_MO			0x09
-#define PCF85063_REG_YR			0x0A
 
 static struct i2c_driver pcf85063_driver;
 
-- 
2.19.2

