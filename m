Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD7C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13E521471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9An/yrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13E521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391316AbeGLClM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:41:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:47003 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391293AbeGLClM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:41:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so19615773pfl.13;
        Wed, 11 Jul 2018 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/k2QY2JFM9/KcDJVDIg38YKX+fbFvcJgf25kHKfv3pg=;
        b=F9An/yrVz65qit5fpCMq0R/PN32/aeuUUOFV3kBoIwnqBhGvk7nSPSh5hKO8UmqvHd
         j591ZCjt3/Wum2c7F4LC7NJrWnabjqxTCi3vhPZ2XG8j1PZQponVd6yQCdYUUDKN6bFm
         8s4pVH/N9U5FcDj1vSzRqYLTiimQo4rYFjiW7QQajmW7vGLd13zjSLlElzb86y5OKkm7
         1j3BVHWxS0dxR7P8RcEPiiQ7xJVF9FJ2n/ieA5KIBCF72+vay2CpOC/7nSWID9WlFLDO
         D5PNiyK65sZG6RHvapjFoYiE15kZvAvbdYP6GuiYWiOVNtSLYPvz/J6fnh+3eEdgkudB
         eIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/k2QY2JFM9/KcDJVDIg38YKX+fbFvcJgf25kHKfv3pg=;
        b=TuICeR+5hWLpz9CB+4cNYrjxm1ZBIY9Qv9SVn/xumfR+lDlILi9F1sV03WOYiiZjop
         iKR288bma29WbI6RCWyqc+xmf9yHUozzHELFscvFTOjHz5fvCQKenSrKZcT+1PRqYxqc
         6hjIvjLBj1lsn/aHqRdFfhX4bPFtiohXJX3ARfVd1qFp9Vf7usxtLMjgcj/f7fcezPxj
         Hpqx3r7EfKjpUjULwqS58tP8xbztm0g0fK+bpEK59QLiyWTBh4svUr77waeYBUJvp3an
         gWCx64kdjsdaa+KpkwolajiNS8y+BYcrczlNcucDMVJ7PvM38Pg34GiFsk1h15n5X672
         tF2A==
X-Gm-Message-State: AOUpUlGLAY2s40sRhMRn39F2gKAy7Zu3GrGWyp9a+ED70SBmJOLR+kyx
        jC59ThIPyDgaHwr972fQ23U=
X-Google-Smtp-Source: AAOMgpf9ts2Hi+M2h55jrEOJJ1kqKwMr37U60y8azbNLpHWOMW8FF5uFoYMJEuNBm+eM9GnsYK0ABA==
X-Received: by 2002:a63:e452:: with SMTP id i18-v6mr350954pgk.185.1531362836075;
        Wed, 11 Jul 2018 19:33:56 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id w16-v6sm57260335pfi.101.2018.07.11.19.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 19:33:55 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>, cphealy@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 2/2] ARM: dts: imx51-zii-scu3-esb: Fix RAVE SP watchdog compatible string
Date:   Wed, 11 Jul 2018 19:33:37 -0700
Message-Id: <20180712023337.30112-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712023337.30112-1-andrew.smirnov@gmail.com>
References: <20180712023337.30112-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like I made a nasty typo in the original patch which resulted
in missing watchdog device. Fix it.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: cphealy@gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
index 0bb42c00d72b..dffb761a1cc8 100644
--- a/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu3-esb.dts
@@ -325,7 +325,7 @@
 		#size-cells = <1>;		
 
 		watchdog {
-			compatible = "zii,rave-sp-watchodg-legacy";
+			compatible = "zii,rave-sp-watchdog-legacy";
 		};
 
 		eeprom@a4 {
-- 
2.17.1

