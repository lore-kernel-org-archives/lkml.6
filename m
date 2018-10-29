Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C15DC46475
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241692080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fUhqPpuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241692080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbeJ2QNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:13:55 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51824 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbeJ2QNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:13:25 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D1E048781F;
        Mon, 29 Oct 2018 20:25:53 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1540797953;
        bh=aa81lk+tnvlI+U6sRrADkZjfMbd7061EJ7B4jRO4Mkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fUhqPpuk6HVATv7DZN19baA3cvUvop8ygtGR1P9zfdqBYEbLc+qH+Bol3n72xlAuT
         tu9V8J63kE6hE9RpGiYYhx5xNr5+16xzBUU8O535oGfSNmNaMzbTQfDNQE8KVQxSNv
         m1SnF/MA9gCiAFotKYiHM75/E8RxCeuuD5xaIGuP23ScyRzV7OpGjr+HvwekHG/BGV
         nwHpZPqS9phLWATmjvBVBV1ECFO8+Cvervfa3TOIsmfrG98nNzy68QXybwmTrMdHBG
         Zz1DxrdARWfSfOsefMeGev8TXOkogn0oGaOx9eZrMFLuePcuc+V1BnEVpyXwnv/3wR
         QtJ43HrMLNTpA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bd6b6010000>; Mon, 29 Oct 2018 20:25:53 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id BBC8713EFD8;
        Mon, 29 Oct 2018 20:25:53 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E11BC1E21FF; Mon, 29 Oct 2018 20:25:48 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk
Cc:     u.kleine-koenig@pengutronix.de, jlu@pengutronix.de, bp@alien8.de,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v5 5/8] ARM: l2x0: add marvell,ecc-enable property for aurora
Date:   Mon, 29 Oct 2018 20:25:32 +1300
Message-Id: <20181029072535.31667-6-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
References: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
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
=20Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
=20arch/arm/mm/cache-l2x0.c                         | 7 +++++++
=202 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documenta=
tion/devicetree/bindings/arm/l2c2x0.txt
index fbe6cb21f4cf..15a84f0ba9f1 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -76,6 +76,8 @@ Optional properties:
=20  specified to indicate that such transforms are precluded.
=20- arm,parity-enable : enable parity checking on the L2 cache (L220 or =
PL310).
=20- arm,parity-disable : disable parity checking on the L2 cache (L220 o=
r PL310).
+- marvell,ecc-enable : enable ECC protection on the L2 cache
+- marvell,ecc-disable : disable ECC protection on the L2 cache
=20- arm,outer-sync-disable : disable the outer sync operation on the L2 =
cache.
=20  Some core tiles, especially ARM PB11MPCore have a faulty L220 cache =
that
=20  will randomly hang unless outer sync operations are disabled.
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b70bee74750d..644f786e4fa9 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct de=
vice_node *np,
=20		mask |=3D AURORA_ACR_FORCE_WRITE_POLICY_MASK;
=20	}
=20
+	if (of_property_read_bool(np, "marvell,ecc-enable")) {
+		mask |=3D AURORA_ACR_ECC_EN;
+		val |=3D AURORA_ACR_ECC_EN;
+	} else if (of_property_read_bool(np, "marvell,ecc-disable")) {
+		mask |=3D AURORA_ACR_ECC_EN;
+	}
+
=20	if (of_property_read_bool(np, "arm,parity-enable")) {
=20		mask |=3D AURORA_ACR_PARITY_EN;
=20		val |=3D AURORA_ACR_PARITY_EN;
--=20
2.19.1
