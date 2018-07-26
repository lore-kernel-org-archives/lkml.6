Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C726BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732F52083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JSNc0EXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732F52083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbeGZTys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:54:48 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46022 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732199AbeGZTyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:54:47 -0400
Received: by mail-qt0-f194.google.com with SMTP id y5-v6so2565553qti.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/bNfDVbfghH/SNSX4UM/6ceNHRpa1rw0i7lqzYlIwC8=;
        b=JSNc0EXFznEfm2AiH26/Z9W4Y54BJpBRPj8a+3RBw0Db/q5GwkqAIF0zHUXuiwH3Js
         dsWWxCQm1Jun6SZ9qB3iamDNKlDPQNa8fDhJci9i3s039RjKy8Ai6qhdZAwTo6kZR9ho
         Xtx+g7uGLoDceDpmRwA9RKLz04M24CNcfXdRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/bNfDVbfghH/SNSX4UM/6ceNHRpa1rw0i7lqzYlIwC8=;
        b=WzS8ocsGlMmIRZTPRc/C2hzln3xjEKnKbFuJ/px6MSlu0dbEJhmYrWNr63aNmswPdM
         RLcjG/H5sGzwdutgf5By4QyDzgNjd+wNTd3CVzNXeZj3zscKxghmPAARjbVy+JAn1rwT
         g4X948nwm52WCSkM+EAibrofGE9WVhn9RwLeKulq8Zw1Wp1DXkuA4zBSoAapdv2oZnuE
         1w36hHrQiKv7aBHAHXzCQDwdwjiXCf5UVXIrk6Glws798d6Lvgbq1KEcy3+g+tKLRa3L
         z3ltfhtxFEzAq54Sg0DXbak2aS0mDNi75HCStIYU6FDuZtQb7cEsv6E/NhWZIgKmaSkm
         6mmQ==
X-Gm-Message-State: AOUpUlFhnrvTokigclMpDKfZA7PCepxfHJFToU7dnLiHCx8gyIby7mz8
        9b/ajA+cSZpDD485gYTB/MfS1w==
X-Google-Smtp-Source: AAOMgpf8l8rBjYFt+tJtt3sLcjyi6g9Nu36a4MopheVrS861ocn/SdXJ1SFtRnjT3GtCxKL9BALrmQ==
X-Received: by 2002:ac8:41d6:: with SMTP id o22-v6mr3153684qtm.1.1532630203847;
        Thu, 26 Jul 2018 11:36:43 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a187-v6sm1383359qkd.47.2018.07.26.11.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 11:36:43 -0700 (PDT)
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
Subject: [PATCH 7/7] net: phy: Add pm support for scan ctrl register to bcm mdio mux
Date:   Thu, 26 Jul 2018 11:36:24 -0700
Message-Id: <1532630184-29450-8-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for saving and restoring the 'scan control' register
in the Broadcom iProc mdio mux driver.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 89c18d6..d1fce1e 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -26,6 +26,9 @@
 #define MDIO_RATE_ADJ_INT_OFFSET	0x004
 #define MDIO_RATE_ADJ_DIVIDENT_SHIFT	16
 
+#define MDIO_SCAN_CTRL_OFFSET	0x008
+#define MDIO_SCAN_CTRL_OVERRIDE_EXT_MSTR	28
+
 #define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
@@ -51,7 +54,7 @@
 #define MDIO_OPERATING_FREQUENCY	11000000
 #define MDIO_RATE_ADJ_DIVIDENT		1
 
-#define MDIO_NUM_OF_REGS_TO_RESTORE	2
+#define MDIO_NUM_OF_REGS_TO_RESTORE	3
 
 struct iproc_mdiomux_desc {
 	void *mux_handle;
@@ -68,6 +71,7 @@ struct iproc_mdiomux_desc {
 static const u16 restore_reg_offsets[MDIO_NUM_OF_REGS_TO_RESTORE] = {
 	MDIO_RATE_ADJ_EXT_OFFSET,
 	MDIO_RATE_ADJ_INT_OFFSET,
+	MDIO_SCAN_CTRL_OVERRIDE_EXT_MSTR,
 };
 #endif
 
-- 
1.9.1

