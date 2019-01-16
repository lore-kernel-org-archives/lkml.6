Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A27EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DCB20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZC0NuQZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405796AbfAPRLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:11:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43116 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405679AbfAPRKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:10:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so3341778pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
        b=ZC0NuQZtzevm393jUDaHO6qpCP2McdL+j3pG8SHj8qOAQVS/1QG7Yt1qLhn4lYBfXv
         TKzUb569Z/TbPyWrXJEKtl1HiYCAGDjeZs1LTcyyVczGzmPMQWeyKmAKgJQuLB2CcEH6
         chCzh0ahiDk1qZcywqatjLafUd5NmxNOjqCI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
        b=LS32TcpglKR3zhrBJ4jaUDYVb1b69snqje8jQZNdfgLK3R0vVLCvmcDXmP91p5l5q/
         hz6U0M3RgOmE90agN9llLg/o/+RnvOIYQtveWhYVHUfVkYODOnNnD7RpbsVW7RC87dCr
         /p3UQkjNBEzFtJEam6DOMI89UCVfmac1wCEpCD1rsqS/WOby5sJWJm1r2vdqr2p2SbDq
         AFEw525ffNBfULQSuSsLznwAKSio+/U0ZRDgNk7qwqBs7h2GJirufN0Sl1R3OAkVjJ+d
         bveg+/vqFst0N+03x8tFwaC9tJdbCYBQdHrbNiNy64BL08CacITsIYiE3V1qgjzoDMia
         ALGQ==
X-Gm-Message-State: AJcUukflTDS0h9zW9o/1kXuLx1jvdXdb2dqZoufNvFKtwhL3+/uXCemu
        yyIM+VB1HoLjqFRY85WCTbJgYSTnJfn/CQ==
X-Google-Smtp-Source: ALg8bN5Z3c0YGDemQldXlh6snVOzNjS1AbTnli+TC48ycW1IO7letruuW7PeFCTB7aymNst0sOA23Q==
X-Received: by 2002:a63:160d:: with SMTP id w13mr9980661pgl.43.1547658654668;
        Wed, 16 Jan 2019 09:10:54 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id h129sm17914023pfb.110.2019.01.16.09.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 09:10:53 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Youlin Wang <wwx575822@notesmail.huawei.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 7/8 v4] arm64: dts: hi3660: Add hisi asp dma device
Date:   Wed, 16 Jan 2019 09:10:28 -0800
Message-Id: <1547658629-25378-8-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
References: <1547658629-25378-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Add asp-dma device to hi3660 dts

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Removed undocumented bindings
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 4c8d682..77a7135 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -567,6 +567,16 @@
 			dma-type = "hi3660_dma";
 		};
 
+		asp_dmac: dma-controller@e804b000 {
+			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
+			reg = <0x0 0xe804b000 0x0 0x1000>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			dma-requests = <32>;
+			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "asp_dma_irq";
+		};
+
 		rtc0: rtc@fff04000 {
 			compatible = "arm,pl031", "arm,primecell";
 			reg = <0x0 0Xfff04000 0x0 0x1000>;
-- 
2.7.4

