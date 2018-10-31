Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D64ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D752320847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+ZNmOH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D752320847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbeKAIIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbeKAIIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 577432081B;
        Wed, 31 Oct 2018 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027314;
        bh=XN53/lWZa39s9dQIpYDFSx1T/RxiXKXB7/udPg8hAkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+ZNmOH2gNTgWSy9BJfAlr4SW8mLl4CF2zw8Naszk+Ags3lbbmbniyYFGlL1l7nMm
         ebrMXNMLPh8Chn/YzCQZEeUoM/0pKPVoYYhp7qsMMbutMry8PZwJ97I5u6ec5RxMpr
         ZOc5373M3khby4kisx6zUw7qjFK+7ex2homwWZDo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 043/126] net: hns3: Fix ets validate issue
Date:   Wed, 31 Oct 2018 19:06:31 -0400
Message-Id: <20181031230754.29029-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit adefc0a2ff465f4ac4a88450fe69d336c8b074c5 ]

There is a defect in hclge_ets_validate(). If each member of tc_tsa is
not IEEE_8021QAZ_TSA_ETS, the variable total_ets_bw won't be updated.
In this case, the check for value of total_ets_bw will fail. This patch
fixes it by checking total_ets_bw only after it has been updated.

Fixes: cacde272dd00 ("net: hns3: Add hclge_dcb module for the support of DCB feature")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 955f0e3d5c95..b4c0597a392d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -79,6 +79,7 @@ static int hclge_ieee_getets(struct hnae3_handle *h, struct ieee_ets *ets)
 static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 			      u8 *tc, bool *changed)
 {
+	bool has_ets_tc = false;
 	u32 total_ets_bw = 0;
 	u8 max_tc = 0;
 	u8 i;
@@ -106,13 +107,14 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 				*changed = true;
 
 			total_ets_bw += ets->tc_tx_bw[i];
-		break;
+			has_ets_tc = true;
+			break;
 		default:
 			return -EINVAL;
 		}
 	}
 
-	if (total_ets_bw != BW_PERCENT)
+	if (has_ets_tc && total_ets_bw != BW_PERCENT)
 		return -EINVAL;
 
 	*tc = max_tc + 1;
-- 
2.17.1

