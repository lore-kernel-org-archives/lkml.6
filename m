Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBE7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B84020651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOB1Q123"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405841AbfAPRLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:11:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39080 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394478AbfAPRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:10:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so3297009pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJa/3xt1JMxzSbHyVab2zd3RhWbY439V9Orw9mFVXdA=;
        b=kOB1Q123vSecSRTJ06CsqyBuW9/HImrhm3MqYY0doaB11TP2Dvk+npnTSqQsTfnRcW
         mTe1bbiGHRs4vn+edG0CtmnyPCzVa6hRASQjKRNBQD5vUqJzCSfGsxe7g9I+sZPV16Hd
         3hEdg0wcrJKS+17GRjAwcC1qKLl6RGEh06c3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pJa/3xt1JMxzSbHyVab2zd3RhWbY439V9Orw9mFVXdA=;
        b=dFTwUyvkK+JqfVRFXbAXsdx3Q+yx0Doj0e4X5n5UG09Z4fhhxapfgQoke3evtTOAvF
         jHMEPgEpUY85zQAmmOIfMqk3HScFHUZzJKQsU4zTVOFcmnb9NCXu741uLZFnBn96WJGB
         W/dYYBNiEHWYdVPqkVjs6/ITZWjO0VxIxMQOyuGtwydNIf6os4494b/Iu8HxAbMI10AW
         Kv4vEd3CvGn+T+eDFpaYIh7rwZdtV+26lIdSmt7OQESL6z6HpJfirGtfCYMAQqNgoojy
         jeoGKnn3CPC4xUtC+thW05GuGZAcnscL10ktZBz8/Jsk7VpX9QZrZjDGjet5fcBaKkAv
         C7cw==
X-Gm-Message-State: AJcUukd9tFDiGZU4iZ4iMxHPlFUqj9yAKP5jCb7+6zR6psZsKku8gImZ
        8AXZ4tW5mIF1UuCFWxg33YeN5rfVHV/d1A==
X-Google-Smtp-Source: ALg8bN53UVr90AHvPfr8dtUoE+UjK3twxa1QIy9kliJAMjdXVHiYMuFJ2I9wblt0BFdSy8YMh/khfA==
X-Received: by 2002:a17:902:2a0a:: with SMTP id i10mr10713001plb.323.1547658646183;
        Wed, 16 Jan 2019 09:10:46 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id h129sm17914023pfb.110.2019.01.16.09.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 09:10:44 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/8 v4] Documentation: bindings: dma: Add binding for dma-channel-mask
Date:   Wed, 16 Jan 2019 09:10:23 -0800
Message-Id: <1547658629-25378-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dma channels can be reserved for secure mode or other
hardware on the SoC, so provide a binding for a bitmask
listing the available channels for the kernel to use.

This follows the pre-existing bcm,dma-channel-mask binding.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3: Renamed to hisi-dma-avail-chan
v4: Reworked to generic dma-channel-mask
---
 Documentation/devicetree/bindings/dma/dma.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
index 6312fb0..eeb4e4d 100644
--- a/Documentation/devicetree/bindings/dma/dma.txt
+++ b/Documentation/devicetree/bindings/dma/dma.txt
@@ -16,6 +16,9 @@ Optional properties:
 - dma-channels: 	Number of DMA channels supported by the controller.
 - dma-requests: 	Number of DMA request signals supported by the
 			controller.
+- dma-channel-mask:	Bitmask of available DMA channels in ascending order
+			that are not reserved by firmware and are available to
+			the kernel. i.e. first channel corresponds to LSB.
 
 Example:
 
@@ -29,6 +32,7 @@ Example:
 		#dma-cells = <1>;
 		dma-channels = <32>;
 		dma-requests = <127>;
+		dma-channel-mask = <0xfffe>
 	};
 
 * DMA router
-- 
2.7.4

