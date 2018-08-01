Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593AD20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593AD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436578AbeHAT0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:26:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52908 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390540AbeHATSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C28C8E9E;
        Wed,  1 Aug 2018 16:54:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xi Wang <wangxi11@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 038/336] net: hns3: Fix for VF mailbox cannot receiving PF response
Date:   Wed,  1 Aug 2018 18:46:13 +0200
Message-Id: <20180801165030.541265459@linuxfoundation.org>
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

From: Xi Wang <wangxi11@huawei.com>

[ Upstream commit 1819e40908ee76c7219287224c22c772556c927e ]

When the VF frequently switches the CMDQ interrupt, if the CMDQ_SRC is not
cleared, the VF will not receive the new PF response after the interrupt
is re-enabled, the corresponding log is as follows:

[  317.482222] hns3 0000:00:03.0: VF could not get mbx resp(=0) from PF
in 500 tries
[  317.483137] hns3 0000:00:03.0: VF request to get tqp info from PF
failed -5

This patch fixes this problem by clearing CMDQ_SRC before enabling
interrupt and syncing pending IRQ handlers after disabling interrupt.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1441,6 +1441,8 @@ static int hclgevf_misc_irq_init(struct
 		return ret;
 	}
 
+	hclgevf_clear_event_cause(hdev, 0);
+
 	/* enable misc. vector(vector 0) */
 	hclgevf_enable_vector(&hdev->misc_vector, true);
 
@@ -1451,6 +1453,7 @@ static void hclgevf_misc_irq_uninit(stru
 {
 	/* disable misc vector(vector 0) */
 	hclgevf_enable_vector(&hdev->misc_vector, false);
+	synchronize_irq(hdev->misc_vector.vector_irq);
 	free_irq(hdev->misc_vector.vector_irq, hdev);
 	hclgevf_free_vector(hdev, 0);
 }


