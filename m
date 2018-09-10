Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ADDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C51820833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbONVz7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C51820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeIJUJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:09:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41097 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeIJUJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:09:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so10626814pfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k14lBxRZet8JTP0sZsFzzMdrUIiDAx3PCahAr8M1lTM=;
        b=DbONVz7SNceTZXBZJ8Gl0rnlFDJW0nx0gDqbWxJjPAh0FU6WbQn5fnmnQX/SPblLQM
         R5dn8fXgoyp9F+BayRLiTZj1xjjwsa9c+cNblxab/snkslnvqb4DubBY+neFF4oPV9m+
         JZTvXyEfdmfD6P5xOPV4BcrIX1U5FSXgs2mBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k14lBxRZet8JTP0sZsFzzMdrUIiDAx3PCahAr8M1lTM=;
        b=bW7wa24o7FM/Bm42Ai5oxQPPpd25ajKmio/uQaEvBePpLMZZet/7t5YF7eOQOOcp1Z
         ZEAZYJOM15WlM9dH4RoNq6f2Ghcc0jEwa2oiUI8pNZ5joDFlWddWJ4IQlbjt64g9ahup
         vOXwW4SzG2nPGqX8o7W+82+DuOUNIhxQlkuaaICkcVLMhoCuDeMxgRqGAf5Lb6rN4Fve
         oUoEU3IDncV8u8YcjxrfgwEkjyQFH6t5iK629uI0TdKstNs0RMqDzlg9ITN/c3LCC/Dk
         OgANwe7j4uM1vMAWVH0Y3OFivwrcHBxijeUak6W1EKTAiGxoC1QWQ6ymp8q916wAdIWw
         pTRQ==
X-Gm-Message-State: APzg51B5N+cuSV3bTtGM0syd3IMlG2S6HB6cJM6Us7ECoqUmudOSoYWu
        0Gpj920HUbtb7nkSpLyB6+/4
X-Google-Smtp-Source: ANB0VdY+YL+272sxvYeYxwuGJDW6P6/Y/3lJAb3pIhIsB8QKeqbJX/Nis0AJl0X6UUBDBYgnww6LFA==
X-Received: by 2002:a65:5284:: with SMTP id y4-v6mr23235056pgp.283.1536592475955;
        Mon, 10 Sep 2018 08:14:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:728c:6bba:60a8:6c40:2817:7ee1])
        by smtp.gmail.com with ESMTPSA id e202-v6sm26703907pfh.16.2018.09.10.08.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:14:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/4] dt-bindings: arm: rockchip: Add binding for Rock960 board
Date:   Mon, 10 Sep 2018 20:43:54 +0530
Message-Id: <20180910151356.25946-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910151356.25946-1-manivannan.sadhasivam@linaro.org>
References: <20180910151356.25946-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Rock960 board from Vamrs Limited.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index acfd3c773dd0..aaad9e2ff9a3 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -5,6 +5,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "vamrs,ficus", "rockchip,rk3399";
 
+- 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
+    Required root node properties:
+      - compatible = "vamrs,rk3399-rock960", "rockchip,rk3399";
+
 - Amarula Vyasa RK3288 board
     Required root node properties:
       - compatible = "amarula,vyasa-rk3288", "rockchip,rk3288";
-- 
2.17.1

