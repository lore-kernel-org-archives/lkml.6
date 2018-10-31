Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCDAECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63BE2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGJ80Xzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63BE2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeKAIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbeKAIGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02CE120821;
        Wed, 31 Oct 2018 23:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027188;
        bh=0piVUUi+GSA2xIrRVmtZzaCTB2jy4xFi6NYBGTQCSic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGJ80Xzf+MUMDHnijjkdTWn4cUKVXCtY8e7JJJ7CMtXzVHzHnRFidZ2CXwsm4mvl+
         suoxERpW6aAXFegd57gOciyKAg/kF8rtAdrlvHo5ZRT+qv88eC202y80Jm+WfYwqwo
         vuaxhVn2+o75UQ5+eBKQ6lx+Neb1c9wPQ8I/mZpc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 051/146] net: hns3: Fix ets validate issue
Date:   Wed, 31 Oct 2018 19:04:06 -0400
Message-Id: <20181031230541.28822-51-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
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
index f08ebb7caaaf..92f19384e258 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -73,6 +73,7 @@ static int hclge_ieee_getets(struct hnae3_handle *h, struct ieee_ets *ets)
 static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 			      u8 *tc, bool *changed)
 {
+	bool has_ets_tc = false;
 	u32 total_ets_bw = 0;
 	u8 max_tc = 0;
 	u8 i;
@@ -100,13 +101,14 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
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

