Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25DBECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C494208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sf+C+gzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C494208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbeKIHeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbeKIHeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:14 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59AE4208E3;
        Thu,  8 Nov 2018 21:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714206;
        bh=oE9ykIj7bq9CjfPaS0P3Ugq6Y3jHj8HmoxOmwYY4iVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sf+C+gzytlQ0iBSquKKvZsCLHpKXiWhjAfQlyjsbPOYmE4LJ23H0u4q5HCiliRNqZ
         nYqYYYRQY/X96JsK5wBIS/NsfEffi+AwEs0Ct8/KjVVKFCRazALdgWHlYgnc4JPCAg
         //1BDpv8A+2nWO+9+LxViL7YAQtXC/7PMuTr708A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 118/144] sctp: translate network order to host order when users get a hmacid
Date:   Thu,  8 Nov 2018 13:51:29 -0800
Message-Id: <20181108215106.555350281@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



