Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017DDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF50214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPiNupNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF50214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404914AbeKTDW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:22:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404434AbeKTDW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:22:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3F62148E;
        Mon, 19 Nov 2018 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646721;
        bh=hTQ5fOrzzj2/gK2yFnokqDiYgTRqfKatlKZkXxlbesE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPiNupNskb/cZZCM8JO8eGKElAKrk7e4IdgeIhelChplFP2dqTpbNU1p2S2Cyk3/0
         9eUL2d7uS7R2amo0Xvca9F9WqQsj0xaNzpnraROs3K1PHkxug1JrA6hI8urYNM1vdg
         Lh8ZrF1PTiOFHrTiv5CKBNPx1h7z1BClEZCXGdCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 028/160] pinctrl: qcom: spmi-mpp: Fix drive strength setting
Date:   Mon, 19 Nov 2018 17:27:47 +0100
Message-Id: <20181119162633.483729642@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 89c68b102f13f123aaef22b292526d6b92501334 ]

It looks like we parse the drive strength setting here, but never
actually write it into the hardware to update it. Parse the setting and
then write it at the end of the pinconf setting function so that it
actually sticks in the hardware.

Fixes: 0e948042c420 ("pinctrl: qcom: spmi-mpp: Implement support for sink mode")
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -459,7 +459,7 @@ static int pmic_mpp_config_set(struct pi
 			pad->dtest = arg;
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
-			arg = pad->drive_strength;
+			pad->drive_strength = arg;
 			break;
 		case PMIC_MPP_CONF_AMUX_ROUTE:
 			if (arg >= PMIC_MPP_AMUX_ROUTE_ABUS4)
@@ -503,6 +503,10 @@ static int pmic_mpp_config_set(struct pi
 	if (ret < 0)
 		return ret;
 
+	ret = pmic_mpp_write(state, pad, PMIC_MPP_REG_SINK_CTL, pad->drive_strength);
+	if (ret < 0)
+		return ret;
+
 	val = pad->is_enabled << PMIC_MPP_REG_MASTER_EN_SHIFT;
 
 	return pmic_mpp_write(state, pad, PMIC_MPP_REG_EN_CTL, val);


