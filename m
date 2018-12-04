Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10804C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81A9214ED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="akwQIwfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81A9214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeLDLCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbeLDLCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76DE214DA;
        Tue,  4 Dec 2018 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921337;
        bh=cfHN5+y0rUPilxoxQ1gHEHYID0tg10RXz5nZ+kVQczU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akwQIwfxgn+hu41xD/ocGHWwVtRIgU1JY3nMJhaWRnBZdOu0vTPEzTHnD7AKmw4KM
         IaYYfDxszkjPBiS2z+Lq5oK3xN+LesYRyQNEIzp23MLt4xxU/NnbmBTDSG2efjzZLq
         D1PHuZgG62JZ8D920y7KC60m1gMuS2qA7ZU3NKLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vakul Garg <vakul.garg@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 025/146] net/tls: Fixed return value when tls_complete_pending_work() fails
Date:   Tue,  4 Dec 2018 11:48:31 +0100
Message-Id: <20181204103727.845368602@linuxfoundation.org>
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

commit 150085791afb8054e11d2e080d4b9cd755dd7f69 upstream.

In tls_sw_sendmsg() and tls_sw_sendpage(), the variable 'ret' has
been set to return value of tls_complete_pending_work(). This allows
return of proper error code if tls_complete_pending_work() fails.

Fixes: 3c4d7559159b ("tls: kernel TLS support")
Signed-off-by: Vakul Garg <vakul.garg@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 4.14: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5996fb5756e1..d18d4a478e4f 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -388,7 +388,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context *ctx = tls_sw_ctx(tls_ctx);
-	int ret = 0;
+	int ret;
 	int required_size;
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	bool eor = !(msg->msg_flags & MSG_MORE);
@@ -403,7 +403,8 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	lock_sock(sk);
 
-	if (tls_complete_pending_work(sk, tls_ctx, msg->msg_flags, &timeo))
+	ret = tls_complete_pending_work(sk, tls_ctx, msg->msg_flags, &timeo);
+	if (ret)
 		goto send_end;
 
 	if (unlikely(msg->msg_controllen)) {
@@ -539,7 +540,7 @@ int tls_sw_sendpage(struct sock *sk, struct page *page,
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context *ctx = tls_sw_ctx(tls_ctx);
-	int ret = 0;
+	int ret;
 	long timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
 	bool eor;
 	size_t orig_size = size;
@@ -559,7 +560,8 @@ int tls_sw_sendpage(struct sock *sk, struct page *page,
 
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
-	if (tls_complete_pending_work(sk, tls_ctx, flags, &timeo))
+	ret = tls_complete_pending_work(sk, tls_ctx, flags, &timeo);
+	if (ret)
 		goto sendpage_end;
 
 	/* Call the sk_stream functions to manage the sndbuf mem. */
-- 
2.17.1



