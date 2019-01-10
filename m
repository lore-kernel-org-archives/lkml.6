Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E713C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017A5214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuy9V6jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfAJRec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:34:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35199 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbfAJRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:34:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so5489515plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
        b=iuy9V6jqxAJvqy6tSRvIkhHDKg8AXbR5U4GoOHS7AYuJ1eQsjPeBl4HoCL+CJbK8js
         YmeTND5LSvjqetT9V/BjRuIcOw7EE85aB+fz0Br7Bpbw0ga8wRqG+Gtk9Dn13KEepPQt
         8OdyWhubbn3WBx+yHycjEcSI0/RspL/JCEcUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BJPwKdPemEfYMv75wEmswxneBbTlFKZrByoYlXp3bSs=;
        b=oZDa2AJIWx5YBdU4TIPT+gWLKHNHGfe2O85U0UErrwmikQGBc0v6MNTIaxT9R80qhZ
         hbYaLCZ0QMw9VhUHQGdSTvoVepYJv8/Ers86i6ektZstfd1zlj6W8R7OrWEVmVwfZlbO
         DB2eOHzYtxhwIBN0Pm/mtoowymh1OxW/Oa1vlNhSo1BiEmv67NifyZvFtT6wEDgaUaXz
         g0iFQrhFsNQNSP0SUjCEf4JGhLdwNF9n+jEV1Cun1xrGHFMypjJVh9ttc/eDpXvcrxFu
         fcziNyreQ7E/1RmdtcIN7LKRH3k12rLh8g4f5zGzjnrsJt8JGHCzonf1qwXc+b9C4FlF
         7MbA==
X-Gm-Message-State: AJcUukfjH3YNO/x27gQlRbNErV0dlw1GPw7Iz9Mbp+J3kXKp+hJ7nOz3
        oOOoV13cnLsA845Hku38mzby09UQHHcTAQ==
X-Google-Smtp-Source: ALg8bN48czPk4P5inKX4Efd+Xi+gXZtHTbv+vius5pKpS0Z5BoHbBlmB83+2n1+SsSrPUACT2FXgcQ==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr11079391pla.136.1547141666568;
        Thu, 10 Jan 2019 09:34:26 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id k15sm125977409pfb.147.2019.01.10.09.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 09:34:25 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 7/8 v3] arm64: dts: hi3660: Add hisi asp dma device
Date:   Thu, 10 Jan 2019 09:34:11 -0800
Message-Id: <1547141652-8660-8-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
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

