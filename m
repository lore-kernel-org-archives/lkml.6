Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92572C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C9527263
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ74HhYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C9527263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbeF1KtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:49:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40658 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbeF1KtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:49:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id z24-v6so2414582pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=N+v2giY287WCzlDNGU3zOnRFUlY+bYEIE7Sj+F34UR0=;
        b=SJ74HhYU4pI9TStWPpXNihasoRTNBIOis3rR4bx8BNxs2wRfCb7cQUVZw5aR14oan5
         gtHjcBixMPCcvFsYBMuqzMAclhqrSbyMggxZEBjuzAaMVWdUj6hCxrcuJBcLT2tNhAWA
         nSWB3FQ/6463MaMS5IQSKzikvKA6NI+OvO0o0nvZ4767bkB4tK1KlEZAUz1x4s9JU3Pu
         FTZrYMFvLjoD2DdeZs6/7n2YwgLDQ1Is4g4oIAhBiMKvKH23eV5hXXbNjg6L7ACzcvGG
         WdoXwATIRgGHbfbaaZM3dzrQopB3PfNC37W3wtHpeRYk4Eo4ke2oNzmoSUvZ3yI8Szms
         hJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=N+v2giY287WCzlDNGU3zOnRFUlY+bYEIE7Sj+F34UR0=;
        b=YBG569XbH4WKi85f3sXwh6c6O7ruPaEbswQI5uAO29BEDFzddP/sbdX0Lls3IVxcES
         jySVX+aAixp+ssKSCbyzctQxJr6Jcec/1GZiesQiM10q6fUfLK2hEhb2Y6uU/mz+9/Px
         gIBliWaJMa1C/vy+jwi5Kp3BfJhhGd18PvWEkAm8iYcW1ubJUOxUcGzVkEjqUWYu4L6J
         VjIjFhIMYsDf3Emr91e0fj9SP6kYxjacsdsuEONx2xWMy+q41ESD1bTGYI7rY5BbyHmZ
         +VZXJpuuCfUW1nMsdkvOVkp1OQIiAeP5lDuBH1dTl3w1ip2LDooUmsegja32BlXHoBhz
         T/bQ==
X-Gm-Message-State: APt69E2EJdGmC8JKDl81iBQ0l3QanJeQwqRki/qn88zOwPP4banXjnmw
        IYRzgQrNE2QHZn+XMQeM3n4=
X-Google-Smtp-Source: ADUXVKK0BsRtd0GMnd75v5pRBOrw8D67zx+uBpIJaitbf7pYceqgQOEuJ0GQVzDDDB4cVX7zz8Uuug==
X-Received: by 2002:a63:7d4c:: with SMTP id m12-v6mr8322384pgn.201.1530182955469;
        Thu, 28 Jun 2018 03:49:15 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id k13-v6sm15872971pfg.130.2018.06.28.03.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 03:49:14 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nds32: Fix the dts pointer is not passed correctly issue.
Date:   Thu, 28 Jun 2018 18:49:02 +0800
Message-Id: <20180628104902.9078-1-greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found that the original implementation will only use the built-in dtb
pointer instead of the pointer pass from bootloader. This bug is fixed
by this patch.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index 2f5b2ccebe47..63a1a5ef5219 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -278,7 +278,8 @@ static void __init setup_memory(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-	early_init_devtree( __dtb_start);
+	early_init_devtree(__atags_pointer ? \
+		phys_to_virt(__atags_pointer) : __dtb_start);
 
 	setup_cpuinfo();
 
-- 
1.9.5

