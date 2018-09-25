Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C50C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB71D20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFkBO4n0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB71D20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeIYPLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:11:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33479 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIYPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:11:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10-v6so1445358wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=24xEIGND92Wry87aRP5S+r2CoVI/mGeClIEhmLV7kWE=;
        b=QFkBO4n0OJHz1OCdkarXuxWrZ1/9HdldlP+H6dN4WG6Q84n0T4V3bXkg++3crFFLHc
         ifJLjRg+Q/WygElxH6nJ13OH/0ilBVh9yE+oUKMQez9cFKKHkcgSsC6GJy1XV/eS0M0F
         /5XeDdoNK08NyuYvFggL4yvQAh7txa6zDBqzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=24xEIGND92Wry87aRP5S+r2CoVI/mGeClIEhmLV7kWE=;
        b=clfkpulj57ejTg3BwT+2H4df5Injs+JLVRFrH51MHWsAFhgsYoGGXsVWOW1kcKdYVk
         6GSXMDJOrmR84hHoBojMnoOT3Y2lmKlQwhq/G2MdA8f/zv4WLUBoeF0jDtEEPfMGIo8p
         fQRKAJpuykjJP2uDwD7RxRydhz19yXfPXhCbaEk5cavicLGREJbiPOd3wBcYoyLiJBEj
         8icKxNu5O+3s5tuZg9snxKjkdtu2+tieSCYu0JXGvGrUgC6uqH0hNTSj6XQcL6gZgJV/
         GbExHx+Ur6AEC20enHUET2RRrNwBip1SwW0k71sMw0c/cQqDnff2AOJKi/P47T4fN1nI
         ngaA==
X-Gm-Message-State: ABuFfogL3uEvADuanWZlZp0ckl+GpWMZRsoUsDnBCnKYD5hLfqitLJcE
        A6NUDJfZ8PpFmWXkc4YLvATSVg==
X-Google-Smtp-Source: ACcGV63OLoXsZVmu8be4qAjDQjiS6MZC+2pQZRumfLVZKin2P/kkh1npiFECmkYGkF3kpacm3Wjq/g==
X-Received: by 2002:adf:a925:: with SMTP id u34-v6mr14366wrc.175.1537866273230;
        Tue, 25 Sep 2018 02:04:33 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 09/14] thermal/drivers/hisi: Use platform_get_irq_byname
Date:   Tue, 25 Sep 2018 11:03:07 +0200
Message-Id: <1537866192-12320-10-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have the interrupt names defines, replace platform_get_irq() by
platform_get_irq_byname(), so no confusion can be made when getting
the interrupt with the sensor id.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index a542cb3..941c2c4 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -63,6 +63,7 @@ struct hisi_thermal_data;
 struct hisi_thermal_sensor {
 	struct hisi_thermal_data *data;
 	struct thermal_zone_device *tzd;
+	const char *irq_name;
 	uint32_t id;
 	uint32_t thres_temp;
 };
@@ -407,6 +408,7 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 		return -ENOMEM;
 
 	data->sensor[0].id = HI6220_CLUSTER0_SENSOR;
+	data->sensor[0].irq_name = "tsensor_intr";
 	data->sensor[0].data = data;
 	data->nr_sensors = 1;
 
@@ -423,6 +425,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 		return -ENOMEM;
 
 	data->sensor[0].id = HI3660_BIG_SENSOR;
+	data->sensor[0].irq_name = "tsensor_a73";
 	data->sensor[0].data = data;
 	data->nr_sensors = 1;
 
@@ -576,13 +579,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		data->irq = platform_get_irq(pdev, 0);
+		data->irq = platform_get_irq_byname(pdev, sensor->irq_name);
 		if (data->irq < 0)
 			return data->irq;
 
 		ret = devm_request_threaded_irq(dev, data->irq, NULL,
 						hisi_thermal_alarm_irq_thread,
-						IRQF_ONESHOT, "hisi_thermal",
+						IRQF_ONESHOT, sensor->irq_name,
 						sensor);
 		if (ret < 0) {
 			dev_err(dev, "failed to request alarm irq: %d\n", ret);
-- 
2.7.4

