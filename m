Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E0DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9A220821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZXLZaI0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9A220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeKADge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:36:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40683 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbeKADgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:36:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9-v6so7686689pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIRB5G3XsW3tJTCLvGiA9lY0I+P7n55uNj5h9NRT6WE=;
        b=ZXLZaI0+jRaO7bVSzpPu910lXuzCRg249Oq9+ztyHUz4KMyOsSzEimeCD3owzJWCMy
         9sHkpfYZ0mpONOGqJddw7zPYfxTn+URuCUoyCZdOkQlS9zFSf/tXdALjxLsNsJySuM9i
         9NJKRkn7iilOAMUbO6O3JTtgZdnVap/eN+5FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIRB5G3XsW3tJTCLvGiA9lY0I+P7n55uNj5h9NRT6WE=;
        b=RPFI4sZrKcggRk/ZWg5vlgXG+Bm4VSBnsfhLONqJ3mtWpa7jT0f435SDE9j9tcUm4a
         0AOPzhyKjgl/1mOKQCPk4wZkrtQPxpb1UBtP2f+o8gGcBjFLRz7VzGdsuL6fFgALNxF2
         l/Tl6/w4IpkW9Mws8ykB7r93YT088tEWtYHjk4HNbOsSh7/lhEYTER5f5RjGbS8P9Yx7
         HyyrcMb7fAgDjX7bn73riSIlUcwG/pUnyCcHPfNffMYzev0xzU3kJP5+pIfgsxoaDqDT
         UNsLpEBYEe/h8KhT8bdIXzdCvjE7XZPHzVNslbQZ8iHrt2g5IqdSk5HCPFV2rEyCzfYM
         7Vtw==
X-Gm-Message-State: AGRZ1gLz3dglEYbc8mQPTOqlqk6iZGt5+S52F//OMvygqG5erIqKVGVH
        JM87X34Zv6LFx+FhAEkehnu3TQ==
X-Google-Smtp-Source: AJdET5fivIN/NemrTnjIluz6pB0mzUySCyo847nvKJbACFGRW8iE9WYyxMcV/WTa1Sq68+++2Q2dxw==
X-Received: by 2002:a17:902:be01:: with SMTP id r1-v6mr4384341pls.143.1541011040331;
        Wed, 31 Oct 2018 11:37:20 -0700 (PDT)
Received: from localhost.localdomain ([2409:4070:221e:94ae:dc27:379e:a542:5441])
        by smtp.gmail.com with ESMTPSA id 72-v6sm37165627pfl.126.2018.10.31.11.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:37:19 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@openedev.com>
Subject: [PATCH 6/7] arm64: allwinner: h6: Add RTC clock to phandle 32kHz external oscillator
Date:   Thu,  1 Nov 2018 00:06:33 +0530
Message-Id: <20181031183634.29640-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagan Teki <jagan@openedev.com>

Outside of SOC few chips need external clock source through RTC example
Wifi chip. So H6 RTC clock node need to phandle 32kHz external oscillator
like A64 RTC.

Add support for it.

prefix rtc- with clock-output-names defined in dt-binding to avoid
confusion with existing osc32k name.

Signed-off-by: Jagan Teki <jagan@openedev.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index c8d2fe76da7e..028ec286aa0a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -271,6 +271,9 @@
 			reg = <0x7000000 0x400>;
 			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
 		};
 
 		r_ccu: clock@7010000 {
-- 
2.18.0.321.gffc6fa0e3

