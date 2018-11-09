Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A57020840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SR3oIBcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A57020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeKIQnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:43:39 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45859 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKIQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:43:38 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 64D9989156;
        Fri,  9 Nov 2018 20:04:24 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541747064;
        bh=7pBgkn6yqsFB/7HrIpaxbvTidNEiKjOKcblyTutVUkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SR3oIBcTj/CBuRed9FoidjCFl4yTIxJzlxG+RPm6slrV0frRqQ9VAYfs0G9d47qRK
         RvkBaF3to0Ihxv4M+EMw1pu4smikNZWphZBWXYq/W3LhGqn4/SAzmLViKa4zDvLWqf
         w+rwBB1NDYwufEXp3gmx3teZSbOoyIPe5hPrHPhkNgQ5+RMamz9KhZKK79+ajthgvR
         tZG3qRUWZXxPzl2rX1Un7unzteAf1l4zXHZDs2lvU0DBaVdlqPQ02mMXQfYTf0277C
         Shu3XUn+4C30RC2XsqzncOtsFfms4S+12vmEyBYclq+6wKUHZEIIjCHcje2qogH+bI
         S00VkZJMCaOZA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be531600003>; Fri, 09 Nov 2018 20:04:00 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 4849213EEA1;
        Fri,  9 Nov 2018 20:04:05 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 24E961E0BC9; Fri,  9 Nov 2018 20:04:00 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, arnd@arndb.de,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v6 9/9] EDAC: armada_xp: Add support for more SoCs
Date:   Fri,  9 Nov 2018 20:03:49 +1300
Message-Id: <20181109070349.20464-10-chris.packham@alliedtelesis.co.nz>
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
index 3759a4fbbdee..7f227bdcbc84 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -332,6 +332,11 @@ static int axp_mc_probe(struct platform_device *pdev=
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
