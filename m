Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06781C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46A2214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="CECeVLQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46A2214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJIBdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:33:03 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:59442 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJIBdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:33:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id B142920FEB;
        Mon,  8 Oct 2018 20:20:02 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received; s=dkim; t=1539022801; x=
        1541614802; bh=01vMnBcvhmgbenPNRiP6vEWBw0VXxpZO/dS2anQ0+Ys=; b=C
        ECeVLQf7vOQz0AjPo/izDx3TQ/SIsOqMfaV3T9prE88FQmZans4in9rWSe30yLXI
        7RrzB64s25vd+pIG9s+qdSMFaNCuluXTm059ZMWsnhFdw+QTIok2sQhiRq//cqNU
        ZjnbY2SRI0El9lRUmo30q/Sr4MPWQ8oKyz+NfgD208XtM5Uc38hBqskZQNiKntkN
        NN1Uq5x6NAnxTlIZ6uaJ9jW9GjU/46oPQgo1Ml9gMYch9pShqDpIjOiZjf9xs5Aj
        t9Q+KK1jgVTC5AyBguT6FifiIs6D+xSONbzunfo0s7k1GdZJO/0CtPfwwTpwiuqt
        EDFWNAuTnQQ9BSVMXh2dhKsOY31sa8UEZxV15j7HX0YxeG9nwtuFZ5P0u80Pi3G/
        pjIOqk/R3YcKjBhLXcpKtx1/Z6lV/emCdIQSEB8b9M91WqDWE1j/O7BjsmbLsqr/
        puBtRL7YSp/GnPOi7goXubpptS3aLgxJj2eu4LkCXZ+OgNfYwyho10zRhhB601tC
        aCjZ+wNyRrfaSXlhrLssFthD1xZAeVYm8yNIFtlEg3HIBtwC8Ee3XM6wzwaPYoX0
        YW0zibLTu3Ms2ah44h+PxHxCtjXaDpteygP9A7UgJ4k91jNZV49qVxs1GwkVFV5a
        sjqsMDdZUC2sfeO9jCw/MGjIQZJwbNwyorJ698VTso=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 4ErXytZKCOSQ; Mon,  8 Oct 2018 20:20:01 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 6DEDA1F99B;
        Mon,  8 Oct 2018 20:20:01 +0200 (CEST)
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
Subject: [PATCH v3 4/7] arm64: dts: allwinner: a64: sopine: enable power supplies
Date:   Mon,  8 Oct 2018 21:19:05 +0300
Message-Id: <20181008181908.9456-5-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008181908.9456-1-oskari@lemmela.net>
References: <20181008181908.9456-1-oskari@lemmela.net>
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

