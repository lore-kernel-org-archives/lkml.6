Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93667C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5022B2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIOhfgv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5022B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeKGUur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:50:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37746 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeKGUur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:50:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so7214546pgq.4;
        Wed, 07 Nov 2018 03:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tHj/VoF2L1128brEyrVE0VniLlQnviPAFfJIa4x/4sc=;
        b=KIOhfgv77ULUBczCYaLDVUs/5IwzIxuCLkUMFaV3s9phs1DLnyGthzClxDpHgNBGlm
         h0EyNz5WoLptBG9hdChgTRTqysIH83wlGfyOi3mRt4cJjeinRNgLoBQ+QH2BcIPgCXBg
         fcf1ft38qjm8NtIq4MpK5sa0jwh9RzR4orflouePt+xWY3Nh9zLDjDu8Ymrnb6JbXBPe
         sDQS4XJ7eBPA8VijabQq4Kn25n6lCAJN42o58xwF81RLToP7sF/vzRkxNHhs0jzkWApn
         Ks9i5CQa0QUbYaDRh0nPkgqO6P8NsTjo54+j12esiMWjx22TfVLDkbrHXc/FVzUcxgwD
         pPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tHj/VoF2L1128brEyrVE0VniLlQnviPAFfJIa4x/4sc=;
        b=Ih3IxBmTFzgoiTHL8lgNFF5Lhi6lURRadpuooW/lZ52pZtTpyKSlqyQf2WmG8WhFJb
         IfDSLzhiaUFsTFes1vSKB//1c0hYk52KeLIwBeCzCcTFp+AfqgA7kCF5/i7U9tIJ5bjB
         6FFRjPfw4moYBeGshnFQe0Hrz3wVcl5HFVH/A7f4U4TQlHQB71hreC5QnpIj1Ol486pF
         GA9EoKZdbqptUIuh+xhPgtZB5sj+15yp37WCAk+kVbKyOJpBqJh30hTyCRX/X37lADiy
         38DsN0uXejXUrx+q0TFegMAo4OWxpbOJtcbBz4lSXOuC81Uk2YdlIIMySg4EEE/e/e1Q
         JHGQ==
X-Gm-Message-State: AGRZ1gJLky9lQEBoLPsAIyHg3dMLd1/cptRIoIz0Um87FoiISCQiET8D
        DuR2iu9+mcSJL6VVTZ3uMsg=
X-Google-Smtp-Source: AJdET5cO7gYbEiLUSw9zku/T4UXBSqD4CgyC90ze/dR82yzSfGJIs4niGVZsEDiAADA3eVMNlE0yeQ==
X-Received: by 2002:a63:f547:: with SMTP id e7mr1256879pgk.182.1541589651325;
        Wed, 07 Nov 2018 03:20:51 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m129-v6sm452622pfm.78.2018.11.07.03.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 03:20:50 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] inet: minor optimization for backlog setting in listen(2)
Date:   Wed,  7 Nov 2018 19:20:16 +0800
Message-Id: <1541589617-1607-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the backlog earlier in inet_dccp_listen() and inet_listen(),
then we can avoid the redundant setting.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/dccp/proto.c                | 2 +-
 net/ipv4/af_inet.c              | 2 +-
 net/ipv4/inet_connection_sock.c | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 43733ac..658cd32b 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -948,6 +948,7 @@ int inet_dccp_listen(struct socket *sock, int backlog)
 	if (!((1 << old_state) & (DCCPF_CLOSED | DCCPF_LISTEN)))
 		goto out;
 
+	sk->sk_max_ack_backlog = backlog;
 	/* Really, if the socket is already in listen state
 	 * we can only allow the backlog to be adjusted.
 	 */
@@ -960,7 +961,6 @@ int inet_dccp_listen(struct socket *sock, int backlog)
 		if (err)
 			goto out;
 	}
-	sk->sk_max_ack_backlog = backlog;
 	err = 0;
 
 out:
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 1fbe2f8..39066cd 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -208,6 +208,7 @@ int inet_listen(struct socket *sock, int backlog)
 	if (!((1 << old_state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto out;
 
+	sk->sk_max_ack_backlog = backlog;
 	/* Really, if the socket is already in listen state
 	 * we can only allow the backlog to be adjusted.
 	 */
@@ -231,7 +232,6 @@ int inet_listen(struct socket *sock, int backlog)
 			goto out;
 		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB, 0, NULL);
 	}
-	sk->sk_max_ack_backlog = backlog;
 	err = 0;
 
 out:
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 15e7f79..860e22a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -874,7 +874,6 @@ int inet_csk_listen_start(struct sock *sk, int backlog)
 
 	reqsk_queue_alloc(&icsk->icsk_accept_queue);
 
-	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	inet_csk_delack_init(sk);
 
-- 
1.8.3.1

