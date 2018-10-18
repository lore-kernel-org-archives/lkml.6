Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780C2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FD321476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2PJJokxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FD321476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeJSCBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbeJSCBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:01:09 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1AF321473;
        Thu, 18 Oct 2018 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885544;
        bh=zutqkF59nIVYBOTXf60RRb6y5wwy2F/x5ib8mK1rcPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2PJJokxdsD9Z0OIy6cB5htli8DP3Oct8d7qp4k+w3+2+m318gPHcF4I1N5BHEQoFg
         TrmWvIiPNO31P/qnWIzLGuP+uAmVzEDGIaLB7CLK/d2yudN98F8L7eHN5DAjeWL0FH
         W6W8a2evR/FiJAFismprHBEoVGVEZsxgf2+k+OKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 43/53] iommu/rockchip: Free irqs in shutdown handler
Date:   Thu, 18 Oct 2018 19:54:36 +0200
Message-Id: <20181018175423.843074215@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit 74bc2abca7603c956d1e331e8b9bee7b874c1eec ]

In the iommu's shutdown handler we disable runtime-pm which could
result in the irq-handler running unclocked and since commit
    3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
we warn about that fact.

This can cause warnings on shutdown on some Rockchip machines, so
free the irqs in the shutdown handler before we disable runtime-pm.

Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Fixes: 3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/rockchip-iommu.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1242,6 +1242,12 @@ err_unprepare_clocks:
 
 static void rk_iommu_shutdown(struct platform_device *pdev)
 {
+	struct rk_iommu *iommu = platform_get_drvdata(pdev);
+	int i = 0, irq;
+
+	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO)
+		devm_free_irq(iommu->dev, irq, iommu);
+
 	pm_runtime_force_suspend(&pdev->dev);
 }
 


