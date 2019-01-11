Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF857C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05A42084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219093;
	bh=TXxontep7GD++4WKnJjeZcJuAwA8Yy+rqA9l9mJJRTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mzIfZHmcAYEsePCE//Q1VY4FWb0KIbxAqELT+kcnIAVm06Wh75CfhZILV+psgHpFd
	 N+F3d7KSvcMOLKEgueZ3ZoOGOfZhmzUI30nak26+7YaTS5MRkX00x2lyAoTByWf8wn
	 xQJsrMvVOASSaFhuY8TNs8kiRpKB2wdqLjWunk1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbfAKPEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:04:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388892AbfAKOaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4332063F;
        Fri, 11 Jan 2019 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217010;
        bh=TXxontep7GD++4WKnJjeZcJuAwA8Yy+rqA9l9mJJRTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aOlEkINWToTG+GUAiRZfrmhxCZvqmII4/jkqsDvWUJncjRNi3XR1Wq5Pbsgk86/jK
         Toz4OOKZUnoBvrtOVj9yc2Z2D3NH/HpEniqbBCz0kNHjy8NKRRmDY48NCY+RPPTPsv
         1+f1FSEvFzMNpA+NB2PR/yRlhY6r3z5qXpH3MqgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 001/105] pinctrl: meson: fix pull enable register calculation
Date:   Fri, 11 Jan 2019 15:13:32 +0100
Message-Id: <20190111131103.019120129@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 614b1868a125a0ba24be08f3a7fa832ddcde6bca ]

We just changed the code so we apply bias disable on the correct
register but forgot to align the register calculation. The result
is that we apply the change on the correct register, but possibly
at the incorrect offset/bit

This went undetected because offsets tends to be the same between
REG_PULL and REG_PULLEN for a given pin the EE controller. This
is not true for the AO controller.

Fixes: e39f9dd8206a ("pinctrl: meson: fix pinconf bias disable")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 6c43322dbb97..2998941fdeca 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -272,7 +272,8 @@ static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
 		case PIN_CONFIG_BIAS_DISABLE:
 			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
 
-			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
+			meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg,
+					       &bit);
 			ret = regmap_update_bits(pc->reg_pullen, reg,
 						 BIT(bit), 0);
 			if (ret)
-- 
2.19.1



