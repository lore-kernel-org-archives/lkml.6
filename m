Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75070C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8D720671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NplTA12J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8D720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbeGZDrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:47:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39194 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbeGZDqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so331578edi.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+nsVfccIXqR+S2s/FyZy+sOs0AQ+AsIrQjblPhFpGGg=;
        b=NplTA12J5mSCev8mhqUxUht+a/25ULgNqetMEwZ6PRlFQuGxdGW//twADOquCS4/yF
         2Ws0aJFiJsrLuk0uu/NipEuRLw/r1HpNEm6a11u1N0lV32NsWug85mZdcsEw/KOMkfMT
         gN33shtYVb+5LzNYSo8U5F6bypy811dDa12iFzl7U7vkC4CewGkNC+BM425hlvfpGXuG
         BUYwsf0mjPPsyowuMA9X+kGR//BD3vgEkGcGXyFVbC/YgZw25Q2xrCzs4iScttiuvdfm
         N40EXU3+2zUZfI31xzb0HGul3Ov0A/kFZYyZxsDLYe8mqbP/XYsHYB/KYu+G31Mk6ZGK
         2CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+nsVfccIXqR+S2s/FyZy+sOs0AQ+AsIrQjblPhFpGGg=;
        b=fEgUxweqfaKfCgr8BUHElrgcGdVop8zeH+HCgcduwOOSGGYbFGVxyH4IMxIr8WvzVF
         WI5aBU+HNwZkXi/Pf5iEXlGsrSdkAGmu6ts59cXfAQJJ5gdvSg8QJUEJEkjuCXQL/7Db
         ErhAafnVlOPHh6ZiaaCuoduDKeztEyOMwKKcQff9ld2BE5LvBTBLL3V+LM2e2rY4rWR+
         j2dGYJkoFMwpeYSc0R0S5eMWjglPVAHixES68SAoBjYKGg7/POTLBiLcjKaxs1ZMuY95
         m8bHMSb7ro4UCfZqRkyDhY5vNKNty5Mi9C8pSLj4TGLTb/HVhkGDFr1xO6TbbJ+jf3Re
         A+Jw==
X-Gm-Message-State: AOUpUlGeHszc1DDFADTE7OQN1DZ+gyardTLOseI4UH87UDSfKADhjlo2
        iTuqpI77EWTQw4Acq5wXmUAAhyivb44=
X-Google-Smtp-Source: AAOMgpc0sqgA6HrTHbhBC7JBxAsriXp5F3MaUTNwtPs5CsMrnXaJB23Wu7peTttdGdJkKDv58Fj46A==
X-Received: by 2002:a50:d1c7:: with SMTP id i7-v6mr472873edg.169.1532572318771;
        Wed, 25 Jul 2018 19:31:58 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:58 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 11/18] xfrm: Add compat support for xfrm_user_expire messages
Date:   Thu, 26 Jul 2018 03:31:37 +0100
Message-Id: <20180726023144.31066-12-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse expire messages sent by userspace according to in_compat_syscall().
Applications that used native bind() syscall are in XFRMNLGRP_EXPIRE, so
send there xfrm_usersa_info messages (with 64-bit ABI). Compatible
applications are added to kernel-hidden XFRMNLGRP_COMPAT_EXPIRE group, so
send there xfrm_usersa_info messages_packed (with 32-bit ABI)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 95 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 30 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 230462077dc9..ca1a14f45cf7 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -67,6 +67,12 @@ struct xfrm_userspi_info_packed {
 	__u32				max;
 } __packed;
 
