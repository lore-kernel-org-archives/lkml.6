Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32656C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40D920840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="mQH55A+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40D920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeKIQnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:43:33 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45800 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeKIQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:43:30 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E0CEC886BC;
        Fri,  9 Nov 2018 20:04:15 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541747055;
        bh=1l326nDgcmfFRxpFQ8xN2pkboVdKSCSc9uvWpRK5DdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mQH55A+Wtstg/tn87pp5ZSIh3wUiq1t4ir2cM3iwvT76zwrmb2eMkrUOtrvYT2h+O
         GpYpHihB8VrT35T16nxmarHI5NSt+YJVjyarkjJVMAboi4beRnx7wJ9HGJjyyNx2XP
         GwBn48hrebdnnsh1hGdmxOxoxL5D4gRVl+0EMjLRigyyQO2ViL1OuPndHm4AU0XKY1
         cAQG+ZO9VuTmlOjjWEJXOD8VTcCZj32i1cYfg0VhBAI0uYO/W/NPoHf3USSYarUWyS
         xZLgpOP1ODG6DVM35IKjs/AtTqjjTB0A+HVInzJAR05OtdyWDNt1OjagWsn0zHHwSn
         oMD7d6G9FVuMA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be5315f0004>; Fri, 09 Nov 2018 20:03:59 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 9079713EEA1;
        Fri,  9 Nov 2018 20:04:04 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 6D43A1E0BC9; Fri,  9 Nov 2018 20:03:59 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 4/9] ARM: l2x0: support parity-enable/disable on aurora
Date:   Fri,  9 Nov 2018 20:03:44 +1300
Message-Id: <20181109070349.20464-5-chris.packham@alliedtelesis.co.nz>
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

The aurora cache on the Marvell Armada-XP SoC supports the same tag
parity features as the other l2x0 cache implementations.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
[jlu@pengutronix.de: use aurora specific define AURORA_ACR_PARITY_EN]
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
=20arch/arm/mm/cache-l2x0.c | 7 +++++++
=201 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 7d2d2a3c67d0..b70bee74750d 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct de=
vice_node *np,
=20		mask |=3D AURORA_ACR_FORCE_WRITE_POLICY_MASK;
=20	}
=20
+	if (of_property_read_bool(np, "arm,parity-enable")) {
+		mask |=3D AURORA_ACR_PARITY_EN;
+		val |=3D AURORA_ACR_PARITY_EN;
+	} else if (of_property_read_bool(np, "arm,parity-disable")) {
+		mask |=3D AURORA_ACR_PARITY_EN;
+	}
+
=20	*aux_val &=3D ~mask;
=20	*aux_val |=3D val;
=20	*aux_mask &=3D ~mask;
--=20
2.19.1
