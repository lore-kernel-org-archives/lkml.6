Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF2EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF3A20869
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANNAMCUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF3A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbeKOAaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:30:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40563 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeKOAaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:30:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so7993849pfm.7;
        Wed, 14 Nov 2018 06:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=juWN0AHhn8PkaMOx73jGipNLB5iWRGd14Jgaz4hPCcw=;
        b=ANNAMCUFkrDBdRa5ht98Lgkhp4dyFEtB5/xMGiUptBORK+RORKsIEW1SN6by0o5w+j
         BlHQCQl1WL9fTwIe8SW2/oQzGG62rrPHoS8JKRk+KH7ZppClVC8y+KMbmB0hPHGjhSx6
         xEjlWg5POqe0iSQZCe8fZa5rQWREQ4DiWd0raGiwx6n1ElX8Y5JZoFThHLuunt5M0vaV
         dc+tR8ZDPZUzHtUZYq1//feqNz9CA9Ta6WEVGSUHLewXmsJjSzagJA4Jo9v99hsuTF4v
         AY0ScSDYnU+/SQG27Ujpr5vE+GZ4SKTeTHCcLj9xKdQonRw2+3UNsNnVEjOqDgMMfzFE
         Xv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=juWN0AHhn8PkaMOx73jGipNLB5iWRGd14Jgaz4hPCcw=;
        b=juj4AR59KNnq+E65O1mHxjBgMr/SRlg0rHrkqo2dc2SKid07pVxB0n1RJhoxQvmt0J
         LD54OpFWBxdC3pvPWHQ9yHrF/uzWzR1DL6fS6T5/IUC8StT4tX1PC9y68xw+JkU0GU42
         W2A1UrGYuGHGwdQyfnLLAY/q5ynWIYtW1jLDwuXO1R9SyQk4IgH9RzodhPw9GcbPUhII
         u5q08ILo26vLTPMjtOzlQ99Tut/4KGtSLZnmX4GT0Vzzf6SnECF5Adk7hT+umMeENall
         nPvPQTJciqwELunMj6yRWfMhq/MqtxnQLzB2J8FV/8eOYDdi9kv6gLnE6VQV4jepZ7hy
         Gbyg==
X-Gm-Message-State: AGRZ1gKi1ytESHrBBJpRQEZLfH4mCD+ZJ0NgH3GWdbnYau41kd+MOByH
        vM3F5wgOZvT5aATNzJ955lT7H1Sz
X-Google-Smtp-Source: AJdET5djP96MkSb8vgWvo7ASK/4tlg+U9TTus+1wfNutIa3sy4RqiEyXUN8bkHUJbvBAIPC+5wRL5A==
X-Received: by 2002:a65:5c81:: with SMTP id a1-v6mr1916554pgt.390.1542205622352;
        Wed, 14 Nov 2018 06:27:02 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id f193-v6sm34081124pfc.74.2018.11.14.06.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 06:27:01 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: clean up STATE_TRACE
Date:   Wed, 14 Nov 2018 22:26:17 +0800
Message-Id: <1542205577-21925-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we can use bpf or tcp tracepoint to conveniently trace the tcp
state transition at the run time.
So we don't need to do this stuff at the compile time anymore.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/net/tcp.h | 12 ------------
 net/ipv4/tcp.c    |  4 ----
 2 files changed, 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4743836..9d51a20 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1328,20 +1328,8 @@ static inline bool tcp_checksum_complete(struct sk_buff *skb)
 
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb);
 int tcp_filter(struct sock *sk, struct sk_buff *skb);
-
-#undef STATE_TRACE
-
-#ifdef STATE_TRACE
-static const char *statename[]={
-	"Unused","Established","Syn Sent","Syn Recv",
-	"Fin Wait 1","Fin Wait 2","Time Wait", "Close",
-	"Close Wait","Last ACK","Listen","Closing"
-};
-#endif
 void tcp_set_state(struct sock *sk, int state);
-
 void tcp_done(struct sock *sk);
-
 int tcp_abort(struct sock *sk, int err);
 
 static inline void tcp_sack_reset(struct tcp_options_received *rx_opt)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9e6bc4d..ca2b08c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2241,10 +2241,6 @@ void tcp_set_state(struct sock *sk, int state)
 	 * socket sitting in hash tables.
 	 */
 	inet_sk_state_store(sk, state);
-
-#ifdef STATE_TRACE
-	SOCK_DEBUG(sk, "TCP sk=%p, State %s -> %s\n", sk, statename[oldstate], statename[state]);
-#endif
 }
 EXPORT_SYMBOL_GPL(tcp_set_state);
 
-- 
1.8.3.1

