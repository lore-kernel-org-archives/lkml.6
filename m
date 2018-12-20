Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DA8218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF/7ESn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbeLTRVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:21:49 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45555 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733204AbeLTRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:13 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so2371382edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jlet1gmOp0nMztTIDjXylbPLAAUyw6ocJIKxfagKKjE=;
        b=qF/7ESn009kLIDBRfWi6VtjFqJzSugFy0AJiZoGvol6NLzPWFdLO1RKivZMNhn6+Ad
         QafWEUAUk6xswXP26CIk+9tz7O9naDHiIE5dZaM402800/lAeFkGP2ly7aKZwLt2dSVx
         au3bNnJw4AbflzgNH2XuD1mSBd6yo2e+dKNSqqSpRJX61hWy69IN0zM046IfCd9JoRaC
         h9lyiIQD+mMiqucoLiXNznapP4ldZVjWnNcKrYFygi2c8mp9Z+3cWCKw/nxZyErTBfCv
         oDCa66kLlF5f7/ZtbCC3XKIg2/m808xDBUb2/OBUp8F1IWL2BHYA6zl1XkpN7RYDDC1b
         ELNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jlet1gmOp0nMztTIDjXylbPLAAUyw6ocJIKxfagKKjE=;
        b=mmMSp1unMcLn9eC1PNuN223kRUFck8nOwXaLcr0CqCUoWX6UZcJeUUmmwxGNoCN6C2
         LFtepFIFdjzMt8TqVBigUSWt/XFX6D0iLtjVOHngvcGMQXV3tvgMAjd6V22jMKLIr5eP
         4Wg40Is2ltZJ3AsbI1O32nmdBsHMw8H1l+VnAC6yhKYbdEuIdWb1Vhly1ChUScKvHFfR
         5IgIZdntsnUXIS8AAE9KF+npCeso0n29qvP03HyzPiOaL20NWgWXGFHisW3xKttwWpL8
         r4FS36BDrS1ftlUO2fn5cdbpiFvAOuq273TdCcJMD/2A1tgoD9DwMvqyetYKRDhHLslV
         Ev+w==
X-Gm-Message-State: AA+aEWasTWmnQxTyHT88wROzWs2ISudugYEZhUFS9fKe0pE2snApRFOf
        3VEA/CMW3zLdxOsAeLjUUis=
X-Google-Smtp-Source: AFSGD/XKgrGIWmcJMYsY/djIJadcBo+gXd++410oexGux0407/lKYw6lIZzKG+zdqQKwCPkHQCPh/A==
X-Received: by 2002:a17:906:f84:: with SMTP id q4-v6mr14849071ejj.52.1545326411231;
        Thu, 20 Dec 2018 09:20:11 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id q50sm6289772edd.66.2018.12.20.09.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:10 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v3 04/19] mailbox: bcm-flexrm: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:47 +0100
Message-Id: <20181220172002.9016-5-thierry.reding@gmail.com>
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

Cc: Vikram Prakash <vikram.prakash@broadcom.com>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index d7a8ed7d8097..d713271ebf7c 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1665,7 +1665,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 		mbox->controller.chans[index].con_priv = &mbox->rings[index];
 
 	/* Register mailbox controller */
-	ret = mbox_controller_register(&mbox->controller);
+	ret = devm_mbox_controller_register(dev, &mbox->controller);
 	if (ret)
 		goto fail_free_debugfs_root;
 
@@ -1691,8 +1691,6 @@ static int flexrm_mbox_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct flexrm_mbox *mbox = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&mbox->controller);
-
 	debugfs_remove_recursive(mbox->root);
 
 	platform_msi_domain_free_irqs(dev);
-- 
2.19.1

