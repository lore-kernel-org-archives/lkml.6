Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70878C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E8720989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXzAynt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E8720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeK2RIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbeK2RIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:08:45 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B2120868;
        Thu, 29 Nov 2018 06:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471474;
        bh=wqxFmSmYAQRxjED9FBHuu8sSN9zVd/Y3uFhSyJTyY3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXzAynt50EdYPrA6YncLIw8CkFRzu8resWkY8EcbIZ/1M+ZYhYYmENRLIpHXdIVKC
         K7Rm3rRaDYqVunAtqDvYMrKzbrRi1+5QFmuHkYgg+28ZXwIdfGw+7LSV3u75qWxLU7
         4IYeIaUNVI2NC7sVvdqb/LKVkse1w87rdFNAdyfc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.9 16/18] iommu/vt-d: Use memunmap to free memremap
Date:   Thu, 29 Nov 2018 01:03:28 -0500
Message-Id: <20181129060331.160224-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060331.160224-1-sashal@kernel.org>
References: <20181129060331.160224-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 829383e183728dec7ed9150b949cd6de64127809 ]

memunmap() should be used to free the return of memremap(), not
iounmap().

Fixes: dfddb969edf0 ('iommu/vt-d: Switch from ioremap_cache to memremap')
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2558a381e118..f8c8537f0587 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3054,7 +3054,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			}
 
 			if (old_ce)
-				iounmap(old_ce);
+				memunmap(old_ce);
 
 			ret = 0;
 			if (devfn < 0x80)
-- 
2.17.1

