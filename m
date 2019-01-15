Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C59C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C629420657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVXX9YUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbfAOSod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:44:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35777 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbfAOSob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:44:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so1611129pgs.2;
        Tue, 15 Jan 2019 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TtWJIG9DHX8rBzM5ORFS81BvPd0cvEPbKrsCQLC4nJQ=;
        b=jVXX9YUrSm/xZtDg/5o9+YVQ2q7TIz2h9LvZWGWrkKSObKgAa/P48+BkyCS7vq7crU
         v2lchY1ClGOdbk1O3t7OVSogfbRlNaVhGNyiwnURO4hu3wuifD2zWW0QaMx35G1auAH4
         BUqr+pi0BU2HRKE4P2CCQDPoSDYkRGnIRFMUvkpGCrzcvASJf2giNqmOxE3e4ZPqgkmi
         cqgT1v8ghIJp88p1S4lWEiofQ9xpjyLJc4UhYMrV8XVkpodtmVch9i4jIhG3BKrDnQSC
         ++1Kyd3/qPhpi9FhQTWWtILuRsq68XYRcM7Ar1ziU9WfzSjjJzhMsAEofNwDcGWh4TLc
         tHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TtWJIG9DHX8rBzM5ORFS81BvPd0cvEPbKrsCQLC4nJQ=;
        b=pGUp+KJdY6XgY5sF/eO+czTcYhx50W+oDTUZJ5Eqdi8XVE0Rmm2p+Mon2VQErt/Xuc
         sNWFk91kWPeF/RMY+OMHtkU8mzLL/zSN4revTun6fLaiUk3ic5Qp1yMruKXUrmZlTHj6
         8lepKcQYasnYB8KIeYW+PAYWyLZwN/Hxh8MSyP8pUk0ShLufL9i84zgUR4+1K6tHRUUn
         FlRQpUY69+LCEnkOq5INuFiFpo7OupwLTVPNYXg0hLLhAOX2pn+qXeOrAZp++4LkMaQA
         H0H/GKlFvqw8GV6Jj9jdbjXtbDih/Du2aKKYP9Q1NGYa04xSFOwW5TPkKjQq3odtSMKs
         8N5A==
X-Gm-Message-State: AJcUukc++onzRYpaVnMsDRzSFKDPsraa56zBXUhHuwQfU5v7h3sxEvpP
        sKc7neZOxBg/0DXbCVkxs1fQWo4e
X-Google-Smtp-Source: ALg8bN52k4uoOXF4b1ts7nOGJmtf6spsbkUrT78jEE03O8uBWS+RmoBW1S8QUKynAESj23oH/0nIrw==
X-Received: by 2002:a63:2315:: with SMTP id j21mr5038901pgj.297.1547577869575;
        Tue, 15 Jan 2019 10:44:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id m67sm9156950pfb.25.2019.01.15.10.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 10:44:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
Subject: [PATCH v2 1/2] dt-bindings: reset: Add document for Broadcom STB reset controller
Date:   Tue, 15 Jan 2019 10:44:05 -0800
Message-Id: <20190115184406.3164-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115184406.3164-1-f.fainelli@gmail.com>
References: <20190115184406.3164-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding document for the Broadcom STB reset controller, also known
as SW_INIT-style reset controller.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/reset/brcm,brcmstb-reset.txt     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
new file mode 100644
index 000000000000..6e5341b4f891
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
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

