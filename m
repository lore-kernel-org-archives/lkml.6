Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F99C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786A5214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+0wNMal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786A5214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbeKMTtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:49:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35360 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731814AbeKMTtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:49:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id z16-v6so12543406wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tjLGayql7yCYJSAwW7hn4YcSYNkPJBOMlvKL2addz8c=;
        b=T+0wNMalUeS8Gk94cewQ9eKynMLerA4SG/ZseVqHeDIAe3ZE5VsWDg0/NcU2zs5HRf
         hsb6/ClTXINx+TwGX2zNvd8dA9VAS0XyLIMJPbYUHRNfL/7pVCHs4VJKuCdkNKAsj9nt
         jLH5NCn5tbo+9PFs1DOFdN65q2Q/8RJs3j8l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tjLGayql7yCYJSAwW7hn4YcSYNkPJBOMlvKL2addz8c=;
        b=qGQ4OjDnfsqSjESVDvSC/IzinaXtQ9Zv3uspr//7KdWLvd+EeDd9rL3ydxgW1h5kZX
         xNfV420+eWeKENKTfx15EF9DvRjXuHLTNS+KCaIzLj6uFanDFFjCqf0aLbL7nCrII5vJ
         djuwzNvLABPQJEv5jyR4gVY46C8N8dsLDfs2b9t20HR6IhbhOU/fTNS8/u8/DD7Ay5mW
         MBz7RYYC59btqFZpXqE6djxOM0agoLrAIyB5a/YmmZv/XUOOCpDOFMQDBhJqecGWlgRN
         u5eJQCL1dmpEddubcI7fQ2QIa+tOgHJvVWvkBqJhA4j70ob228lAXVpztJkCDU4pWR6Y
         8Zog==
X-Gm-Message-State: AGRZ1gJaFZALKP4l3rbmhJtYtfwx6q8F+ic4PlhMFdcwyh6bD7OYbMmr
        uF8Z+Ro7lRH189fJy+o4++1e0A==
X-Google-Smtp-Source: AJdET5fcYfMfPb0CXnVMYvHRo9NcbDLEkYMgs1ItT0qxCcUQcC+Alo7jEydnXzMqCPoAB6CxDnzppw==
X-Received: by 2002:a5d:4a11:: with SMTP id m17-v6mr4104009wrq.259.1542102717359;
        Tue, 13 Nov 2018 01:51:57 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:8cab:bca7:b2f2:d2bb])
        by smtp.gmail.com with ESMTPSA id d4sm6044279wrp.89.2018.11.13.01.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 01:51:56 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        alexandre.torgue@st.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/3] dt-bindings: pinctrl: stm32: Document hwlocks properties
Date:   Tue, 13 Nov 2018 10:51:40 +0100
Message-Id: <20181113095142.32015-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181113095142.32015-1-benjamin.gaignard@st.com>
References: <20181113095142.32015-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hwlocks as optional property

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index ef4f2ff4a1aa..48df30a36b01 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -56,6 +56,7 @@ Optional properties:
    More details in Documentation/devicetree/bindings/gpio/gpio.txt.
  - st,bank-ioport: should correspond to the EXTI IOport selection (EXTI line
    used to select GPIOs as interrupts).
+ - hwlocks: reference to a phandle of a hardware spinlock provider node.
 
 Example 1:
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
-- 
2.15.0

