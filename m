Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1659C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9935320840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="GMNKZqPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9935320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbeKIQn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:43:57 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45839 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbeKIQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:43:33 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5B38189154;
        Fri,  9 Nov 2018 20:04:16 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541747056;
        bh=oI4+ADffqReYBu1GS1c414QlvVag+1zxLv+5gkp2Lsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GMNKZqPr7gZZiHCvc7XJukxvrxVDnAmq5O9tD4BwiOD4msINier1aYf1XaFw7XHIB
         ukrB+E1L+B8CBsrGyBMAG8Fi7k51Per1XxUbqr+LSoxJlZh1/64fFzwjXdwAzMrWco
         4M6BjCHG1pOFgxD/W+XDvOtvBZbrvaUXgvo7V2XDi/U9Kc80lRFUIgjP8kGT5W3+Re
         J264o6js1jciuB0iksjR0P/bbjnvWokyYQGfMMsisTa8YjN0YDsU4XQNva2RJkVFPy
         k0lD2QUzKFyPNnsn+4ruRXmJwkG3XTYoHw2FZjeofzghyU2OrvDlNkFHf1Nn/HCE2x
         U4Lc/gPZm5W3g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be531600000>; Fri, 09 Nov 2018 20:04:00 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id C424013EEA1;
        Fri,  9 Nov 2018 20:04:04 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 9F96C1E0BC9; Fri,  9 Nov 2018 20:03:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 6/9] ARM: l2x0: add marvell,ecc-enable property for aurora
Date:   Fri,  9 Nov 2018 20:03:46 +1300
Message-Id: <20181109070349.20464-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
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
=20arch/arm/mm/cache-l2x0.c | 7 +++++++
=201 file changed, 7 insertions(+)

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
