Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D58C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270AA20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="The2+Muq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270AA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbeKDCGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:06:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39357 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeKDCGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:06:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so2324557pgv.6;
        Sat, 03 Nov 2018 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PkU2TzgCLqIr6brsSG/jWvDFCvA3KRYUmoZUhlMH0nY=;
        b=The2+MuqJx67/zFxUG30pVGhvrhseGz1X0MjZDNk9+XikzlIb2RlN4HW28Vniqhay+
         dItAvv/G59350Z4DXwGhZ1pLyNt9TlUT9zTmDPPrNcvRsJ2Sxsfjt8ipZNgoPfxViP4L
         eGPYhZuvmmMUwjGn1jK8N1A9bxApyuzpdS54kWqrnmOjfs4lcp5DekQ9wo4A3BYOPvM0
         INwJvDDUFIibAZ6iGY5qsrc2OdrmQ43FdB1mc8TqJsYb/eTiv6mbGHlNmPv/MnWr9tfz
         +14YGZbhucZOBYEbUbKAivHPn4VuLjjeQqS7J5dsc8wauF5cOENhZEeVKN/vV0nmX/hi
         sT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PkU2TzgCLqIr6brsSG/jWvDFCvA3KRYUmoZUhlMH0nY=;
        b=haWRkuXD+kWiT3hh9qCd1K/p3/h+hA0hJNCCWQHAgxfB9IP3qztfn6cHnx3w71WeZ1
         HPA2y8Idkj4qHGt8V1Nf/C/TZF8vCL9Dw7YHhAz+2gdU/Qgf0DnceZ1cSzhn+3VgnHr6
         JA6viDRg28NV03TFJufaF2Y27cfkX4T0tE0fVLSLmrjDPPnfnoP1DccjRR0BySHgzlwz
         Zw9fAuCGZcFl24GHVAt5zDxtUDE8pZVEKSQcRm7rOzZhAnLY2gV9hBJzJ9eI5LOJk5co
         y+MjoIYPzik6s6WfxJRLMQAy9KBqKIoL8w63+9wMmboREpKQibgW8lDZVTwJptrYe3iI
         JIDA==
X-Gm-Message-State: AGRZ1gLP87bEfvLPBjWv39hZtzYLyjbLVNuw+HgpLqfX8SUdOQ+2uthv
        cf1Vjo0DfuIH16S/KEZPUXo=
X-Google-Smtp-Source: AJdET5dL5aD8bcdojyHv8rv51SkLke4M/GtvTiF4SIR0bOqRcuyENva5pg/E3B+0httSn060G3iCLg==
X-Received: by 2002:a65:5a05:: with SMTP id y5-v6mr14593134pgs.161.1541264095400;
        Sat, 03 Nov 2018 09:54:55 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id r26-v6sm36006568pga.69.2018.11.03.09.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 09:54:54 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] tcp: do not update snd_una if it is same with ack_seq
Date:   Sun,  4 Nov 2018 00:54:31 +0800
Message-Id: <1541264071-9905-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the slow path, TCP_SKB_SB(skb)->ack_seq may be same with tp->snd_una,
and under this condition we don't need to update the snd_una.

Furthermore, tcp_ack_update_window() is only called in slow path,
so introducing this check won't affect the fast path processing.

By the way, '&' is a little faster than '-', so I replaced after() with
"flag & FLAG_SND_UNA_ADVANCED".

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2868ef2..db5a6b7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3376,7 +3376,8 @@ static int tcp_ack_update_window(struct sock *sk, const struct sk_buff *skb, u32
 		}
 	}
 
-	tcp_snd_una_update(tp, ack);
+	if (after(ack, tp->snd_una))
+		tcp_snd_una_update(tp, ack);
 
 	return flag;
 }
@@ -3610,7 +3611,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if (flag & FLAG_UPDATE_TS_RECENT)
 		tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
 
-	if (!(flag & FLAG_SLOWPATH) && after(ack, prior_snd_una)) {
+	if (!(flag & FLAG_SLOWPATH) && flag & FLAG_SND_UNA_ADVANCED) {
 		/* Window is constant, pure forward advance.
 		 * No more checks are required.
 		 * Note, we use the fact that SND.UNA>=SND.WL2.
-- 
1.8.3.1

