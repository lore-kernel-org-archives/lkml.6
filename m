Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E660ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A56C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRz4MCNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A56C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeKIHil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbeKIHik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:40 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BBCE20989;
        Thu,  8 Nov 2018 22:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714471;
        bh=dILW/sbXvsEZmGe+SvkkuBt380mdKnZP80QdRcMZ+yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRz4MCNC8y8X40NRJk6usPfvf+vlZ78P2xG4VKpdgqKv66gitrzhS16pNP/AyvkrO
         73PO6igsSjU/ZeJzbuC/d1lvcH/aLUdKbCFt/PnrtFRhP7VEm+3P0auKzkJ4zN8Srw
         cmqjzzdbiBsbdn/usJzQ01vESNZ51LsYgfCDfRFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 078/114] PM / devfreq: tegra: fix error return code in tegra_devfreq_probe()
Date:   Thu,  8 Nov 2018 13:51:33 -0800
Message-Id: <20181108215108.040058182@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
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

[ Upstream commit 9e578b37505018622dfafc40eed7cd78ff2af221 ]

platform_get_irq() returns an error code, but the tegra-devfreq
driver ignores it and always returns -ENODEV. This is not correct,
and prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/devfreq/tegra-devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 848b93ee930f..64a2e02b87d7 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -688,9 +688,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ\n");
-		return -ENODEV;
+	if (irq < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+		return irq;
 	}
 
 	platform_set_drvdata(pdev, tegra);
-- 
2.17.1



