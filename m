Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FD5C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BBD21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690512;
	bh=hJIh8QLmnTUJg9HEZ4nA/enTyoQ3r6pXm5y59mYhCk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lemLb7bLI1R/CTVJYDSU28nuOGYhF6gyRjjsIEMG0uaxHkB+0dlMIP3mPaWeXiEQ5
	 glpjZ7UrgfBHdWmEYyM88afstXKW1aENH819+JG6VuzIXNgkmBg3F3FJKAMMF71AtF
	 NWtYsADX/Unt8vNT3Jd12muCbsBgryscY76Obpbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfA1Psa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbfA1PsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:48:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C5C21741;
        Mon, 28 Jan 2019 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690504;
        bh=hJIh8QLmnTUJg9HEZ4nA/enTyoQ3r6pXm5y59mYhCk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcDeGYWlhADg92dyGh9xq0Y9t6RtDZIr+HFujb2yoyC1FbbdebwUvekl68Pgu643o
         bHxXaNAC9qfVEnN0QoEUvUPb3KIXorKeh6OqKtcYiDr50x8NX/Q3wAiYKDfBLXE+CZ
         sYZ4NhP5M6qFaOV+wUPO59wCa9uddcDfZ9vU4OBo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 108/304] ARM: dts: mmp2: fix TWSI2
Date:   Mon, 28 Jan 2019 10:40:25 -0500
Message-Id: <20190128154341.47195-108-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit 1147e05ac9fc2ef86a3691e7ca5c2db7602d81dd ]

Marvell keeps their MMP2 datasheet secret, but there are good clues
that TWSI2 is not on 0xd4025000 on that platform, not does it use
IRQ 58. In fact, the IRQ 58 on MMP2 seems to be a signal processor:

   arch/arm/mach-mmp/irqs.h:#define IRQ_MMP2_MSP  58

I'm taking a somewhat educated guess that is probably a copy & paste
error from PXA168 or PXA910 and that the real controller in fact hides
at address 0xd4031000 and uses an interrupt line multiplexed via IRQ 17.

I'm also copying some properties from TWSI1 that were missing or
incorrect.

Tested on a OLPC XO 1.75 machine, where the RTC is on TWSI2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/mmp2.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..47e5b63339d1 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -220,12 +220,15 @@
 				status = "disabled";
 			};
 
-			twsi2: i2c@d4025000 {
+			twsi2: i2c@d4031000 {
 				compatible = "mrvl,mmp-twsi";
-				reg = <0xd4025000 0x1000>;
-				interrupts = <58>;
+				reg = <0xd4031000 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <0>;
 				clocks = <&soc_clocks MMP2_CLK_TWSI1>;
 				resets = <&soc_clocks MMP2_CLK_TWSI1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				status = "disabled";
 			};
 
-- 
2.19.1

