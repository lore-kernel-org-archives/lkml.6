Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5ABC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C46B2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="suj0NKw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C46B2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbeKAIJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbeKAIJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F78520664;
        Wed, 31 Oct 2018 23:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027333;
        bh=8lncVG6UAdim9FMmjioF7wLPI/84ZQCscFAnKFpCAFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=suj0NKw15vw7sRK5uu1B553iR6Ks02H10KYaOGIDck396VlJiTqCZXIz4IAQA7C+c
         nnBuIxFW7zEwZE8/VTsa95ek4ccNusuI1a3EaW16KpoaPd1Y/7fSQtohBZidPfBNbU
         f2b2kyOi3MFXBN9cEdlDRcZ7NyaQEEW7/wQwnLm8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 063/126] net: hns3: Fix for vf vlan delete failed problem
Date:   Wed, 31 Oct 2018 19:06:51 -0400
Message-Id: <20181031230754.29029-63-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit 41dafea2af781d8e3ab8626d236b52e4172905a3 ]

There are only 128 entries in vf vlan table, if user has added
more than 128 vlan, fw will ignore it and disable the vf vlan
table. So when user deletes the vlan entry that has not been
set to vf vlan table, fw will return not found result and driver
treat that as error, which will cause vlan delete failed problem.

This patch fixes it by returning ok when fw returns not found
result.

Fixes: 6c251711b37f ("net: hns3: Disable vf vlan filter when vf vlan table is full")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 867f27106a02..9f2bea64c522 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4686,9 +4686,17 @@ static int hclge_set_vf_vlan_common(struct hclge_dev *hdev, int vfid,
 			"Add vf vlan filter fail, ret =%d.\n",
 			req0->resp_code);
 	} else {
+#define HCLGE_VF_VLAN_DEL_NO_FOUND	1
 		if (!req0->resp_code)
 			return 0;
 
+		if (req0->resp_code == HCLGE_VF_VLAN_DEL_NO_FOUND) {
+			dev_warn(&hdev->pdev->dev,
+				 "vlan %d filter is not in vf vlan table\n",
+				 vlan);
+			return 0;
+		}
+
 		dev_err(&hdev->pdev->dev,
 			"Kill vf vlan filter fail, ret =%d.\n",
 			req0->resp_code);
-- 
2.17.1

