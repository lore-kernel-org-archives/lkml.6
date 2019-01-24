Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75729C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4440A218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBVgzAGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfAXUYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:24:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41018 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbfAXUYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:24:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so3555015pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
        b=GBVgzAGeXK+Rhr1uP35wQOeRalFHWCi6YOovZ9EHhbjKLg4yxkKXqnqtApf0Y5S3H9
         b4H4CAPIayf6QvJmzrs55RsV5o8EGOhnulQipxJQbllKeAijXxj1I8a68SNWkSFK/gRT
         R8QtLPrvRqGYp6FmqxxigMenl9z2kGBksziag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
        b=mlwKZFa/bZ07mOEl2MCTv9DnqOH5BDE848XsPk6oUG4GNqdtQ8r5AVPEIxjdSyzzYW
         sgeoJo6xBSIc70tWfLh9K3K5ap8YVpheO2h61Wst3g73ml9g/evqCdol1A1OOFVzg2/d
         d+KGqR10OXCp67YuCjUC8j/l7SspmcIxsGxPqJLS35lQGIObKR+z+a3tifNfuy4o/rOL
         daEwxCcZVjo0heKiu4nh/KX622OSbvSwdGYSAta/1p0XyISsUKtMgYT+eCl2ZCtQKwSl
         LaqrltM5zglXWTskR1GCI6GMlhkzR3rM4fevH6/ls65iUpb72g4yaPeVoahXC0ja957t
         a1cg==
X-Gm-Message-State: AJcUukf7TxHtBmCaq/U8j2zC25db3xqEajt6QiaD/ZNqFUMtLMSUP7uJ
        h/YI2Z+vosnuwZFyCEGm+8wpbtPc6sjcpg==
X-Google-Smtp-Source: ALg8bN6A6yCdAMBKYtld1GZx43O5sg0gUviTrnslHfiYH9eOjxyBo3E/puHb2tby2efvI4cQdIGP+w==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr7369721pgc.165.1548361478990;
        Thu, 24 Jan 2019 12:24:38 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c72sm45263309pfb.107.2019.01.24.12.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 12:24:38 -0800 (PST)
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
Subject: [PATCH 7/8 v5] arm64: dts: hi3660: Add hisi asp dma device
Date:   Thu, 24 Jan 2019 12:24:22 -0800
Message-Id: <1548361463-28372-8-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
References: <1548361463-28372-1-git-send-email-john.stultz@linaro.org>
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

