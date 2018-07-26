Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00E5C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5002083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T1eGqFo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5002083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbeGZTyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:54:39 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35932 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbeGZTyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:54:38 -0400
Received: by mail-qk0-f194.google.com with SMTP id a132-v6so1663912qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W3Em1zX1UPcM8idrOCNovuYTIKSfFnMtYYlJD0Sc40M=;
        b=T1eGqFo90VIEyRzmotmz/McBV88Chcivpp+uEoCOFgze3+yrSDwlL8aDQ2SAHDqG7B
         R6qEEDYG1eoD9VJdctvetP7Pg5jzXshYI//Vo0+8FYjkbeMAsh1MFVI8NhDQCHvdCXUh
         qQZF6OguNbPBh8NLhtb0NG4X8mXGcMdYC+GXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W3Em1zX1UPcM8idrOCNovuYTIKSfFnMtYYlJD0Sc40M=;
        b=fVVy2HiSihW5ZeV/zjTLvmwNCmXubg09it/1FMH4scBeVEguRVQWrtQzbBjWzIYsoC
         VAai4K8Io3F4UP70+0P/hAMAI8WzGIAGVkCPeUSodyXK1qKHQL0kqj+HPk5j3Lde/XGh
         BM5LzhNb8tctnHQ2wY4VbyHAn+f2HX5KsVzCLvlmfOXix/88C1ALJDyRL62TIPW2wAcX
         ZhhpG+Ug9uGCiIMcKMMnkfhz1AKD8nWPBefiZAxR/sq9Atkd7x6fAKX3R/Oap34ScLXt
         ym116oA36F076YWN476B2yIWLRTcpezZYZgQrZzcqQA1QeMWcoTtGLHN32y5EX1ishf7
         Mzdw==
X-Gm-Message-State: AOUpUlEy3uQHwQCArBNDJ3ie+yTYzTsk+d+vesYh/JQr7gbqAFJwkbND
        e6PBRLEXem4pq/PLVagSx7o/iw==
X-Google-Smtp-Source: AAOMgpcHYN2kmLR5S4j/mBWs3cT8ILvYhOBPdlwgiZUJpwagkGCTr/XdnpAcE3spMZVQADcMVq55lQ==
X-Received: by 2002:a37:88c5:: with SMTP id k188-v6mr2994156qkd.365.1532630194741;
        Thu, 26 Jul 2018 11:36:34 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a187-v6sm1383359qkd.47.2018.07.26.11.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 11:36:34 -0700 (PDT)
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
Subject: [PATCH 4/7] dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
Date:   Thu, 26 Jul 2018 11:36:21 -0700
Message-Id: <1532630184-29450-5-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock phandle, of the core clock driving the mdio block, as an
optional property to the Broadcom iProc mdio mux block.

The clock, when specified, will be used to setup the rate adjust registers
in the mdio to derrive the mdio's operating frequency.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
index dc8aa68..b58843f 100644
--- a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
+++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
@@ -13,6 +13,9 @@ MDIO multiplexer node:
 Every non-ethernet PHY requires a compatible so that it could be probed based
 on this compatible string.
 
+Optional properties:
+- clocks: phandle of the core clock which drives the mdio block.
+
 Additional information regarding generic multiplexer properties can be found
 at- Documentation/devicetree/bindings/net/mdio-mux.txt
 
-- 
1.9.1

