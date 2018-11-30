Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C60C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD31D2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFavkEnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD31D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeK3TJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:09:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53517 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbeK3TJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:09:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id y1so4756729wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QRSPgOw55/T6zE4Vz5EM77WSQ9yydjg6bR6Qzgn853o=;
        b=hFavkEnnGzUvkMspt+c2pT9GINHR2fnxTsznYqafuiSowCA0OZ9DpYfC+0tIwTtpvG
         zcFcp8nj96AHs7++DOXqsWGWEq0PQqwWp39hfwE8J9bBYhHuw5/MgWvpNRg6F5iWfIP9
         oTKoV+7feei4R7/kwxrSa5j5LbOXqBegNR/qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QRSPgOw55/T6zE4Vz5EM77WSQ9yydjg6bR6Qzgn853o=;
        b=oiuUZTodJoj/lj6z0s6gWarqRIN5RyahFiF0U2KXbraFHgBOLxyw3FvZWRTVyaf//F
         4NszY8W85RQxj8rD4dM8kkraw8wJ3rLWRISNYYPTbFKKZoBljREMjAl/OtkKCXbkk2qN
         FRH6EWJJyqx2A+uFW2oqEalGw6ijv+LCfwku33pZ6HsONFXRV0Y6jL8Dh/RdR+2YWKvb
         hST3C2qNBoGafqU2e2/Du8/rs0+WXvx89tRV6N6wodQewh3ewQ+FWUe71/a+7HBXJK+/
         qxU7JT+rmBbc0IzDhsJ1VDmKO3oDti/yJ6ywdgvPo5y7w0FgdwWZ/dWQcYjNsrd4P+UA
         K93Q==
X-Gm-Message-State: AA+aEWZrC9lPYP12KD+2S7LoCuSgWWpBxhea8uWImVaPdem9HHBjjN//
        +Ntg24VyfNsl9IupOXTL+n3l/Q==
X-Google-Smtp-Source: AFSGD/XrxkeRfEK1I6kF5t+olKoHiVXBu6t2U2gUMOsWEQh6WabZvqWyE4X9kQds44pMGIWv/wrr+w==
X-Received: by 2002:a1c:5585:: with SMTP id j127-v6mr4224100wmb.127.1543564863997;
        Fri, 30 Nov 2018 00:01:03 -0800 (PST)
Received: from localhost.localdomain (118.142.136.77.rev.sfr.net. [77.136.142.118])
        by smtp.gmail.com with ESMTPSA id h16sm6212393wrb.62.2018.11.30.00.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 00:01:03 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     vincent.guittot@linaro.org, john.stultz@linaro.org,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] thermal/drivers/hisi: Fix wrong platform_get_irq_byname()
Date:   Fri, 30 Nov 2018 09:00:31 +0100
Message-Id: <1543564833-643-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, the thermal driver on hi6220 and hi3660 is broken.

That is due because part of the posted patchset was merged but a small
change in the DT was dropped.

The hi6220 and hi3660 do not have an interrupt name in the DT, so
finding interrupt by name fails.

Fix this by returning back to the platform_get_irq() function call.

Fixes: 2cffaeff083f (thermal/drivers/hisi: Use platform_get_irq_byname)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index c4111a9..50f4d00 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -589,7 +589,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		ret = platform_get_irq_byname(pdev, sensor->irq_name);
+		ret = platform_get_irq(pdev, 0);
 		if (ret < 0)
 			return ret;
 
-- 
2.7.4

