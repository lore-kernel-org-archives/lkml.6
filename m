Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5392147A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YikBH50w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5392147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404614AbeKTDV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403956AbeKTDV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:21:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8539D21104;
        Mon, 19 Nov 2018 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646662;
        bh=Hn/rF+8AiptKUNpMb27VMJLal1VXwzpqkSUiWYtKYiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YikBH50wjMFvf5gHcxJjmKwkBFY6HbKpQmCz3STvhWhkB5gRmRchCZE65eUdYWyHs
         h4kM/zRsj7TtD4cC90s8ByOuLopyGAf1yZiLAOrRwYnH1ma2u7WnoE9mRYKRgZUZb8
         TDyMWgF7tfRCKHnR0lZRm8/NzcxKZFcLor/vahCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 025/160] pinctrl: qcom: spmi-mpp: Fix err handling of pmic_mpp_set_mux
Date:   Mon, 19 Nov 2018 17:27:44 +0100
Message-Id: <20181119162633.102421466@linuxfoundation.org>
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

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 69f8455f6cc78fa6cdf80d0105d7a748106271dc ]

'ret' should be returned while pmic_mpp_write_mode_ctl fails.

Fixes: 0e948042c420 ("pinctrl: qcom: spmi-mpp: Implement support for sink mode")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -321,6 +321,8 @@ static int pmic_mpp_set_mux(struct pinct
 	pad->function = function;
 
 	ret = pmic_mpp_write_mode_ctl(state, pad);
+	if (ret < 0)
+		return ret;
 
 	val = pad->is_enabled << PMIC_MPP_REG_MASTER_EN_SHIFT;
 


