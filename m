Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9122EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EF7217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF/oh96U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387887AbeLTRUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:25 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45566 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387840AbeLTRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so2371648edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mbSGyI7MU2rG07NSp1FbrVt+xWkd1+3IlqfQ7Nl+dYg=;
        b=bF/oh96UqP58nEN1mSU1j1OyLGF834O0y6e8Il8KhlWJiQc6DYFetS/ICIePIW4Jux
         2mhBA+WalSBy8CJvUtPpMnvr5UGVq/O2Tjmt7oCy+3EE1xNVi0vC1C0sz/GMiZMrnaAt
         ipNRdrjd8ZRApU8uVRdqMEAR7coNPGcQnXFajUMoXdszmfyajuJY7DY/qihBvs4Z2cf0
         If7tgRlTQlWVrM1VpZh53G62YOl8DoC4eZXhp4eead8FF5lnkc2XrsDH1srfFvHPzePt
         ieDiRyo+AxUzMuIYaWvwugAZBc8gpQG/lYXxaz7VZ8GR3pwMebk4QD+vBxz4nTF8ePod
         dvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mbSGyI7MU2rG07NSp1FbrVt+xWkd1+3IlqfQ7Nl+dYg=;
        b=pMbUJKvC+GSn0G8qUDG9MS/X70FeV6s4sftJhksozUv73EPJD1x/DtmuaywjTh3kX/
         IPDQxg3Cq0k7taJvh+68d//R8loFj8fFoSpjLTOzm/tG4fAQfTbhDmZI97eRVOPVxH/r
         d6gQoj/6RcRcmRmRQ8vAFnlsIpp7OPJZPVHSIDom9GHhJV5+7CcnoT77FX9ckwVWircq
         DuWKi+9qX1dnBO666mzVqFSSvkvNgCELOvIdt+ocL5crmwCHYAUNSHFcFOhYgZogUyzB
         n+57apuwKWhpBdWxCv5JDi8IagDK9KGwK3TytWazfoRoNBe0x9Jhdex8cBAF9MRmyOKT
         gPng==
X-Gm-Message-State: AA+aEWbWSCNh5SU3brZHnBq5/4M770/XfAIeNaABQiP4ki36tZOcPQU5
        eK1L9rFVSHfgg6VGEVbFFAQ=
X-Google-Smtp-Source: AFSGD/VNIlI59X2NJjj6BWEu7ONx609t+KbQbEg0g3/ml/ExonS+8xPi8XKEkU6k6lR+axfJb9+wcA==
X-Received: by 2002:a17:906:1b12:: with SMTP id o18-v6mr15121140ejg.65.1545326417302;
        Thu, 20 Dec 2018 09:20:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t9sm6181027edd.25.2018.12.20.09.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:16 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v3 08/19] mailbox: imx: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:51 +0100
Message-Id: <20181220172002.9016-9-thierry.reding@gmail.com>
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

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/imx-mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 363d35d5e49d..774362a05159 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -324,14 +324,13 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	imx_mu_init_generic(priv);
 
-	return mbox_controller_register(&priv->mbox);
+	return devm_mbox_controller_register(dev, &priv->mbox);
 }
 
 static int imx_mu_remove(struct platform_device *pdev)
 {
 	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&priv->mbox);
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
-- 
2.19.1

