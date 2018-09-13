Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17664C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D030020854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D030020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeIMSxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:53:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbeIMSxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:53:43 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 04C18CF3;
        Thu, 13 Sep 2018 13:44:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gal Pressman <pressmangal@gmail.com>,
        Lijun Ou <oulijun@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 045/115] RDMA/hns: Fix usage of bitmap allocation functions return values
Date:   Thu, 13 Sep 2018 15:31:05 +0200
Message-Id: <20180913131826.446265077@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <pressmangal@gmail.com>

[ Upstream commit a1ceeca679dccc492235f0f629d9e9f7b3d51ca8 ]

hns bitmap allocation functions return 0 on success and -1 on failure.
Callers of these functions wrongly used their return value as an errno,
fix that by making a proper conversion.

Fixes: a598c6f4c5a8 ("IB/hns: Simplify function of pd alloc and qp alloc")
Signed-off-by: Gal Pressman <pressmangal@gmail.com>
Acked-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hns/hns_roce_pd.c |    2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -35,7 +35,7 @@
 
 static int hns_roce_pd_alloc(struct hns_roce_dev *hr_dev, unsigned long *pdn)
 {
-	return hns_roce_bitmap_alloc(&hr_dev->pd_bitmap, pdn);
+	return hns_roce_bitmap_alloc(&hr_dev->pd_bitmap, pdn) ? -ENOMEM : 0;
 }
 
 static void hns_roce_pd_free(struct hns_roce_dev *hr_dev, unsigned long pdn)
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -114,7 +114,10 @@ static int hns_roce_reserve_range_qp(str
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 
-	return hns_roce_bitmap_alloc_range(&qp_table->bitmap, cnt, align, base);
+	return hns_roce_bitmap_alloc_range(&qp_table->bitmap, cnt, align,
+					   base) ?
+		       -ENOMEM :
+		       0;
 }
 
 enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state)


