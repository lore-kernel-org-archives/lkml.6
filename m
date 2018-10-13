Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7331BC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2434120835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 08:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="PTkLAXcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2434120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJMPpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:45:49 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:44360 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeJMPpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:45:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id BDEA820B70;
        Sat, 13 Oct 2018 10:09:34 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539418174; x=
        1542010175; bh=9AOQZD8CZEsYHFILfRVx3iqqbKmnzj1G7gNg4TQ9414=; b=P
        TkLAXcdt/+0aknn+uSKZESPZf+QhYSTonhco+NI2OTyeDuRd5a+B+hVyIw4iIrMg
        i7LGKfkSNpAdK2CqjiWb4wWdlbQsrRaD/CSqHIRqB95QH+bWrSbAcWykNgV8vKn1
        GBFnHd4B4ICY1s3VrCVpbYuS7xMBn+crbu0WsnzloKjrf6xZJtwEsA0WsB/9Vf67
        jiqE955LMp8FQG5TXU/7Q+XgbTwhYatzhWFgVQjxtvhOBfi9X3JRp3WLgakVZRNl
        oqJ7+SCWZq9EtwPHCUv4ciVunQwK7Rn2IVlEeIWYsRa50haWWgqXWYh4ezI4V1aq
        wTz9k/Kw7manZ/HmB+RjpeZCwzohN8q+OjgT0Fi3JOXerSakSB2MAoeW71Acw4+F
        4dr9J3O2Ewh/o55S4K8rpSLXNo5bXCr0MSNEGtg8Z4i/xi6jNyKxP6rkKhcOSoSF
        dosqKuzUoWI2voQWJSA/Wic2XqL13onM7ibuF1UrjXvs8uYff5BTKb/3dVOi+reH
        6g2xNcQMf9+Ja1zRXKKxkL33Ny8ldnwWmUIzNYohgGeVhcFWWDccSw9H7rv8p2xH
        8/9fmKKF5kQ4If8sLjpviTIkOH//lHKnYkLDBxrzBf/DAvf5x1GT6SuQxuqRbmc4
        RnOBTkRAxgBL2IPvUhEgj4auSF0fiPbITFo99YGU14=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BV-HmirljvKh; Sat, 13 Oct 2018 10:09:34 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 79CF3202F8;
        Sat, 13 Oct 2018 10:09:33 +0200 (CEST)
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
Subject: [PATCH v4 4/7] arm64: dts: allwinner: a64: sopine: enable power supplies
Date:   Sat, 13 Oct 2018 11:08:45 +0300
Message-Id: <20181013080848.29894-5-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013080848.29894-1-oskari@lemmela.net>
References: <20181013080848.29894-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sopine baseboard have ACIN and battery connectors.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
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

