Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C083C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C05208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C05208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935868AbeFRIWr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:22:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935849AbeFRIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:43 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CCD19C94;
        Mon, 18 Jun 2018 08:22:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 135/279] RDMA/hns: Fix the qp context state diagram
Date:   Mon, 18 Jun 2018 10:12:00 +0200
Message-Id: <20180618080614.424727362@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: oulijun <oulijun@huawei.com>

[ Upstream commit 6e1a70943cecdca9bb13b601b1a9772a7bdcc2c3 ]

According to RoCE protocol, it is possible to
transition from error to error state for modifying
qp in hip08. This patch fix it.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3166,7 +3166,8 @@ static int hns_roce_v2_modify_qp(struct
 		   (cur_state == IB_QPS_RTR && new_state == IB_QPS_ERR) ||
 		   (cur_state == IB_QPS_RTS && new_state == IB_QPS_ERR) ||
 		   (cur_state == IB_QPS_SQD && new_state == IB_QPS_ERR) ||
-		   (cur_state == IB_QPS_SQE && new_state == IB_QPS_ERR)) {
+		   (cur_state == IB_QPS_SQE && new_state == IB_QPS_ERR) ||
+		   (cur_state == IB_QPS_ERR && new_state == IB_QPS_ERR)) {
 		/* Nothing */
 		;
 	} else {


