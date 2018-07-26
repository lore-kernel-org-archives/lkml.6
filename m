Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48357C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B9420673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKV06oK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B9420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeGZGXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:23:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45707 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbeGZGXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:23:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so173421pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 22:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sj+k9ssGIvQGv/CdKo1gq55v2kvm3THWGqKkBDx14aI=;
        b=eKV06oK3HZkZA5xW6GQalFGnGLAVgtthMFaCy9krbudXQ+8zoy7y6eBNkbMY+C2keG
         Euags+eT8AR5T8KEa5GiFdAA5LWMiYAPCG8Ly+8+NJndrADEEX9uwIEOFBCj2O5RzV65
         8NrrXo+kAq6fqrsD3V9U9+b+GQgPHateTPx8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sj+k9ssGIvQGv/CdKo1gq55v2kvm3THWGqKkBDx14aI=;
        b=cEG2mmyxOIy3bi7ifNwodxlwOQkflKJ1eXXjPOQEWAoOtyzNBkRLe7FWuCAOnT4Qvz
         nEMFjEElzzT6s34N+2q+cb8hyiW+oHANAus/FQp5wNyTXKyYKi986CZws9OmBiHlqrZk
         oYo8ZnbOMwMbRDqMbTeCiw63GL8k/gh7MEEshka5Pkw1CY5GPFZfE89uIUw/aM/MS4lB
         S+rQR4yYF4PI4H08FZucnfmmCwc1bnaFjFbeD383AXz3atzNW9OmCvaJKVc9mv1utS3g
         yIZHDik3zcEDahq9GsdB9WizYjHY+uJbIfCoMUWZYkRKRm/PPhJSOZ/If3SPBRkM6J+N
         MIyg==
X-Gm-Message-State: AOUpUlGh/RGiSDpqUHQja3CVHK5Nm3W1/Iv95hDGo74xNwMKFosUdOjA
        UwE4ajSKohzkUcdgo0A76Iil
X-Google-Smtp-Source: AAOMgpeFa9giEkmRg+yFHh9ESlKVI58JzycgJDxbVH5Bs+zOUJ6+CRbXGSB0KN5aibB/kXkMSasL0Q==
X-Received: by 2002:a63:fa48:: with SMTP id g8-v6mr523680pgk.224.1532581680708;
        Wed, 25 Jul 2018 22:08:00 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6208:6a6e:a8cb:6394:3bdf:2b97])
        by smtp.gmail.com with ESMTPSA id y4-v6sm492540pfm.137.2018.07.25.22.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 22:08:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org, dmaengine@vger.kernel.org,
        liuwei@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 4/4] MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver
Date:   Thu, 26 Jul 2018 10:36:58 +0530
Message-Id: <20180726050658.1399-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726050658.1399-1-manivannan.sadhasivam@linaro.org>
References: <20180726050658.1399-1-manivannan.sadhasivam@linaro.org>
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

