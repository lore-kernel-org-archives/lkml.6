Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12173ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD66B20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2EGee7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD66B20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeKAIG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbeKAIG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D2F208A3;
        Wed, 31 Oct 2018 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027206;
        bh=QGXDVHmPstaaUpqNSPdLWRkqUfefjoSwEmGB+NG8ctY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z2EGee7HIZSusImg6X9rAQLOEO6xa3SNjbfIeWDgrIseIkmDhatB3roxQCusAVnTQ
         KcRM+1p6V2AWgfQHlt8YAiUpzvltqFelCInNDopA8pbinbzoCzfYmJ3ocmbRPgOb7B
         0HTxCOg2x3BMmEiaCbnoHKe9oOJWt87mUAjdV+vE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 069/146] net: hns3: Preserve vlan 0 in hardware table
Date:   Wed, 31 Oct 2018 19:04:24 -0400
Message-Id: <20181031230541.28822-69-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

[ Upstream commit daaa8521760ee4d4e65f309c4c37b3a1e58c9d4e ]

When netdev is down, the stack will delete the vlan from
hardware including vlan0, which will cause problem when
doing loopback selftest when netdev is down.

This patch fixes it by always preserving vlan 0 in hardware,
because vlan 0 is defalut vlan, which should always be in
hardware.

Fixes: c39c4d98dc65 ("net: hns3: Add mac loopback selftest support in hns3 driver")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index dd1e390ed68e..2d58726893f4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4739,6 +4739,9 @@ static int hclge_set_vlan_filter_hw(struct hclge_dev *hdev, __be16 proto,
 	u16 vport_idx, vport_num = 0;
 	int ret;
 
+	if (is_kill && !vlan_id)
+		return 0;
+
 	ret = hclge_set_vf_vlan_common(hdev, vport_id, is_kill, vlan_id,
 				       0, proto);
 	if (ret) {
-- 
2.17.1

