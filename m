Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02E020883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC3GnhQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02E020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933384AbeFUL6r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:58:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32777 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeFUL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:58:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so2932246wma.0;
        Thu, 21 Jun 2018 04:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z8IaOns6/2Ud/C2tZWT3Vw+o0brHCG8lcag27ALX8+Y=;
        b=WC3GnhQHn+nj77bAcLjtfQXlUv+pRfVbTgIdOLpFZoZFntFOBjY3PJBcL0W59/zgPQ
         GjsgwMdSBFKGtUSLsn6Gy3/wIZ3m+8Qc6bYk5x0KVr5FVk+3bZHSjC4d7HCe7BBYTG0A
         aymBG4syz8p0oeL+UzHuGWyZZAToyJ/d670Ws4/vOA70+abflx6fOttq2RjssVLgxyzp
         lZDY1ZKgBLELZPl8n37wmmO/42ZZ+5oZQbMWzo2j/cyRAP6XPnc+rynkf43hJwhRAP8A
         HCCD7B5Xa8leIxhzpR1JDrUG5eE4x24/btL5qYzP7SFq+DK8nBYlkStqWjVHM/PCRx7R
         ygCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z8IaOns6/2Ud/C2tZWT3Vw+o0brHCG8lcag27ALX8+Y=;
        b=LJiMmv8L8VTbhrvrjE+MtSNx9sFTClNBXBs01rdrclXBS9RnUwIJ2jkKbE/LHIR/RL
         7uM+cLbZCCRCcMXEpyDCpim2UL0+t+8NcRQ8q58nh8ByuqVeFQt9U+F3F3aWmHZn5Gf4
         1QdvDrM6tU28xvK8h+nNE/lEf46btf4E9RAap7QcrbyZW+TFa6nfyJW6prYe1xs3jxFq
         HO4s7u7mpSW25LFhqjomgQHKrsqYgAPYYJyBq8z8KfQ4yrUdxRZ2sG7AA6uRHAqUT6kp
         bm0QP/wWVhcLqmKAZ8CvI8TUSCSXuQpx9qismulu56u9tuspHvkYv4Ov3wLPqyzA2AJf
         778Q==
X-Gm-Message-State: APt69E0O2SGpp1aFq/QPsQ/8i4yShW17BIPoiQ/Z8UVMDnmU42x6pQYP
        bAraC70ROic8aH9Y/0i5rIkiAv4M
X-Google-Smtp-Source: ADUXVKI1Uq4e3ax/CFqwUEBMDtZjRw6uvokdj/NJqFhcgz0aGE+uGKTP8yZWnp/QEge3X7qC/HREog==
X-Received: by 2002:a1c:1389:: with SMTP id 131-v6mr4922544wmt.65.1529582314597;
        Thu, 21 Jun 2018 04:58:34 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id e188-v6sm13779773wmf.21.2018.06.21.04.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:58:33 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 5/5] dt-bindings: xilinx_dma: drop has-sg property
Date:   Thu, 21 Jun 2018 13:58:22 +0200
Message-Id: <20180621115822.20058-5-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621115822.20058-1-andrea.merello@gmail.com>
References: <20180621115822.20058-1-andrea.merello@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property is not needed anymore, because the driver now autodetects it.
Delete references in documentation.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
Changes in v2:
	- cc DT maintainer
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index c894abe28baa..09a41843cbc0 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -37,9 +37,6 @@ Required properties:
 Required properties for VDMA:
 - xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
 
-Optional properties:
-- xlnx,include-sg: Tells configured for Scatter-mode in
-	the hardware.
 Optional properties for AXI DMA:
 - xlnx,sg-length-width: Should be the width of the length register as configured in h/w.
 - xlnx,mcdma: Tells whether configured for multi-channel mode in the hardware.
-- 
2.17.1

