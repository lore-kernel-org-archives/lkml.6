Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF803C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA422173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PavYGaQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfBZIlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:41:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35060 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBZIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:41:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id p19so5904291plo.2;
        Tue, 26 Feb 2019 00:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BnA2MaR4Gmg7VAs81Et+/kpV/3L9Ur9zUoOX1y58Wh4=;
        b=PavYGaQqdp64Ry3BuRfu4kIystwf0p08qLkFcwZMCaDrOUUiYVNf4IygduheDVh7oH
         DnN4bCxWQDEQJtloxjSvN8GA8VhhAXf6/OnU1gWFQwFNR9tzVSTrBFNguehNC5y6jko4
         LFCwFT+JgptiRnL4byjwJOhnZ1l7P4ZbtoEC5OFBnnzDWDG3TORIY0NKkydAyQttIdem
         SD7pMYNeSiBL5brxe9X7yFyZb497kAHj6Q0TWT5AwzRqshX4V/DhElZXa9iafHPlUTn7
         WeZ2W0e2ufG1AD0DH0bkpGEvm9RNQJMpGFVYQkzVbq9C8bjKqdwVjsjRItuGlzgLQSie
         BW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BnA2MaR4Gmg7VAs81Et+/kpV/3L9Ur9zUoOX1y58Wh4=;
        b=fMvEgJP/RovHomXn9v6HEOE6WJKk01a1yLd/AJ2LVkLcOYN84liYlPiFWb1SpgKbg4
         SO8Ez+F0gYdANBZ3uei7D0VwkmgignUsd/PpI4/1Xv3xKKCbz2hQONO5sjtTAzBKw+/O
         3D58SEehQOvSdmZhNGDfLF9yuxTIoByj/GhHS+FYSVJdjNvpL2dfLMtYiycF/fcxf7iL
         vIxKrVQe/03oK7WoQIryP/Br5mTuB3OEo7TsicSaRtpzv0BKbiEpek9yPfEW5p4+0JSd
         peH2Ze7WO41RxhWU0uO8tN/8YpXO9/vLths11hytUpS3RLWcrisls66L0CT30yNQjLeJ
         rflw==
X-Gm-Message-State: AHQUAubl3tEPvleQphqsIf5GyVLE/cGIxAXKnWzRHV9J1CuDUV4ThIYb
        juuXPBDvbBtYTokCYU4Jdvo=
X-Google-Smtp-Source: AHgI3IapZHdMfAloaPB5fXhtlNePhJds8KQYqfn/sHsxEkqqRpVtaDUX2yZlswQVDdBpBf44lSRmYQ==
X-Received: by 2002:a17:902:9894:: with SMTP id s20mr24900530plp.135.1551170466796;
        Tue, 26 Feb 2019 00:41:06 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c18sm2531691pfo.44.2019.02.26.00.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 00:41:05 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     Geliang Tang <geliangtang@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tcp: fix __tcp_transmit_skb's comment text
Date:   Tue, 26 Feb 2019 16:41:01 +0800
Message-Id: <5599b6d78fa7f5a05d40123d43f955174c2c5baa.1551169935.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function name tcp_do_sendmsg has been renamed. But it still
appears in __tcp_transmit_skb's comment text. This patch changes
it to tcp_sendmsg_locked.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e72aa0ff5785..67a43b966b8a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1003,7 +1003,7 @@ static void tcp_update_skb_after_send(struct sock *sk, struct sk_buff *skb,
 }
 
 /* This routine actually transmits TCP packets queued in by
- * tcp_do_sendmsg().  This is used by both the initial
+ * tcp_sendmsg_locked().  This is used by both the initial
  * transmission and possible later retransmissions.
  * All SKB's seen here are completely headerless.  It is our
  * job to build the TCP header, and pass the packet down to
-- 
2.17.1

