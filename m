Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC607C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EB8208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UzWlpLXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EB8208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeHATnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:43:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35729 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbeHATnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:43:07 -0400
Received: by mail-qt0-f193.google.com with SMTP id a5-v6so20872093qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=189DY+gaLXQRLRw2y8y5yRwb7CdtbfhSBM5/gsjAGqM=;
        b=UzWlpLXz5jOPaOtgvEk7BikHmnOejMqTSjm0cfixQPGei1XgkC4+5spEli3ualHqyn
         HC2bOqIqQ7YVmSGPXYNRvJJdY96GMjMcHCaGS+31x0Ajl/nhSM1hGaqig1uCOh3uF+w1
         AZEIlDoNFX2Xi8KN7o82xtBhvCBVmeU2M7HcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=189DY+gaLXQRLRw2y8y5yRwb7CdtbfhSBM5/gsjAGqM=;
        b=q1tdfG0rKprM8FWyKVIPE2Fdzi1zFjrOmJMWEw96ukZZxtb3xmBFrL1/k4soNLjppw
         pFBZDEf+5jFXfK0jI4GNqysQJUaUZc0X0n1p3tV7BeI55J7NICf+g4wmafFgYfO70/W4
         fw0dFo4q1JdVDC20KVjqOCs89tOBvDd0BNXPnojwiEU4VNKBHGOCoNYqhCmDCQzaF3ji
         lgaxHGk2eQUV+keIloVN1X3pxGY+0XQf5phAbIrwkCstb7HYLKbwHWLBC7whoIXnRM0Q
         WTQ/a4nRQzMWdkUn8XpEvLZrVQMrBA0fbbxyvCxdS9Oqe5RKyHS60BWuLgq648o2Haiz
         8X2g==
X-Gm-Message-State: AOUpUlHzAjExX2r53dHAa3iUvek7wW9jJWI8v+k2NU1G2jyDAhpdhz2S
        elFpphuRZRIaCOYSmxby0B3v5w==
X-Google-Smtp-Source: AAOMgpeCYpSoMAdGRJlBpHxCDECD3CLJlNld5Kcra0YXrAno4F8DyeBLNMIRebevOBQcCBnIoa4hsA==
X-Received: by 2002:a0c:c993:: with SMTP id b19-v6mr24412131qvk.95.1533146174934;
        Wed, 01 Aug 2018 10:56:14 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12-v6sm14401729qkl.54.2018.08.01.10.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 10:56:14 -0700 (PDT)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH v3 1/8] dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
Date:   Wed,  1 Aug 2018 10:56:19 -0700
Message-Id: <1533146186-8374-2-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the base address of the Broadcom iProc MDIO mux driver to
point to the start of the block's register address space.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
index dfe287a..dc8aa68 100644
--- a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
+++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
@@ -18,9 +18,9 @@ at- Documentation/devicetree/bindings/net/mdio-mux.txt
 
 
 for example:
-		mdio_mux_iproc: mdio-mux@6602023c {
+		mdio_mux_iproc: mdio-mux@66020000 {
 			compatible = "brcm,mdio-mux-iproc";
-			reg = <0x6602023c 0x14>;
+			reg = <0x66020000 0x250>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
1.9.1

