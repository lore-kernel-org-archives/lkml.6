Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00FAC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE0820665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYTONtTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE0820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbeJYWzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731424AbeJYWyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:12 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 368B5208A3;
        Thu, 25 Oct 2018 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477274;
        bh=plAOqDmWlF7LJqEBRBTkkraJ5ziieA5Oh382i/xO0TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYTONtTJLXgBuJVOeNb9LFACGZqgOQIbVHDNE6Hn6AaI18JKyh9tnip+nuHsJGKuT
         osgeqzik1SQw95hr24o7QZZb2XXGhXDFZBYrLp65xXN5JIKHN9vzthL9pVZ5I+ND5G
         KaCFrAXZaxpovsf8oSag7w0C+nIZBiZd8ZzTbWo0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 90/98] sctp: translate network order to host order when users get a hmacid
Date:   Thu, 25 Oct 2018 10:18:45 -0400
Message-Id: <20181025141853.214051-90-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 7a84bd46647ff181eb2659fdc99590e6f16e501d ]

Commit ed5a377d87dc ("sctp: translate host order to network order when
setting a hmacid") corrected the hmacid byte-order when setting a hmacid.
but the same issue also exists on getting a hmacid.

We fix it by changing hmacids to host order when users get them with
getsockopt.

Fixes: Commit ed5a377d87dc ("sctp: translate host order to network order when setting a hmacid")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/socket.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 13693d0adeaf..5c16d0e13987 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5607,6 +5607,7 @@ static int sctp_getsockopt_hmac_ident(struct sock *sk, int len,
 	struct sctp_hmac_algo_param *hmacs;
 	__u16 data_len = 0;
 	u32 num_idents;
+	int i;
 
 	if (!ep->auth_enable)
 		return -EACCES;
@@ -5624,8 +5625,12 @@ static int sctp_getsockopt_hmac_ident(struct sock *sk, int len,
 		return -EFAULT;
 	if (put_user(num_idents, &p->shmac_num_idents))
 		return -EFAULT;
-	if (copy_to_user(p->shmac_idents, hmacs->hmac_ids, data_len))
-		return -EFAULT;
+	for (i = 0; i < num_idents; i++) {
+		__u16 hmacid = ntohs(hmacs->hmac_ids[i]);
+
+		if (copy_to_user(&p->shmac_idents[i], &hmacid, sizeof(__u16)))
+			return -EFAULT;
+	}
 	return 0;
 }
 
-- 
2.17.1

