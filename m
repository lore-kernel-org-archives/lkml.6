Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9308A208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdOvsV5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9308A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeKKV65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:58:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40164 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbeKKV65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:58:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so2958367pfm.7;
        Sun, 11 Nov 2018 04:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BFlr4fzbZ2bFRUAgs1AQuqy3va5cbhhQY2IvnpeiMT8=;
        b=OdOvsV5ABnzL8tK3d3OhR0RFmvgrHm4ZRYS2s/W3eu0slCH+Nmhl5H24Hf1qiHiLZA
         R+R9sVGLmZ0bIz9O3swSLzyhYlWtmVT6uy18kJSe8d1swLXmFqELDpfsEwF14coOtR5l
         7cWaJhYICk+OE1lD/CTw7m+MW9bp9YeRPdqEc3SiztNWiq+/Mi8W8b7AmvhLTzdx6QrV
         zcWiyypf0DJ6pNLdWsRMvxzDwaE3zdKfYfEnYu5M8fEnB3PqZcIjdPp8D6X3KTll0ZF9
         gDwKNHZ8liq/FaB/nZ4FenzthipMZMYlvQmBNenoOcZscY1BSDeNZUVSIK3uaIxrqUwg
         S8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BFlr4fzbZ2bFRUAgs1AQuqy3va5cbhhQY2IvnpeiMT8=;
        b=HNvvxf58PElcWZMCO7WT3owfdzR5zjJSirkMV7nV7haJkny7AbYWX/k5WQP0GYFrul
         YpUOb/6zE+n61kaHTLjc2DLF3DrBbeBChxMxYnFwOQy/m4NNJSlQMlWvTqH68HXGvsHb
         s82rtSFXY+W8Onc9fcqOy6AQRiHdDZHbOmeZwjzb9WQFlxeBE0GbBgGx85hIoCFb6/iA
         TkHcOqZhfg26heuEYlwGXGHxKFpnbOYSbERHKd/zokCiUDBy5wR8iuTe/ghSm5VsK+dy
         Mm+0vFlpXVVGLMCQaFEkaLIDwCvO1ACH9WKVpxm+6TH5+S1rZSu71+wmdJh4iaFVPJez
         ycIw==
X-Gm-Message-State: AGRZ1gKK7a6r3mnEt8dLFZV9Wac7VAG3MKqT8JHo/RUZ++RlBGwCRuRf
        VsZa2kDWnIY/yRM/aDQOyr0=
X-Google-Smtp-Source: AJdET5eGEtzStv6omJ/bwtiF96jMB2kYBpFW/e9+FJfHWloGhwUHJCVAKHC53tMcRWSX6kovPBE5FQ==
X-Received: by 2002:a62:3406:: with SMTP id b6-v6mr16248036pfa.50.1541938232672;
        Sun, 11 Nov 2018 04:10:32 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id i2-v6sm11530897pgq.35.2018.11.11.04.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 04:10:31 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH net-next v2] tcp: minor optimization in tcp ack fast path processing
Date:   Sun, 11 Nov 2018 20:10:10 +0800
Message-Id: <1541938210-11797-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bitwise operation is a little faster.
So I replace after() with using the flag FLAG_SND_UNA_ADVANCED as it is
already set before.

In addtion, there's another similar improvement in tcp_cwnd_reduction().

Cc: Joe Perches <joe@perches.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2868ef2..edaaebf 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2457,8 +2457,8 @@ void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked, int flag)
 		u64 dividend = (u64)tp->snd_ssthresh * tp->prr_delivered +
 			       tp->prior_cwnd - 1;
 		sndcnt = div_u64(dividend, tp->prior_cwnd) - tp->prr_out;
-	} else if ((flag & FLAG_RETRANS_DATA_ACKED) &&
-		   !(flag & FLAG_LOST_RETRANS)) {
+	} else if ((flag & (FLAG_RETRANS_DATA_ACKED | FLAG_LOST_RETRANS)) ==
+		   FLAG_RETRANS_DATA_ACKED) {
 		sndcnt = min_t(int, delta,
 			       max_t(int, tp->prr_delivered - tp->prr_out,
 				     newly_acked_sacked) + 1);
@@ -3610,7 +3610,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if (flag & FLAG_UPDATE_TS_RECENT)
 		tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
 
-	if (!(flag & FLAG_SLOWPATH) && after(ack, prior_snd_una)) {
+	if ((flag & (FLAG_SLOWPATH | FLAG_SND_UNA_ADVANCED)) ==
+	    FLAG_SND_UNA_ADVANCED) {
 		/* Window is constant, pure forward advance.
 		 * No more checks are required.
 		 * Note, we use the fact that SND.UNA>=SND.WL2.
-- 
1.8.3.1

