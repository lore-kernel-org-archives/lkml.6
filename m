Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E4BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6834620685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSSkskGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6834620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeKFF1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:27:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeKFF1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:27:17 -0500
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6C020685;
        Mon,  5 Nov 2018 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541448357;
        bh=koXYc1hu8TLaclFoB67fwNXdGvz5/KzWabA6+Y3RKso=;
        h=From:To:Cc:Subject:Date:From;
        b=OSSkskGrZx3/G3EMZRcScTSsq1syNiQfKFDP6Ndf0X6fzWKGduSt3xXmeEZ2yEV70
         osdjJkVEsRcJ0GRQKfC/Qtrcr/x+id+J3aY7PpSmonM/8dIHTOygpMiv3YW4psN8W0
         Nz0GQDwKxk++MJprb4PlKj6fQuIQQgZMRB7ssdSw=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     p.zabel@pengutronix.de
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinh.nguyen@intel.com>
Subject: [PATCH 1/3] arm64: dts: stratix10: use "altr,stratix10-rst-mgr" binding
Date:   Mon,  5 Nov 2018 14:05:47 -0600
Message-Id: <20181105200549.17159-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@intel.com>

The standard reset-simple driver the uses the "altr,rst-mgr" binding is
not getting initialized early enough in the boot process, so timers
that the kernel needs are still left in reset. Thus an early
reset driver was created. This early reset driver is only for the
SoCFPGA 32-bit platform.

The Stratix10 platform does not need any of the timers that in reset to
boot, thus we don't need to early reset driver. Therefore, use the
"altr,stratix10-rst-mgr" binding for the reset-simple platform driver on
the Stratix10 platform.

Also remove the "altr,modrst-offset" property because the driver no
longer needs it.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 8253a1a9e985..5f0b18ae5007 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -308,9 +308,8 @@
 
 		rst: rstmgr@ffd11000 {
 			#reset-cells = <1>;
-			compatible = "altr,rst-mgr";
+			compatible = "altr,stratix10-rst-mgr", "altr,rst-mgr";
 			reg = <0xffd11000 0x1000>;
-			altr,modrst-offset = <0x20>;
 		};
 
 		spi0: spi@ffda4000 {
-- 
2.17.1

