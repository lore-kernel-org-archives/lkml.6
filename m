Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B55ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A5B20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9Jlg5oJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A5B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbeGWFRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:17:48 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36235 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387817AbeGWFRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:17:48 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so7678123plb.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 21:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sj+k9ssGIvQGv/CdKo1gq55v2kvm3THWGqKkBDx14aI=;
        b=h9Jlg5oJlizQUQnO1ZKbkASnLsQ7lTE9UFuMuMA2K0gyYaPHuvnNGm4fpD+PTO5TSs
         XoC5svlYV0EjXg3nJ71ThtBDTCuJEFwUoIW0U0meDZmhkYepVKGwjDvE8glBWT7MIIUs
         bkg9Cmo28OCVlrwYy77huhN9FLkQocqQI/SDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sj+k9ssGIvQGv/CdKo1gq55v2kvm3THWGqKkBDx14aI=;
        b=hMCsObyHQ/qov1sJolgyIvlHZgXavg0Kh8lwLGMMFEstcVP2/Q9CuaFk0KtNZHocYK
         qJiUn3/wjzQhZbsOydlqBqI2WSvTU4jv2SxTTdh2blZ9hfeKcHSRWohyLx6y/WuQqUyb
         8ykBbkx+Apjb6dLAcIbEqu+T0DxoQcDg3+s71AqcPX5rNeSjYcsD3M9dvUYjwGlBhtaS
         zRI0Nn+JIAf+PBaRagHNQkHMi0PGmIusj/igkUJTwUTpd5aAGDrg73caOhLN/PPNzpoO
         ftMDfwOs8F+2CYxihzrHPssCLVPIIMmkFjenOsSEPgpqej/+8g4Cm7kaoIcO6+suJm7/
         XjVg==
X-Gm-Message-State: AOUpUlGckDX9YJGkr+xzpDdY4QXJ7Gd3tysc/pFyhs0CXYnmdN5OKiZa
        VVnXJpDWbOtjLOg3b1d5wwYD
X-Google-Smtp-Source: AAOMgpcsdA6AOfhltC3tbc8n5d6TyXCPOUwuC3mKrMHAg8mYxFK37y+04WmI1Djj8L2Rgbck7mzzpA==
X-Received: by 2002:a17:902:d70d:: with SMTP id w13-v6mr11440084ply.40.1532319515762;
        Sun, 22 Jul 2018 21:18:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:802:a98c:b568:c01f:49a2:2aa5])
        by smtp.gmail.com with ESMTPSA id i20-v6sm13369282pfj.82.2018.07.22.21.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 21:18:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/4] MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver
Date:   Mon, 23 Jul 2018 09:47:43 +0530
Message-Id: <20180723041743.32024-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
References: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for Actions Semi Owl SoCs DMA driver under ARM/ACTIONS.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b54e9ebc6f..56d9c7715c2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1145,12 +1145,14 @@ F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clk/actions/
 F:	drivers/clocksource/owl-*
+F:	drivers/dma/owl-dma.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
 F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+F:	Documentation/devicetree/bindings/dma/owl-dma.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

