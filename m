Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD9ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DBC21486
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 21:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="txRZ7Z5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DBC21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeJGEZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 00:25:18 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:53338 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJGEY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 00:24:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 1FFC820791;
        Sat,  6 Oct 2018 23:20:09 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1538860808; x=
        1541452809; bh=01vMnBcvhmgbenPNRiP6vEWBw0VXxpZO/dS2anQ0+Ys=; b=t
        xRZ7Z5AFFFwfc0VfiscPMLai6ANacodU3/j3LeJ6r+NGadQsL15UlvG3R730+Md5
        lvoZk5/bLHujuquTR9Aw68LXHDwhvclaXMwKfx4kmgkZWrZthWh7RJXTu/Z73cle
        emhtLVNWNpW83+bi4nMudjCUanEWNtnuJE16sZfu2NnzNup7knBrz74IlskNfCjF
        u60hQDLOUQ6aHDuI2LU7N1dAtkAy8Nzc2Rt0Vuq8sgGZeYsxbpLswHpMhQUxcIwM
        PsDjzzTc6xJRh5HgMrorgrbTGzzHU4cc1nlbIOf8eg+NlepXJpr6ukgPVHgYmcZO
        N040i3NV+F47i5wbWDJHDhSV0DEaj/MV04qt9eGRYFlDBSZti0uXGX6odMXqUHfl
        /BDUAhJSuymQJBdDzAbBx3SxaNDJkltl5sHoTdrDSWDncSmkuLV9yKnjWxNaylTx
        gudbsTnkGTonAAVjehqem8dTct03Ij8pmopH0lr+DxUz9pWcWxcLS3sltfDpzMhP
        Sp/HMJpck4Ivlzb5RrQoDrgCxchA7WGdV/smmTs4OUoqKoLGIGnbDdLt0reK/f4v
        oEAZdKs+CQp4KgD2Vzh/vdT+O4IVYS3nPp3vbE7wJbplMU2giP9VcwBnb9Sh1Cgf
        beF/mPDufzJiENBwm2oTMn4MbqOicggQ9AGQ7u2S5U=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0BM6ASD2Voae; Sat,  6 Oct 2018 23:20:08 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id DB87B20790;
        Sat,  6 Oct 2018 23:20:07 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/6] arm64: dts: allwinner: a64: sopine: enable power supplies
Date:   Sun,  7 Oct 2018 00:18:34 +0300
Message-Id: <20181006211836.28253-5-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181006211836.28253-1-oskari@lemmela.net>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sopine baseboard have ACIN and battery connectors.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index c21f2331add6..335cf2263d19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -69,6 +69,14 @@
 	};
 };
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.17.1

