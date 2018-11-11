Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DCDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE7C2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aosE7XMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE7C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbeKLIUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388233AbeKLIUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:02 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1135E21582;
        Sun, 11 Nov 2018 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975406;
        bh=qfzgGE859GfZtkq445Ydla4pV127+Ot5irpgaYackGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aosE7XMB/FUZB5iunPVrsXPMJ/BkuQNOBolKYtMFRYhf63RswxIIGYftlhqGTeR3x
         Ci2l+dGCq+xyJ+Igb4b4Xlt/e+cSLNDhH4QrVw8G6sCDZ+CpIjfvH7oiyCPfpXG7w9
         B9Yaz9S1x+R76DWQH3xMAemqzQi2VVtt7ptAAfII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fuyun Liang <liangfuyun1@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 109/350] net: hns3: Set STATE_DOWN bit of hdev state when stopping net
Date:   Sun, 11 Nov 2018 14:19:33 -0800
Message-Id: <20181111221711.652332759@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

[ Upstream commit 2f7e489611bc685b8e00aba436032a8aac6cac57 ]

We clear STATE_DOWN bit of hdev state when starting net, but do not set
it again when stopping net. It causes that the net is down, but hdev state
is still up. STATE_DOWN bit of hdev state should be set when stopping net.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility Layer) Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |    2 ++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |    2 ++
 2 files changed, 4 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3794,6 +3794,8 @@ static void hclge_ae_stop(struct hnae3_h
 	struct hclge_dev *hdev = vport->back;
 	int i;
 
+	set_bit(HCLGE_STATE_DOWN, &hdev->state);
+
 	del_timer_sync(&hdev->service_timer);
 	cancel_work_sync(&hdev->service_task);
 	clear_bit(HCLGE_STATE_SERVICE_SCHED, &hdev->state);
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1442,6 +1442,8 @@ static void hclgevf_ae_stop(struct hnae3
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	int i, queue_id;
 
+	set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
+
 	for (i = 0; i < hdev->num_tqps; i++) {
 		/* Ring disable */
 		queue_id = hclgevf_get_queue_id(handle->kinfo.tqp[i]);


