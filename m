Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F80C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAEE2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myC2bCkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAEE2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeKFIbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:31:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36464 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeKFIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:31:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id j22-v6so5165863pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 15:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w2jjbJ0+YEm6yQ1XUvrNLmi5/MhCZzp4Le6LoV6nZ0A=;
        b=myC2bCkxsYBj1lT4xb+mVfoKkSmJRZhzcxLrARwV3GHqxrUL82i2QresW/F1MW4yQ4
         az0xgONRE6uz3twDQ7QFNcWDyfbnTVVpEkygD8ziNz9Xjy0rwhVPd1Yl963nF1zm7/TH
         AKceRIOa+sad4iwOQJC0RSu3H1Ms+DolYr0nxs+Qua9I35ntIp1akmyZFE/ZdcnVtvAu
         gmfWYufkpoYqAgaADhPBRXxXALqfJFpPYPNfrFECMGbMLUzY1ta1C97U3O0PFqfJ7GXG
         uxDdOrrtpBmFKenpViCjeBX4oMiRrTSJ2BI0Vwruc/442oF+1DDVKUQWhtqAfnJOqkW1
         V/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w2jjbJ0+YEm6yQ1XUvrNLmi5/MhCZzp4Le6LoV6nZ0A=;
        b=VDlxoXEsibR3KAHby6LV+ydjv6qhJ6LINybdp47smDtVflPHy5q+6E22vDnSak4Nde
         otWHguQpinqoM39JWsfrFLwR8AqizDuEKo58TVaS0UityI1HiBmNkTVoHBs/fmqkv86q
         mlKh5lRGIFq5BueXFGEJzrHyWvHDoncBCKm6SlzDm1ytFb5lzEJuJpnFGLK+UVBpsujd
         3fpYS+U0FgvE5ToxwsEn28BgME9bfV8FtqW5Bq1AdTOgZ0H7QG+hk6lJ6ZDkSaw2oG3B
         mTcqrxo868JR9RZJ0wePgL3HvSnTWJGAzULammXzok6lJqd8p+nEp4h+t8TrEXpkQrZT
         U1xw==
X-Gm-Message-State: AGRZ1gKyAC9AgdcS/hFn9l0QGTEMhsDE87RVYp1wtEN1neuJhwqH/sYH
        b2dXKF6xNRXiSLZ87l2zw8s=
X-Google-Smtp-Source: AJdET5eO8mD0fO/7rSBZImWXiIIJvUSj1zNkJWmVpFdn6QbFPmIjzAuZsCB/lKU8Mou3cfsw+AQV8g==
X-Received: by 2002:a62:de84:: with SMTP id h126-v6mr23729205pfg.129.1541459378779;
        Mon, 05 Nov 2018 15:09:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o12-v6sm62187303pfh.20.2018.11.05.15.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 15:09:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: BCM63XX: Enable reset controller support
Date:   Mon,  5 Nov 2018 15:09:19 -0800
Message-Id: <20181105230920.26270-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow BCM63xx to compile support for reset controllers since we will
require a specific reset controller to release resets for on-chip
peripherals.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 25aac6ee2ab1..005f4e98dfb7 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -189,6 +189,7 @@ config ARCH_BCM_63XX
 	bool "Broadcom BCM63xx DSL SoC"
 	depends on ARCH_MULTI_V7
 	depends on MMU
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
-- 
2.17.1

