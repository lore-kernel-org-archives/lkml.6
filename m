Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BAECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E2E20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WK2e5x/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E2E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJYOYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:24:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39836 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeJYOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:24:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so3480155pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avYgO8zmRu0z6skuS/KZQ7OfLu1Dauo/53ZC7TuTX1M=;
        b=WK2e5x/wn+DwVaY2TkDftoOK6YXeok4Q7tIFiLxlLuvd4DXc5H9FTxJA28BuoHtlSI
         WHYPTDWP68I50uP3WuV8h5sRuYyZJK4TO1yGIsapNDahoRUMbEvGsUJ6AJL5q2dgSJmz
         74tmhRxNd0MJO+2aWquQlgnXhHG4O3WCE1CGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avYgO8zmRu0z6skuS/KZQ7OfLu1Dauo/53ZC7TuTX1M=;
        b=BJQ1QpYigETqvIeKh4KOb4d7qtf/Mlnq3IYpWLnZzngYG4fpamN+iPtfY8k709NOWl
         yXKJziGc7MtaXF0tkmBukpoZNvtUouIbIEq1HR+B43gaLwzDDX82OITaQRIaxjQ3X73v
         2L2X7VBOqANP4hOOeqtMl9aAgng5PEIGeJtrMUag4fkqQfEqokDKqqbKJkZaQHL3jZNZ
         8RyUOD83+JlXktrqUP2wT9Vlfi0dIXP/sOLMuHP52qVeJ/JK6H31Dury8g1EykdoqBB1
         uPPS2h4M99VKppOdQm2g3rGmGvQNRihndpZILVpNKKWQDvxOicyeGpYj2RECAgJlarJP
         JGXw==
X-Gm-Message-State: AGRZ1gITTahgV+SJfO5FcAGuaS9+w4rgNVevVkhts2JiI8RUYay9VTqI
        vX+MirfHSVf4guuLg7l9+p2+0w==
X-Google-Smtp-Source: AJdET5dXWUCegHBd2H47A49LjZusMv03QTMBh+fOrwTNQi9NpllG8Rok9K7iJfgJarzHTRr0RgOQ3w==
X-Received: by 2002:a63:194a:: with SMTP id 10-v6mr211043pgz.192.1540446798805;
        Wed, 24 Oct 2018 22:53:18 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id o75-v6sm14923493pfg.0.2018.10.24.22.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 22:53:18 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 01/10] PM / Domains: Rename genpd virtual devices as virt_dev
Date:   Thu, 25 Oct 2018 11:22:38 +0530
Message-Id: <d5f993001c97895d82bb68e246f6eaafce6dc795.1540446493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several struct device instances that genpd core handles. The
most common one is the consumer device structure, which is named
(correctly) as "dev" within genpd core. The second one is the genpd's
device structure, referenced as genpd->dev. The third one is the virtual
device structures created by the genpd core to represent the consumer
device for multiple power domain case, currently named as genpd_dev. The
naming of these virtual devices isn't very clear or readable and it
looks more like the genpd->dev.

Rename the virtual device instances within the genpd core as "virt_dev".

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7f38a92b444a..fe9b0527b161 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2338,7 +2338,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index)
 {
-	struct device *genpd_dev;
+	struct device *virt_dev;
 	int num_domains;
 	int ret;
 
@@ -2352,31 +2352,31 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 		return NULL;
 
 	/* Allocate and register device on the genpd bus. */
-	genpd_dev = kzalloc(sizeof(*genpd_dev), GFP_KERNEL);
-	if (!genpd_dev)
+	virt_dev = kzalloc(sizeof(*virt_dev), GFP_KERNEL);
+	if (!virt_dev)
 		return ERR_PTR(-ENOMEM);
 
-	dev_set_name(genpd_dev, "genpd:%u:%s", index, dev_name(dev));
-	genpd_dev->bus = &genpd_bus_type;
-	genpd_dev->release = genpd_release_dev;
+	dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
+	virt_dev->bus = &genpd_bus_type;
+	virt_dev->release = genpd_release_dev;
 
-	ret = device_register(genpd_dev);
+	ret = device_register(virt_dev);
 	if (ret) {
-		kfree(genpd_dev);
+		kfree(virt_dev);
 		return ERR_PTR(ret);
 	}
 
 	/* Try to attach the device to the PM domain at the specified index. */
-	ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index, false);
+	ret = __genpd_dev_pm_attach(virt_dev, dev->of_node, index, false);
 	if (ret < 1) {
-		device_unregister(genpd_dev);
+		device_unregister(virt_dev);
 		return ret ? ERR_PTR(ret) : NULL;
 	}
 
-	pm_runtime_enable(genpd_dev);
-	genpd_queue_power_off_work(dev_to_genpd(genpd_dev));
+	pm_runtime_enable(virt_dev);
+	genpd_queue_power_off_work(dev_to_genpd(virt_dev));
 
-	return genpd_dev;
+	return virt_dev;
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
 
-- 
2.19.1.568.g152ad8e3369a

