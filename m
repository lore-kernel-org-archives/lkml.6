Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3E0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1A020844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895354;
	bh=HVpm9Lb4K5qp1tA6cHfxiOp92axP7qcC0HNtDVENUFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bkRXMC9Ab1ACoWFPmpBd0pWb6DkyEvDSmBf8aG45CJbjJz+WUvtJX3b9Yvi/IWauB
	 iKp+AplswzPt4zsifj1MHIlrF4hm89AEVYsk47rce7YObPAk94YBgvlMGp5t67i9HO
	 kqWDo8chvbi5uaTZ0ho/mKGOvDOZ4NuDxiHaSEbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfBKO3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:29:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbfBKO3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A4620675;
        Mon, 11 Feb 2019 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895345;
        bh=HVpm9Lb4K5qp1tA6cHfxiOp92axP7qcC0HNtDVENUFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMULZZOl/Phg+1fc4PvrqgOSxBZs2yNOi8v5TNHc/wVj3Om3IAlSjGps/UhQ5/AOK
         5C9pFVz6ToPbzL5QNoyW/OY52m+eiB86rP3VZMdMk1tHBdxkhAsCjkzz6/5d1geqv4
         asD371+3OJNnbio+FxLZxjpLEsujHXdV7yH5qIvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 173/352] mmc: meson-mx-sdio: check devm_kasprintf for failure
Date:   Mon, 11 Feb 2019 15:16:40 +0100
Message-Id: <20190211141858.093633165@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index abe253c262a2..ec980bda071c 100644
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



