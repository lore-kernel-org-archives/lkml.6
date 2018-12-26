Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AB7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1D521908
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863831;
	bh=Xz9TKh4Z+/RUeuNiezi9P2Dc177HnmBy+5XwvRqAokk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LG4AmIhYbuhVSY93e966NKj/LC9AOFRVlCeiqJf/3oCPwz9x4jvNOWYsJUridhjdb
	 VKT4K6MtWV5oIY61GEH9pC8LHhlUUBFv5RBwHvhZz1dzvgBOt1K7FmBgAebfCcuy+D
	 u3qUfOt5OGEP7daph/bmoUmRrCmTo9l0IzeN9mf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeLZWhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbeLZWhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35F2218FC;
        Wed, 26 Dec 2018 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863824;
        bh=Xz9TKh4Z+/RUeuNiezi9P2Dc177HnmBy+5XwvRqAokk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UpqACwTRKec63qoGGY9tkeZuV/fpCokp+Yhljv9WIbzcQjTFu4Pj5Ht7rZ7L+pPpY
         4xY8sNXRZSiA4kUdrl0cNwix1NNwXqrzNnopzY2dCNSKXBRC25K8qaMnh3Y3F20BUj
         mgB26l7rf37OZzjSzjTGVj8P+4KD66dd2Wrley/I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 41/97] scsi: target: iscsi: cxgbit: fix csk leak
Date:   Wed, 26 Dec 2018 17:35:01 -0500
Message-Id: <20181226223557.149329-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
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
index 8de16016b6de..b289b90ae6dc 100644
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
@@ -1190,7 +1193,7 @@ cxgbit_pass_accept_rpl(struct cxgbit_sock *csk, struct cpl_pass_accept_req *req)
 	rpl5->opt0 = cpu_to_be64(opt0);
 	rpl5->opt2 = cpu_to_be32(opt2);
 	set_wr_txq(skb, CPL_PRIORITY_SETUP, csk->ctrlq_idx);
-	t4_set_arp_err_handler(skb, NULL, cxgbit_arp_failure_discard);
+	t4_set_arp_err_handler(skb, csk, cxgbit_arp_failure_discard);
 	cxgbit_l2t_send(csk->com.cdev, skb, csk->l2t);
 }
 
-- 
2.19.1

