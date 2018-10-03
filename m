Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB4EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B9F2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMK1chv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B9F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbeJCV5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:57:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45829 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbeJCV5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:57:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23-v6so1813178pfi.12;
        Wed, 03 Oct 2018 08:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jEgLo7rrfCPW5l3ealQfMoc5waYiy2TEwp+xxtoiWyQ=;
        b=eMK1chv5JUQSiUClntInrjlfc7WQ/4iclz5yNGVUtyMVJJK6HzSRkwtuJmtxuIbowf
         /PAu5Jqpgh2WGcayTzO8BjALtTAa2FjRj7bnqn8osZSiFTDQM+eZWQStlmtLgyoKmJYq
         LShhA4+GlQSwfVfw4rCg15YSVhA0/70bhW2Q7aAjaqAgPusS2KtGzo0eni13m199JFab
         ZnmY2fDe9Q2aS+w660wQhbfhggoHmecb3EN+6GxBX6CP5TBoPHvuX2aFuBaQOREfocUC
         H0JjYSerH91CxZ2eiq24+uHzCPE2bi9hsgiQzJlAdxYkvMnyU78bqTYB3qbVK7+yamdf
         Av4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jEgLo7rrfCPW5l3ealQfMoc5waYiy2TEwp+xxtoiWyQ=;
        b=mYzrQ+Y0O2Z1bNfL8fDcHmJfKYdpMHV7eZeZLOCKopp+p00RaLxAI4vR++dWGr3uVH
         ec3K7ebtBpHHP0/W6Ciqgsjml0ahR4g9Th41HIALWIwXh+N77lVMan5VijR8kNBGSpQp
         bapCA1zdGjK2FSM2PHFbZTpb7D23H5cZ/mwMk3MenJ4AhRbGH8j0OSNqGlMVCxmrAuhl
         1fyD55zxSnmMnkGEjJFEW2glZ237ogsL5RwFmqQ5o/GwUfC8pQb5RZEdkcz6EfrXSDDC
         09QYI5ixeBpVkCxalDKKJbELLVsDNhymj8CW4SlTKR8R1HSdzI1hDjOazuxi5v2P7Ko+
         r7Dw==
X-Gm-Message-State: ABuFfogt1+t3OuHvVz+lpwUEyXNd1PHZdVJPuqws8Q8hEseDuwfSQSYu
        bPaYq2z7+6qkfMTdLaMxPLc=
X-Google-Smtp-Source: ACcGV62u5JMzG2xeJ5lW46+N1TTXRubpkjSL5XNWzfQZCNZyPfKyHkoCieyBgCRGE4azMPl89JGT9Q==
X-Received: by 2002:a63:5059:: with SMTP id q25-v6mr1736911pgl.171.1538579303679;
        Wed, 03 Oct 2018 08:08:23 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id 19-v6sm4426606pft.97.2018.10.03.08.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:08:22 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] inet: do not set backlog if listen fails
Date:   Wed,  3 Oct 2018 23:07:59 +0800
Message-Id: <1538579279-11614-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two backlog members are not necessary set in inet_csk_listen_start().
Regarding sk_max_ack_backlog, it will be set in the caller inet_listen
and dccp_listen_start.
Regraing sk_ack_backlog, it is better to put it together with
sk_max_ack_backlog in the same function and only set on success.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/dccp/proto.c                | 1 +
 net/ipv4/af_inet.c              | 1 +
 net/ipv4/inet_connection_sock.c | 3 ---
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 875858c..34d48cd 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -959,6 +959,7 @@ int inet_dccp_listen(struct socket *sock, int backlog)
 		err = dccp_listen_start(sk, backlog);
 		if (err)
 			goto out;
+		sk->sk_ack_backlog = 0;
 	}
 	sk->sk_max_ack_backlog = backlog;
 	err = 0;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 1fbe2f8..9690e0d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -230,6 +230,7 @@ int inet_listen(struct socket *sock, int backlog)
 		if (err)
 			goto out;
 		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB, 0, NULL);
+		sk->sk_ack_backlog = 0;
 	}
 	sk->sk_max_ack_backlog = backlog;
 	err = 0;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dfd5009..c25d0b3 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -870,9 +870,6 @@ int inet_csk_listen_start(struct sock *sk, int backlog)
 	int err = -EADDRINUSE;
 
 	reqsk_queue_alloc(&icsk->icsk_accept_queue);
-
-	sk->sk_max_ack_backlog = backlog;
-	sk->sk_ack_backlog = 0;
 	inet_csk_delack_init(sk);
 
 	/* There is race window here: we announce ourselves listening,
-- 
1.8.3.1

