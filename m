Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9B2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B902089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4WpG7Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B902089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbeKZV44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729988AbeKZV4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 874F221104;
        Mon, 26 Nov 2018 11:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230190;
        bh=WDxLKkJOF8dZGrBJiDADD2o/JBzESaf1M5njdA6zuEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4WpG7ZePU/woHetU67PFZ+VZwC8OTv2qOuw4VcTstuOSurAi9bCUoIRvAA2FeDdE
         QyR+m93RP/BpU2A95bjyJ0zu7Q+pXL7D5aONZhRKVyYPzo6a6ysIpAVGrgAiPucqpL
         RudIY/9NR3aE3Yy4UsMEmg+SjnvWNdp8xhudBc6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 008/118] net: hns3: bugfix for rtnl_locks range in the hclge_reset()
Date:   Mon, 26 Nov 2018 11:50:02 +0100
Message-Id: <20181126105100.175086821@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a963052e539887df481d4d3a6ad4c92ca6461852 ]

Since hclge_reset_wait() is used to wait for the hardware to complete
the reset, it is not necessary to hold the rtnl_lock during
hclge_reset_wait(). So this patch releases the lock for the duration
of hclge_reset_wait().

Fixes: 6d4fab39533f ("net: hns3: Reset net device with rtnl_lock")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index db763450e5e3..340baf6a470c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2804,14 +2804,17 @@ static void hclge_reset(struct hclge_dev *hdev)
 	handle = &hdev->vport[0].nic;
 	rtnl_lock();
 	hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
+	rtnl_unlock();
 
 	if (!hclge_reset_wait(hdev)) {
+		rtnl_lock();
 		hclge_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 		hclge_reset_ae_dev(hdev->ae_dev);
 		hclge_notify_client(hdev, HNAE3_INIT_CLIENT);
 
 		hclge_clear_reset_cause(hdev);
 	} else {
+		rtnl_lock();
 		/* schedule again to check pending resets later */
 		set_bit(hdev->reset_type, &hdev->reset_pending);
 		hclge_reset_task_schedule(hdev);
-- 
2.17.1



