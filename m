Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E62BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F682083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bo3xfgCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F682083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbeGZTy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:54:29 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34516 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbeGZTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:54:29 -0400
Received: by mail-qk0-f193.google.com with SMTP id b66-v6so1670980qkj.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WFmqJHdp6mCHYyzAsrWYd2ctjn5+GtF9fEC+CYHgUWI=;
        b=Bo3xfgCi9h1TG52DoF7q7jRfsoqb3z8Ufa7CTitDKBC9StxecXLiWVAgYjN1neP4ZZ
         WRIQIh58TbutV52w17vOK8x6T7Ch4dhXf5vSsSw/nbgDUKaMpX0lOdE0He8x3WWOFiZu
         8DZ5fwgllGs4RoFf5SaXFuUcYZ5rtpbrdKJnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WFmqJHdp6mCHYyzAsrWYd2ctjn5+GtF9fEC+CYHgUWI=;
        b=Z0Zbl/41W555P2wFsID1WK62oqLnHBMVZ0TIbpXGpvVfp1QhbS30ghKD7vhevUk34a
         6KuwagcZfPLTDpVPyTxCf9Lgr3DNGNYdnREMDL4zvkbf2YGT1wq0NQgjsnBLjPAQTIlR
         8ibzWbvZne7wgwm9xhwSKbc6uSe1YBSTkAMUaGYq/o5iWfYu7ERCgnIjVuA8/g9D1R3V
         Bxi+tme/I1Tpz9dADPInkCdk0VXuGNfoTv1pVMuBeVXE33fVB5ZKq91eIiPpgOKliqSS
         kloklMeX6frUYeHpAKiuQg1Stx50fDlqkyUv30ZWojiOG4tWLmuMqTp9PJtbYhuvX2Hr
         HfaQ==
X-Gm-Message-State: AOUpUlEIMONHx1woNkFClbxWM7RI+2FvjS0Pbun2XjhCSiDD3T+sq+MA
        EEu4Ufifzgw0qWj813U7IRA3Dw==
X-Google-Smtp-Source: AAOMgpcXEoOz6oBvk/bfH1PNIZB0bT+AWkOaMPlaQNP1111lu+xHmAqIzFwH3v5hGSe/ptMSrFmNYQ==
X-Received: by 2002:a37:9844:: with SMTP id a65-v6mr2905728qke.30.1532630185751;
        Thu, 26 Jul 2018 11:36:25 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a187-v6sm1383359qkd.47.2018.07.26.11.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 11:36:25 -0700 (PDT)
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
Subject: [PATCH 1/7] dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
Date:   Thu, 26 Jul 2018 11:36:18 -0700
Message-Id: <1532630184-29450-2-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the base address passed to the Broadcom iProc MDIO mux driver
to point to the start of the block's register address space.

Fixes: ce8d5dbfd64f ("Add DT binding doc for Broadcom MDIO bus multiplexer")
Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
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

