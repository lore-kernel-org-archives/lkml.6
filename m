Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8BFC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0B72075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="gf3ejZgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0B72075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390816AbeKVKsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:48:50 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36611 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388274AbeKVKst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:48:49 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1D590886D4;
        Thu, 22 Nov 2018 13:12:06 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1542845526;
        bh=wjn4CFcNHOU1ZpPZPs2FpspHxrTRiloMOnyTBSb9ilA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gf3ejZgv+K7aFikj0OXrEwSYPgJGQH5mcgRwZ47rTCJo/KnkRRyZqamC5K42+XO8b
         AQ77kwywCm97jvR3QsKJXV8e0pKLBse+jnb3f1hUq03U95aHhKZYlapsWul030k33y
         bg/TifXK1xpq/kXnLiClW5gh9OtWTry5g+y2b4UJjkrRS2eUnA36dha+BpfoaljMY6
         WdFyaKcpR7iVh1Jn1QIKHca/Say9iYtcaASzzckNV+263juK+BHbbCdESJy5xTqBXx
         0d69c2LioT6doGtBtidh9VLsozd4G1EPIh1fI4XbB1fSzq2YhntACHnGSdTw6+fZPC
         zUy9/DPQDAZIg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bf5f4550004>; Thu, 22 Nov 2018 13:12:05 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 29ECA13EEFE;
        Thu, 22 Nov 2018 13:12:08 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id B63BD1E08D9; Thu, 22 Nov 2018 13:12:02 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 6/9] ARM: l2x0: add marvell,ecc-enable property for aurora
Date:   Thu, 22 Nov 2018 13:11:39 +1300
Message-Id: <20181122001142.19187-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
References: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aurora cache on the Marvell Armada-XP SoC supports ECC protection
for the L2 data arrays. Add a "marvell,ecc-enable" device tree property
which can be used to enable this.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
[jlu@pengutronix.de: use aurora specific define AURORA_ACR_ECC_EN]
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---

Notes:
=20   Changes in v7:
=20   - remove marvell,ecc-disable

=20arch/arm/mm/cache-l2x0.c | 5 +++++
=201 file changed, 5 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b70bee74750d..e5380f7b14a5 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1505,6 +1505,11 @@ static void __init aurora_of_parse(const struct de=
vice_node *np,
=20		mask |=3D AURORA_ACR_FORCE_WRITE_POLICY_MASK;
=20	}
=20
+	if (of_property_read_bool(np, "marvell,ecc-enable")) {
+		mask |=3D AURORA_ACR_ECC_EN;
+		val |=3D AURORA_ACR_ECC_EN;
+	}
+
=20	if (of_property_read_bool(np, "arm,parity-enable")) {
=20		mask |=3D AURORA_ACR_PARITY_EN;
=20		val |=3D AURORA_ACR_PARITY_EN;
--=20
2.19.1
