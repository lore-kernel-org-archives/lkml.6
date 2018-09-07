Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E978FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CE4204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo1x0tRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1CE4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIGLFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:05:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36321 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeIGLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:04:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id j192-v6so13474371wmj.1;
        Thu, 06 Sep 2018 23:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g6yEf7sPUTftU4J49gga7zTfK93CLLR+cwQ15WOA01U=;
        b=mo1x0tRwtohb/U/gO32QUcNXFIZvBuiAwYmOV7B2Y+7CWbZf3/EijKYIqDPR1VWkMQ
         /2qFVQ/8aqsRUx34wZLXxoMM8IZLnvME/wazBSTvT9lggm5Gc6cFm5oY5ckCy/XbSv45
         cqA8PgPr+3AfpAJ9WNE6w6yuCwL7oX6xAfqQEnFbE0YbHkzSyLnx8302+h5sPk88Bdny
         jGSybm64/dFZJZHwME1GoTSsbRQgFD/7OG9D097rosXD4ckKzlrSWsRXDCTeKL2CRYsi
         InspE/TsJyk4cHqX9S8U2lQnT86bjlb0Fd21zh1kcbMDlhwinuGrxiog6VnOvmxAmjy0
         /U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g6yEf7sPUTftU4J49gga7zTfK93CLLR+cwQ15WOA01U=;
        b=ajtxAYE87nTR/zY42CXLul8Mz5Fodf9e4z3HRCSY/xk14rfnGjSQOhMWfj4amOs5eR
         xQA+N+6dFip09/lRNJYRcHIYsroDFXFOkKECdel/kqHRVVHgy/j7N2IidgDerTnYo8nW
         bBQyCFRjJ+3koYgYLTVEAjbajNbQ1g3wdgHFRrej4izPX36fwCazz3RuI567jxtN2BXI
         YBl6FcyFJwpZg9wgTluf5vJVusLaqedw4onxcL8zY4VwRrCcpmFXVKderrHT3vyzMWIE
         ricud8wLc7MYCNzc82OZ9HXIfnRC4cl31bNxxxtUNMey4Jr1amLy04avnINRTWYxD4Bo
         JrJg==
X-Gm-Message-State: APzg51DzcfDKQMQ5UH9B7TBhnrWhg1OOVZiiAQZUK2y4Blo027I2GgKW
        4EGZ2so+A4pDod9Ir0BDHA4=
X-Google-Smtp-Source: ANB0VdZPyWU0yto9phBQMluQxwVIkHdJpJqHhag12U8FqLdTHE3VVR7cHhRAjVujruV67ng6F3xIgQ==
X-Received: by 2002:a1c:bc86:: with SMTP id m128-v6mr3892949wmf.147.1536301525462;
        Thu, 06 Sep 2018 23:25:25 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w10-v6sm8387233wrp.31.2018.09.06.23.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 23:25:24 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH v5 6/7] dt-bindings: dmaengine: xilinx_dma: drop has-sg property
Date:   Fri,  7 Sep 2018 08:25:01 +0200
Message-Id: <20180907062502.8241-6-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907062502.8241-1-andrea.merello@gmail.com>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is not needed anymore, because the driver now autodetects it.
Delete references in documentation.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
	- cc DT maintainer
Changes in v3:
	- cc DT maintainerS/ML
Changes in v4:
	None
Changes in v5:
	None
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 5df4eac7300c..6303ce7fcc3d 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -37,9 +37,6 @@ Required properties:
 Required properties for VDMA:
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
 
-Optional properties:
-- xlnx,include-sg: Tells configured for Scatter-mode in
-	the hardware.
 Optional properties for AXI DMA:
 - xlnx,sg-length-width: Should be set to the width in bits of the length
 	register as configured in h/w. Takes values {8...26}. If the property
-- 
2.17.1

