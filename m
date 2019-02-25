Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401CBC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF7E2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131998;
	bh=Sn5L+jtD3Lr9iMt/OTPT/W7s4Vzc+6pKne8vkUFjTw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yTad895tZsyFr7gsR0Rn2TdvfVxzrgnEoSOUiw8VjtwKYxT291YHODkiUChCa5Odc
	 vowh3cOb6cUAbn8uRJalM+R3FKVCOaSzl+DsprtLOIStPy7Vr3iDYqCITIgiaZElaW
	 nRjZ1WyyINccy8wxj6iAYbQEpIhdVwBCzkHfNZug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfBYVSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:18:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730127AbfBYVS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:18:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AFBC217F4;
        Mon, 25 Feb 2019 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129508;
        bh=Sn5L+jtD3Lr9iMt/OTPT/W7s4Vzc+6pKne8vkUFjTw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HS0fMOjZ76FYssqYg86VaOLz1b2ng+RaKehn60D79nATwIZkDsVu782vTFv8mw3KR
         +3l5fjjPCMvVkHbWD2d4uI6AYF90bMXrjHgjqaV2ehQBqSloKXlrs7LXY2FYqOV18y
         7U11/JjVEBsMUD/y2MCyaq7pYUWMe5hxLbb0WJsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 54/71] inet_diag: fix reporting cgroup classid and fallback to priority
Date:   Mon, 25 Feb 2019 22:11:56 +0100
Message-Id: <20190225195038.702300108@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit 1ec17dbd90f8b638f41ee650558609c1af63dfa0 ]

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

Fixes: 0888e372c37f ("net: inet: diag: expose sockets cgroup classid")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/inet_diag.h |   16 +++++++++++-----
 net/ipv4/inet_diag.c           |   10 +++++++++-
 net/sctp/sctp_diag.c           |    1 +
 3 files changed, 21 insertions(+), 6 deletions(-)

--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -135,15 +135,21 @@ enum {
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
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -109,6 +109,7 @@ static size_t inet_sk_attr_size(struct s
 		+ nla_total_size(1) /* INET_DIAG_TOS */
 		+ nla_total_size(1) /* INET_DIAG_TCLASS */
 		+ nla_total_size(4) /* INET_DIAG_MARK */
+		+ nla_total_size(4) /* INET_DIAG_CLASS_ID */
 		+ nla_total_size(sizeof(struct inet_diag_meminfo))
 		+ nla_total_size(sizeof(struct inet_diag_msg))
 		+ nla_total_size(SK_MEMINFO_VARS * sizeof(u32))
@@ -288,12 +289,19 @@ int inet_sk_diag_fill(struct sock *sk, s
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
--- a/net/sctp/sctp_diag.c
+++ b/net/sctp/sctp_diag.c
@@ -225,6 +225,7 @@ static size_t inet_assoc_attr_size(struc
 		+ nla_total_size(1) /* INET_DIAG_TOS */
 		+ nla_total_size(1) /* INET_DIAG_TCLASS */
 		+ nla_total_size(4) /* INET_DIAG_MARK */
+		+ nla_total_size(4) /* INET_DIAG_CLASS_ID */
 		+ nla_total_size(addrlen * asoc->peer.transport_count)
 		+ nla_total_size(addrlen * addrcnt)
 		+ nla_total_size(sizeof(struct inet_diag_meminfo))


