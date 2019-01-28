Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870B8C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547EC2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690578;
	bh=9Xjym+iWVaamZ1j/CpphHc+tDjwCls7M2eY854r5K4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qn7Yf6BYfN0KNl3+N7yy/6maGVKQV4BA6cPbWFnnDDJdaRcbFO25wUCVGdmJkezlE
	 MUKAVxZzDd6RN4MgwxhL1r1bbi/XQTloNXBlLZc8zVVo4rAONL07y7yXQfS+fQv66s
	 H8XwbVc6I2473wK+JQjFACwYGNnNzi3vq2JP2RRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfA1Ptg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfA1Ptd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A31C21741;
        Mon, 28 Jan 2019 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690573;
        bh=9Xjym+iWVaamZ1j/CpphHc+tDjwCls7M2eY854r5K4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zza0hiY2ga99N5nKtPAOsbUWYP2/IAMoH9S027XAdcdCdAlX23knQByFDwrKTqnyF
         7B8TXB8YEmWJNQsAmcoMAamCcsdCpklFxuTYs33rKS5qJXaY8Nj4vAXqvUfSObZTZG
         MGk9wAekIMHGXRzqH755DINY/trqfQccjKotcZHw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 128/304] pinctrl: nuvoton: check for devm_kasprintf() failure
Date:   Mon, 28 Jan 2019 10:40:45 -0500
Message-Id: <20190128154341.47195-128-sashal@kernel.org>
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

[ Upstream commit 4be1eaf322f07bb9694618fd2763a3a1f0a3dd25 ]

devm_kasprintf() may return NULL on failure of internal allocation thus
the assignment to  .label  is not safe if not checked. On error
npcm7xx_gpio_of() returns negative values so -ENOMEM in the
(unlikely) failure case of devm_kasprintf() should be fine here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 7ad50d9268aa..3bda620d18bb 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -1932,6 +1932,9 @@ static int npcm7xx_gpio_of(struct npcm7xx_pinctrl *pctrl)
 			pctrl->gpio_bank[id].gc.label =
 				devm_kasprintf(pctrl->dev, GFP_KERNEL, "%pOF",
 					       np);
+			if (pctrl->gpio_bank[id].gc.label == NULL)
+				return -ENOMEM;
+
 			pctrl->gpio_bank[id].gc.dbg_show = npcmgpio_dbg_show;
 			pctrl->gpio_bank[id].direction_input =
 				pctrl->gpio_bank[id].gc.direction_input;
-- 
2.19.1

