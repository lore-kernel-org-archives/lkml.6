Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3220FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E885820664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmevFm0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E885820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbeKAILZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbeKAILX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE902081B;
        Wed, 31 Oct 2018 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027471;
        bh=6j4QWqlfuxcnan2613gO4k8zZZO6NT3Wz+utt/o07LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmevFm0LRKZMUwrkNhvdDLyWGOZFLNVChFf6TevMWcrsIKTW3PtGuT8nYl13c6wQP
         Je9ufVFWvrqhhdVxI+xJQveyTh5yxTSokuIATsrkBqNwVwlQaOukE96DmJJo6l83tM
         OVuWnUtVLRftggPX02Pcge20Ih4XsFJzLvDM4Ks4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 19/48] pinctrl: qcom: spmi-mpp: Fix err handling of pmic_mpp_set_mux
Date:   Wed, 31 Oct 2018 19:10:25 -0400
Message-Id: <20181031231054.29333-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 69f8455f6cc78fa6cdf80d0105d7a748106271dc ]

'ret' should be returned while pmic_mpp_write_mode_ctl fails.

Fixes: 0e948042c420 ("pinctrl: qcom: spmi-mpp: Implement support for sink mode")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 6556dbeae65e..418bc40df7ca 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -319,6 +319,8 @@ static int pmic_mpp_set_mux(struct pinctrl_dev *pctldev, unsigned function,
 	pad->function = function;
 
 	ret = pmic_mpp_write_mode_ctl(state, pad);
+	if (ret < 0)
+		return ret;
 
 	val = pad->is_enabled << PMIC_MPP_REG_MASTER_EN_SHIFT;
 
-- 
2.17.1

