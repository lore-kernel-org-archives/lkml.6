Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E849C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E5520659
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2Cooy09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E5520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406950AbeKTDhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:37:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33042 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406598AbeKTDhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:37:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so3645107plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTOWvfrx0BsJZxmGzOshOzTkCx1AKkW+EAS4P/Cqekc=;
        b=G2Cooy09CPKls/oHLpjM8t7ruKTNmVmObqf/PwgQXaCyGsDhs3ehjnR0jekIjmbXOE
         wwqoQyNhFqTTeZWPZU4javuQf84nfLNvJpWI+1ZaZe5M4uiaKMJHx17jZm5hWJiWCCYU
         tfnpAqCG7+GmSciJLQ01vwCmEyKPoHg33jyYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTOWvfrx0BsJZxmGzOshOzTkCx1AKkW+EAS4P/Cqekc=;
        b=HW/4i0dZQam8Y+Me3yqMxUAdSfjkPeV0eBwyowyENJian0VIvfaIAPzlgoqWXQEqYw
         +xRjs1Ebs8BpcsRuXm4TFxAEk4IN/oASm76rkwXY1f0zp1uNkJ216InshjznLaAM5yGU
         S2uNVU2M7/mrsIaxiqxwmJHgSykjzZSo8oecgR9PC2ewvxOpRSJqGtC6byIHkMJSO/xc
         HGx/dWF1vOouVbeGzjCp8k5WtwDdkotPlAPXpG94+m609i0eZa1HLS8LgrsH1bLLJSzN
         yjRpFF24K9GJgWQjTNslpX21VOUJoLLsffH3aU+/WakOsmoHiHIe+sdo0irD9kHHh7pd
         95PA==
X-Gm-Message-State: AA+aEWbnI/WZK0Y9dZw8yU28qG3I4LV6VhtbOo+bpDvF9YS+6UzEpnfF
        SJFYeMBj4IWVmh+NyiBcjf1J
X-Google-Smtp-Source: AFSGD/Vx5ByW8rVZebFS7ct5jsaZSTRDoDVBh2NgQkd4xzjornUvW0Szc3PTB2w0pTKfwCG8SOne3w==
X-Received: by 2002:a17:902:7617:: with SMTP id k23mr5814335pll.83.1542647577752;
        Mon, 19 Nov 2018 09:12:57 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:12:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 16/16] MAINTAINERS: Add entry for RDA Micro SoC architecture
Date:   Mon, 19 Nov 2018 22:39:39 +0530
Message-Id: <20181119170939.19153-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for RDA Micro SoC architecture with myself
and Andreas Färber as the maintainers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c3fbbb361f8..7a5ae685a638 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1945,6 +1945,20 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
+ARM/RDA MICRO ARCHITECTURE
+M:	Andreas Färber <afaerber@suse.de>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/rda8810pl-*
+F:	drivers/clocksource/timer-rda.c
+F:	drivers/irqchip/irq-rda-intc.c
+F:	drivers/tty/serial/rda-uart.c
+F:	Documentation/devicetree/bindings/arm/rda.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
+F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
+F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
+
 ARM/REALTEK ARCHITECTURE
 M:	Andreas Färber <afaerber@suse.de>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.17.1

