Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F33ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC0421473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLOapzl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC0421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeIXBsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:48:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43676 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbeIXBsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:48:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so8118871pfi.10;
        Sun, 23 Sep 2018 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4sewCqRenZ7tBSn3lGXJuhD5SB87f/LxTJNLYW/0lFU=;
        b=iLOapzl65s5FemE9Z1wtOCch59skhneZkUE5kpk61uOEd5d1L6bqpkxtTqdDwAKS7P
         uYXB7tRt/FKK94OnwRI8cC93JdHzXJP1l9oT7FrzsCpJiDoyFT0a9tMVx56MiHjxI9Zf
         fl4YjkbsvoJk1xTobLQ+u3Mw/3rP4f/xAGNALcl5g2NjogbDFH3612N0jymI6YsvTx9+
         Mr9l+P5bjLRGnN2kbDL6Q/zngIkRlYwbQZJmclAGqIbNTahn6E5Z/AUXnmuktkOuouW7
         4OOk2BBLeQcHfCeFnQnAJcM6HXYA2PW4knMs3jrFQauWIVeD4OEgRd2+a7RHadYorIAh
         674w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4sewCqRenZ7tBSn3lGXJuhD5SB87f/LxTJNLYW/0lFU=;
        b=PplAcTXXwfIAVg5Myl0652r9Ky+xP59dyoynH870okvdfsYsCgUeMZd3YTTWc5g4R6
         K4F99h8TgKyN0xq/R8wP9EB3iRHWZvZoMtNqUiVtBBegeN/Fc2xQ52DIuOnOq99dDgFS
         75LxRaGW6Brp3NrUVq60gJRcO2Mozsd98YwMr4cMcZS3RHebZBL9pSZ1rIZE3p77MOa6
         qhKQXQHNwP7LgWnteC0n6+TK0y/j3PbjrV7p8fDkGJsWoqiNxVqHY+bUvhZB6H630iYf
         MZUGPtvToKyf6MH9pxMEJ8XwrZoYfsE42bwhrEZ6Qw4TklWGIg2V9C8H6///USKoJpGn
         xAvA==
X-Gm-Message-State: ABuFfohsCJcD0RDXLfMDf8VwbGRbsOA6nzKwZ1oq2K8HOslBtgLdMGoN
        SpWPy5dv/eHwKMKECgHKnS0=
X-Google-Smtp-Source: ACcGV63dNXxlwMeZBdHeAnYPmggnojtvllQTGOKWd25JRfKs9+nrEFB62wp6IwA7mDDu2RkePOFi/A==
X-Received: by 2002:a63:4343:: with SMTP id q64-v6mr6797164pga.276.1537732165610;
        Sun, 23 Sep 2018 12:49:25 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id u15-v6sm26357830pgn.56.2018.09.23.12.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 12:49:24 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: expose sk_state in tcp_retransmit_skb tracepoint
Date:   Mon, 24 Sep 2018 03:49:01 +0800
Message-Id: <1537732141-22468-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With sk_state, we can know whether this connection is in SYN_SENT state
or ESTBLISHED state.
The reason to distinguish between these two scenario is that the
retransmission in ESTABLISHED state always mean network congestion while
in SYN_SENT state it always mean server issue, i.e. the syn packet is
dropped due to syn backlog queue full.

PS: SYNACK retransmission is traced in tcp_retransmit_synack tracepoint.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/tcp.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index ac55b32..2bc9960 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -56,6 +56,7 @@
 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
 		__field(const void *, skaddr)
+		__field(int, state)
 		__field(__u16, sport)
 		__field(__u16, dport)
 		__array(__u8, saddr, 4)
@@ -70,6 +71,7 @@
 
 		__entry->skbaddr = skb;
 		__entry->skaddr = sk;
+		__entry->state = sk->sk_state;
 
 		__entry->sport = ntohs(inet->inet_sport);
 		__entry->dport = ntohs(inet->inet_dport);
@@ -84,9 +86,10 @@
 			      sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
 	),
 
-	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c",
+	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s\n",
 		  __entry->sport, __entry->dport, __entry->saddr, __entry->daddr,
-		  __entry->saddr_v6, __entry->daddr_v6)
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  show_tcp_state_name(__entry->state))
 );
 
 DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
-- 
1.8.3.1

