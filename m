Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7446AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE37206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuhENEoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbeLNR7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:59:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39657 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbeLNR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:59:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so4901328lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRJbbr64lvVh0lL0pj1PYc1G/ooZr74kh6CTU1AQsCc=;
        b=HuhENEoi/whKaG+A+YSurhvmK8qQwGvJAZrDquZ65idKa1wrw78E8tyVBKOB16GiQY
         0ATLMmjlultFzOxK9KdubWaRhfscmYv3G+RuInbsHirVVWeW91gl6R36Yn255FLsFJyN
         /S7DvRNopo1fxUQ1pDOq6BrUdggpOVokCMhPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRJbbr64lvVh0lL0pj1PYc1G/ooZr74kh6CTU1AQsCc=;
        b=ifdYpk25VNguK+ynsvImSkiBvf6TDS+3/3w4jjGkAanI3scWbnLLe+TTJ9kZPs7PdA
         dEpcfUmpVM1FYLHHkDIXmrz0M4O4MYavkjaZlz17VbJLaClmZ0oEacmQTi5tipDqBY+k
         RptDy01aHQmVUG5SN6ZYZHixiXJ6bi/4wJpYcTRpGW2EYMeHbFC7g14fDPmDCN6lwRA6
         xq1iWnrk0s7c/BeqCXPQNa3ukSIhx/gZ8ZL27q/skvluPjv7QemmFpIgDSNVoJWUDIMH
         EmjgPNbWP/mI/AokR93N/TPPGiY1OpNARbgsH9kgLUyxvr5ahx7HnxO+HuCBhqALT9as
         cVZg==
X-Gm-Message-State: AA+aEWYmbVXl7bwihXrMS6RXehkxCvHWG4N6oAL5bKKlSa9Z2ejsc/JR
        AzpDqa/zbCDAgpdQGDq1FRJO1A==
X-Google-Smtp-Source: AFSGD/WHMJt9n1z+tUXnOAESctE90P3rY/wEHV93tSJIfHPL/2/+IstUs4iOlKxhLmKFsgL5H8fZrA==
X-Received: by 2002:a19:1a14:: with SMTP id a20mr2291788lfa.1.1544810362450;
        Fri, 14 Dec 2018 09:59:22 -0800 (PST)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id r29-v6sm930739ljd.44.2018.12.14.09.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 09:59:21 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH] l2tp: Add protocol field decompression
Date:   Fri, 14 Dec 2018 19:59:21 +0200
Message-Id: <20181214175921.6859-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Protocol Field Compression (PFC) is enabled, the "Protocol" field
in PPP packet will be received without leading 0x00. See section 6.5 in
RFC 1661 for details. So let's decompress protocol field if needed, the
same way it's done in drivers/net/ppp/pptp.c.

In case when "nopcomp" pppd option is not enabled, PFC (pcomp) can be
negotiated during LCP handshake, and L2TP driver in kernel will receive
PPP packets with compressed Protocol field, which in turn leads to next
error:

    Protocol Rejected (unsupported protocol 0x2145)

because instead of Protocol=0x0021 in PPP packet there will be
Protocol=0x21. This patch unwraps it back to 0x0021, which fixes the
issue.

Sending the compressed Protocol field will be implemented in subsequent
patch, this one is self-sufficient.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 net/l2tp/l2tp_ppp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 04d9946dcdba..c03c6461f236 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -236,6 +236,10 @@ static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int
 	    skb->data[1] == PPP_UI)
 		skb_pull(skb, 2);
 
+	/* Decompress protocol field if PFC is enabled */
+	if ((*skb->data) & 0x1)
+		*(u8 *)skb_push(skb, 1) = 0;
+
 	if (sk->sk_state & PPPOX_BOUND) {
 		struct pppox_sock *po;
 
-- 
2.19.1

