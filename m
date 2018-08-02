Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C3DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD4B208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GPnZhXC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD4B208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbeHBCmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:42:12 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32891 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbeHBCmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:42:11 -0400
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so581528qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=189DY+gaLXQRLRw2y8y5yRwb7CdtbfhSBM5/gsjAGqM=;
        b=GPnZhXC5E7pNxlqWEX9IMy4v2CydY8Z4zIYGhv5hW21N84zsjYbUAA4R0ZV4ftRDZe
         9W1ibYCaeuaUscOEjyLKR+m2LJw7bFR1dTMVeMis6YJmiPFDE6nakeWxDNbc8zlhWIZV
         a9YjIdbrxWElY+C/5GiGpVxUPyWeZBlT44hBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=189DY+gaLXQRLRw2y8y5yRwb7CdtbfhSBM5/gsjAGqM=;
        b=nd28ZbbapuJ74V66Mh7naymLiAffqkvD7Z6XkjYycQ6cmeUT56VesL1Uv1qZcTLh8I
         7Yc5/vvL3nhtZzNKGrBV6olJU2dA1jcqinsJjyJ7YycLf6zNSUZv8Rn+NNUWMumXc90B
         ocw5/WjKs+d/Tssxgwc7egWJ5ZDhusr3hlvgI1E9/FENuz6Sz+QKbASd/gbiFdtLxE6w
         mB8IYUcvlMNXD5tcIALI2Uhm7SA8jRcX701OUmEYZeO7d31BcKSQQTfbHvBO50nyKyeq
         qOkKQ9Vv48UbMusvRk3wSLHihw/vb8v7GI+NA1GbkLzZVCBd7wU+6NZTdIGCtFEzuOG7
         GL7w==
X-Gm-Message-State: AOUpUlESVDYHfMFyEHaJ6boskQ5U4BSOy+CKJ3R/HoSpQIPrgFpQwlpD
        Zby2cZAS8pY4Du6A1ckXB3dsWg==
X-Google-Smtp-Source: AAOMgpfAtu0kop0nh9fRCRAbCx0MbQV9hL5Uw+ib4/e75LjCTz2em6Xq8+MINlVcpNYExegu61cZQQ==
X-Received: by 2002:a0c:c3c6:: with SMTP id p6-v6mr641296qvi.146.1533171220963;
        Wed, 01 Aug 2018 17:53:40 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e81-v6sm325116qka.3.2018.08.01.17.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 17:53:40 -0700 (PDT)
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
Subject: [PATCH v4 1/8] dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
Date:   Wed,  1 Aug 2018 17:53:46 -0700
Message-Id: <1533171233-14557-2-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
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

