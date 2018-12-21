Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE11C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FD7218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY30Gfvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbeLUBfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:35:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34201 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbeLUBfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:35:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so1717444plz.1;
        Thu, 20 Dec 2018 17:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d/H0IPCs/zGaOeUW7gjqD90ZTHLo9Q7AE+BJZps2hKg=;
        b=WY30GfvuyBfq9r8h3jaOWv6hOvMVh0LxBfm5BJ0gVLK6J1MjWGSIFVOUqRhvV5NIa+
         ZJcnm/A1Y1087wzjehsKOD+687Sqhr0syAC8al2gtV2sDCtVLhErpDDTIpOryuFBewkO
         pihEorgRPUPIwoqNGxe7fW1BXdUzXZ5iLdgSu9oCmdxEckwaYsz3gm5q/a4PyKELVhX2
         Sw1DbvVU2q6NmpHEz5kWoe1Sm1SNKy9U9Z6HqXbcOEI2rR77VeMt8shbj+DjeTZkeXoA
         W12gmnvCecHw08pogIK/uWnu7pm9BFevzI4hsJqPJMauMzXm+1N8l1sTiU0IbGL3gxm7
         ySQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d/H0IPCs/zGaOeUW7gjqD90ZTHLo9Q7AE+BJZps2hKg=;
        b=Si5OsXzyMmbbyf7ZzYcKFVdmx+T11MoXapNFmtFrsR29miSc9Ol5PD2E/lwebXT4WJ
         bnKvKsuA2abOqTz/SFYLHMngUi4oQWf8zSJNE3+uOc0ZlmL0NZdq//dKHkDz1NuTfQmi
         9nPpUx4JUGdtyn7TBrZOAuGl92tQjEE2tDkhEfNuyNr9kXGq+fTYo8o4QvBSFsrDPq6N
         q1wiSrFg+MRvolOeTTDvC+8kY7mz5se0Qr4VcYXPqmDUp2zbvtffsf60lAppiAia7/eM
         bXmIWnkqSRKkdk9d+olwK/Pxs7rWHcvJi6PTVvM25ZI4RMBCfDbeg3bXbcaXdKfyhtyL
         t6Cg==
X-Gm-Message-State: AJcUukeT6edPrGyUhBXtJ2F45rjPailvIa1ZuIR5xRkDiW3QSLSA2C1h
        TPUa+0/8stYPNeo+qoiaIXk=
X-Google-Smtp-Source: ALg8bN64papHktpfj87W+i23wbtCRwyA4c9Htd36K/BKTM4cM6EwvYHgaDX7FqMMcvVB14la8w6EMg==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr534475plb.166.1545356101975;
        Thu, 20 Dec 2018 17:35:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g70sm36590854pfg.98.2018.12.20.17.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 17:35:01 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     p.zabel@pengutronix.de, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB reset controller
Date:   Thu, 20 Dec 2018 17:34:08 -0800
Message-Id: <20181221013409.14324-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221013409.14324-1-f.fainelli@gmail.com>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding document for the Broadcom STB reset controller, also known
as SW_INIT-style reset controller.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt

diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
new file mode 100644
index 000000000000..6e5341b4f891
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
@@ -0,0 +1,27 @@
+Broadcom STB SW_INIT-style reset controller
+===========================================
+
+Broadcom STB SoCs have a SW_INIT-style reset controller with separate
+SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
+reset lines.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible: should be brcm,brcmstb-reset
+- reg: register base and length
+- #reset-cells: must be set to 1
+
+Example:
+
+	reset: reset-controller@8404318 {
+		compatible = "brcm,brcmstb-reset";
+		reg = <0x8404318 0x30>;
+		#reset-cells = <1>;
+	};
+
+	&ethernet_switch {
+		resets = <&reset>;
+		reset-names = "switch";
+	};
-- 
2.17.1

