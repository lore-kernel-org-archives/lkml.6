Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A47FC65C33
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401442075C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd0RSb5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401442075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbeJGUoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 16:44:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35604 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeJGUoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 16:44:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so6684273pgb.2;
        Sun, 07 Oct 2018 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lX1/NsOGv1583M3f2ZWgefxWjBkUrBcgLtkxn/B7Q0w=;
        b=Cd0RSb5Ko9zmb8yTdj54E9xGVH8IKbt7GQviK12ph4/eLz+HZafFap3p0/5v68WelB
         ojBaIQVfnSSnFHsPHA4WtaLOf+5J6LYhn2L74wEYYJacgn9QxDr37an280geqk+G3isa
         Jik378ivnxeVFLYDwh55nfWJgSqrYdfF8lvT5fAp4N0vg+e9xhQd8IJh0r9lxQDYrvji
         Rd4PEwDIX97yg6MaYs1NPYObO0CClKAPp3EX6BTyJiSHojTsiPanJmL9/QxMhYooZPha
         NbyZuk+enWx8KOH94tSAXZcO0VYM05gVqb32Im2FRwlxM3e4V8Jg5AM2m0fYYN5Xr1KY
         +w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lX1/NsOGv1583M3f2ZWgefxWjBkUrBcgLtkxn/B7Q0w=;
        b=pjbCKnML/OGIoGWJKL/lAvaLAtaBz0VzcgOfHnk37uADiTf4QxqDg4KxH+/QEIlL6H
         AbkZCcGBray9Tpw4vzTeCDc1etMvrqvp8SI4Vc2ZNDgtiC5kGU2DLQVxb5GBY4LcLmmW
         TPY3E1TDTa+eFTUthSY3t6M6MNuO4MUh7A0jmzbYKnkBI4c5FPTJktWVuvr6x6Ao1n4O
         mAwZaEUFKWzzP2zspoYdSj6FGC5oWCu7rIg9eLQrRP6myDhLl8FAxAOcXisZL+MEU8lv
         wUwmJEPDgB87jpqV1XaThBgWbgQx3VuYzYXq3T8bO86R0aBDA2pTzB/OOBJ818LV5jTW
         G0Fg==
X-Gm-Message-State: ABuFfohCs7ft4q7pSOAGCqnCdEiN4ez3rvwACndQJThsUGbGii4gT8W7
        8XDpijBtooKniNFz8QCzDhk=
X-Google-Smtp-Source: ACcGV61qOhSc/zV8UN+Vo+C1mnA2Jn/1ttGxCrqkDjUlXGwuCn1h+pJAhYES2KCatloUcfsttR3rkQ==
X-Received: by 2002:a62:210:: with SMTP id 16-v6mr21477506pfc.100.1538919439648;
        Sun, 07 Oct 2018 06:37:19 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k71-v6sm18213602pge.44.2018.10.07.06.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 06:37:18 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 net-next] inet: do not set backlog if listen fails
Date:   Sun,  7 Oct 2018 21:36:45 +0800
Message-Id: <1538919405-3093-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to set the backlog if listen fails.
The sk_max_ack_backlog will be set in the caller inet_listen() and
dccp_listen_start() if inet_csk_listen_start() return without error.
So just remove this line to avoid this unnecessary operation.

Regarding sk_ack_backlog, we have to set it before a TCP/DCCP socket is
ready to accept new flows to avoid race, because dccp and tcp have lockless
listeners

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dfd5009..cdd5c95 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -871,7 +871,6 @@ int inet_csk_listen_start(struct sock *sk, int backlog)
 
 	reqsk_queue_alloc(&icsk->icsk_accept_queue);
 
-	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 	inet_csk_delack_init(sk);
 
-- 
1.8.3.1

