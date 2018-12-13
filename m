Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086C6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B389E2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NapKWXCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B389E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeLMU7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:59:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35157 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMU7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:59:20 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so1630146plo.2;
        Thu, 13 Dec 2018 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xL2yzcdrlOEuMWINGjk+/wkCxWpq2CGtEEwHgTJzNGI=;
        b=NapKWXCfDo4NfIy8TwRwgK7fk8EmdyBJa5xYfRdKsaBfXYIX71mZa7FnUs7LZsUFTZ
         TbaT2xKVxXSYYsya++7OaDEuuhMH2VeVNTj7mzzUTfC8dOiq7Vpt77HHX7g8vMLbaivQ
         SQSyq2JW4B+jE0NPih4I4iSuEW4y61h1pfZ5harGyUx+ckr3YT9DX8N2xaPRCLhcCchh
         I16JQt/6Z0FCXC0M+KIJHLHTVs/F+f5b9qNbjHFv4sD676jeBvdGVdIEon8z3/Egn8ax
         DYOZ15HPWLTK8oyJaKKXs2v7T/pbXWbOiKW29xT5N0bYDDK/O8Im3fbyg/Md6Blltbex
         gz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xL2yzcdrlOEuMWINGjk+/wkCxWpq2CGtEEwHgTJzNGI=;
        b=jM/3BRU1zDFrmJUHgLsRVM8qLQiIbQmb97nlPGRcPmlN1vmcJ+i3TGI179yqn/Lx4j
         ao5EU2f3tCoIv82cgapjKBQDVIFRxqO8nPoU/6qqmF+ucyQ0S8EBJeN4h7+EGSvMjNfb
         a8Vz5Kz6rI7YgfgdaLFBvO4JWNMgQKAvZSOc9n+QoUbWep9EIxoffQBkGTeSTRuwDEEv
         ByCjX+JyhF3Vl303T+/BLgD2WWxiRwjJNfLwRFA68IBjWvliCfvRp17Yfo3wVGlRm5SF
         GEp21V38HmdzBMOOOjssKUfZNlpoYhKOcJ0ow6XDy3RCbQiKqV/OZTWyfAA6y2dYolgG
         F4kw==
X-Gm-Message-State: AA+aEWZcB7hu9+2gkNyT2uPwN6MadiNBQlgMKuEkiZxXxJdsOXqZv2cl
        YK0m8trbS23u9bGVzZgMYdk=
X-Google-Smtp-Source: AFSGD/UYApWWeXFc/aVKS9gg3yEFms4vgD8yqkk4gGBwxTlOz9E0vnQmXtAuUeU2RZMWGRE+sgXDkw==
X-Received: by 2002:a17:902:8346:: with SMTP id z6mr323353pln.340.1544734759876;
        Thu, 13 Dec 2018 12:59:19 -0800 (PST)
Received: from dwesterg-mobl.amr.corp.intel.com ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id 22sm8093698pgd.85.2018.12.13.12.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 12:59:19 -0800 (PST)
From:   dwesterg@gmail.com
X-Google-Original-From: dalon.westergreen@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thor.thayer@intel.com
Cc:     Dalon Westergreen <dalon.westergreen@linux.intel.com>
Subject: [PATCH] arch: arm: socfpga: arria10: Add stmmac ptp_ref clock to socdk devicetree
Date:   Thu, 13 Dec 2018 12:59:10 -0800
Message-Id: <20181213205910.26359-1-dalon.westergreen@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalon Westergreen <dalon.westergreen@linux.intel.com>

Add the stmmac ptp_ref clock as it is configured in the arria10 socdk.
The stmmac driver defaults the ptp_ref clock to the main stmmac clock
if the ptp_ref clock is not set in the devicetree.  This is inapprotiate
for the arria10 socdk.

Signed-off-by: Dalon Westergreen <dalon.westergreen@linux.intel.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 2a7466891d0e..58bfa84dcdb3 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -74,7 +74,8 @@
 &gmac0 {
 	phy-mode = "rgmii";
 	phy-addr = <0xffffffff>; /* probe for phy addr */
-
+	clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
+	clock-names = "stmmaceth", "ptp_ref";
 	/*
 	 * These skews assume the user's FPGA design is adding 600ps of delay
 	 * for TX_CLK on Arria 10.
-- 
2.19.2

