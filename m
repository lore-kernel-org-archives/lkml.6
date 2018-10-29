Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E1ECDE46
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1004420851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="qkNEog8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1004420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbeJ2QN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:13:28 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51835 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbeJ2QN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:13:27 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3972C886BF;
        Mon, 29 Oct 2018 20:25:54 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1540797954;
        bh=gn2rzIoMKhd2UOIOyaYdme8NNPTVV2gtR1o2Xit7/WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qkNEog8/FeDd13oLCRAjBbe2BI+iib8e8vT30IhBLY/VdIK6W+PR9ALRLUco/aduo
         361MietWgRz6V8jBAIkGDVijbDoAFsH6CS1U1KNOJArj1W1g1berJOmmmzUU9b8YCS
         uEDFiSuI1D0/20JzDl17nqpaSopEsyPObcP9TSxQxP4OT5KNGZKxx6j8hUnjY8LQNH
         FeyviL0xMR8Wlw9851yhaakIZfTlCSOTfPbUpUnV96OA3iRjF0WsDuy3KZK/kK4ow9
         qxswlmrB7/fQAQ0Os9ttVFXQrIbMEgM5OIB1zaVsysfYkPIzorylaEw8iKKBaRO+QP
         sejlMfuuJTUWA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bd6b6010003>; Mon, 29 Oct 2018 20:25:53 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 4381013EFE5;
        Mon, 29 Oct 2018 20:25:54 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 6A2BD1E21FF; Mon, 29 Oct 2018 20:25:49 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk
Cc:     u.kleine-koenig@pengutronix.de, jlu@pengutronix.de, bp@alien8.de,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v5 8/8] EDAC: armada_xp: Add support for more SoCs
Date:   Mon, 29 Oct 2018 20:25:35 +1300
Message-Id: <20181029072535.31667-9-chris.packham@alliedtelesis.co.nz>
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

The Armada 38x and other integrated SoCs use a reduced pin count so the
width of the SDRAM interface is smaller than the Armada XP SoCs. This
means that the definition of "full" and "half" width is reduced from
64/32 to 32/16.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
=20drivers/edac/armada_xp_edac.c | 5 +++++
=201 file changed, 5 insertions(+)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.=
c
index 70cff01afc8d..03a18b54467a 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -341,6 +341,11 @@ static int axp_mc_probe(struct platform_device *pdev=
)
=20
=20	axp_mc_read_config(mci);
=20
+	/* These SoCs have a reduced width bus */
+	if (of_machine_is_compatible("marvell,armada380") ||
+	    of_machine_is_compatible("marvell,armadaxp-98dx3236"))
+		drvdata->width /=3D 2;
+
=20	/* configure SBE threshold */
=20	/* it seems that SBEs are not captured otherwise */
=20	writel(1 << SDRAM_ERR_CTRL_THR_OFFSET, drvdata->base + SDRAM_ERR_CTRL=
_REG);
--=20
2.19.1
