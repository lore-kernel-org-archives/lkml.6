Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86891C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E36206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="sCMVWVK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E36206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeKUEYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:24:02 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:34452 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbeKUEWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 442951FBED;
        Tue, 20 Nov 2018 18:52:30 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1542736349; x=
        1545328350; bh=YtsaaInLaSJV+mW4ZGJfvOx1QGYgTi0mgpQkgtrzmII=; b=s
        CMVWVK1Gu9a7P93wNqOpwsr2/VdtiBo36dS/3O8p0QKhrcGBiKROMjcfTu8DkKbR
        r7mpnLXLQz/nbxTx/JtVQ09BXGcA11DXyQf41ourlnIIPgopu0KnZOfcyuVfiynu
        uPwRjchccKmcyOkKAS8WB0Z2NhWh4qCQ6v2UHKt1B1CKJHqkjST8dbpDgaaJMc8I
        AEz5eNEI/pPvVoOl1wYVaQD2Qa7J+uwnwU/xudkItxRML4w0FS+hm5gLzRYrzSHT
        LmVlw7Lau+HjQLsrtKDMyD/mcrnNgCyxWF2JCxxD42ziqzS/pHslHI9vF6eHyOYE
        cLT8so+wAhyYdug4Ev2GvtUnaOPeOElDkHPzHHuADmq38UNUmFackd9Co8PqXYvM
        0o/iPDYelj4cdK2QyrgF+xW+ftpOkXYaTcXRNN6ckMrNMKhqfSniGPs+vJt2GyB8
        uKrZbPZzf2BkzFZ5BSDC1d+pemZL5IZOXNVswzbUtFNfTWgLizxANxYhpp2uUUc1
        q76/H1NhLWxbXov4pw/Z7Kl0CCvzMI2tkQtDC5eVcV2O1B9OeXRl5zCzMbOAMt8V
        UMb0dnb1v7BiTW3vi6BiHI6ZHDpNq1jU0+XhOOGVnZI7nQa0s4VjjtcO9k58BKsW
        t0yI5AZA/nJuhZMEu2Ktyf32wekoeL+UngseODHWFc=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GuKFiLuNcU_c; Tue, 20 Nov 2018 18:52:29 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 87D5420791;
        Tue, 20 Nov 2018 18:52:28 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v6 5/8] arm64: dts: allwinner: a64: pinebook: enable power supplies
Date:   Tue, 20 Nov 2018 19:52:08 +0200
Message-Id: <20181120175211.3913-6-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120175211.3913-1-oskari@lemmela.net>
References: <20181120175211.3913-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Pinebook has ACIN connector and 10000 mAh battery.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 77fac84797e9..6a1402bf0362 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -148,6 +148,14 @@
 
 #include "axp803.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
-- 
2.17.1

