Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD7CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB74820989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="V6H/psgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbeLTJiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:38:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45302 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732309AbeLTJir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:38:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so603491plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iUhDhIZ1xk9FGjJuaNFZaLpj2B2Rjon4JycLrDK7TY=;
        b=V6H/psgfubi2ZpcX1KcSuZloVb87/jIk1GnDUZsltHeipuJkZ8f1VCoPynfhff1c1c
         EjKaN2uhgMOBCosjaufOAgCgYu+yMrJTw9Pf8cSTV4+WQeQ7Robjx0IfkzT4wjLkjK4U
         KGCYr5aDhHM4RxbLQePEcLHD+B1gsIi0/R0dq4r0Zv/41Wa+iHcOGcyULZ4SIYksDuZY
         KmVajrBL/UhTdupusqU5tE8x0Udtj3Z+AY1gIP4Poke2NQKFmVR62BPjMyUcuHeQ+wRE
         la2b1qMCh8g2l0tE9y4v1ww1Of6sZQS8o6vv1HYgdDtPWAx2eJKawAOu9yhVD49y0c6R
         SDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1iUhDhIZ1xk9FGjJuaNFZaLpj2B2Rjon4JycLrDK7TY=;
        b=L55uVdXDe6EBsBQN0HxguJx9w8L4bscaJE4q1w5jz7PMF3GGQuk56QofXtdiD0X5xD
         RZymO9vEcP1uFK944WLbLi+TP5T1DuShpVLesSURUw6puShpvWNcuMvciuJBgKqa+iY6
         BDI8Q7QtPcQN/+uKJ8f9ZfmrGrpIVRi34AjxSGfpfGEcgYgMFsKWnImF11GGoMZMZaz4
         DuZ3p680cphxZVigLU7kERWZoeKQH4n4sNdYOSw9aOH0exQaWI2nQ6J9qUwoDqvxd/oI
         ttMj3ezFtKCOjD3mNwMQxPf7D0qmVui4vhqq/jWG2xJeJ3VbRmiJQfJKdb/HK4qJcUGZ
         B75Q==
X-Gm-Message-State: AA+aEWb3Lp6HmNgS8AXjrfhtCkLGazbbyyGuiMcCw7qpxp9AZF3hR6f3
        0BJj1NMswALPEiWKliQ+SsUifQCFoTM=
X-Google-Smtp-Source: AFSGD/U5p2Hoh5L4wPl040c5puKaXDHXPlrwcGXU2WsuUxZPDgnM90oglNVymgFW7rT5l7V7v45A/A==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr23741384pld.8.1545298725645;
        Thu, 20 Dec 2018 01:38:45 -0800 (PST)
Received: from localhost.localdomain (36-239-205-170.dynamic-ip.hinet.net. [36.239.205.170])
        by smtp.gmail.com with ESMTPSA id j6sm32194261pfg.126.2018.12.20.01.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 01:38:44 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mcp16502: Fix build error when !CONFIG_SUSPEND && CONFIG_PM_SLEEP
Date:   Thu, 20 Dec 2018 17:38:28 +0800
Message-Id: <20181220093828.28821-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use #ifdef CONFIG_PM_SLEEP guard around suspend_fn/resume_fn to fix below
build error.

  CC [M]  drivers/regulator/mcp16502.o
In file included from ./include/linux/device.h:23:0,
                 from ./include/linux/gpio/driver.h:5,
                 from ./include/asm-generic/gpio.h:13,
                 from ./include/linux/gpio.h:62,
                 from drivers/regulator/mcp16502.c:11:
drivers/regulator/mcp16502.c:528:32: error: ‘mcp16502_suspend_noirq’ undeclared here (not in a function); did you mean ‘mcp16502_suspend’?
  SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mcp16502_suspend_noirq,
                                ^
./include/linux/pm.h:342:19: note: in definition of macro ‘SET_NOIRQ_SYSTEM_SLEEP_PM_OPS’
  .suspend_noirq = suspend_fn, \
                   ^~~~~~~~~~
drivers/regulator/mcp16502.c:529:10: error: ‘mcp16502_resume_noirq’ undeclared here (not in a function); did you mean ‘mcp16502_suspend_noirq’?
          mcp16502_resume_noirq)
          ^
./include/linux/pm.h:343:18: note: in definition of macro ‘SET_NOIRQ_SYSTEM_SLEEP_PM_OPS’
  .resume_noirq = resume_fn, \
                  ^~~~~~~~~

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mcp16502.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index ec5b6836a20c..2507acb7f5dc 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -498,7 +498,7 @@ static int mcp16502_probe(struct i2c_client *client,
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
+#ifdef CONFIG_PM_SLEEP
 static int mcp16502_suspend_noirq(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -518,10 +518,7 @@ static int mcp16502_resume_noirq(struct device *dev)
 
 	return 0;
 }
-#else /* !CONFIG_SUSPEND */
-#define mcp16502_suspend NULL
-#define mcp16502_resume NULL
-#endif /* !CONFIG_SUSPEND */
+#endif
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops mcp16502_pm_ops = {
-- 
2.17.1

