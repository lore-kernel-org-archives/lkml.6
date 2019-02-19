Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4246C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E421773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="jTMbMw5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfBSNhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:37:36 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:38723 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSNhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:37:36 -0500
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 90AB1A63BD;
        Tue, 19 Feb 2019 14:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1550583453;
        bh=2zZz6fGoKd7rJzGHSo5EVGyHaG18tL7ausA0l16/ZnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jTMbMw5DJAtHjV0i2ksIgh3X2DjJwJEuSf4qTJK7+b+7Dppq/03FW6D5hWCvlNMYn
         bxwCU4IB7Fjjpm5EEk8fcyZybUet1sBn3ym6zYUycW5mPw/TUKzuEFM4oKeTYdMfzm
         OGZO21DNZD9M2d3tN07j/JfTD/14cf8E9uBfrUA4=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] ARM: dts: imx6dl-yapp4: Use rgmii-id phy mode on the cpu port
Date:   Tue, 19 Feb 2019 14:37:00 +0100
Message-Id: <1550583420-112858-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY must add delays to both Tx and Rx clock on the cpu port
to work propperly.

It worked with the rgmii mode before beacause the qca8k driver
(incorrecly) enabled delays in that mode.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
This imx6dl-yapp4 platform is currently waiting in linux-next.

Commit 5ecdd77c61c8 ("net: dsa: qca8k: disable delay for RGMII mode"), now
also in linux-next removed the delays from the RGMII mode so the networking
stopped working.

Recently Koul submitted a patch that implements the rgmii-id mode to fix
the issue [1].

As the networking is broken at this moment it does not matter which patch
goes in first. It is not neccessary to wait until the Koul's patch is
applied/merged if that should be the case.

[1] http://patchwork.ozlabs.org/patch/1044505/

 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index b715ab0fa1ff..091d829f6b05 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -125,7 +125,7 @@
 				ethphy0: port@0 {
 					reg = <0>;
 					label = "cpu";
-					phy-mode = "rgmii";
+					phy-mode = "rgmii-id";
 					ethernet = <&fec>;
 
 					fixed-link {
-- 
2.1.4

