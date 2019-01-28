Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACBCC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483AD2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691600;
	bh=Br3FdFmO5Bxhwo3/NR5Z76846Tc32IX+vUHVM7Gid7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JsssTOnCnbmz+WxwWQ0Xh9iZlK+K4aOZB3HpkTOIzPwpt+oba9jiR7ayySzw+fcXY
	 dmmACb3mXAzs7L1B6COTHqkPBbTuHpwEyQ4HuH5H300B0+69Nhi5W9bz1aE4B/g360
	 AXCisXqqYUlS+yRPL8DK/EbLG97M0s2uBur4zLq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbfA1QGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:06:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbfA1QGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:06:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A782171F;
        Mon, 28 Jan 2019 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691594;
        bh=Br3FdFmO5Bxhwo3/NR5Z76846Tc32IX+vUHVM7Gid7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5oWZFgOMvm/mormBqZPlrHP2Bi7d6mpwc1lYh3tRtETQ//N8W+nS8WQwJ98LoC/f
         gdfcq1jwspLbAowjq3wunK4Xp2Or9v9RlOvsTa4bhS3fJKpcPKYOVXgWXchNEU5bHk
         9qel0wnWXViLT9en64yAQDXgKgvOTg6TZ1kQ2plE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 153/258] mmc: meson-mx-sdio: check devm_kasprintf for failure
Date:   Mon, 28 Jan 2019 10:57:39 -0500
Message-Id: <20190128155924.51521-153-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit b0d06f1cb0e2079a3c64fb6e27c19d9a55c723a1 ]

devm_kasprintf() may return NULL on failure of internal allocation thus
the assignments to  init.name  are not safe if not checked. On error
meson_mx_mmc_register_clks() returns negative values so -ENOMEM in the
(unlikely) failure case of devm_kasprintf() should be fine here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/meson-mx-sdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 2cfec33178c1..9841b447ccde 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -596,6 +596,9 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
 	init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
 				   "%s#fixed_factor",
 				   dev_name(host->controller_dev));
+	if (!init.name)
+		return -ENOMEM;
+
 	init.ops = &clk_fixed_factor_ops;
 	init.flags = 0;
 	init.parent_names = &clk_fixed_factor_parent;
@@ -612,6 +615,9 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
 	clk_div_parent = __clk_get_name(host->fixed_factor_clk);
 	init.name = devm_kasprintf(host->controller_dev, GFP_KERNEL,
 				   "%s#div", dev_name(host->controller_dev));
+	if (!init.name)
+		return -ENOMEM;
+
 	init.ops = &clk_divider_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = &clk_div_parent;
-- 
2.19.1

