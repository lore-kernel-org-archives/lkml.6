Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C3C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B559206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="a8I7dgjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfAPR74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:59:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33736 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfAPR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:59:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so8043477wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bcv4MkeoVz8gZ3m+0FU+1hIF0hDCII/eg515n8hHTfs=;
        b=a8I7dgjYkgC0u2nsI3XmM5KgB4T5r3bSqVHTR4J8ABoYESmbNjaCisD4hK+GkAsidu
         My6Qx8R1ppE1Crmj/2hsKiOpNjW02bOhZP2lldWUFx934x27+dl8HeNqlxj6fpFWGegu
         mIgbV2MbBSPCw4bwNjOa22WY30RoFiFyYGvMN3N1yMMJvdjit027EzA7GlvKVPJYZ2f4
         w3GZsXQvUNOaufhOiBG+3kLOQzh5WYWV6uNWrHD4D0omKZVMEr+ErTaPPMPZ81kMTzVb
         vkdBvDzHvgNC/wHVJNmwQoHkbHzLh+5xzHGKUf0FPhBHPjYsA9nCcdRDz5RjZYQ7oWs/
         WqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bcv4MkeoVz8gZ3m+0FU+1hIF0hDCII/eg515n8hHTfs=;
        b=V4e1Z/FA6AHF3U3W+SVzUTjM6ZL469DaIN9e/XmCWe/sCvOceYnPpv+TBc/cZ5c0zS
         3TxND1oMcjTED9Wnep2oyoPXLwQwPxReS0HSg7elmqO47q3uGAVljyab9dYLv/WaxNXr
         32emXFTFYDoMUhssfsTCRaJgMuX9bZOMdshyH/OH1gFujwVS1Swd5TfvG3ewgyrStxcx
         TQMuaDq2zWqXKsLQXcXbNq6KLybTnGymZtLPUHxA9gZ9UPO0UVLOG5IlRsVd0h8PyfU6
         7Pm4a+Os4vmsL4P2WTMKuthzy0oApVxvViBA82LMqBjedgY7N5JaM4BEVv2Nr5P11FrN
         5a6w==
X-Gm-Message-State: AJcUukfk24KU9q8e1taz4kMaKAQI9di13bJGUoqrmasfTw/hRpihy0f4
        0nENjUos2fWGQb1+QhRo1kwg5dV/Tsw=
X-Google-Smtp-Source: ALg8bN6jQGun62yIQILU6wHRg/6NfJ1mnia6doWM06JqHNuITBa9t8rnEn19shKmOie2FSU3VlgwRA==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr8771520wru.28.1547661592737;
        Wed, 16 Jan 2019 09:59:52 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t70sm59324609wmd.36.2019.01.16.09.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 09:59:52 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH] arm64: dts: meson: s400: fix emmc maximum rate
Date:   Wed, 16 Jan 2019 18:59:47 +0100
Message-Id: <20190116175947.6093-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limiting the HS200 rate on the s400 was just a way to mask that the
tuning setting were not correct. This seems to have been fixed with
the recent MMC driver update. We can now use HS200 at full speed.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 0c98ca78c8b8..75fe1a2c49d0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -488,9 +488,8 @@
 	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
-	max-frequency = <180000000>;
+	max-frequency = <200000000>;
 	non-removable;
 	disable-wp;
 	mmc-ddr-1_8v;
-- 
2.20.1

