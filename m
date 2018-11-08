Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5FCECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740B8208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1JEhC4ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740B8208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbeKIHgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbeKIHgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:42 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276DC20892;
        Thu,  8 Nov 2018 21:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714354;
        bh=r6TjTBKneVH4Di0AwvHYGxdwyFcS3VS5d4L5kNhbucg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1JEhC4axKKsq45MX17BDasqRKBO8af3luRcBbrebLNL8I9rcEL+0qB/U1qYt92ReN
         aWrW+Fiut8iIC94G5pC+omt+pCULqWLfzvUBNuRA8bd8bvvVyPz2bEC6fGeI8/BIMO
         BHZRuAIjWYUaylJHSpavvgGBmi09uz/tLyTmYCq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mateusz Jurczyk <mjurczyk@google.com>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 028/114] af_iucv: Move sockaddr length checks to before accessing sa_family in bind and connect handlers
Date:   Thu,  8 Nov 2018 13:50:43 -0800
Message-Id: <20181108215101.652628608@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e3c42b61ff813921ba58cfc0019e3fd63f651190 ]

Verify that the caller-provided sockaddr structure is large enough to
contain the sa_family field, before accessing it in bind() and connect()
handlers of the AF_IUCV socket. Since neither syscall enforces a minimum
size of the corresponding memory region, very short sockaddrs (zero or
one byte long) result in operating on uninitialized memory while
referencing .sa_family.

Fixes: 52a82e23b9f2 ("af_iucv: Validate socket address length in iucv_sock_bind()")
Signed-off-by: Mateusz Jurczyk <mjurczyk@google.com>
[jwi: removed unneeded null-check for addr]
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/iucv/af_iucv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index aeffb65181f5..5984cc35d508 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -705,10 +705,8 @@ static int iucv_sock_bind(struct socket *sock, struct sockaddr *addr,
 	char uid[9];
 
 	/* Verify the input sockaddr */
-	if (!addr || addr->sa_family != AF_IUCV)
-		return -EINVAL;
-
-	if (addr_len < sizeof(struct sockaddr_iucv))
+	if (addr_len < sizeof(struct sockaddr_iucv) ||
+	    addr->sa_family != AF_IUCV)
 		return -EINVAL;
 
 	lock_sock(sk);
@@ -852,7 +850,7 @@ static int iucv_sock_connect(struct socket *sock, struct sockaddr *addr,
 	struct iucv_sock *iucv = iucv_sk(sk);
 	int err;
 
-	if (addr->sa_family != AF_IUCV || alen < sizeof(struct sockaddr_iucv))
+	if (alen < sizeof(struct sockaddr_iucv) || addr->sa_family != AF_IUCV)
 		return -EINVAL;
 
 	if (sk->sk_state != IUCV_OPEN && sk->sk_state != IUCV_BOUND)
-- 
2.17.1



