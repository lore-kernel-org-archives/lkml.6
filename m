Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDE7C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FC52146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkcwvF6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FC52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeK3TJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:09:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56071 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeK3TJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:09:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so4740796wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BULyaOacFd0d+m8z9WucrlU3IR4UOzS/+4lMifUgKf8=;
        b=BkcwvF6bmwP+b3m7YqvDHCbspSIkZHvy1WElrP/igiMnjI9tkcYwVqxQzmylnl/ctG
         EEh27BUlsfnPLSnMrN4ua5zN7r+h1VuWCyinCxuFWxhubjdn7b0cIwoGPmThA52dguHe
         FWbmvTiRMtFk/brObMH7jbGF6nH62qUZDjaJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BULyaOacFd0d+m8z9WucrlU3IR4UOzS/+4lMifUgKf8=;
        b=PwF8oKVILcg2ErquMQ/ZO1ydbCRKBtHxOrBShvCbNGpn8CuKPGlxicIO87UMX0h3hF
         khRfqUO07rnYBv2tnvvezaDuQwoFdHiTT5cZP29spwWP/6Cnqnz/SWox+qt/EcxkBwVz
         ZAGhoyrnytoS0qE+JEcy6sj2GRCzB2+YntnxCndhAh86sWHrHzqyXT+FcNolD/wwpEdy
         DUmxuz6w74YDb5GUF4dmhYeNebAVzbnkWP/mTw5SZH47nvWsXrAhGeQpfL7FWe1m9CV7
         Mvq1KPWvYrb4GWj2fkszin6KnPTHdAdS0JKXxLzMTZbegGgDhEkwFhP5RBeo/dv7U/Bw
         9L0A==
X-Gm-Message-State: AA+aEWZYhB/+jsJk1cW6G+VpAqVcabc4k2mixSVwrRmIlMf5aC+GF+Hs
        wQw/dGdxWgLafLxfhqeOUmlNBw==
X-Google-Smtp-Source: AFSGD/VqqYRmxInzPfxesU6ZVhqjEEZcGRWykhD5CsPf9WQ+NkwB8QZP93S+rruSyPzbqilnePMEOA==
X-Received: by 2002:a1c:a84f:: with SMTP id r76mr4354622wme.16.1543564865598;
        Fri, 30 Nov 2018 00:01:05 -0800 (PST)
Received: from localhost.localdomain (118.142.136.77.rev.sfr.net. [77.136.142.118])
        by smtp.gmail.com with ESMTPSA id h16sm6212393wrb.62.2018.11.30.00.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 00:01:05 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     vincent.guittot@linaro.org, john.stultz@linaro.org,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal/drivers/hisi: Fix number of sensors on hi3660
Date:   Fri, 30 Nov 2018 09:00:32 +0100
Message-Id: <1543564833-643-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543564833-643-1-git-send-email-daniel.lezcano@linaro.org>
References: <1543564833-643-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch the thermal driver is broken on hi3660.

The dual sensors support patchset was partially merged, unfortunately
the dual thermal zones definition is not available in the DT yet, so
when the driver tries to register all the sensors that fails.

By reducing to 1 the number of sensors on the hi3660, we switch back
to the previous functionnality.

Fixes: 8c6c36846f11 (thermal/drivers/hisi: Add the dual clusters sensors for hi3660)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 50f4d00..2d26ae8 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -424,7 +424,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	struct platform_device *pdev = data->pdev;
 	struct device *dev = &pdev->dev;
 
-	data->nr_sensors = 2;
+	data->nr_sensors = 1;
 
 	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
 				    data->nr_sensors, GFP_KERNEL);
-- 
2.7.4

