Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF6DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391A620879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ONF/pSr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfAJELc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:11:32 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19154 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfAJELb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:11:31 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c36c5d90000>; Wed, 09 Jan 2019 20:11:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Jan 2019 20:11:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Jan 2019 20:11:30 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 04:11:30 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 04:11:30 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c36c5f00002>; Wed, 09 Jan 2019 20:11:30 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>,
        Jinyoung Park <jinyoungp@nvidia.com>
Subject: [PATCH 1/2] regulator: max77620: Initialize values for DT properties
Date:   Thu, 10 Jan 2019 12:11:16 +0800
Message-ID: <20190110041117.8216-1-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547093465; bh=o2p44xN65nInpkkbxhA73quEzc+FQFCXP97mHOEic2c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=ONF/pSr3YsloxqZPxB0Vt0ynerev/se+HjwV/mPs+9FW+oXysy/CmtOdmjaixKvRM
         phCM9JFrqboC5HBKW/kB0Bia8+uu0ePy/nFR3YatV6KC6Yc4IIEiw1lU24tgbUIQDw
         8MFHQZpiaN+p1pmU4A5L/luzkcxXKjha7JGUb9guT7R/w0Yc14nRygx0/uzdTQXHvN
         Ut1gAYkXcyoN+yGLF3RLLUjkPbFh6+NBjXoQdv/ifg4OpiAuxh4NQMQyJlsKNqlrJ9
         MStTlx/4r5HwQ0Ezop+kTeKlohdjiC4E+3OFVmOrdtTRiqaaIs7cjzG/xmFaMCFSyr
         W42tCCd3mPgqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If regulator DT node doesn't exist, its of_parse_cb callback
function isn't called. Then all values for DT properties are
filled with zero. This leads to wrong register update for
FPS and POK settings.

Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 drivers/regulator/max77620-regulator.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max=
77620-regulator.c
index b94e3a721721..cd93cf53e23c 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -1,7 +1,7 @@
 /*
  * Maxim MAX77620 Regulator driver
  *
- * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * Author: Mallikarjun Kasoju <mkasoju@nvidia.com>
  *	Laxman Dewangan <ldewangan@nvidia.com>
@@ -803,6 +803,14 @@ static int max77620_regulator_probe(struct platform_de=
vice *pdev)
 		rdesc =3D &rinfo[id].desc;
 		pmic->rinfo[id] =3D &max77620_regs_info[id];
 		pmic->enable_power_mode[id] =3D MAX77620_POWER_MODE_NORMAL;
+		pmic->reg_pdata[id].active_fps_src =3D -1;
+		pmic->reg_pdata[id].active_fps_pd_slot =3D -1;
+		pmic->reg_pdata[id].active_fps_pu_slot =3D -1;
+		pmic->reg_pdata[id].suspend_fps_src =3D -1;
+		pmic->reg_pdata[id].suspend_fps_pd_slot =3D -1;
+		pmic->reg_pdata[id].suspend_fps_pu_slot =3D -1;
+		pmic->reg_pdata[id].power_ok =3D -1;
+		pmic->reg_pdata[id].ramp_rate_setting =3D -1;
=20
 		ret =3D max77620_read_slew_rate(pmic, id);
 		if (ret < 0)
--=20
2.19.2

