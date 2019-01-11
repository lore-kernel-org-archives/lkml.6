Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3557EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F242D2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217397;
	bh=EjP9gQd3qpC/i4romInb5N4JEkj1nBP62YNdMb0woiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g7ASxOyieFCaf2vwqnQne+YZKX6lbT4sWDClk2RwTgfpCt5LFSrD0K9QqXosgs22k
	 8N9vl9Y8Er3VgQGcx5TPxRHwhwF6ZraBM1MZLu55BTMyWhrZDYAeo1ylLtYtEGooUL
	 g9Bk/xZd19pAwL7T06xYtsD/JNDLzBHGlEzyhiaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbfAKOgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390402AbfAKOgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6425C204EC;
        Fri, 11 Jan 2019 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217392;
        bh=EjP9gQd3qpC/i4romInb5N4JEkj1nBP62YNdMb0woiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOhDKh0ee+9rhXtPyO9LHl35uE1AvWiOvr/ftZv4CecinwJsSiL5VCpPPg4uYv3Ck
         HfeFi1G3OCIa2YFvMt0S3XbefDzC8w+JwZC/qdLjlaDhJ2Q/3xEKsW7RTcPT0h7IzN
         Xl0yCCSfXj1bjOSKzKp7VH5Xy5Lnai0WKFsRrwdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Atul Gupta <atul.gupta@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/148] net/tls: Init routines in create_ctx
Date:   Fri, 11 Jan 2019 15:13:42 +0100
Message-Id: <20190111131116.046812436@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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
index 7fab2891ce7f..a091c03abcb2 100644
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



