Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D802C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D4C20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="LPQ7HNHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D4C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeJCD6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:58:00 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:39334 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeJCD6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:58:00 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A4FA68011F;
        Wed,  3 Oct 2018 10:12:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1538514760;
        bh=Pu+1ciGlEm6xZggihOkIbM7fZFzJGWqFxIymnxZ/nUc=;
        h=From:To:Cc:Subject:Date;
        b=LPQ7HNHPVSwsSNTtRs8BDHg6tLtV61CeILPyBJ6oQ06RCpn+tPmP6ahs3irtlEpi7
         yI/r/0VJUNv2zdo15+JU8ZlkBSX3rww9xME4swohD7l+imbhOU+AOeQSM7NBKRy3K1
         c20fOfKnNJT10+dgUWjVl4S+xqTo5DcSCshNF8iY=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bb3df480000>; Wed, 03 Oct 2018 10:12:40 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 87A3F13EEA8;
        Wed,  3 Oct 2018 10:12:44 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 6A09E1E1D93; Wed,  3 Oct 2018 10:12:40 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: auto-detect nand ECC properites for db-88f6820-amc
Date:   Wed,  3 Oct 2018 10:12:33 +1300
Message-Id: <20181002211233.20774-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board has a Micron MT29F8G08ABACAWP chip which requires a ECC
strength of 8/512. Rather than hard coding any particular strength the
the nand controller auto-detect the ECC strength based on the ONFI data.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
=20arch/arm/boot/dts/armada-385-db-88f6820-amc.dts | 2 --
=201 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts b/arch/arm/b=
oot/dts/armada-385-db-88f6820-amc.dts
index dc9ccce1d4a1..7881df3b28a0 100644
--- a/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
+++ b/arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
@@ -99,8 +99,6 @@
=20		label =3D "pxa3xx_nand-0";
=20		nand-rb =3D <0>;
=20		nand-on-flash-bbt;
-		nand-ecc-strength =3D <4>;
-		nand-ecc-step-size =3D <512>;
=20
=20		partitions {
=20			compatible =3D "fixed-partitions";
--=20
2.19.0
