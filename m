Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FABC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A98520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A98520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965124AbeFRIVl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:21:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55354 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965094AbeFRIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:21:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7F295C8D;
        Mon, 18 Jun 2018 08:21:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lijun Ou <oulijun@huawei.com>,
        Yixian Liu <liuyixian@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 133/279] RDMA/hns: Bugfix for init hem table
Date:   Mon, 18 Jun 2018 10:11:58 +0200
Message-Id: <20180618080614.334226341@linuxfoundation.org>
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

[ Upstream commit 215a8c09e5e2aa6ae1fbcef87f8f27d65d5d1ca4 ]

During init hem table, type should be used instead of
table->type which is finally initializaed with type.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -912,7 +912,7 @@ int hns_roce_init_hem_table(struct hns_r
 		obj_per_chunk = buf_chunk_size / obj_size;
 		num_hem = (nobj + obj_per_chunk - 1) / obj_per_chunk;
 		bt_chunk_num = bt_chunk_size / 8;
-		if (table->type >= HEM_TYPE_MTT)
+		if (type >= HEM_TYPE_MTT)
 			num_bt_l0 = bt_chunk_num;
 
 		table->hem = kcalloc(num_hem, sizeof(*table->hem),
@@ -920,7 +920,7 @@ int hns_roce_init_hem_table(struct hns_r
 		if (!table->hem)
 			goto err_kcalloc_hem_buf;
 
-		if (check_whether_bt_num_3(table->type, hop_num)) {
+		if (check_whether_bt_num_3(type, hop_num)) {
 			unsigned long num_bt_l1;
 
 			num_bt_l1 = (num_hem + bt_chunk_num - 1) /
@@ -939,8 +939,8 @@ int hns_roce_init_hem_table(struct hns_r
 				goto err_kcalloc_l1_dma;
 		}
 
-		if (check_whether_bt_num_2(table->type, hop_num) ||
-			check_whether_bt_num_3(table->type, hop_num)) {
+		if (check_whether_bt_num_2(type, hop_num) ||
+			check_whether_bt_num_3(type, hop_num)) {
 			table->bt_l0 = kcalloc(num_bt_l0, sizeof(*table->bt_l0),
 					       GFP_KERNEL);
 			if (!table->bt_l0)


