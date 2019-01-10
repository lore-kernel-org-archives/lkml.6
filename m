Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCFEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B015D2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGVrZvxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfAJReT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:34:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44864 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbfAJReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:34:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id e11so5476326plt.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dcx6eEjMVOZ+Ig9EyGz6+bvTiD4bhQGrPgBuNC1183Y=;
        b=fGVrZvxGT+yjviq8KD9D7HKXW4EY6Ys3/5ws/n/XoWTXQppyNScmId8EqcbWnONL/E
         IujSXBN5v3qOF046m5ve9AtsWNKUsd9gFjJCDNdYJMb08b7YGy3R3UFz8lBSJIa8D3Kd
         S+tq1y5uxy/frm0cy+P+rvdjZgp4P7ERWrRBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dcx6eEjMVOZ+Ig9EyGz6+bvTiD4bhQGrPgBuNC1183Y=;
        b=TUoEl74ukJIKoUsTr2RV89YcUU9O6xxeTzEYwua0vQRyuKEe+LTQeout8Im9hk0tvR
         Rzzovv/yyAbmevYK/ZvP3AgZkioswgyxFlIAa+SQTthrmZpZJFYdrtCCi0pFJzWoeGMI
         jv+g6NhBauoc2dx2/LfvErGR/KKqf/B3eOttEOXxgAW5SuNwmqOJPuMzjZ4cyYzsM0XV
         UX2ZPfdkUI75ySIiJnNIjC3MLvsJoYHKgp4uBHrlcL2UvJjaA4W8km5EWYOT5n8G7DY0
         LVd1T5yYXyh08awHsLPBIJLmoKXnaiuS0TaBJ0H989NNbSz7toqD7P2VP/BarW0ddkZl
         saTg==
X-Gm-Message-State: AJcUukdIrpdJcrl4vNgHg/+tJEfmemJIsSJu6LCOQuNdA41fZ/zPJ/VO
        ZFsmYkBqNEVg80wcERoEBkd2VJywcM0V5A==
X-Google-Smtp-Source: ALg8bN43bqvvSkmwC5b9V3zV4AWPhWXkrMz8YcRTGfeFnh+77pA+FXTl3p5vE0SAtBsKTqyzKZelyQ==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr10995603plb.46.1547141657129;
        Thu, 10 Jan 2019 09:34:17 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id k15sm125977409pfb.147.2019.01.10.09.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 09:34:16 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 1/8 v3] Documentation: bindings: k3dma: Extend the k3dma driver binding to support hisi-asp
Date:   Thu, 10 Jan 2019 09:34:05 -0800
Message-Id: <1547141652-8660-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Extend the k3dma driver binding to support hisi-asp hardware
variants.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: dmaengine@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Simplify patch, removing extranious examples
---
 Documentation/devicetree/bindings/dma/k3dma.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
index 4945aea..10a2f15 100644
--- a/Documentation/devicetree/bindings/dma/k3dma.txt
+++ b/Documentation/devicetree/bindings/dma/k3dma.txt
@@ -3,7 +3,9 @@
 See dma.txt first
 
 Required properties:
-- compatible: Should be "hisilicon,k3-dma-1.0"
+- compatible: Must be one of
+-              "hisilicon,k3-dma-1.0"
+-              "hisilicon,hisi-pcm-asp-dma-1.0"
 - reg: Should contain DMA registers location and length.
 - interrupts: Should contain one interrupt shared by all channel
 - #dma-cells: see dma.txt, should be 1, para number
-- 
2.7.4

