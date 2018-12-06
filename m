Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FE9C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7FA20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107415;
	bh=zmoFpXKMgI5GcE4lkathkNMClp1CJ0VEpJOd2+/L7OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ci8G/jIuzmHeekAG1v1I1A2GwAAzvNBGRZS23M0oZ9jZSdbAkOcZ1am5fX5flkI07
	 zjMhOwbS2g+924QE5TmNVxqqvJOzcS9KlI9PilXn+p1tUTtLzVutmJIwNzzHJZHHyt
	 QoAZE4eUc+Z/0OKFUZUSdE3tkN7FXxolbJC8f7Mg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7FA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbeLFOne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbeLFOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E36F214DB;
        Thu,  6 Dec 2018 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107408;
        bh=zmoFpXKMgI5GcE4lkathkNMClp1CJ0VEpJOd2+/L7OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4Y4JV2lHteIwUPtxaqWlRDScT7G/bSQuHJyW0ZZtxybeXB0VTkhlZf6+HhZq5Zqj
         /xVJFIQzRAK1Sn9AACONCCqsyAshhUVn3HKRCBZSISalshNGUHI14FxTfl9gcSHQEC
         THIpLVoWJg9WllGvFa/S5DnNsdGJWBvnhWDfmqtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH 4.14 49/55] thermal/drivers/hisi: Remove pointless lock
Date:   Thu,  6 Dec 2018 15:39:23 +0100
Message-Id: <20181206143004.382565505@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit 2d4fa7b4c6f8080ced2e8237c9f46fb1fc110d64 upstream.

The threaded interrupt inspect the sensors structure to look in the temp
threshold field, but this field is read-only in all the code, except in the
probe function before the threaded interrupt is set. In other words there
is not race window in the threaded interrupt when reading the field value.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/hisi_thermal.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -221,14 +221,10 @@ static irqreturn_t hisi_thermal_alarm_ir
 static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct hisi_thermal_data *data = dev;
-	struct hisi_thermal_sensor *sensor;
-
-	mutex_lock(&data->thermal_lock);
-	sensor = &data->sensors;
+	struct hisi_thermal_sensor *sensor = &data->sensors;
 
 	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
 		 sensor->thres_temp);
-	mutex_unlock(&data->thermal_lock);
 
 	thermal_zone_device_update(data->sensors.tzd,
 				   THERMAL_EVENT_UNSPECIFIED);


