Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7471ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B313214AB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtSqOS63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B313214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIQFKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:10:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45167 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeIQFKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:10:41 -0400
Received: by mail-io1-f65.google.com with SMTP id e12-v6so10011717iok.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jDArbQdVww+YSgUKwhIereZD0KDuIxo3XfjQo0Dfyoc=;
        b=MtSqOS63VH9yjjal86E/bgA2jgcaxL1KyQEcQ7/F7RLWZQ3Y1vZYGZoRUlLEor0FtB
         B6NLZCup0miL/UXfeOOAOdN/KrAPoV8JC1Nb17n08wPxnp4wjzmvxb4IvR4/BwDet5BJ
         dyScJ5A5M08ju3b2Si9t6v5eNJAi6WUH1Y8+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jDArbQdVww+YSgUKwhIereZD0KDuIxo3XfjQo0Dfyoc=;
        b=cgMUwn+CiO9hOLJwF6SzjTmEkhQGHlhEtTaDnpKa0BNuefQvYXZ2tANyMfF+/3JXDY
         +QTm/dEiQx01g+v7E5zfu4qC/7cBvHF8QPPs+WEqoSuC2yj//2ODpr/3QdQ1zAsPS0Ot
         gbuBdjoTCUmFxjEggZQvzhzfkGKxFCzRe7r6XNIp3bRg9DattppAhY7Gn+svKyddtKjO
         dJwAMsV8OAPVjr/m/OMSPcUi9QsJjhZB+cWuKlwb2FjlEYFJ1CkdKeA30/odpUm1Qxjg
         thgPHG/e8LuLfBRER7XNRzqHmx3ET4bFzSJBewXM0VfkjsLykCF1dNJEg7Hi9hCAvI1I
         xteQ==
X-Gm-Message-State: APzg51BJqoAXdrzv8oHYEGmc4d4rQVmCeAJSTiJA8Pxdw4vtKmTylGNe
        +Q1L2O73GDgc7y5mMJvF0JUbxA==
X-Google-Smtp-Source: ANB0VdbTnWOE3EInvMGSi/nCkv1qhWUH1lfh56XEx0Lnwzysok6QZBT5reM0nGV10mZQLwOt7KHbHg==
X-Received: by 2002:a6b:c694:: with SMTP id w142-v6mr17833891iof.142.1537141560397;
        Sun, 16 Sep 2018 16:46:00 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4495177ioc.63.2018.09.16.16.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 16:45:59 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/7] slimbus: core: match device tree based devices correctly
Date:   Sun, 16 Sep 2018 16:45:42 -0700
Message-Id: <20180916234546.29661-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

device_id for device tree based devices come from dt compatible string,
such drivers need not provide non dt style device id table.

Match those device using compatible strings.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 262591f..55eda58 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -33,6 +33,10 @@ static int slim_device_match(struct device *dev, struct device_driver *drv)
 	struct slim_device *sbdev = to_slim_device(dev);
 	struct slim_driver *sbdrv = to_slim_driver(drv);
 
+	/* Attempt an OF style match first */
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
 	return !!slim_match(sbdrv->id_table, sbdev);
 }
 
@@ -106,7 +110,7 @@ EXPORT_SYMBOL_GPL(slimbus_bus);
 int __slim_driver_register(struct slim_driver *drv, struct module *owner)
 {
 	/* ID table and probe are mandatory */
-	if (!drv->id_table || !drv->probe)
+	if (!(drv->driver.of_match_table || drv->id_table) || !drv->probe)
 		return -EINVAL;
 
 	drv->driver.bus = &slimbus_bus;
-- 
2.9.3

