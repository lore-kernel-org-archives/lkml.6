Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290E7C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90C0218D2
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 10:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="S+MJHKi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBIKgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 05:36:01 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:50643 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbfBIKgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 05:36:00 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 9FA07214CB;
        Sat,  9 Feb 2019 13:35:55 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mg3O0Hc126-ZtAOOOlR;
        Sat, 09 Feb 2019 13:35:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1549708555; bh=weyGSSPZTmzjDJkPPv/JM9hqiCOaD0wRkWhVqPbumqE=;
        h=Subject:From:To:Cc:Date:Message-ID;
        b=S+MJHKi/+mmLPdNeYXMQXJewt0RmoNCWvRJp9S9/p18q2jPAI8SC+6XTfqt6AcwHu
         bjPu0cnuO0kYE+4achFNMvULmlnsuExo5VnRY5qw9uGH2Gr2NWOWUSQS05q4XFPTtr
         Ab2xIPypRzyPxZb/5a0uXiDFU6PwHxJ0AMnijgCk=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:b010:d002::1:62])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id p2ovsD1V36-ZtjCtWY4;
        Sat, 09 Feb 2019 13:35:55 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] inet_diag: fix reporting cgroup classid and fallback to
 priority
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sasha Levin <sashal@kernel.org>, linux-sctp@vger.kernel.org
Date:   Sat, 09 Feb 2019 13:35:52 +0300
Message-ID: <154970855279.305165.13649851988934332761.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Field idiag_ext in struct inet_diag_req_v2 used as bitmap of requested
extensions has only 8 bits. Thus extensions starting from DCTCPINFO
cannot be requested directly. Some of them included into response
unconditionally or hook into some of lower 8 bits.

Extension INET_DIAG_CLASS_ID has not way to request from the beginning.

This patch bundle it with INET_DIAG_TCLASS (ipv6 tos), fixes space
reservation, and documents behavior for other extensions.

Also this patch adds fallback to reporting socket priority. This filed
is more widely used for traffic classification because ipv4 sockets
automatically maps TOS to priority and default qdisc pfifo_fast knows
about that. But priority could be changed via setsockopt SO_PRIORITY so
INET_DIAG_TOS isn't enough for predicting class.

Also cgroup2 obsoletes net_cls classid (it always zero), but we cannot
reuse this field for reporting cgroup2 id because it is 64-bit (ino+gen).

So, after this patch INET_DIAG_CLASS_ID will report socket priority
for most common setup when net_cls isn't set and/or cgroup2 in use.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 0888e372c37f ("net: inet: diag: expose sockets cgroup classid")
---
 include/uapi/linux/inet_diag.h |   16 +++++++++++-----
 net/ipv4/inet_diag.c           |   10 +++++++++-
 net/sctp/diag.c                |    1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index 14565d703291..e8baca85bac6 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -137,15 +137,21 @@ enum {
 	INET_DIAG_TCLASS,
 	INET_DIAG_SKMEMINFO,
 	INET_DIAG_SHUTDOWN,
-	INET_DIAG_DCTCPINFO,
-	INET_DIAG_PROTOCOL,  /* response attribute only */
+
+	/*
+	 * Next extenstions cannot be requested in struct inet_diag_req_v2:
+	 * its field idiag_ext has only 8 bits.
+	 */
+
+	INET_DIAG_DCTCPINFO,	/* request as INET_DIAG_VEGASINFO */
+	INET_DIAG_PROTOCOL,	/* response attribute only */
 	INET_DIAG_SKV6ONLY,
 	INET_DIAG_LOCALS,
 	INET_DIAG_PEERS,
 	INET_DIAG_PAD,
-	INET_DIAG_MARK,
-	INET_DIAG_BBRINFO,
-	INET_DIAG_CLASS_ID,
+	INET_DIAG_MARK,		/* only with CAP_NET_ADMIN */
+	INET_DIAG_BBRINFO,	/* request as INET_DIAG_VEGASINFO */
+	INET_DIAG_CLASS_ID,	/* request as INET_DIAG_TCLASS */
 	INET_DIAG_MD5SIG,
 	__INET_DIAG_MAX,
 };
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 1a4e9ff02762..5731670c560b 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -108,6 +108,7 @@ static size_t inet_sk_attr_size(struct sock *sk,
 		+ nla_total_size(1) /* INET_DIAG_TOS */
 		+ nla_total_size(1) /* INET_DIAG_TCLASS */
 		+ nla_total_size(4) /* INET_DIAG_MARK */
+		+ nla_total_size(4) /* INET_DIAG_CLASS_ID */
 		+ nla_total_size(sizeof(struct inet_diag_meminfo))
 		+ nla_total_size(sizeof(struct inet_diag_msg))
 		+ nla_total_size(SK_MEMINFO_VARS * sizeof(u32))
@@ -287,12 +288,19 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 			goto errout;
 	}
 
-	if (ext & (1 << (INET_DIAG_CLASS_ID - 1))) {
+	if (ext & (1 << (INET_DIAG_CLASS_ID - 1)) ||
+	    ext & (1 << (INET_DIAG_TCLASS - 1))) {
 		u32 classid = 0;
 
 #ifdef CONFIG_SOCK_CGROUP_DATA
 		classid = sock_cgroup_classid(&sk->sk_cgrp_data);
 #endif
+		/* Fallback to socket priority if class id isn't set.
+		 * Classful qdiscs use it as direct reference to class.
+		 * For cgroup2 classid is always zero.
+		 */
+		if (!classid)
+			classid = sk->sk_priority;
 
 		if (nla_put_u32(skb, INET_DIAG_CLASS_ID, classid))
 			goto errout;
diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 078f01a8d582..435847d98b51 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -256,6 +256,7 @@ static size_t inet_assoc_attr_size(struct sctp_association *asoc)
 		+ nla_total_size(1) /* INET_DIAG_TOS */
 		+ nla_total_size(1) /* INET_DIAG_TCLASS */
 		+ nla_total_size(4) /* INET_DIAG_MARK */
+		+ nla_total_size(4) /* INET_DIAG_CLASS_ID */
 		+ nla_total_size(addrlen * asoc->peer.transport_count)
 		+ nla_total_size(addrlen * addrcnt)
 		+ nla_total_size(sizeof(struct inet_diag_meminfo))

