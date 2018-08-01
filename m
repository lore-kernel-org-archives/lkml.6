Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C8FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396D12083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396D12083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404553AbeHATDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:03:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404460AbeHATDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:40 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4873BFA8;
        Wed,  1 Aug 2018 16:57:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lijun Ou <oulijun@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 100/336] net: hns3: Fixes initalization of RoCE handle and makes it conditional
Date:   Wed,  1 Aug 2018 18:47:15 +0200
Message-Id: <20180801165032.990718565@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit 544a7bcd5cc74734003cf7f12502b26cebfed19f ]

When register a RoCE client with hnae3vf device, it needs to judge
the device whether support RoCE vf function. Otherwise, it will
lead to calltrace when RoCE is not support vf function and remove
roce device.

The calltrace as follows:
[   93.156614] Unable to handle kernel NULL pointer dereference at virtual address 00000015
 <SNIP>
[   93.278784] Call trace:
[   93.278788]  hnae3_match_n_instantiate+0x24/0xd8 [hnae3]
[   93.278790]  hnae3_register_client+0xcc/0x150 [hnae3]
[   93.278801]  hns_roce_hw_v2_init+0x18/0x1000 [hns_roce_hw_v2]
[   93.278805]  do_one_initcall+0x58/0x160
[   93.278807]  do_init_module+0x64/0x1d8
[   93.278809]  load_module+0x135c/0x15c8
[   93.278811]  SyS_finit_module+0x100/0x118
[   93.278816]  __sys_trace_return+0x0/0x4
[   93.278827] Code: aa0003f5 12001c56 aa1e03e0 d503201f (b9402660)

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Reported-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1493,10 +1493,12 @@ static int hclgevf_init_instance(struct
 			return ret;
 		break;
 	case HNAE3_CLIENT_ROCE:
-		hdev->roce_client = client;
-		hdev->roce.client = client;
+		if (hnae3_dev_roce_supported(hdev)) {
+			hdev->roce_client = client;
+			hdev->roce.client = client;
+		}
 
-		if (hdev->roce_client && hnae3_dev_roce_supported(hdev)) {
+		if (hdev->roce_client && hdev->nic_client) {
 			ret = hclgevf_init_roce_base_info(hdev);
 			if (ret)
 				return ret;


