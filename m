Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7148C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A17208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J/n54SD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A17208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeHATnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:43:25 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40252 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732418AbeHATnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:43:24 -0400
Received: by mail-qt0-f193.google.com with SMTP id h4-v6so20867919qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBoiA9B2sqMzS5oHoGN2NkkLQkeS/0hG8NCGBeKGHho=;
        b=J/n54SD3FB52MVWbzlzObnZzEbscLfE5RhCFwr8chw+QZz/pWA/C5+XR//uW+1aBzV
         pNptOPk3jBTjfe9CIDxEVtQfOjPtOxo48vZ/p2SkS6OA52k0VHFHGnTN+XC8ZP/EORl6
         VzAKrv3nLfSA4rNo7jh8uNcQoKGC694BFTDS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBoiA9B2sqMzS5oHoGN2NkkLQkeS/0hG8NCGBeKGHho=;
        b=t0jHTCa0NZYDbCmFplQyaeY57hgESUo459qTpAX3ircOIhKM5DSnECMDyGfpkFG+yH
         4ZJ7WTVdfqfuyaBefSmvBH2cVMHXJ2ZFVK80WRtFkHkm+YpIPwkzGNYF1RQhI/PYgMvE
         cVLL9A/X8Zj3ktAgk4ayCfvfh8nCAblYUQ1oMWH7GwM5Fl/4gB+7RY0yl3hmivzikgCV
         OQwARdhxFHTuOF7q082Fu5RS8XAfjtppWLCQIxP645OKSY3PYWmj/K8AZPuulfPtCrYn
         HWZdJ4gnXEY010CWtq5ntspoBKqOlZuLoPpje1L2UK4dbEazU6pfZsZWfiZvo+1tosrF
         Exdg==
X-Gm-Message-State: AOUpUlGFjs84Yl2P8jVuQWgCCiVQ12qcQpGlEEjtMSHrvs+rT4GlGsBt
        bl9XPeSWvef5M0zrtIxL+/t9/A==
X-Google-Smtp-Source: AAOMgpcVev4UGWLJhjn3BjqqOR3QrfMXu+8wRwA95bkdY3hDo9jIOrVQoIY7Vm1q46HcwtenQF0C+w==
X-Received: by 2002:a0c:b792:: with SMTP id l18-v6mr24509355qve.110.1533146191961;
        Wed, 01 Aug 2018 10:56:31 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12-v6sm14401729qkl.54.2018.08.01.10.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 10:56:31 -0700 (PDT)
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
Subject: [PATCH v3 6/8] dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
Date:   Wed,  1 Aug 2018 10:56:24 -0700
Message-Id: <1533146186-8374-7-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock phandle, of the core clock driving the mdio block, as an
optional property to the Broadcom iProc mdio mux.

The clock, when specified, will be used to setup the rate adjust registers
in the mdio to derrive the mdio's operating frequency.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

