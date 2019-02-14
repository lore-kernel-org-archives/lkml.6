Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A435C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F034720835
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oys6S3BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393506AbfBNNJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:09:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34159 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbfBNNJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:09:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so3072739pgd.1;
        Thu, 14 Feb 2019 05:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eeGeoU0xurxGwS3T8J3Qs6AIQrB91qKDaXpQlmfMjNc=;
        b=Oys6S3BQ7QXvNJ1Y3uR75qzfcn+UiBkJt58HqepB2oL0EggBQ0DKYKHXU2N3ehIKkE
         pd/ojEZ2B6GNkywUQF9LUjcnS+6stMegnIl8Q8CxvEKd1jBSIeH+KugIg0yG3XbTQV1V
         o3yObmmNxWatXMlWMnUxSAlOLD0BGhP07v4cf9hQPv8zCTVipgeIHCrg4pfRz345aBW7
         X3WNjLBTdSb3yEBGVrDRefdeow8SekVHJxsVfGlFZF9Lj0B8G1qln3hIL2Bux2ZQ09M7
         x1L3a9sBcA00x1u1wn6NM3dseOewlIU3zrymdBzpev3xDSqElPan87AzAj/RkHS2aJun
         0tZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eeGeoU0xurxGwS3T8J3Qs6AIQrB91qKDaXpQlmfMjNc=;
        b=FGrWfPlR7aNBI7OHpwjRNRHsU6GvGb5jTugZllF9Nv7eJo+h3aMT6cSnzi31ak5kKi
         7GY0aVtrlsa2PDFHA6T6/m+AgARHtQKt4EiYG4g0aQE1vS0b5VXt9yi6814kmHfoCroj
         2bIV9JYFr6Kn0EwDs+vTOV2Xw8IYE6y7rr94lJQbJFJAoxui3ne4HowuKhVS/paJH4nq
         zue0HILIn3NVZb2Uth6Lm/+U54oOixFeoGlIgck+Bi5U3/9CgcVbxG7Be6y6G1K/IPJU
         0MXC9PeLgkddgT6I9NTxzDJLX2eFTVRRbd2mE9b3T/M46jG+Aff4AnKY88rBrytdr2jW
         G4rQ==
X-Gm-Message-State: AHQUAuaLX+fbsz78sjaoSgsxkGtAONS9SOyJ/UfxUUie0sD0NimjNxdM
        fG/6Dvb69fuydinsvkguDLo=
X-Google-Smtp-Source: AHgI3IbX2IU5qoqbx9ScoTSOLf10PJ64/byqvusQUiw1YNyOQ7Lp6DTRSuSRdHc8Vtt+KPjhC7oqVA==
X-Received: by 2002:aa7:83c6:: with SMTP id j6mr3919860pfn.91.1550149756814;
        Thu, 14 Feb 2019 05:09:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n73sm3347705pfj.148.2019.02.14.05.09.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:09:15 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/4] arm64: dts: allwinner: h6: Enable CPU DVFS(cpufreq)
Date:   Thu, 14 Feb 2019 08:09:06 -0500
Message-Id: <20190214130910.9201-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cpufreq support of h6, source of information is as follows.

h6 cpu opp info:
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi

axp805 spec:
http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf

---
The patchset is based on the sunxi source code and has not been tested on an
actual board.
---

Yangtao Li (4):
  arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
  arm64: dts: allwinner: h6: pine: Add CPU supply regulator
  arm64: dts: allwinner: h6: Add clock to CPU cores
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  8 ++-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  8 ++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 69 +++++++++++++++++++
 3 files changed, 81 insertions(+), 4 deletions(-)

-- 
2.17.0

