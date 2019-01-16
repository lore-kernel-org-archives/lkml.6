Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA94C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE7020675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1kvmDhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405534AbfAPRKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:10:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34521 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405351AbfAPRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:10:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so3313919plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeyXvvqE5bL0aSA9R8EemEtHWRM9NeMogHgyU1Syf0k=;
        b=a1kvmDhPW81K3f0m0+Jig4OKzRNMPLUeAoJTMJ2WPWBzPThKbtn8jU5zc1lbiCLGfZ
         hiQqYjxGREPP0RnDgfG3dOwVZbCs6jk+Zrpluqb6wYdTApVW8LF9PGUjUvMX1d3iXQBB
         g58DRO+VyOOrLNtoAIglBfC93/Y5Y3kvMmTAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GeyXvvqE5bL0aSA9R8EemEtHWRM9NeMogHgyU1Syf0k=;
        b=grpje589mVin0aui4VEqZxfSnxAnGV8EFvw5sRvJc9CEVo7UPkyZblQZ+3JFAL2vrv
         m09ZyeITiCA3yNJRXjb7lCGw9RP3f80iTgeXMbpq20ZEOc9cPful50HgcP90tLx1F+GO
         nwRZyZ8OjB7S72Lvxtl0VjLsU8mrwblCS3Nc6Wat3d6UWxAmPqrvqHe8pYfUKWDiCSSr
         ZTOKnJi5rGFjWDFSUIb2DQ5VKSp9gIHOSgdwKG0att3qjTCxUAj5UxdYRAqlJCNYBShs
         EthFhQkt4IUMPRjUGaVaPA/xJHMZ2kEcQbPQgOXvWSdnmeZpdks40q0umTbrXsVpQun1
         5zmQ==
X-Gm-Message-State: AJcUukdnNzh+DqrxA9W/LmxY3B75wmet4tDwuTNhH2xzWUzU//NIzfWz
        /YL3kyUqC6H7OQRpbsBCcTADDDiGSAb10A==
X-Google-Smtp-Source: ALg8bN7nlqj4eb8HA/AK0fRhI7c6n2hui2RsCL9RXiebA/o/re4EvsYevFU9l+JTA3cM1IsKOrOgdQ==
X-Received: by 2002:a17:902:66e6:: with SMTP id e93mr10678478plk.92.1547658644110;
        Wed, 16 Jan 2019 09:10:44 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id h129sm17914023pfb.110.2019.01.16.09.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 09:10:43 -0800 (PST)
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
Subject: [PATCH 1/8 v4] Documentation: bindings: k3dma: Extend the k3dma driver binding to support hisi-asp
Date:   Wed, 16 Jan 2019 09:10:22 -0800
Message-Id: <1547658629-25378-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

