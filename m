Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B04C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 06:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACB6208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 06:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GkUvtjES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfAAGnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 01:43:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45827 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfAAGnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 01:43:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so13863360pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 22:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AMznWe95QdV1GP0WW3Yl0Y7+cEK5agGrzdLNNRyeYp4=;
        b=GkUvtjESp2w9iiVtvyItRv1eAiW/eMLagweLYWINxEPKHooNhxVo/ViGJq7koLyrvk
         Ms4f+dIA6NTcqjEo4SqnKXxHjJmcSljGxuWhkEePTsI1rB/WcVx8xpaNffTIJyNK0xZ6
         MOTsTJkgP316q2Chq57+2Q8/UxgF0DkyygtVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AMznWe95QdV1GP0WW3Yl0Y7+cEK5agGrzdLNNRyeYp4=;
        b=QWKQ7sTfHGYLbkeYIWK0r3wsTuvJF9pBsVA/0JTNiajReOlz363MSn9rGlEMOzMIE7
         H2tsDwUd1Zn5uRsURRiewiyV4WPRWfMEKwvRzdKoHaKA0Dxix91E2C6Vf1Iv0rLVUGL4
         MjDhB93fhRusWFLqYmt3OY7VTogCDmfLMRaHjvSpaJrAR3Rq8AdnPD0zj5AFn6p7rWfg
         mcHdad7h7cseYKjB11WN0EbeiLUEr11T7UBj6/GqBvYKna3QiyVOVoAdPVhnn1q7WTL3
         uTut08N2Nae2jSLh6CrDp9W+ug7SFmuHY8WSaDpLOM7ZrwcKsF8lqj4QERXLbAMI3GNk
         yD5Q==
X-Gm-Message-State: AA+aEWaRBPSdabftS/7uO8IP5E1QZplCyQIfBT5nPrCB4ncOWm9/hcPp
        k5iqNAtVtKbMZVmjmuUCzCaUHEZYUu0=
X-Google-Smtp-Source: AFSGD/XZVVW5URYoXIlECez3E1P/TBPTPzk6LFf9fbThvI2qkNdnR9ylGr0Ki6o6rw3E3FlrXjMXaQ==
X-Received: by 2002:a62:2082:: with SMTP id m2mr39667108pfj.163.1546325003568;
        Mon, 31 Dec 2018 22:43:23 -0800 (PST)
Received: from cpxswub.broadcom.com ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s9sm67327266pgl.88.2018.12.31.22.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Dec 2018 22:43:22 -0800 (PST)
From:   Murali Krishna Policharla <murali.policharla@broadcom.com>
To:     davem@davemloft.net, amritha.nambiar@intel.com,
        ecree@solarflare.com, ktkhai@virtuozzo.com,
        alexander.h.duyck@intel.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Murali Krishna Policharla <murali.policharla@broadcom.com>
Subject: [PATCH] net: core: Fix to store new mtu setting in netdevice.
Date:   Tue,  1 Jan 2019 12:12:14 +0530
Message-Id: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store newly configured mtu settings in the netdevice after mtu
configuration is successful to the dsa switch.

Fixes: 2315dc91a5 ("net: make dev_set_mtu() honor notification return code")
Signed-off-by: Murali Krishna Policharla <murali.policharla@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 net/core/dev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 722d50d..58617aa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7586,12 +7586,15 @@ int dev_change_flags(struct net_device *dev, unsigned int flags)
 int __dev_set_mtu(struct net_device *dev, int new_mtu)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	int ret = 0;
 
 	if (ops->ndo_change_mtu)
-		return ops->ndo_change_mtu(dev, new_mtu);
+		ret = ops->ndo_change_mtu(dev, new_mtu);
 
-	dev->mtu = new_mtu;
-	return 0;
+	if (ret >= 0)
+		dev->mtu = new_mtu;
+
+	return ret;
 }
 EXPORT_SYMBOL(__dev_set_mtu);
 
-- 
1.9.1

