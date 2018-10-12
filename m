Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C9CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438252077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438252077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeJLSGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:06:10 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:51718 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726788AbeJLSGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:06:10 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 12 Oct 2018 19:34:22 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: kyeongdon.kim@lge.com
Received: from unknown (HELO localhost.localdomain) (10.168.176.142)
        by 156.147.1.121 with ESMTP; 12 Oct 2018 19:34:22 +0900
X-Original-SENDERIP: 10.168.176.142
X-Original-MAILFROM: kyeongdon.kim@lge.com
From:   Kyeongdon Kim <kyeongdon.kim@lge.com>
To:     davem@davemloft.net, ktkhai@virtuozzo.com, viro@zeniv.linux.org.uk,
        garsilva@embeddedor.com, jbaron@akamai.com, dvlasenk@redhat.com,
        xiyou.wangcong@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kyeongdon.kim@lge.com
Subject: [PATCH] net: fix waring in af_unix
Date:   Fri, 12 Oct 2018 19:34:14 +0900
Message-Id: <1539340454-67970-1-git-send-email-kyeongdon.kim@lge.com>
X-Mailer: git-send-email 2.6.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the "'hash' may be used uninitialized in this function"

net/unix/af_unix.c:1041:20: warning: 'hash' may be used uninitialized in this function [-Wmaybe-uninitialized]
  addr->hash = hash ^ sk->sk_type;
                      ^

Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d1edfa3..e6cecc8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -989,7 +989,7 @@ static int unix_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	struct sockaddr_un *sunaddr = (struct sockaddr_un *)uaddr;
 	char *sun_path = sunaddr->sun_path;
 	int err;
-	unsigned int hash;
+	unsigned int hash = 0;
 	struct unix_address *addr;
 	struct hlist_head *list;
 	struct path path = { };
-- 
2.6.2

