Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D51C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9410320838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoWLEQBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9410320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLGRwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:52:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35940 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeLGRwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:52:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so2037193pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rwWQPcwAG5bL0jLJ466vv4VF+mkIHlpaX2C3j57q9XM=;
        b=MoWLEQByCfeN2DbJfumm8qytGeZSXqamSjDSyUv9e6MWFbr7zB1DusGQVy7vobbyTd
         Az2LkPbXG2Vsi6Fss7OU3EWrgTfIxqqNM6sCLa/TeDKw7YaQ1W6arHQYHnNGwroEOKBG
         Wfu6NbwBvaJp7FB9prZOjbmLtREUWuWfZ8zF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rwWQPcwAG5bL0jLJ466vv4VF+mkIHlpaX2C3j57q9XM=;
        b=Wv4T79dkJiCfN/8zf2PK52KKVF4CaG7vCFHrUWHRf9uNFdAtgS+VhR8zClQPQPZnT/
         EECWxUh5fPtP1HD7b0J9YdKlf/c6XdMjyzDZnWy1zT2pFDem6kA7Pn2lI/LxNnUbPUI3
         kHvdGZnwMQlpVEsb6cRjIUV3GoK3niGkVQaUGlHdAC/YZS5AJKukap+VAVX0JTpg+HoA
         PxpFpXsyhSxRzqJXD9hWHQnbgOlbh0hYAZlmpEVOuiK9PfUQ3xUbdkK4+U+T3WshvDj8
         ScO6aOQjyRxsiy1bBy1RZSuho8dUN3CHxj0JV7a9oV0M5I0oiVxauyErkXyr8Dr8gGhe
         BIsg==
X-Gm-Message-State: AA+aEWZngqYERUcHzM9aaLzENTs73HMOs14phvYLQqtCqB+UlTITw/dW
        RZWeqHNniAQUc246GTVaoOxi
X-Google-Smtp-Source: AFSGD/V7dL40rNgO91I6OaI5GVtS41dTEMu50J0EKyYp/qjaRceIItuadQJPqsBc2viOfsxA134pig==
X-Received: by 2002:a63:451a:: with SMTP id s26mr2826299pga.150.1544205133658;
        Fri, 07 Dec 2018 09:52:13 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7207:e9c8:7189:c4b2:429f:42db])
        by smtp.gmail.com with ESMTPSA id k191sm4611387pgd.9.2018.12.07.09.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 09:52:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Date:   Fri,  7 Dec 2018 23:21:49 +0530
Message-Id: <20181207175151.8969-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
References: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
similar to HI3660 SoC with almost same IPs. Only major difference interms
of UFS is the PHY. HI3670 has 10nm PHY.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
index a48c44817367..a327c1e24365 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
@@ -6,7 +6,9 @@ Each UFS Host Controller should have its own node.
 Required properties:
 - compatible        : compatible list, contains one of the following -
 					"hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
-					host controller present on Hi36xx chipset.
+					host controller present on Hi3660 chipset.
+					"hisilicon,hi3670-ufs", "jedec,ufs-2.1" for hisi ufs
+					host controller present on Hi3670 chipset.
 - reg               : should contain UFS register address space & UFS SYS CTRL register address,
 - interrupt-parent  : interrupt device
 - interrupts        : interrupt number
-- 
2.17.1

