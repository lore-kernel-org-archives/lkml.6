Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DB2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84A4208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyNp01W3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfADU4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:56:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42472 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfADU4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:56:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so17911587plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 12:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dcx6eEjMVOZ+Ig9EyGz6+bvTiD4bhQGrPgBuNC1183Y=;
        b=QyNp01W30Sy5XI75DuAswJ5UvdmabjG0XTJd4rPqawsXvGW005+IhRY54AuB8ZleOj
         kBhdRaq9ASBAaVco0dHzvzML8xDlc3IuqGbxfmiTnTGEaixsxzbZZn/XHFWmPUrIYbvz
         At1++r7g7tZLaTn6M+Lk6QOhwuh5u9MdKExWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dcx6eEjMVOZ+Ig9EyGz6+bvTiD4bhQGrPgBuNC1183Y=;
        b=j9z0B1YeGXLPqeoUQoAO7FKAsTY2qCU84SXlQMO1rgnVN31ArllcBKdu4YGFfcFaIC
         7IWgNnx2JviOTxuTpnmIqhhQa0E2h+v493yoVZzxfoB6fbFd2mrGU5XDMEJ1bhk1I64R
         VZmzpr2ileCuSfePdHtdukfAJu/0xU2f1ggl4DfbnBqzoCg6EyhoeQZoBLqF5+gSU3nI
         gqk9m3G8SP6o0Il3Nhz16mnKF29lLP9usBX6ifDojW9dU+5wsaIDJRdW0F7StgnczN+N
         vtM7srDPH0TtyjSurzRq0HyQgN3XJQPlguamb9zbNtFsUYR8ClvY3dI+MJ0F9NnWP/SK
         luEA==
X-Gm-Message-State: AJcUukdV6zqKya6YRYWyYU/9Q/Hc++OZn1Z4mdpHvr2ytgAFEMrYOs0V
        5wOp8zICDRLato5GXigE3QMEqdwl2K2orw==
X-Google-Smtp-Source: ALg8bN4wqL57WWYm3AnmQvqkhOZ3jnmjhB9BABwrzFbSykpU654QuDYEozKo4bvxi7VNk5DltcPZ/A==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr53664973plf.202.1546635394099;
        Fri, 04 Jan 2019 12:56:34 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id l3sm98058334pga.92.2019.01.04.12.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 12:56:33 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Youlin Wang <wwx575822@notesmail.huawei.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 1/8 v2] Documentation: bindings: k3dma: Extend the k3dma driver binding to support hisi-asp
Date:   Fri,  4 Jan 2019 12:56:21 -0800
Message-Id: <1546635388-13795-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
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

