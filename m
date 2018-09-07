Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F95CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B654C2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fvwwiw5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B654C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeIGRbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:31:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43820 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeIGRbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:31:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id m84-v6so12154662lje.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjJqIo2V9tulakXDU1vfB5XIkmIeLndvv4RgJPCzB8w=;
        b=Fvwwiw5Dppw/bW4cvsyVrBgVYHlIcros3B2Jiq3Lyzesw4AbMZJ7mqI4YTgGs4qWFD
         ojCQxjqP7aLZVFtA4XYZPYZPfjX8Nc7FjydzS5bAX1oEO3ZwlXNUmfMwJK8SVv63icNv
         9W/N7GApDGlFL8yO65UsBOAXAsr89EUaHF7BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjJqIo2V9tulakXDU1vfB5XIkmIeLndvv4RgJPCzB8w=;
        b=Fd+cQuuGbXPvvA5ZIq2+af+Cn+aQG9iVWonrHQ3D2CsZrpwHYTvSlWVvJ1Gw6jBcnr
         GWwKz8yWEh0EjpULAX+0N8N5AAczj9OZvkM1KsOb4A1CffV5q57SOv+LVZvCH75vaeJ9
         IrqgbCD+hjfFY4np5ijYI1stec7pC2EOoZiCJfDGPrplN0/DEBzeD9SRt/6mEjSCRUaV
         e6RUl8EF5MpEnLM/UX5w0iF8VW+9jwZdAxkdg3L7u/1/gfoxFeYb2uj+x71mrkkeOB4j
         wm2Y0Ew4Nh5kUgeQ23mm9vVKCwZSQrOmDRLBQMBq03bm25mZV41kErLzBKfjOk8lkTgK
         k0YA==
X-Gm-Message-State: APzg51B0SjmjQLbdXrCgLf62qEO9EhDGSNmjQ2GRXHDQsSOPBkw9FNkz
        qUG1JMwoiCv0TB6tXsGhywZgYQ==
X-Google-Smtp-Source: ANB0VdY5UC4ItsK2EZ2GLaQgLyDaThq/k3WaPhzriAW/d0FZLW3MOd3hxUtcFHyoAkNwe7bZoFhiDg==
X-Received: by 2002:a2e:9698:: with SMTP id q24-v6mr4088958lji.35.1536324619273;
        Fri, 07 Sep 2018 05:50:19 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id v63-v6sm1291957lje.20.2018.09.07.05.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 05:50:18 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        tehnerd@fb.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] net/core/filter: fix unused-variable warning
Date:   Fri,  7 Sep 2018 14:50:05 +0200
Message-Id: <20180907125005.32383-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with CONFIG_INET=n will show the warning below:
net/core/filter.c: In function ‘____bpf_getsockopt’:
net/core/filter.c:4048:19: warning: unused variable ‘tp’ [-Wunused-variable]
  struct tcp_sock *tp;
                   ^~
net/core/filter.c:4046:31: warning: unused variable ‘icsk’ [-Wunused-variable]
  struct inet_connection_sock *icsk;
                               ^~~~
Move the variable declarations inside the {} block where they are used.

Fixes: 1e215300f138 ("bpf: add TCP_SAVE_SYN/TCP_SAVED_SYN options for bpf_(set|get)sockopt")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index d301134bca3a..0ae7185b2207 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4043,14 +4043,14 @@ static const struct bpf_func_proto bpf_setsockopt_proto = {
 BPF_CALL_5(bpf_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
-	struct inet_connection_sock *icsk;
 	struct sock *sk = bpf_sock->sk;
-	struct tcp_sock *tp;
 
 	if (!sk_fullsock(sk))
 		goto err_clear;
 #ifdef CONFIG_INET
 	if (level == SOL_TCP && sk->sk_prot->getsockopt == tcp_getsockopt) {
+		struct inet_connection_sock *icsk;
+		struct tcp_sock *tp;
 		switch (optname) {
 		case TCP_CONGESTION:
 			icsk = inet_csk(sk);
-- 
2.18.0

