Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB97C46471
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E612087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ev+CCGgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E612087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbeIQFKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:10:43 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40559 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeIQFKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:10:42 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so8778280ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1bcJh9CtfJ4gAb6t6vtjisbCR0PKBNS05ea9K+ric0w=;
        b=Ev+CCGgnvLIEXmiRTpQCrXBwU5Sr96o05fDv55zIg+z7zwz0OheesH3dewlX9N9eHB
         6yZ876AB+oazr67VkYjG3rjV1lY8h/3RN+cfPcvaTuHkiSIpY344ClDhkeIAbxnn6YuD
         5CSKr/1swr9ywRZjGSkZxa2UyiQkN3m5rEjA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1bcJh9CtfJ4gAb6t6vtjisbCR0PKBNS05ea9K+ric0w=;
        b=MKm+FmKRdxlcfSvXNnJKhrcCbiUCLYEc1u4yrzwo+BAOBgYiJOXGtyYJ0gVTwj/ooZ
         2ByBiVMRcr9RioUULM3hkB22BS/BypBdKHHYGYjjPwKTVqBm4MrFKGpOvMUJM9myZ9ny
         cnJBF5dYwoIpE4Pdk/8upyiBL62W/+OWBKL4bU0sOxHH6//7sLj6XmCDCQQBKRgSL9sF
         VR9uxV/YF75TP8+d2h21sdgtenew/xc1n4Sz6XT63NVf5t1EKkhWphjEPT/UzscOu4GE
         h+2q4MnfpD5d/ws2fHNvtc0ocdAxRdyuqks+7P+4wmY6DCEZzto0Zu01Ec94YbN2XAUF
         spZQ==
X-Gm-Message-State: APzg51D9EqdfvNEHp/y6jpN7Ryw1O7fspn1M/IpYj6jepNowzbqlp/rJ
        hq/XFSjGnGiTsuO9oQYzSGQ9kw==
X-Google-Smtp-Source: ANB0VdZwJHiLbZJbBZtX/QkrLfVNuaoAO+VWs87iuhwajGLr9YqptxAZFqUbn0bSnsg5cVTWd0ss3w==
X-Received: by 2002:a24:aa08:: with SMTP id b8-v6mr10725014itf.49.1537141561414;
        Sun, 16 Sep 2018 16:46:01 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4495177ioc.63.2018.09.16.16.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 16:46:01 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/7] slimbus: ngd: validate logical address assigned by remote
Date:   Sun, 16 Sep 2018 16:45:43 -0700
Message-Id: <20180916234546.29661-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Validate logical address assigned by remote, in failure cases this value
is all zeors.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 8be4d67..b9f2e3f 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1004,6 +1004,7 @@ static int qcom_slim_ngd_get_laddr(struct slim_controller *ctrl,
 				   struct slim_eaddr *ea, u8 *laddr)
 {
 	struct slim_val_inf msg =  {0};
+	u8 failed_ea[6] = {0, 0, 0, 0, 0, 0};
 	struct slim_msg_txn txn;
 	u8 wbuf[10] = {0};
 	u8 rbuf[10] = {0};
@@ -1034,6 +1035,9 @@ static int qcom_slim_ngd_get_laddr(struct slim_controller *ctrl,
 		return ret;
 	}
 
+	if (!memcmp(rbuf, failed_ea, 6))
+		return -ENXIO;
+
 	*laddr = rbuf[6];
 
 	return ret;
-- 
2.9.3

