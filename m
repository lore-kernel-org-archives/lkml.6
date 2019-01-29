Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69CAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6912920880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761163;
	bh=WaUh7aid9qWLar8enot2CAZsUnFGjxVtX0aCzZ/A0NA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nmBvnAflNWi2rRZ9mAKM5gRkh4lUpLFEHvjO5UfgGPvvPAdzUmnCJBO66a9lHhiwY
	 JeojUirGKby0QRCAIh73hBt76p0MVCnKJ55A/0ebjSGDrnmCjCdlK218RulV+ThfTU
	 SULyOw/qqticid/tcAgQXp8AGSGj/5MK4FlPsxrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfA2L0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfA2L0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:26:00 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77FDE20989;
        Tue, 29 Jan 2019 11:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761159;
        bh=WaUh7aid9qWLar8enot2CAZsUnFGjxVtX0aCzZ/A0NA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PecLi7kcQnY1o4XvhBmQBFXMpE6VSkk6IIgOjNd1TpRC0axhjEdoYguQ8nHBwHbVH
         RQ1k4ojiFb70vlaF9klkDLhXVv86BgXYuJTKfdTfaHX92Rt70xZgq8IvlDnoJlE97N
         RusqAz+qXUedNcBZqZlXMtW9OrTuLmrWBxzdPPNw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] mfd: sec-core: Return gracefully instead of BUG() if device cannot match
Date:   Tue, 29 Jan 2019 12:25:53 +0100
Message-Id: <1548761153-28114-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548761153-28114-1-git-send-email-krzk@kernel.org>
References: <1548761153-28114-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace impossible BUG() in probe with a proper return.  This can be
triggered only in case of a clear bug (e.g. adding broken half-support
for new S2MPSXX flavor) but BUG() is discouraged and the boot process
can actually try to continue.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/sec-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index c3bb53f79e63..2c2f48b24eeb 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -474,8 +474,9 @@ static int sec_pmic_probe(struct i2c_client *i2c,
 		num_sec_devs = ARRAY_SIZE(s2mpu02_devs);
 		break;
 	default:
-		/* If this happens the probe function is problem */
-		BUG();
+		dev_err(&i2c->dev, "Unsupported device type (%lu)\n",
+			sec_pmic->device_type);
+		return -ENODEV;
 	}
 	ret = devm_mfd_add_devices(sec_pmic->dev, -1, sec_devs, num_sec_devs,
 				   NULL, 0, NULL);
-- 
2.7.4

