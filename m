Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6C8C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240DE2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079130;
	bh=uFAuhtd/f0/7ZyXjvSieWlZnKOhJ7igsY2fIp42nKHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KdWXukvfrvh54EJe2MTfyLI7kLU1H4o8HbztbiLWVaQQqiO1hQkB9p1u0Pc914ff4
	 xKYmfPQKcOX4FOuUdV6ad/iv2/zu89dGQykIMVKTCFqTjTr1qm56mvPZOkhOP+l44o
	 OdTt/+BpIFpjkxg9aHvBAzJ+OuOVhbiWDt0n+LNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfAUN6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbfAUN6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:58:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C509A2087F;
        Mon, 21 Jan 2019 13:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079123;
        bh=uFAuhtd/f0/7ZyXjvSieWlZnKOhJ7igsY2fIp42nKHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bml+AUlBp90AvqFQ1+HfK9NqUSddwCSfsDFX1EjDtWZgGTMlEL73AzSbBnDWHhdDz
         CxbMsFAyHk+q/rrl/TOEvWaDCqRDyGmsP25O8ST6UC7f49kHDiFWXu3iAzZVtr+k8y
         zeSlgr8/arvDz3UUqT5G76mku4PRvyVxaGD7Iu5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 17/99] scsi: target: iscsi: cxgbit: fix csk leak - 2
Date:   Mon, 21 Jan 2019 14:48:09 +0100
Message-Id: <20190121134914.573332050@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ed076c55b359cc9982ca8b065bcc01675f7365f6 ]

In case of arp failure call cxgbit_put_csk() to free csk.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 71888b979ab5..b19c960d5490 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -641,8 +641,11 @@ static void cxgbit_send_halfclose(struct cxgbit_sock *csk)
 
 static void cxgbit_arp_failure_discard(void *handle, struct sk_buff *skb)
 {
+	struct cxgbit_sock *csk = handle;
+
 	pr_debug("%s cxgbit_device %p\n", __func__, handle);
 	kfree_skb(skb);
+	cxgbit_put_csk(csk);
 }
 
 static void cxgbit_abort_arp_failure(void *handle, struct sk_buff *skb)
@@ -1206,7 +1209,7 @@ cxgbit_pass_accept_rpl(struct cxgbit_sock *csk, struct cpl_pass_accept_req *req)
 	rpl5->opt0 = cpu_to_be64(opt0);
 	rpl5->opt2 = cpu_to_be32(opt2);
 	set_wr_txq(skb, CPL_PRIORITY_SETUP, csk->ctrlq_idx);
-	t4_set_arp_err_handler(skb, NULL, cxgbit_arp_failure_discard);
+	t4_set_arp_err_handler(skb, csk, cxgbit_arp_failure_discard);
 	cxgbit_l2t_send(csk->com.cdev, skb, csk->l2t);
 }
 
-- 
2.19.1



