Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38E0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BFF223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcdsYoU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BFF223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbeKNAqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:46:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42998 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387402AbeKNAqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:46:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id u5-v6so8337610wrn.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0uFgq7uL2kAGCBa/t+I51Xcd1+QHn6w3C87keUlgI0=;
        b=PcdsYoU2sU104K6nE+gv4EzJuS1ZFSkqqL1xRi9zoOLD1pEfZx7NyoV7Ueq0SLs3D7
         1xK0CYitRfX2M08grMfdxspAWZ5ORlVNiRuhKrhYFwl1+7vSv3zB39297+7k8JlIWBZ3
         tDA2RRamzWQMHAPh++CgDKReCE544uw9wvPms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0uFgq7uL2kAGCBa/t+I51Xcd1+QHn6w3C87keUlgI0=;
        b=eZ2xItjWEZrtO5kpVttURIZ87v3wCr2w1OlRCzrR8b1C9DtgN0jzdZ963m9u2Ute8A
         ZBhow2EJNyJJRJuhBG87xK0JBZiIdRG+jB/NiVV2P0iX6T10z6IOFdNQyJrYNF0NS7h3
         xNO5o9pvKCR/0hdIUYdu8UYkZPVhIyXpzCLP3uw1tkiZ9yIvHb2fy9RWo2ZKIahqxnZu
         Ku2yUFAanhXNXuapFyENUrjIFCJaE/9RdL38dPcEKefJL4QJb+n//RjHLH/mph9sJZ8h
         TermFNj82QBxkyZyk2oY74Io8EsQjp1HTCFoOiL6tIgv0kvCASByIoxVo5C3jYqX33Iz
         i9iA==
X-Gm-Message-State: AGRZ1gKADsnx8XzP2y2AwBhBwZHMYbYYaWpnxjSoYS+bQq5/Kfxze+sk
        86KOd9YGmFU++G62bEYE9yLDhg==
X-Google-Smtp-Source: AJdET5cywocwCrBeVkJCWAPWAuyvWQ0K6pOHqEGbzxwRHvqTVAjnttLLzJAbIBuJvcyu5taPtrJClA==
X-Received: by 2002:adf:df82:: with SMTP id z2-v6mr5076186wrl.118.1542120495976;
        Tue, 13 Nov 2018 06:48:15 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:8cab:bca7:b2f2:d2bb])
        by smtp.gmail.com with ESMTPSA id s16sm3292020wrt.77.2018.11.13.06.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 06:48:15 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: stm32: Document hwlock properties
Date:   Tue, 13 Nov 2018 15:48:03 +0100
Message-Id: <20181113144805.1054-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181113144805.1054-1-benjamin.gaignard@st.com>
References: <20181113144805.1054-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hwlocks as optional property

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
index 6a36bf66d932..cd01b2292ec6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
@@ -14,6 +14,10 @@ Required properties:
   (only needed for exti controller with multiple exti under
   same parent interrupt: st,stm32-exti and st,stm32h7-exti)
 
+Optional properties:
+
+- hwlocks: reference to a phandle of a hardware spinlock provider node.
+
 Example:
 
 exti: interrupt-controller@40013c00 {
-- 
2.15.0

