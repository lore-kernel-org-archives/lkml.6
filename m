Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AA0C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1352148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789325;
	bh=2JQQ7fEO4SlE0rwOW2YDWROllY6Mumh9K/OsVBoOt60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O65HdF0BamWidptTnwCHuHDK5gRoGKSDHRWdbSQkPB74mScN1Dlh/AuKT8j7QqSDH
	 vPDw2MPlrSl6Gs2bMR55UnKuQFXUygiQawHPDhRL1GYwdlFF8bxw+tPFNUJegzG5q/
	 WEnl/zcH4+/GDh+Hd3U04uhK7XpzG4vbt3KCvZXo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1352148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbeLNMIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731314AbeLNMIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C34D22148E;
        Fri, 14 Dec 2018 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789323;
        bh=2JQQ7fEO4SlE0rwOW2YDWROllY6Mumh9K/OsVBoOt60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4MDCVUmuAZ3Hp+PnKumQJRrhRxXmInev6jf4B8cB62+329LLbMtyqCpKJpWPy2PM
         zxgJTm5MffUmHkkcBSLtACeGPKUy8Z9jGy3nYXeZdrjkBAltRUhSp3ef9LoZ4rGQQ0
         bOY9Tk5ziA1S22qGdVl2hJOXGqjfxhULyR2Icubc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 37/89] ARM: dts: at91: sama5d2: use the divided clock for SMC
Date:   Fri, 14 Dec 2018 12:59:50 +0100
Message-Id: <20181214115731.514041123@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14 ]

The SAMA5D2 is different from SAMA5D3 and SAMA5D4, as there are two
different clocks for the peripherals in the SoC. The Static Memory
controller is connected to the divided master clock.

Unfortunately, the device tree does not correctly show this and uses the
master clock directly. This clock is then used by the code for the NAND
controller to calculate the timings for the controller, and we end up with
slow NAND Flash access.

Fix the device tree, and the performance of Flash access is improved.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index b1a26b42d190..a8e4b89097d9 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -308,7 +308,7 @@
 				  0x1 0x0 0x60000000 0x10000000
 				  0x2 0x0 0x70000000 0x10000000
 				  0x3 0x0 0x80000000 0x10000000>;
-			clocks = <&mck>;
+			clocks = <&h32ck>;
 			status = "disabled";
 
 			nand_controller: nand-controller {
-- 
2.19.1



