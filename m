Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCDDC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F4720671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K/AAJmlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F4720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbeG0WrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:47:09 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45968 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389750AbeG0WrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:47:08 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so6504079qti.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y6Hd5BS/lfwDod/uAbVqEBcsSQeI1lqv/Zl6upf/sUA=;
        b=K/AAJmlRAvJJHba+zF1e1iFmOk0ZaKDCUQu8cfqBYym7q/phu3yVpvpbpCHP9Vl160
         lgrmUEGPc4HxykW2R63VfJ8j2WJQF0b+fbCUErEBNLkt0lBuBd5zST3lLSa7CuzyWdmG
         WpO+eUwGorxLumZ2feMR5R1zuuW5l02+i7xM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y6Hd5BS/lfwDod/uAbVqEBcsSQeI1lqv/Zl6upf/sUA=;
        b=WKk8P2T4NM0SpSNj1C0hqW3tGNlKNyKiGCfnDKcsTXR0P2fdf19Lxms8f3R97Zjrj/
         ooTduqwnNsczxd6mF2xNMFRrb+Npq4+riFLWb0iDy02uHyqC9pxzWpop36wfD+3yQy16
         DhA7VLTAcaR/kKGPlrfx7Mpy40/8RNEO9dcbl/grG2YAcYbVgjFgSv5qPypgX3fBHVHs
         EpF+FPt5dCieYtkKCOK/5il+Czvd2bvQadMosWbE6Rpy8VrR4cAohriRzw884iymotQZ
         gOFNTCc622pBQAaHazXsczEGDjYiBYnwn44C7SI82yl+LUeQs/zuC7/+8C978q4zh2kb
         705A==
X-Gm-Message-State: AOUpUlGjyLrKVwpNTVbBj/gF3iUbfW0Z0JblEQCLqfoGGv/ADcY0+h3j
        q650eNyyPfMb1MEMCiv3zlCONA==
X-Google-Smtp-Source: AAOMgpc2NZIdU2nC7sytihIATbiYlFlKPx8KqLjZKUhRpRonWHXSSaXEWac1qX9mk+MkeeJ4qIKFgw==
X-Received: by 2002:ac8:7107:: with SMTP id z7-v6mr7417164qto.326.1532726604596;
        Fri, 27 Jul 2018 14:23:24 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3416622qtc.67.2018.07.27.14.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 14:23:24 -0700 (PDT)
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
Subject: [PATCH v2 1/7] dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
Date:   Fri, 27 Jul 2018 14:23:27 -0700
Message-Id: <1532726613-6483-2-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the base address of the Broadcom iProc MDIO mux driver to
point to the start of the block's register address space.

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

