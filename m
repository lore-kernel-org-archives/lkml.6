Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF56C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4B1206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896272;
	bh=4Le2FhkgFzKakR2mvMOi/WMm6Az2V7429MXzNoly06c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qtnffag3M75STreDaaZfZ8SA3/QIKa6NjxzHgYo0qZTYPtvnp5zlM+CquGglOgky5
	 sQbVH2pskaVKLekUdFyhx8m+4yIN4lwZ/w125/Jma87RCz8olbwFks5vmAKMCquyPB
	 y/9zz2CX+76IyV2xBIQT9YDnBgiz1LeCLzkrKVpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbfBKOoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:44:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732835AbfBKOo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:44:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C6D2206BA;
        Mon, 11 Feb 2019 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896266;
        bh=4Le2FhkgFzKakR2mvMOi/WMm6Az2V7429MXzNoly06c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xm+lu2RqH1eNimgzQDJ+5G82dl2U5T/NpD6w6uzrtcbJPpo5sAhY7jKs5WLichgxt
         8d3JNXMlIjRa2pxZW8cu3y2VXI8h/3/4QpevO113fiefqCNQ4l1QVoFNWi8X6KeEdL
         1A2ibj95pmHQhnin5+l3l4ST6FTUHzBLaJLMK3ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/313] ARM: dts: mmp2: fix TWSI2
Date:   Mon, 11 Feb 2019 15:16:07 +0100
Message-Id: <20190211141859.663034498@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



