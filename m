Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93C3C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827B521872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBXRpivB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfADU4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:56:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39009 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfADU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:56:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so17922198pld.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m/40e80Ep6rjyjDwykxJoS1RLKo9nvsjp+tokbpPYFM=;
        b=LBXRpivBXTJ8hv9TT23AvS5t0vZyW8WHfzVz7FAGNablhcZ3jYNskvWO7NP4e897WF
         K94qSyLpJASrD74iWKAtlj2YgbRyNuHw98Y0CtaClyQZQUuiHX/Ofc5A3Sre6qhb4s6D
         0LW2AVd3Fm+rt34p3mJ0P4Yd4gRgL/qKFn5sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m/40e80Ep6rjyjDwykxJoS1RLKo9nvsjp+tokbpPYFM=;
        b=C6Yrz0KOjclpKOiWYX0j8RGp4R2Ei2M+L2e5mK9bD7160tEd9Q8ZE3Urz7Hf7mCLZy
         PVJA/HFauQv9Iky56jj8ZZzVC2Xpb1azG8MA1HTcOvqiOy//dpz+bv7Wkczm5AqKBBfv
         4XTRg/G7rSBRcXAmP/AJ/arnQTA5pzRLG3hzCcI3q52HIypovr0BJRmtaaF0QRkcuIhD
         sTSqpCItwHO/Fcy2L/Gbuy/NOa2g7puRKRlXxDcbkQ+iVOdoxfXQ6OkiXa5zH4l+eoJm
         X9N3lV7AoxaoQ0LyAyVnysfeNvfrVrKFQfM2TOb3102mtl8znMOTGOGqBGrjTG7c7B8+
         E1oA==
X-Gm-Message-State: AJcUukeDo2Ea00nvFJNBnOg9GGFZeiGK44w9roIaCO8pEyqAa1n0OvVS
        D4jJfdlE0SHxRemFa8FkfSioSQmzkDdkcg==
X-Google-Smtp-Source: ALg8bN4FYH1Q5Q6VXHoi1tVBi7Wp4B3bTxmqGV2ooA93z8nbHiJzYxQyUIdPXrWu4QO7cusbDgs3zw==
X-Received: by 2002:a17:902:96a:: with SMTP id 97mr50784814plm.45.1546635395922;
        Fri, 04 Jan 2019 12:56:35 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id l3sm98058334pga.92.2019.01.04.12.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 12:56:34 -0800 (PST)
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
Subject: [PATCH 2/8 v2] Documentation: bindings: k3dma: Add binding for dma-avail-chan
Date:   Fri,  4 Jan 2019 12:56:22 -0800
Message-Id: <1546635388-13795-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dma channels can be reserved for secure mode or other
hardware on the SoC, so provide a binding for a bitmask
listing the available channels for the kernel to use.

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
 Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 10a2f15..1c466c1 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -14,6 +14,9 @@ Required properties:
 		have specific request line
 - clocks: clock required
 
+Optional properties:
+- dma-avail-chan: Bitmask of available physical channels
+
 Example:
 
 Controller:
-- 
2.7.4

