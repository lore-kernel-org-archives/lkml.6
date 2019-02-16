Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFFF222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIMyn/VX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfBPKZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 05:25:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37307 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfBPKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 05:25:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so9905616edv.4;
        Sat, 16 Feb 2019 02:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mc4u4S+SKw29TLDk0Sl52rBqAGyHvQIr6vBt8G/7xas=;
        b=UIMyn/VXaUbqdFErsICf/WhOLFCqxOHJnUJtY+t3qdnV3GkLLPyE4xgOm6KtI+3oK6
         ddChQdKwjhLU9tqmETPG91D+p6ZVZbdUlOafsR/svYUw+3PoTn7NWRJGUDHAuCry6aTb
         V6tmoR1XaB/hRVQ6XMTv59JcbdWosmK/CNnIAV14zSn7iH8+iEHvsFqHDzqcYZpmsn07
         dvJheDFEzBpUaZvDcpth386rCFDIFQjQMfNVW2LghEM+sUp2tI0LtknwClxjiD3Yt4NM
         oJuOsJCI4+Ua86Qi0Bq0VyZGbvmsd6ejMGfy3qTFClv/rjw+V1WbGjxdx51UKsPRxqKK
         v6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mc4u4S+SKw29TLDk0Sl52rBqAGyHvQIr6vBt8G/7xas=;
        b=R/jU1G4C9QJPBTopva7zAz7+BDfW3nty6mXdsgeHTqUkzyZg+0HXx9JBibhkaaF0MV
         KRlEzqiYnh13Gs8775B4QAE5w6jZxE708YeYSgPCG+jawA6znjfoZbiWfHTvufoEufVD
         DP4ew5F/6gR3u7vUYNHavP9arcYMTSD1T2cr+gws+6hI1ZausK7gKbWwrVuZl+mQi79c
         zACzoHo5usn3D8H60lrPomhjCVjJ1S+CgeEXx2xrzm6DGAgodS+5VRVZIGJtjqCXmhnO
         xSXD/UBpw28NdS1w45ZVZlrze9qs0ZA0YB+zci83OppJOiy6DipNuer712q3X5tGLO0w
         eq3g==
X-Gm-Message-State: AHQUAuakhHgP0CLF+L8f5QY6Dk1fM8wQup+veyIFh+l4c4q1HyX6yKvQ
        5rT1G3jBn0Fy5k8VxTtHunX/f7iH
X-Google-Smtp-Source: AHgI3IaC+xNQM1hE3cy5muyzNHc3MkKHEKmQqH5Ez7UIEkQs9F/czQp0Zya8bMj1QkAkW+jabraRmA==
X-Received: by 2002:a50:9012:: with SMTP id b18mr5500286eda.30.1550312756301;
        Sat, 16 Feb 2019 02:25:56 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m14sm2323986edc.27.2019.02.16.02.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 02:25:55 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rk3188-bqedison2qc: remove cap-mmc-highspeed from mmc1 node
Date:   Sat, 16 Feb 2019 11:25:45 +0100
Message-Id: <20190216102545.1809-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc1 pins are used for SDIO with a wifi chip.
The function mmc_sdio_switch_hs() only checks for MMC_CAP_SD_HIGHSPEED and
not for MMC_CAP_MMC_HIGHSPEED, so cap-mmc-highspeed can be removed.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index e0424daf2..4b798d1a5 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -446,7 +446,6 @@
 &mmc1 {
 	bus-width = <4>;
 	cap-sd-highspeed;
-	cap-mmc-highspeed;
 	keep-power-in-suspend;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
-- 
2.11.0

