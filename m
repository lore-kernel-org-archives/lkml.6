Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A81C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7392217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="AJn3vb5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbeLTNO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:14:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39639 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbeLTNO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:14:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so884532pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=rZhe25yQxkee0DtZS6VfNe2KF6R6wBu8BVFsWVclt2c=;
        b=AJn3vb5iEDv0wG1r5mtU9gNCyW9nUhx/QfFMwzhBq7frWVC7B0emdfZHPE/ESkCU5h
         x82BW4ne+GG2zffyUCiHdNWvK/oNNs+3pgR22fC0hDBXFvAk6XAlFDgh/5FLDQSq+38a
         FHfXb/TVK2fPKYlt4B0kkgZImJKpLkDp7iuMf0MFOnX4wJUKS/UWLD5LdVItElb3RIi1
         HdpRdW9B0Vrvz/iqgz6oAOTqI3CoAStcv4lerVlFHp9DrP+gvTEdIJLSx33+D9ZXO3Cz
         IVfHqiHNq2muTi0Ecsb5UzISk+3LnPet8FZZ8FUHaVWlq4Z9EwvOyTIFueiFV3+Z6flF
         QKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rZhe25yQxkee0DtZS6VfNe2KF6R6wBu8BVFsWVclt2c=;
        b=hSr/0yKfqb2P9MyU5xoAL3Zz2Eh5KB8sZW4o47r9ab5Ctob7uny2mPISjyoMojvQX4
         NtP9LOSDwZqxT08RjVmISbayPpUnuM/mqLtutm0hAjFtxTjbLfV9UnAQJsVU/srggP49
         1fk+3aWhYjAM4fCvA66hU8ox0InDmFXPuTeos7o4Gw5SFh4BQWaXiQs2zShbsGD3M2O/
         zzKoW/6Bx+GqSOOjLsq6fSL6O6hiYWPRPnN/BIpCU2eI6XgHg31uN1AUpe4KLy81daLa
         hmgiHDqjIq0WEHxIp7j++hbB8dXbSEFtLQr3YOlP8lsoKQOjC8acfkxuI5CSQWzIwebx
         1oZA==
X-Gm-Message-State: AA+aEWaeua0rNGKh4YTrk+XK5oYUIPZ7TTtn570+PL+QpI2f4fGuiTyf
        t4fHP4B18wiGzgyM7dcoFIRQSQ==
X-Google-Smtp-Source: AFSGD/WFdsvM4dJigaOkv3/+JygBy9zb7HhBF2P2bY9EkX9nkoWDMLfCZ/1Esp/oDdLOwpQoxmoITw==
X-Received: by 2002:a65:4381:: with SMTP id m1mr22652931pgp.358.1545311665106;
        Thu, 20 Dec 2018 05:14:25 -0800 (PST)
Received: from localhost.localdomain (36-239-205-170.dynamic-ip.hinet.net. [36.239.205.170])
        by smtp.gmail.com with ESMTPSA id b7sm40809404pga.39.2018.12.20.05.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 05:14:24 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mcp16502: Use #ifdef CONFIG_PM_SLEEP around mcp16502_suspend/resume_noirq
Date:   Thu, 20 Dec 2018 21:14:13 +0800
Message-Id: <20181220131413.21922-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mcp16502_suspend/resume_noirq is only used by SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
when CONFIG_PM_SLEEP is defined.
So use #ifdef CONFIG_PM_SLEEP instead CONFIG_SUSPEND guard.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch replaces below patch I sent today.
regulator: mcp16502: Fix build error when !CONFIG_SUSPEND && CONFIG_PM_SLEEP
Changed the subject line because after commit 308144ce8e51 ("regulator: mcp16502: code cleanup")
it's not related to build error now.

 drivers/regulator/mcp16502.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 809a664733a4..cb11fb206899 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -497,7 +497,7 @@ static int mcp16502_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
+#ifdef CONFIG_PM_SLEEP
 static int mcp16502_suspend_noirq(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -517,10 +517,7 @@ static int mcp16502_resume_noirq(struct device *dev)
 
 	return 0;
 }
-#else /* !CONFIG_SUSPEND */
-#define mcp16502_suspend_noirq NULL
-#define mcp16502_resume_noirq NULL
-#endif /* !CONFIG_SUSPEND */
+#endif
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops mcp16502_pm_ops = {
-- 
2.17.1

