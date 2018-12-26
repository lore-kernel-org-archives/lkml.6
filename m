Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E272C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D7620651
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863840;
	bh=7dPR5oAcH9RrDmzf/4NdRoQWLPdqz69+annDkq4g8D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SYN+Gv28/8z/5hWvaC7dzTe9nlEmRvrZeTAuNGGhsY0eStin8mxhUDSjsv0LWwdxQ
	 2PdswNDbfoSDDOMFvT9Tn/loX7M8xS/xkV5sn/uvWBq5TLs+C9XhwXj3vnGnqd658U
	 6cgUg9po6yngUIJMC8kY9dMR7+D+XFLCGHzmXtWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbeLZWhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:37:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbeLZWhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF44520651;
        Wed, 26 Dec 2018 22:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863834;
        bh=7dPR5oAcH9RrDmzf/4NdRoQWLPdqz69+annDkq4g8D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAW1mZhLuIEkaNdjiubiwmiH7OybfbNWGkPev/rHffjVOHEGFvvbBqeFOeioggivP
         DIjmBaoGrVC0zS4UyXzeclKql5gmGX2pGVMYJ88epqkJxIQcUeAZAp25bSTSw5ylSr
         Bjf/ZTDJVfcmHT/k7/6nkyzFucnWs14Gk55HFeRc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Atul Gupta <atul.gupta@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 49/97] net/tls: Init routines in create_ctx
Date:   Wed, 26 Dec 2018 17:35:09 -0500
Message-Id: <20181226223557.149329-49-sashal@kernel.org>
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

From: Atul Gupta <atul.gupta@chelsio.com>

[ Upstream commit 6c0563e442528733219afe15c749eb2cc365da3f ]

create_ctx is called from tls_init and tls_hw_prot
hence initialize function pointers in common routine.

Signed-off-by: Atul Gupta <atul.gupta@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 523622dc74f8..be9c6545e53d 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -555,6 +555,9 @@ static struct tls_context *create_ctx(struct sock *sk)
 		return NULL;
 
 	icsk->icsk_ulp_data = ctx;
+	ctx->setsockopt = sk->sk_prot->setsockopt;
+	ctx->getsockopt = sk->sk_prot->getsockopt;
+	ctx->sk_proto_close = sk->sk_prot->close;
 	return ctx;
 }
 
@@ -685,9 +688,6 @@ static int tls_init(struct sock *sk)
 		rc = -ENOMEM;
 		goto out;
 	}
-	ctx->setsockopt = sk->sk_prot->setsockopt;
-	ctx->getsockopt = sk->sk_prot->getsockopt;
-	ctx->sk_proto_close = sk->sk_prot->close;
 
 	/* Build IPv6 TLS whenever the address of tcpv6	_prot changes */
 	if (ip_ver == TLSV6 &&
-- 
2.19.1

