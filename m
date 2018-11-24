Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67697C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 21:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D94220874
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 21:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="ORHlirPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D94220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=appneta.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeKYHts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 02:49:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34597 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeKYHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 02:49:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so12050581plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 13:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsVq7Try0+0PUqdwDnCZRFIpVFVJuvM91yUkfOnbM58=;
        b=ORHlirPwv98jXEjpH0pjmKDk7XXdUovpmOpSnl3wEHWG2ApXkNc8IRyYnv3HGC2lsI
         FdNQdlA0DBZayeZhaLUMdiKF+bwHRfIND2SFoAzrkLd27Nyzl7JST4rFejZm/6c1uWvc
         uk3wNsALjDyl8RVs2TkfBbmwi5fviMPNQMUfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsVq7Try0+0PUqdwDnCZRFIpVFVJuvM91yUkfOnbM58=;
        b=foqs7+e7EcdXfN3en5K72XFHp9hn46yegsKObGrWxLVaX2AvsXozYrx4Bt1LWx2aFM
         B3sqWWr+EcQudKbS1Vv+IIsfKgIBwPdssYfdXyBtZt/2JzowcA3U7vddpYZd622cw3DR
         GSF96wsaNRzg+NTQRJ3mPY/cNYfTtUAvTxt2+ydrWh84V2KpKhrkjOMTL0Zh/YbcDrBt
         tlWIVkxfFlN+BjQDoTDxgZQS9IbZmGRJDhd3Tv/4HvQorsCC8DoCCw03mW7Fxx9th/fX
         +Z17o+vuGEz8Uek2T/5Jvsd17M5Z+cylgbaqptMmtENk703dxWryPUUFPgVY+NjsA3Vb
         5zkQ==
X-Gm-Message-State: AA+aEWaaQH8hpP95uNwOGFYrZ895cdXy9yi2R6oM/tdp0J3v2NGPeM/q
        0yjAs9HG14g/aYwgRiQ38Syb
X-Google-Smtp-Source: AFSGD/XgIGq89YAuwL8AU8RZ/19aV/UNzklH4ET4T/uOHbaIiFe3PnN/M7Oywu3iZ3c5d4cOmMO/xw==
X-Received: by 2002:a17:902:5588:: with SMTP id g8mr5370026pli.22.1543093230941;
        Sat, 24 Nov 2018 13:00:30 -0800 (PST)
Received: from debian9-jae.jaalam.net (64-46-6-129.dyn.novuscom.net. [64.46.6.129])
        by smtp.gmail.com with ESMTPSA id x27sm95448432pfe.178.2018.11.24.13.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 13:00:30 -0800 (PST)
From:   Josh Elsasser <jelsasser@appneta.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Josh Elsasser <jelsasser@appneta.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] ixgbe: recognize 1000BaseLX SFP modules as 1Gbps
Date:   Sat, 24 Nov 2018 12:57:33 -0800
Message-Id: <20181124205801.67828-1-jelsasser@appneta.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two 1000BaseLX enum values to the X550's check for 1Gbps modules,
allowing the core driver code to establish a link over this SFP type.

This is done by the out-of-tree driver but the fix wasn't in mainline.

Fixes: 6a14ee0cfb19 ("ixgbe: Add X550 support function pointers")
Signed-off-by: Josh Elsasser <jelsasser@appneta.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 10dbaf4f6e80..9c42f741ed5e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2262,7 +2262,9 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
 		*autoneg = false;
 
 		if (hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core0 ||
-		    hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1) {
+		    hw->phy.sfp_type == ixgbe_sfp_type_1g_sx_core1 ||
+		    hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core0 ||
+		    hw->phy.sfp_type == ixgbe_sfp_type_1g_lx_core1) {
 			*speed = IXGBE_LINK_SPEED_1GB_FULL;
 			return 0;
 		}
-- 
2.19.1

