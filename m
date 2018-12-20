Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C99C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128B0217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7xy3Zex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbeLTRUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45593 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbeLTRUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so2372283edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CX/+P131Nmt+TB9PCjfflN8q5zM8HO223uXN1QzfE5w=;
        b=O7xy3Zex8U+D2vfZ723w8OyPC/MtmSD2mXlqSGn3gQmEiVJ4VxNMkRz+GVanVNHmPa
         Bv6irttBSgAmmWQ8jbRfYpA4LBd9R89/EYL2QzKZhsYmr8QFWi9NDUrJwh7Z4Nsgg8np
         DkmwQ0X2vdCKgmPGDNOIhB8SxyAyCnkVLwFhyC370/+/stqkuniy58JmiX3nBu+kG4qM
         ja6e+5sF0E0mwHE2DUf0y1nni+5QSS6rZH0EeybLUQmMgjTdvIit1YcSzOLhog4xyXS7
         CAqdzw3dhgGl9ii6qCAquzkJhzF6IEQu/BMFpLTdMl0sFZlfO60kJyue+w8jHvpLP9We
         lehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CX/+P131Nmt+TB9PCjfflN8q5zM8HO223uXN1QzfE5w=;
        b=PTtDWu9XDCs2a/wlFev5dS2K/U841S/7UbLDi1zW8MGuZEV/inNtRe1AcF9pNtETgM
         hjsKgdqG8i+BwwHqm5oxJZSDqBd3iSe5/H+xMLQbBV8YiulBY6nbyq66jv6jmG+GGiXF
         jv4BYVf4d2WNnKGM8xlJuh/p4HMYAmbzMPbeeChfkXr43QQ3own/CsHXkmp5ek0qbmJa
         IMPekqMNXhGv06sMnUqCtz5MXHkt2lJcCDX6wGyebmNAVvG/tAcTmcWbICVb1TqHtVXR
         D/efLUbDjj3PuYF7aWAisX3dL/QhiHbKlybY9krW6Hg7wc4HDUwVAJveOH9zsmOcsiBq
         60aA==
X-Gm-Message-State: AA+aEWY/4s7m0IRWoqqrqahMya1LHHiK99IhjZXRTCZJhyriYsuBnlym
        m63rtTNujG7Rj1krquOT+to=
X-Google-Smtp-Source: AFSGD/WjELsUdBsK03wpw/Wiq5VaBQUKgWD9VFdrAZRjFmwrMw2ZXZJX0xAuJn9l3PqO4plZrTevBg==
X-Received: by 2002:a50:a5e2:: with SMTP id b31mr23825261edc.5.1545326432861;
        Thu, 20 Dec 2018 09:20:32 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 97sm6354567edq.45.2018.12.20.09.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:32 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH v3 18/19] mailbox: stm32-ipcc: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:20:01 +0100
Message-Id: <20181220172002.9016-19-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220172002.9016-1-thierry.reding@gmail.com>
References: <20181220172002.9016-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Ludovic Barre <ludovic.barre@st.com>
Reviewed-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/stm32-ipcc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 533b0da5235d..a338bd4cd7db 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -299,7 +299,7 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	for (i = 0; i < ipcc->controller.num_chans; i++)
 		ipcc->controller.chans[i].con_priv = (void *)i;
 
-	ret = mbox_controller_register(&ipcc->controller);
+	ret = devm_mbox_controller_register(dev, &ipcc->controller);
 	if (ret)
 		goto err_irq_wkp;
 
@@ -329,8 +329,6 @@ static int stm32_ipcc_remove(struct platform_device *pdev)
 {
 	struct stm32_ipcc *ipcc = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&ipcc->controller);
-
 	if (ipcc->wkp)
 		dev_pm_clear_wake_irq(&pdev->dev);
 
-- 
2.19.1

