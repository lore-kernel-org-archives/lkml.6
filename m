Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148E6ECE564
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2053214C3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZ5CW7Fo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2053214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeIQFKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:10:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36055 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeIQFKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:10:39 -0400
Received: by mail-io1-f67.google.com with SMTP id q5-v6so10058814iop.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QcoflERtpbbMpFHGfNLZf+J44DqlCQNeE1IN/AfmCyw=;
        b=QZ5CW7Fo4X2d5dWSsyibw1FewzAcVLqIfsIhOn4Di1qz3uJz15hTqBNSl6D//5Ki9q
         Eaa02bx8tJ+CixARxakw8c9gpyXYVTtppksrkOPfobracWgN3WG1hQ9GI5FqP3FlMSxp
         Ny/RKE7IIEv1qOa3nF/AotMXlPtBYPZGF8GaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QcoflERtpbbMpFHGfNLZf+J44DqlCQNeE1IN/AfmCyw=;
        b=QJMTtDzCXsFAhUoDJrEkaceF2a9h3JSvZXFF6y2LGBAxnGTDSrAfoHStdNaIefLvug
         dY1QNcbyRo+zgrKKPW5phAWcTB30CHzIj79QHVetaCw9NdJ1Yko1DaHQLon2DNS3dnT2
         d6r54aU0UWjBngXjMRU/1Zzq4XEysxd2fdd0xGraMgW99D3f/AQ9egbzidgA6spDD70p
         PG2gjhWvyYwyAz63THl3tbF5VSAsqHUbYlr5iI2dmRWl5HheVq5O2+zWKIyiBRhzI/zX
         5u23VWKUQ2ORH2fk6fasMB6kgv7QrM+gJEk+pyqok2RzYpS8v1FD6SNHFcwJb62wvcDw
         KN3A==
X-Gm-Message-State: APzg51CsB5/2vHBcQargOxoTobbIlmUCSTYS7IU3Nc0iTnUO26oiPu4Q
        jkupkMHOiM+TeL7REAaFJvgSfH+fAU8=
X-Google-Smtp-Source: ANB0VdZfaqPCa+jueB1u3F+i/YV6WKBSxekAl0eW6kTflKSfH9ugH2prhJyZ2i5B3D3T2T/EZe/Hjg==
X-Received: by 2002:a6b:25d2:: with SMTP id l201-v6mr18710058iol.115.1537141558285;
        Sun, 16 Sep 2018 16:45:58 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4495177ioc.63.2018.09.16.16.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 16:45:57 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/7] slimbus: core: add support to uevent
Date:   Sun, 16 Sep 2018 16:45:40 -0700
Message-Id: <20180916234546.29661-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to uevent to help automatic module loading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 95b00d2..31f2910 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/idr.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slimbus.h>
 #include "slimbus.h"
@@ -57,11 +58,24 @@ static int slim_device_remove(struct device *dev)
 	return 0;
 }
 
+static int slim_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct slim_device *sbdev = to_slim_device(dev);
+	int ret;
+
+	ret = of_device_uevent_modalias(dev, env);
+	if (ret != -ENODEV)
+		return ret;
+
+	return add_uevent_var(env, "MODALIAS=slim:%s", dev_name(&sbdev->dev));
+}
+
 struct bus_type slimbus_bus = {
 	.name		= "slimbus",
 	.match		= slim_device_match,
 	.probe		= slim_device_probe,
 	.remove		= slim_device_remove,
+	.uevent		= slim_device_uevent,
 };
 EXPORT_SYMBOL_GPL(slimbus_bus);
 
-- 
2.9.3

