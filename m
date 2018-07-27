Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB848C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9428020671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XWPXhjpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9428020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389912AbeG0WrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:47:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40517 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389890AbeG0WrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:47:20 -0400
Received: by mail-qt0-f195.google.com with SMTP id h4-v6so6514138qtj.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dYPpw6H1dyI06VHDUYPiZCD3atKutfh2hFmhSO5Fw3I=;
        b=XWPXhjpKSnr1JYfVCmgTBMn1mfrjpMZ85ncknhbR9bnPGIjL4NCU+2C+giFgkc2N+k
         Kemvz8wP0S4D4QlGcpPRe8+VdQ1ybZQDSv/3ff5B2WBP6EGpA5sAXvtrFmMz4YKcckVU
         /5VIhLZxRd2ssqmDHH/HrtZJgJl5uqgEmtrpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dYPpw6H1dyI06VHDUYPiZCD3atKutfh2hFmhSO5Fw3I=;
        b=lnBWZHUiAfPP/j838AUe2jztZbUw95dbiHac2A9vDkUbARAHe5G7MQ5s8oyJDu/xRD
         dVTzlTnL5mSw4pwcDQPMlzJxoghSERrZY5AOD6tyQ2unrqICbwkvqNGtaZmIuhfJ0uQ7
         RIYZj6isL5E4PNrgKqItEYiTjs1fupcYiMi26yGuMhyqRTL8iur4bQZeufjAhYxp6Svx
         C5kJROS4SnuKxCJINoGju3Rr9+VBUx9YGfT199r3kEDZDQLpmgpWKut8DcrZ1LkBvyhF
         tEnmZbGZt74aayI0C3VEZtnNqUgfDpWS7UhCcIAF7Z5vzc/XaXOYA9GxKfsDFhq2E7n6
         NBtg==
X-Gm-Message-State: AOUpUlEsgfKCrsjmxkecaQP07W2steGWKGimGhPiLvj9lkBUUYbFrKx8
        qxYjN3YHswXFDk0zyrQwoKbTFA==
X-Google-Smtp-Source: AAOMgpd4/5+kqjjxYxqRKpVxdE61LgOii/hMrmF+KCZekFMT+4OnRt0dMNenbmtMv+5vfjLhbR8MOQ==
X-Received: by 2002:aed:3cae:: with SMTP id d43-v6mr7774851qtf.379.1532726616517;
        Fri, 27 Jul 2018 14:23:36 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3416622qtc.67.2018.07.27.14.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 14:23:36 -0700 (PDT)
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
Subject: [PATCH v2 5/7] dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
Date:   Fri, 27 Jul 2018 14:23:31 -0700
Message-Id: <1532726613-6483-6-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock phandle, of the core clock driving the mdio block, as an
optional property to the Broadcom iProc mdio mux.

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

