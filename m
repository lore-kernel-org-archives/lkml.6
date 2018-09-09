Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D00C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 03:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5D820868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 03:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCFckXzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5D820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeIIICt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 04:02:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38217 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeIIICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 04:02:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so8222821plq.5;
        Sat, 08 Sep 2018 20:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XgMXMw7vLyiClYXa/YUL47+R2Bnaaf4i0uaksEqUno4=;
        b=kCFckXzCVBtxZydq+vv+wTX2R83GmS5C8h8v7UdCfETEz0JaVC1dwB6HlIJmIxWByb
         6d1Vq7yI6bjJVIVeoyzsMok5fWeiIINOzWw0jP+Ly7Dgj1axnR7XxLkDgBTaKe7i7eKn
         Wv7XS2KS1UBaDxEWDEHC8i37ks6GGT1GSb9VN/tJUZZvYrbcs6LJ8GGjwmEhVW0koqa4
         686IKe6YkeEzeT1vyZz3PN7YQnvxqbptmq0cIwJ1/23bhmNoXL1eJgDNBuIk4joEVIIK
         I/jJLwx2SJ4V1quZUqQdnP+p4neJaEaABWv8CIsxXwtHNbgFe1WF7X5tBp6U7uuth0AX
         ba/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XgMXMw7vLyiClYXa/YUL47+R2Bnaaf4i0uaksEqUno4=;
        b=BwJjGcp9vjPXu5cWe9uPp/Opok7UGK/40mYSAu+hgUgrvs4lJqScVCMI5YvharEgWl
         CkHbp1tWqCd6WUEuK4hKKqXpylpo3cDuTuzJnvh1mQV3l8itIu4OL8PfDREiDtSHGnX8
         7JCJ/U8CYnQ9i85rMZsRUwOCIBzfPloGIx2oWIkajhzyToOaf/FZjmG39lj4oUAw12+k
         5xWfH5kqwp52j2QY1kNB79UQ/S5+QUplI+RnnkySJsQlAurJBWhAQ/C0qyOk+IQOQffB
         uLKXJ+p5PKjEL63S8UaMsk66nCCEnuDvqNm4UGycYz/V18PsA09hpi7s7Aukc8tEr/PM
         qgfg==
X-Gm-Message-State: APzg51BarQvXc8LZlJ3ljXJ0GtPqRafdarfm5N5UtnkGt2aNde7JGC3x
        ewKsEoeKsMqQ/L055Ez91YA=
X-Google-Smtp-Source: ANB0VdYQECsZe89rrtYMLqdGT2XPlMB7IjdQRsNsDH0cP99r5xxyLPRW10BOQEy3Sb3ol287oLKqmQ==
X-Received: by 2002:a17:902:bb0c:: with SMTP id l12-v6mr15313656pls.5.1536462887458;
        Sat, 08 Sep 2018 20:14:47 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id c17-v6sm29086961pfk.187.2018.09.08.20.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 20:14:46 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 net-next 2/2] tcp: fix the error count of tcpInSegs
Date:   Sun,  9 Sep 2018 11:14:22 +0800
Message-Id: <1536462862-11767-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536462862-11767-1-git-send-email-laoar.shao@gmail.com>
References: <1536462862-11767-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RFC1213, the tcpInSegs is the total number of segments received.
While currently it is the total number of SKBs received.
The number of SKBs may be not equal with the numer of segments because of
GRO.
So fix this error count.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/net/tcp.h   | 2 ++
 net/ipv4/tcp_ipv4.c | 3 ++-
 net/ipv6/tcp_ipv6.c | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 770917d..66578f4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -310,6 +310,8 @@ static inline bool tcp_too_many_orphans(struct sock *sk, int shift)
 #define __TCP_INC_STATS(net, field)	__SNMP_INC_STATS((net)->mib.tcp_statistics, field)
 #define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
 #define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
+#define __TCP_ADD_STATS(net, field, val)	\
+	__SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
 
 void tcp_tasklet_init(void);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 23d7cb5..2b98242 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1703,7 +1703,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto discard_it;
 
 	/* Count it even if it's bad */
-	__TCP_INC_STATS(net, TCP_MIB_INSEGS);
+	__TCP_ADD_STATS(net, TCP_MIB_INSEGS,
+			max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 
 	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
 		goto discard_it;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index bbf7667..8d4ef46 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1441,7 +1441,8 @@ static int tcp_v6_rcv(struct sk_buff *skb)
 	/*
 	 *	Count it even if it's bad.
 	 */
-	__TCP_INC_STATS(net, TCP_MIB_INSEGS);
+	__TCP_ADD_STATS(net, TCP_MIB_INSEGS,
+			max_t(u16, 1, skb_shinfo(skb)->gso_segs));
 
 	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
 		goto discard_it;
-- 
1.8.3.1

