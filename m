Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A5CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0582080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTTC98pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbeLNVMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:12:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45754 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbeLNVMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:12:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so5272590lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 13:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyNnUR4lfp/hoy1rKAT2aYL4FMj9E3HybgGC/oR7mho=;
        b=KTTC98piaTj0WoYaI4cfpgCrMgv52G2aSZ5Cth1Hq8a38qUM7NQyNvnv95AO6a2XSc
         cAtgsvbmnHavFmJmCLtCJ0Q1Zfi9xQ4R6Nc7qbXDnK40nKiA0p6Qo8k60+peRor/YxXm
         hwfsX/TO/4ohhNm/F0C7AdcOfaTzsonNjooz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyNnUR4lfp/hoy1rKAT2aYL4FMj9E3HybgGC/oR7mho=;
        b=iem0Lwn0WZbXZdnBJ1W5dFS08cu7k5hFAL58RTpymyPth1tCZbHcj7s0RixcDfnarZ
         lmA9FwTWozu13XhqgMfKt6CTmxikYzY1CyULL9lDftguG1MO5AFAK65ketmttME9fZI1
         8pmW0tZpDD+r+gXANx+Hi1TswyJ5oXp6u2pVP4e6XmVyakY/JNr8XfRqVMJh5LUfsrO7
         UNVutILtXc+7TVJRYVzahoJo2z/vXsVkFOkBBfpD7aaq4eR8girlfy7fz0skYcBRuohC
         f2vRqifvWODeRKsUQK7S7cBtz+d+m6x1gKJOzQjANIaCM+oqq+H5fNXm4yfjtYHoRC6U
         cj7w==
X-Gm-Message-State: AA+aEWYuV3y+PaztzdT+orqNuDmVhhCou9W/Omo7w+pO/uKljQXQeNmS
        6pLHdWIFAuQ0kzsZ3mAnuAAJRA==
X-Google-Smtp-Source: AFSGD/V7FYbwn4oyw6kXjNmdUu/hXhOQPZGIlTuc1nJ5YrvWETXczN4B25LUMPe/nhYqDZZdV5b2Xg==
X-Received: by 2002:a19:5782:: with SMTP id l124mr2569905lfb.91.1544821964480;
        Fri, 14 Dec 2018 13:12:44 -0800 (PST)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id u15-v6sm1190636lja.63.2018.12.14.13.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 13:12:44 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     James Chapman <jchapman@katalix.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guillaume Nault <g.nault@alphalink.fr>
Subject: [PATCH 2/2] l2tp: Add Protocol field compression
Date:   Fri, 14 Dec 2018 23:12:42 +0200
Message-Id: <20181214211242.9721-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181214211242.9721-1-semen.protsenko@linaro.org>
References: <20181214211242.9721-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Protocol Field Compression (PFC) is enabled, the "Protocol" field
in PPP packet should be transmitted without leading 0x00. See section
6.5 in RFC 1661 for details. Let's compress protocol field if needed,
the same way it's done in drivers/net/ppp/pptp.c.

To actually enable PFC, one should issue corresponding ioctl to L2TP
driver from user-space, like this:

    ioctl(fd, PPPIOCGFLAGS, &flags);
    flags |= SC_COMP_PROT;
    ioctl(fd, PPPIOCSFLAGS, &flags);

It can be done e.g. from pppol2tp plugin (pppd), when pcomp option was
negotiated with peer.

Of course, we don't compress Protocol field when sending LCP packets. As
stated in RFC 1661, section 6.5:

    The Protocol field is never compressed when sending any LCP
    packet.  This rule guarantees unambiguous recognition of LCP
    packets.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 net/l2tp/l2tp_ppp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 145435977b21..7860b219af07 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -363,7 +363,10 @@ static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	struct sock *sk = (struct sock *) chan->private;
 	struct l2tp_session *session;
 	struct l2tp_tunnel *tunnel;
+	struct pppol2tp_session *ps;
 	int uhlen, headroom;
+	unsigned char *data;
+	bool is_lcp;
 
 	if (sock_flag(sk, SOCK_DEAD) || !(sk->sk_state & PPPOX_CONNECTED))
 		goto abort;
@@ -384,6 +387,15 @@ static int pppol2tp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	if (skb_cow_head(skb, headroom))
 		goto abort_put_sess;
 
+	ps = l2tp_session_priv(session);
+	data = skb->data;
+	is_lcp = ((data[0] << 8) + data[1]) == PPP_LCP &&
+		data[2] >= 1 && data[2] <= 7;
+
+	/* Compress protocol field if PFC is enabled */
+	if ((ps->flags & SC_COMP_PROT) && data[0] == 0x00 && !is_lcp)
+		__skb_pull(skb, 1);
+
 	/* Setup PPP header */
 	__skb_push(skb, 2);
 	skb->data[0] = PPP_ALLSTATIONS;
-- 
2.19.1

