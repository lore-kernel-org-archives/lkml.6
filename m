Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB233C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA49D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu8EPKB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfBLQV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:21:56 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50635 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbfBLQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:21:56 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so8611674iti.0;
        Tue, 12 Feb 2019 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8btgNXZv4xnAj7Q1ZEA/tKZmZrLdKCuelXmTGcsS/EM=;
        b=Uu8EPKB/gHIzhUcCUdAAS/eXGcxTpi9xo9JIon7sKTENGaJ2RpSs6WxOmZ9HGCSuXT
         YY1dTe6eZxwVNtexdzfuZbCy7v1GUxzX5FJybU053+w/dEblDoACaOk/D1707GQr6qBE
         yEDSGjgL1aWqc+26slZQVMR1QCyrdQYJJQBB/Yu3qFly373mItN+RoJdpr+QSroHSGiZ
         JslyF1ydkTUDJXNFW07eQydoM6LplaF7YGm8otUgjZk3ovQH+hU8hfPYpxtPeYGJtCm0
         X3+WVkyp4OQ23ic11+64OOU/CEBniD9FpLaA5g1kt5TVJRkiJPTH6RZ9YkWpCjN6Mgjh
         eQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8btgNXZv4xnAj7Q1ZEA/tKZmZrLdKCuelXmTGcsS/EM=;
        b=W0DhSsqUonHITKXWwcJOPgIgDqvv0ipDDBJcBGw66IY/dJrx1dcIdyAQWMrcvTw0z+
         Uz8g94K65OUvGQYaRFMGGt6TkG4yDQ4kzNyUq09kIsCiLDUC0AMVfprXdo9UlsuC/+Yz
         +5jbU4TKPoTvB9mXxKDtYfoG61WIenqcVA3eET6oD7Q++Ce26KsZpTX3Vq1XQlA1+2Qb
         CxQQ9SmoXjfHWSthET1QeOEufq5JtBFT4OqB6ixYSKMA/Ln3luRJcitFA1kzB9z/hPaE
         vxVVs0jRVy7ZqFExFqrSFKI7jz1yxj4tdaxHgP9jWhZnKYb4mFi2UAJwwCRl9IcffIbP
         DljA==
X-Gm-Message-State: AHQUAuZecZiAhY3tCAk4WFqofCGI2s4iA1SieCoLG6qIavScXHM2ib/i
        EH6zpBenFT9N1/8uIFeqhDvJzJbn
X-Google-Smtp-Source: AHgI3Ibu2BkRqrUMY/9rZ6e64MU3jSldCbyY4Vqq+njQ1Ks6ZUiU5sjp9mT4TIPKmvIZdyMjXxTKRQ==
X-Received: by 2002:a24:3982:: with SMTP id l124mr2091595ita.116.1549988515530;
        Tue, 12 Feb 2019 08:21:55 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id o16sm1564013ito.19.2019.02.12.08.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:21:54 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] power: supply: ds2782: fix possible use-after-free on remove
Date:   Tue, 12 Feb 2019 11:21:49 -0500
Message-Id: <20190212162149.21583-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In remove(), use cancel_delayed_work_sync() to cancel the
delayed work. Otherwise there's a chance that this work
will continue to run until after the device has been removed.

While we're here, fix the deallocation order in remove(),
to correspond to the inverse of the probe() allocation
order. This guarantees that any remaining work can run
to completion with all driver structures still intact.

This issue was detected with the help of Coccinelle.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

v2: fix silly use-after-free in remove()

 drivers/power/supply/ds2782_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index 019c58493e3d..04b0fe7d7d62 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -319,17 +319,17 @@ static void ds278x_power_supply_init(struct power_supply_desc *battery)
 static int ds278x_battery_remove(struct i2c_client *client)
 {
 	struct ds278x_info *info = i2c_get_clientdata(client);
+	int id = info->id;
 
 	power_supply_unregister(info->battery);
+	cancel_delayed_work_sync(&info->bat_work);
 	kfree(info->battery_desc.name);
+	kfree(info);
 
 	mutex_lock(&battery_lock);
-	idr_remove(&battery_id, info->id);
+	idr_remove(&battery_id, id);
 	mutex_unlock(&battery_lock);
 
-	cancel_delayed_work(&info->bat_work);
-
-	kfree(info);
 	return 0;
 }
 
-- 
2.17.1