+struct xfrm_user_expire_packed {
+	struct xfrm_usersa_info_packed	state;
+	__u8				hard;
+	__u8				__pad[3];
+} __packed;
+
 /* In-kernel, non-uapi compat groups.
  * As compat/native messages differ, send notifications according
  * to .bind() caller's ABI. There are *_COMPAT hidden from userspace
@@ -2240,10 +2246,19 @@ static int xfrm_add_sa_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
 	int err;
-	struct xfrm_user_expire *ue = nlmsg_data(nlh);
-	struct xfrm_usersa_info_packed *p = (struct xfrm_usersa_info_packed *)&ue->state;
+	struct xfrm_user_expire_packed *ue = nlmsg_data(nlh);
+	struct xfrm_usersa_info_packed *p = &ue->state;
 	struct xfrm_mark m;
 	u32 mark = xfrm_mark_get(attrs, &m);
+	u8 hard;
+
+	if (in_compat_syscall()) {
+		hard = ue->hard;
+	} else {
+		struct xfrm_user_expire *expire = nlmsg_data(nlh);
+
+		hard = expire->hard;
+	}
 
 	x = xfrm_state_lookup(net, mark, &p->id.daddr, p->id.spi, p->id.proto, p->family);
 
@@ -2255,9 +2270,9 @@ static int xfrm_add_sa_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = -EINVAL;
 	if (x->km.state != XFRM_STATE_VALID)
 		goto out;
-	km_state_expired(x, ue->hard, nlh->nlmsg_pid);
+	km_state_expired(x, hard, nlh->nlmsg_pid);
 
-	if (ue->hard) {
+	if (hard) {
 		__xfrm_state_delete(x);
 		xfrm_audit_state_delete(x, 1, true);
 	}
@@ -2727,33 +2742,49 @@ static int xfrm_netlink_bind(struct net *net, unsigned long *groups)
 	return 0;
 }
 
-static inline unsigned int xfrm_expire_msgsize(void)
-{
-	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire))
-	       + nla_total_size(sizeof(struct xfrm_mark));
-}
-
-static int build_expire(struct sk_buff *skb, struct xfrm_state *x, const struct km_event *c)
+static int build_expire(struct sk_buff **skb, struct xfrm_state *x,
+		const struct km_event *c, bool compat)
 {
-	struct xfrm_user_expire *ue;
 	struct nlmsghdr *nlh;
+	unsigned int ue_sz;
 	int err;
 
-	nlh = nlmsg_put(skb, c->portid, 0, XFRM_MSG_EXPIRE, sizeof(*ue), 0);
-	if (nlh == NULL)
+	if (compat)
+		ue_sz = NLMSG_ALIGN(sizeof(struct xfrm_user_expire_packed));
+	else
+		ue_sz = NLMSG_ALIGN(sizeof(struct xfrm_user_expire));
+
+	*skb = nlmsg_new(ue_sz + nla_total_size(sizeof(struct xfrm_mark)), GFP_ATOMIC);
+	if (*skb == NULL)
+		return -ENOMEM;
+
+	nlh = nlmsg_put(*skb, c->portid, 0, XFRM_MSG_EXPIRE, ue_sz, 0);
+	if (nlh == NULL) {
+		kfree_skb(*skb);
 		return -EMSGSIZE;
+	}
 
-	ue = nlmsg_data(nlh);
-	copy_to_user_state(x, &ue->state);
-	ue->hard = (c->data.hard != 0) ? 1 : 0;
-	/* clear the padding bytes */
-	memset(&ue->hard + 1, 0, sizeof(*ue) - offsetofend(typeof(*ue), hard));
+	if (compat) {
+		struct xfrm_user_expire_packed *ue = nlmsg_data(nlh);
 
-	err = xfrm_mark_put(skb, &x->mark);
-	if (err)
+		copy_to_user_state_compat(x, &ue->state);
+		ue->hard = (c->data.hard != 0) ? 1 : 0;
+	} else {
+		struct xfrm_user_expire *ue = nlmsg_data(nlh);
+
+		copy_to_user_state(x, &ue->state);
+		ue->hard = (c->data.hard != 0) ? 1 : 0;
+		/* clear the padding bytes */
+		memset(&ue->hard + 1, 0, sizeof(*ue) - offsetofend(typeof(*ue), hard));
+	}
+
+	err = xfrm_mark_put(*skb, &x->mark);
+	if (err) {
+		kfree_skb(*skb);
 		return err;
+	}
 
-	nlmsg_end(skb, nlh);
+	nlmsg_end(*skb, nlh);
 	return 0;
 }
 
@@ -2761,17 +2792,21 @@ static int xfrm_exp_state_notify(struct xfrm_state *x, const struct km_event *c)
 {
 	struct net *net = xs_net(x);
 	struct sk_buff *skb;
+	int err;
 
-	skb = nlmsg_new(xfrm_expire_msgsize(), GFP_ATOMIC);
-	if (skb == NULL)
-		return -ENOMEM;
+	err = build_expire(&skb, x, c, false);
+	if (err)
+		return err;
 
-	if (build_expire(skb, x, c) < 0) {
-		kfree_skb(skb);
-		return -EMSGSIZE;
-	}
+	err = xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_EXPIRE);
+	if ((err && err != -ESRCH) || !IS_ENABLED(CONFIG_COMPAT))
+		return err;
 
-	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_EXPIRE);
+	err = build_expire(&skb, x, c, true);
+	if (err)
+		return err;
+
+	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_COMPAT_EXPIRE);
 }
 
 static int xfrm_aevent_state_notify(struct xfrm_state *x, const struct km_event *c)
-- 
2.13.6

