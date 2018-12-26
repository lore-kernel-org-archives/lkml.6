Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E897C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B36218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864044;
	bh=zQBnGdIZKVh6Bxtc3XZ/F3JNsuzA2RJRWr5ghRnaVq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YP8cwJsFY48A2BVCMLWcZyZoUl34t3mP3cZ1AvevW8Qa4yR+pL7/7lrDouuULCG2F
	 MBZNh3USRzFcDy1NPRRFDkinaGc/+tF6W97xHn9d7lMkxm5uhzEIngcwNFX37A2feU
	 3FFNU9ag9rM6Y5FwAJcQzbi0jPHtrljLmYyeMaik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeLZWkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbeLZWkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3BF521741;
        Wed, 26 Dec 2018 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864039;
        bh=zQBnGdIZKVh6Bxtc3XZ/F3JNsuzA2RJRWr5ghRnaVq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGJeoxiEq/tXCYuWemhuaiCc/O9ULxVmWihB0cV7NxAe4Uq/UTdvN01vgx9Cr2huO
         M999t0BEfNXMu8BIxuIPL/0UuH0MaybZc0BFjoRnBCoxt6DzxWztXH8HqXDA5DPNO+
         yXtC2SRymxE2TN9PW0gajGPv36NQjnPis0WPTWjs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 27/59] scsi: target: iscsi: cxgbit: fix csk leak
Date:   Wed, 26 Dec 2018 17:38:07 -0500
Message-Id: <20181226223839.150262-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit 801df68d617e3cb831f531c99fa6003620e6b343 ]

csk leak can happen if a new TCP connection gets established after
cxgbit_accept_np() returns, to fix this leak free remaining csk in
cxgbit_free_np().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index d4fa41be80f9..0c00bb27c9c5 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -631,8 +631,11 @@ static void cxgbit_send_halfclose(struct cxgbit_sock *csk)
 
 static void cxgbit_arp_failure_discard(void *handle, struct sk_buff *skb)
 {
+	struct cxgbit_sock *csk = handle;
+
 	pr_debug("%s cxgbit_device %p\n", __func__, handle);
 	kfree_skb(skb);
+	cxgbit_put_csk(csk);
 }
 
 static void cxgbit_abort_arp_failure(void *handle, struct sk_buff *skb)
@@ -1147,7 +1150,7 @@ cxgbit_pass_accept_rpl(struct cxgbit_sock *csk, struct cpl_pass_accept_req *req)
 	rpl5->opt0 = cpu_to_be64(opt0);
 	rpl5->opt2 = cpu_to_be32(opt2);
 	set_wr_txq(skb, CPL_PRIORITY_SETUP, csk->ctrlq_idx);
-	t4_set_arp_err_handler(skb, NULL, cxgbit_arp_failure_discard);
+	t4_set_arp_err_handler(skb, csk, cxgbit_arp_failure_discard);
 	cxgbit_l2t_send(csk->com.cdev, skb, csk->l2t);
 }
 
-- 
2.19.1

