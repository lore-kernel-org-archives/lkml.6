Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF28C468C6
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B9420936
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V75hZYJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B9420936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeGOQAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 12:00:05 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38453 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeGOQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 12:00:04 -0400
Received: by mail-qk0-f194.google.com with SMTP id y4-v6so19414987qka.5;
        Sun, 15 Jul 2018 08:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RdItEfAx0nKeiRWEcbdveIc3f6iUR3yvyIg/1JmTcX0=;
        b=V75hZYJ/PB2R9XtXvww1K1nZKp1+TnNCjV1OGL/9Eqvfuoa35Df0K6g/ZK+PR2W2zT
         4Iw7FkZUCBhwxVQxH+SsmXoF/L9hLFE6QZUk297GNCUxzOc3gfn5cUufmqzLXsFcbcBn
         BspOmvUpUWJTO/R7qQgSbAyDuiZ83KwgbzuKV5ugRJ3PANZMqmCuEy3Vct1t/s07bYP9
         psnWTftVSRARlC4PCMDft3GY8v0cUd3F/XV5hvCNHGlvuNcgylh2t2uItKFRBhvT8pVy
         HASVlvv1h8hkq6T0SepuAyPgn4w+cOSyoJi3qzdYrdYlG5Kf8PBU70tIHZCova+VqmUx
         7WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RdItEfAx0nKeiRWEcbdveIc3f6iUR3yvyIg/1JmTcX0=;
        b=lVMsi5rUug/xjcAKq3e9bsKLbz4ZeXziPdCMwG0/vsQSwJDjfCnFe1X1DXoh5Nv7x6
         W5sSC69tfzE4fuaTaiNbZha2XLR34zGMg8hXUZ595ldK8JzyzcS0s8wHIKh1aVeS5p7U
         qVmiZZ+PRMJngTv7v9/qPSFr14TTsaqmDYRmjbgtboJWCJEMJduXD2ISIn6WKgJIgBWJ
         Mvm9GyLI5wKgwqXeP90CRAE7VuY/6L+bgt8VeBKqo7JuhhAMkZ+ardI+R57cKNydBuM8
         IVAMmf9ipFIIsXOFI69nYAhyEET3iLz5gICSVXvwIuNxyLavpClNAO6mKZmpLLshsMcP
         qQ7g==
X-Gm-Message-State: AOUpUlFS5fpWqw6KeBe0tIrlQ/MeccQ4h//hIl8eNvyAQhfaIX7uYaVn
        ZynTMdnhMi43aOKJ34h8l48=
X-Google-Smtp-Source: AAOMgpcpciRHCYgejwNfEDFS4sCYz+wIYfLJjwbk5+7M5BLyRgp48dEG1D1OubPc0SL87ZJA+LaH6w==
X-Received: by 2002:ae9:d885:: with SMTP id u127-v6mr11305554qkf.219.1531669003843;
        Sun, 15 Jul 2018 08:36:43 -0700 (PDT)
Received: from localhost.localdomain.iceblazer.shadowybug.net (pool-173-67-16-152.bltmmd.fios.verizon.net. [173.67.16.152])
        by smtp.gmail.com with ESMTPSA id f184-v6sm12911418qkc.23.2018.07.15.08.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 08:36:42 -0700 (PDT)
From:   Stefan Baranoff <sbaranoff@gmail.com>
Cc:     Andrey Vagin <avagin@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Stefan Baranoff <sbaranoff@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net,v2] tcp: Fix broken repair socket window probe patch
Date:   Sun, 15 Jul 2018 11:36:37 -0400
Message-Id: <1531668997-1439-1-git-send-email-sbaranoff@gmail.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct previous bad attempt at allowing sockets to come out of TCP
repair without sending window probes. To avoid changing size of
the repair variable in struct tcp_sock, this lets the decision for
sending probes or not to be made when coming out of repair by
introducing two ways to turn it off.

v2:
* Remove erroneous comment; defines now make behavior clear

Fixes: 70b7ff130224 ("tcp: allow user to create repair socket without window probes")
Signed-off-by: Stefan Baranoff <sbaranoff@gmail.com>
---
 include/uapi/linux/tcp.h |  4 ++++
 net/ipv4/tcp.c           | 13 +++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 29eb659..e3f6ed8 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -127,6 +127,10 @@ enum {
 
 #define TCP_CM_INQ		TCP_INQ
 
+#define TCP_REPAIR_ON		1
+#define TCP_REPAIR_OFF		0
+#define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
+
 struct tcp_repair_opt {
 	__u32	opt_code;
 	__u32	opt_val;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8e5e2ca..ec2186e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2823,16 +2823,17 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
 	case TCP_REPAIR:
 		if (!tcp_can_repair_sock(sk))
 			err = -EPERM;
-		/* 1 for normal repair, 2 for no window probes */
-		else if (val == 1 || val == 2) {
-			tp->repair = val;
+		else if (val == TCP_REPAIR_ON) {
+			tp->repair = 1;
 			sk->sk_reuse = SK_FORCE_REUSE;
 			tp->repair_queue = TCP_NO_QUEUE;
-		} else if (val == 0) {
+		} else if (val == TCP_REPAIR_OFF) {
+			tp->repair = 0;
+			sk->sk_reuse = SK_NO_REUSE;
+			tcp_send_window_probe(sk);
+		} else if (val == TCP_REPAIR_OFF_NO_WP) {
 			tp->repair = 0;
 			sk->sk_reuse = SK_NO_REUSE;
-			if (tp->repair == 1)
-				tcp_send_window_probe(sk);
 		} else
 			err = -EINVAL;
 
-- 
1.8.3.1

