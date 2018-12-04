Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582AAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB9420851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV0U2Kz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB9420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeLDLCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbeLDLBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:01:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26942214DB;
        Tue,  4 Dec 2018 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921314;
        bh=4H+VElXLqw7HftnFU360vd1W0+C2sDOeIhDJ8Eqo/d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rV0U2Kz8vqdUjESN+R12oaAW5alFdNvYMuOBp0ypOBK+uYqNHazAIyXSdNN3oo1bp
         J6V7GnggqUTQzVA6At51LJ4EAq2OdHhA0jFsonVJ4A7AKCE+6muBsmgjm9JtWNdkMf
         NnLLMlNHpiqspyTR56r96EuXsPPKu+vuBYMbUfI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Lesokhin <ilyal@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 023/146] tls: dont override sk_write_space if tls_set_sw_offload fails.
Date:   Tue,  4 Dec 2018 11:48:29 +0100
Message-Id: <20181204103727.749075306@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit ee181e5201e640a4b92b217e9eab2531dab57d2c upstream.

If we fail to enable tls in the kernel we shouldn't override
the sk_write_space callback

Fixes: 3c4d7559159b ('tls: kernel TLS support')
Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index f88df514ad5f..33187e34599b 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -429,9 +429,6 @@ static int do_tls_setsockopt_tx(struct sock *sk, char __user *optval,
 		goto err_crypto_info;
 	}
 
-	ctx->sk_write_space = sk->sk_write_space;
-	sk->sk_write_space = tls_write_space;
-
 	/* currently SW is default, we will have ethtool in future */
 	rc = tls_set_sw_offload(sk, ctx);
 	tx_conf = TLS_SW_TX;
@@ -440,6 +437,8 @@ static int do_tls_setsockopt_tx(struct sock *sk, char __user *optval,
 
 	ctx->tx_conf = tx_conf;
 	update_sk_prot(sk, ctx);
+	ctx->sk_write_space = sk->sk_write_space;
+	sk->sk_write_space = tls_write_space;
 	goto out;
 
 err_crypto_info:
-- 
2.17.1



