Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4278C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F19A206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvlb8zPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F19A206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeH1VrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:47:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37982 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeH1VrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:47:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id e2-v6so1084881pgv.5;
        Tue, 28 Aug 2018 10:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kp4evUltoBqieY7M4Vu6/pYXWKfkGOFsqIZplVj17zU=;
        b=Uvlb8zPpCOIIFXAPIGEhCHFLDd+XaX/LsCGyoAjyezp7svv5V6KFbYQCGEzgReDdJ+
         FwnMhFpl966anHSdnDg8lSipfmvb9aNTGPadSX+P/H515OMuKzhlWROLXJ+XJvNs7D83
         3UJH4HJ/CXSkuFuDNNzxyyK8tZX/VtiV5peR4snMfqhAJqljX2x+YhAMHxTXiRMR3gF9
         ahNl24euK4mdgNqRMYkfBxZBTUY6/JAqWO4ApMS5Pzvtstxp/xBG+YlpCEBxVfUC/uUR
         cf2vtiAUas6lqGEy7jxr4GU6N1bjShuWOjmTqU1ibTVkm7IqXJm2z9qXwq00BBccE2fI
         8bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kp4evUltoBqieY7M4Vu6/pYXWKfkGOFsqIZplVj17zU=;
        b=Jt/tY/IjGUCHBclK9xm+e/cKAOeF0AR6Mo8em5R2tXgYmSABeA7na80+nQzt/hywpn
         C6VECySFd1TdSriYIZcb+O3edrgWSwWBq9Hb/HksBGXjQmw2MmXUW7W9yeldXll/V8nd
         J1pNCB7lKcePFH9+sfQmScB78sqNBNKR+6EP+et581zLAn9ZbFcKutwHE5aVA3BVIOsf
         QOnfoDn4JtzPKZT+CRIM9OXVkLBHYrpfYK+8qkKVu915Izassu3iHcX8FXrZ+0Qs3b+X
         4XMSdNIfI8sTRtoDHOw6onFN8Z5sjHc6J5zvAUS6PBlRrqsQQ0tIA9kU5fxrCMbNF0a8
         DQoA==
X-Gm-Message-State: APzg51DYqtO9+iasSmhklREY+bxxrGotwDumMcc1RMY5kTPtT3LJ0jcT
        hSwsKjiY6OP1yhQqomSRr8M=
X-Google-Smtp-Source: ANB0Vda5asV7IDgy7/xolwKT/TaVvsEwFU1Vymari7cgD8PJS6bkn1Cp6FV6MC0DE4OBJzH2uGFChw==
X-Received: by 2002:a63:5964:: with SMTP id j36-v6mr2498273pgm.222.1535478876008;
        Tue, 28 Aug 2018 10:54:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v23-v6sm2664465pfm.80.2018.08.28.10.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 10:54:34 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        andrew@lunn.ch, rmk+kernel@armlinux.org.uk
Subject: [PATCH v2 2/3] dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
Date:   Tue, 28 Aug 2018 10:54:19 -0700
Message-Id: <20180828175420.7992-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828175420.7992-1-f.fainelli@gmail.com>
References: <20180828175420.7992-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Broadcom roboswitch Switch Register Access Block interrupt
lines and additional register base addresses for port mux configuration
and SGMII status/configuration registers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/net/dsa/b53.txt       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/b53.txt b/Documentation/devicetree/bindings/net/dsa/b53.txt
index 1811e1972a7a..5f1029e853b8 100644
--- a/Documentation/devicetree/bindings/net/dsa/b53.txt
+++ b/Documentation/devicetree/bindings/net/dsa/b53.txt
@@ -46,6 +46,29 @@ Required properties:
       "brcm,bcm6328-switch"
       "brcm,bcm6368-switch" and the mandatory "brcm,bcm63xx-switch"
 
+Required properties for BCM585xx/586xx/88312 SoCs:
+
+ - reg: a total of 3 register base addresses, the first one must be the
+   Switch Register Access block base, the second is the port 5/4 mux
+   configuration register and the third one is the SGMII configuration
+   and status register base address.
+
+ - interrupts: a total of 13 interrupts must be specified, in the following
+   order: port 0-5, 7-8 link status change, then the integrated PHY interrupt,
+   then the timestamping interrupt and the sleep timer interrupts for ports
+   5,7,8.
+
+Optional properties for BCM585xx/586xx/88312 SoCs:
+
+  - reg-names: a total of 3 names matching the 3 base register address, must
+    be "srab", "mux_config" and "sgmii_config";
+
+  - interrupt-names: a total of 13 names matching the 13 interrupts specified
+    must be: "link_state_p0", "link_state_p1", "link_state_p2",
+    "link_state_p3", "link_state_p4", "link_state_p5", "link_state_p7",
+    "link_state_p8", "phy", "ts", "imp_sleep_timer_p5", "imp_sleep_timer_p7",
+    "imp_sleep_timer_p8"
+
 See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
 required and optional properties.
 
-- 
2.17.1

