Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFCDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C959820989
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543246;
	bh=4VkIYvC7imqTb/giYC1SNBh4MwUvoKH0s9iixnVPNG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y9YbRVPZYAxxMCet8dB7J1bdoTi/kn2dGxT4YO+DuCtOhHJiNrCymPQ92RotfLcJS
	 VRvep9kryJJ1051fr5oyKYuq/WJtENjItHzn/cGUL9xjT+d7dGf8Fukijy8CnyXtRc
	 wQxMc+GGBUiWwVJdOZCsEPKC2jUZkRN/HaQ6wQA0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C959820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeLKPrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbeLKPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7A8208E7;
        Tue, 11 Dec 2018 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543243;
        bh=4VkIYvC7imqTb/giYC1SNBh4MwUvoKH0s9iixnVPNG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGP1eRRbB+Qx02sZqRTYTXwnR+HHWW2uQyKXP8Qfqq9Uu33f2awsoWtjTSVPBlrJt
         NPwGkYD3cyUaEOmlscbwWBJ0xuU04butgziroEs9S98D17XWFCsk1YBnaZcWJv6a91
         wb2iNmwfAT1xaSSCJg0m+ScOmja5MrLcHVHxCXoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pan Bian <bianpan2016@163.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 68/91] iommu/vt-d: Use memunmap to free memremap
Date:   Tue, 11 Dec 2018 16:41:27 +0100
Message-Id: <20181211151611.871897810@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 49b266433f4c..7feaa82f8c7c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2977,7 +2977,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			}
 
 			if (old_ce)
-				iounmap(old_ce);
+				memunmap(old_ce);
 
 			ret = 0;
 			if (devfn < 0x80)
-- 
2.19.1



