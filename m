Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7313C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C38E2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697127;
	bh=81HtfFb5OqO9OhqaF5dRONV8p+/AZCBdNWkc+Yj5Gek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eixuNsd1b85TF9WuIy2XrdnK9215OUKn4Xuf1AZ+DXR+pj5bW/Wm7S10bgIcbfpnE
	 yai3NHcSPgxDNQIuPpGZ08yuxjJDc5ROX8R8J4rVfWyXL2wT8zfKd+6we/dWxfT88K
	 Oz+OEfYgAYByEzeUFiT602sSJbZwVlwUp9zABcLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfA1Px5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbfA1Pxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:53:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312242147A;
        Mon, 28 Jan 2019 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690830;
        bh=81HtfFb5OqO9OhqaF5dRONV8p+/AZCBdNWkc+Yj5Gek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQWttOdJnZ+h8wIw5xEtSiQm/BMypC1L0slT4HV3sf9bFxZ7fAEGrMOMhVXpPqwAc
         Rse1owjaeBcR7mjkzmlVN8jI16edEFDfkm169uVccoDbKfFWvMBO8PIiltuC3NRKe/
         lrI09GGhG8i773Vr6C9R9woNGymtywo6BAWyyp5s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 206/304] pinctrl: rza1: Handle devm_kasprintf() failure cases
Date:   Mon, 28 Jan 2019 10:42:03 -0500
Message-Id: <20190128154341.47195-206-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit db221412cd2014506642967155698825ad80f6b6 ]

devm_kasprintf() may return NULL on failure of internal allocation
thus the assignments are not safe if not checked. On error
rza1_pinctrl_register() respectively rza1_parse_gpiochip() return
negative values so -ENOMEM in the (unlikely) failure case of
devm_kasprintf() should be fine here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 5a49b644b307 ("pinctrl: Renesas RZ/A1 pin and gpio controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-rza1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rza1.c b/drivers/pinctrl/pinctrl-rza1.c
index 14eb576c04a2..9cfe9d0520ac 100644
--- a/drivers/pinctrl/pinctrl-rza1.c
+++ b/drivers/pinctrl/pinctrl-rza1.c
@@ -1225,6 +1225,9 @@ static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
 	chip->base	= -1;
 	chip->label	= devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pOFn",
 					 np);
+	if (!chip->label)
+		return -ENOMEM;
+
 	chip->ngpio	= of_args.args[2];
 	chip->of_node	= np;
 	chip->parent	= rza1_pctl->dev;
@@ -1326,6 +1329,8 @@ static int rza1_pinctrl_register(struct rza1_pinctrl *rza1_pctl)
 		pins[i].number = i;
 		pins[i].name = devm_kasprintf(rza1_pctl->dev, GFP_KERNEL,
 					      "P%u-%u", port, pin);
+		if (!pins[i].name)
+			return -ENOMEM;
 
 		if (i % RZA1_PINS_PER_PORT == 0) {
 			/*
-- 
2.19.1

