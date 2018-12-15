Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF13C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6CD2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 09:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrz79qkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbeLOJdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 04:33:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37410 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbeLOJdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 04:33:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so3859746plr.4;
        Sat, 15 Dec 2018 01:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Hs7nsjsykKZ3hTMp6zGOqOD3FYy+k3AZmDCkDxXVlgI=;
        b=Wrz79qkRHKZsY2TMklQpv0viUdBZpdvr0V8FvLBK2+IAV6JAEYzoRvzFZhEN+zcwPv
         6D1VdCWPGxwzvwGrOiybupStykaRmVcQlwD5190mCgY5DnZq5ZvVGqeWdWZM0OU033Ns
         3C3SrCjl+K0pfJVE7xKAKwC6sWPd/VaMvm/tCaJivQkFEuKxR0D3XfoMjIzKirvmy+oz
         uAJ45ilB7IFAr/J0oWMEpLall9HuRV0baqHba0L1JUTDbKPi2Lh3RclIFAmhkjgPumgd
         hZzhXf2UzHtAwx4U9v5Y96Mm/65gjzCHAO0JpkYZfPcso0ePb/Lmn6hdEd53Uzd6ow3d
         UX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hs7nsjsykKZ3hTMp6zGOqOD3FYy+k3AZmDCkDxXVlgI=;
        b=f5i7T13xyv6+/JrbYjHqOwxRbPuoeOVPAOfj7UYBMiy/mypO2YRNGwO6um755UVX3m
         Io3+t3vVVDsTmIEE3UFm8U4ivSawuslEVMLGKJSFAngPeLSINa7KMOoNJ6pLKEanCg4f
         urwkDnueSMZpCU/trWqVsO+o/AGZMuGQC7jfq2ynrpYPFvQpMyXTgbF90IE/NCxvRf5I
         HYoh9riv+u58FM9DNFgePPPGGWVm5QAq39HKT6CxngTLDp5oxUf4Uu1cXZlEN4Le/cDk
         Sko4/ZERkvNKtJnr8RaM3GOFadqQhlLzX8VNoHZPBpktRZWsHbTAuBkmFGBG+MgEMwFd
         EqMA==
X-Gm-Message-State: AA+aEWb9GWoB7Lou08PPpC8q5/otY+u7kJVZ0CUbQ9rX7NGlXK9GPeGo
        ocQgDx7VEFESwLWj4ZeERFs=
X-Google-Smtp-Source: AFSGD/VJ7keuDE6Vb5zprXIi4rBza3JtM9pcb7SxDTMCXKrnRngDfqWSbiA3Feq9o8ET9u+/bYGZqw==
X-Received: by 2002:a17:902:4827:: with SMTP id s36mr5679758pld.168.1544866400900;
        Sat, 15 Dec 2018 01:33:20 -0800 (PST)
Received: from li1588-6.members.linode.com (li1588-6.members.linode.com. [139.162.104.6])
        by smtp.gmail.com with ESMTPSA id q1sm9616294pfb.96.2018.12.15.01.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 01:33:20 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: minor optimization for calculating packets_out in tcp connect
Date:   Sat, 15 Dec 2018 17:33:09 +0800
Message-Id: <1544866389-11168-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we building a syn packet, the tcp_skb_pcount(skb) is always 1,
which is set in tcp_init_nondata_skb().
Regarding the syn_data, it is set through
memcpy(syn_data->cb, syn->cb, sizeof(syn->cb)),
which is always 1 as well.

So we don't need to use tcp_skb_pcount(skb), that could give us a
little improvement.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 730bc44..12bb5e7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3404,7 +3404,7 @@ static void tcp_connect_queue_skb(struct sock *sk, struct sk_buff *skb)
 	sk->sk_wmem_queued += skb->truesize;
 	sk_mem_charge(sk, skb->truesize);
 	tp->write_seq = tcb->end_seq;
-	tp->packets_out += tcp_skb_pcount(skb);
+	tp->packets_out += 1;
 }
 
 /* Build and send a SYN with data and (cached) Fast Open cookie. However,
@@ -3486,7 +3486,7 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 
 	/* data was not sent, put it in write_queue */
 	__skb_queue_tail(&sk->sk_write_queue, syn_data);
-	tp->packets_out -= tcp_skb_pcount(syn_data);
+	tp->packets_out -= 1;
 
 fallback:
 	/* Send a regular SYN with Fast Open cookie request option */
-- 
1.8.3.1

