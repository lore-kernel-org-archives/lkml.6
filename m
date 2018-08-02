Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913EDC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47745208A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iPzvOZEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47745208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbeHBCm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:42:29 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32926 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbeHBCm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:42:28 -0400
Received: by mail-qt0-f193.google.com with SMTP id c15-v6so582089qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBoiA9B2sqMzS5oHoGN2NkkLQkeS/0hG8NCGBeKGHho=;
        b=iPzvOZEBHxE8wEyJxi62uZXlspRqQnEmirxIr1ZnJM0q8m72RooA0WlAHu9hN1xnDN
         pZm/rGgKz+msbpuSkKQQ81HepTF8dUCe/wCx1HaORsmHwEod5wbUlKwLPwIVLaJErMZw
         mGlgkRh5q9AjZoKGDiVnIZ87F380VhLbir3wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBoiA9B2sqMzS5oHoGN2NkkLQkeS/0hG8NCGBeKGHho=;
        b=j5vZtZ9sRgoEyk3/raeCJLnF7In3InC4eUn51bugtLCOoKJDBCWuv0DO3D6eFHrsLJ
         ZqwhTTpVkOO8/qR0W+mEXRRWgohLbz8jVbSmPsZj+m233HxQXD75yrnS6DM6mlYWNyso
         lOqVNuzGD6xj2pho6dAB8sk/ZWg/iX9tLZlPUsed3Dot937qVtXeRvWnVzWXr0xVg3GG
         IFMUcKZCTb4I0eRH5gQotmDLpk6Vu25ocZ1Ls6tRf3iT8a1qS2gPOiB/Rl2B1XRV9I3C
         VyLIvyK22RQnX7E2EqVX1OeZ2MVqLyj5VgnULBaiCr9FxUxPokmEkLgZRbezWP73h1PN
         W6MA==
X-Gm-Message-State: AOUpUlEskWN4yXVfC+zH8qwIb9DjW/GuiAImjQnPwdnrJP3P1PhoZ+/A
        fu8cPxAXVNzNl/hcggB23yoXsg==
X-Google-Smtp-Source: AAOMgpfYTbbv+nxQ0q0Jm+8UsKdc9J5J7CM4PSMMM8RBMvDNDz1s3/fojIYiqoy8ki/geftffSzwow==
X-Received: by 2002:a0c:afb8:: with SMTP id s53-v6mr638185qvc.164.1533171237886;
        Wed, 01 Aug 2018 17:53:57 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e81-v6sm325116qka.3.2018.08.01.17.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 17:53:57 -0700 (PDT)
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
Subject: [PATCH v4 6/8] dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
Date:   Wed,  1 Aug 2018 17:53:51 -0700
Message-Id: <1533171233-14557-7-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
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

