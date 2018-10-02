Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1504EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7435208E7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7435208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeJBUKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeJBUK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:26 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11347BF0;
        Tue,  2 Oct 2018 13:27:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 007/228] net: hns3: Fix for mailbox message truncated problem
Date:   Tue,  2 Oct 2018 06:21:44 -0700
Message-Id: <20181002132459.540941518@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Fuyun Liang <liangfuyun1@huawei.com>

[ Upstream commit ead5bd4d35c0a14d5ce1474177718c678dff5205 ]

The payload of mailbox message is 16 byte and the value of
HCLGE_MBX_MAX_ARQ_MSG_SIZE is 8. A message truncated problem will
happen when mailbox message is converted to ARQ message. This patch
replaces HCLGE_MBX_MAX_ARQ_MSG_SIZE with the size of ARQ message in
hclgevf_mbx_handler to fix this problem.

Fixes: b11a0bb231f3 ("net: hns3: Add mailbox support to VF driver")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -208,7 +208,8 @@ void hclgevf_mbx_handler(struct hclgevf_
 
 			/* tail the async message in arq */
 			msg_q = hdev->arq.msg_q[hdev->arq.tail];
-			memcpy(&msg_q[0], req->msg, HCLGE_MBX_MAX_ARQ_MSG_SIZE);
+			memcpy(&msg_q[0], req->msg,
+			       HCLGE_MBX_MAX_ARQ_MSG_SIZE * sizeof(u16));
 			hclge_mbx_tail_ptr_move_arq(hdev->arq);
 			hdev->arq.count++;
 


