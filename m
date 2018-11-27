Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44408C04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE81208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE81208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbeK0TsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:48:06 -0500
Received: from ms.tdt.de ([195.243.126.94]:57610 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729598AbeK0TsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:48:05 -0500
Received: from localhost.localdomain (unknown [10.2.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 3DC0321C28;
        Tue, 27 Nov 2018 08:50:54 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     andrew.hendry@gmail.com, davem@davemloft.net
Cc:     stephen@networkplumber.org, joe@perches.com,
        anto.cardace@gmail.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 2/3] net/x25: fix null_x25_address handling
Date:   Tue, 27 Nov 2018 09:50:28 +0100
Message-Id: <20181127085029.9589-2-ms@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181127085029.9589-1-ms@dev.tdt.de>
References: <20181127085029.9589-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 o x25_find_listener(): the compare for the null_x25_address was wrong.
   We have to check the x25_addr of the listener socket instead of the
   x25_addr of the incomming call.

 o x25_bind(): it was not possible to bind a socket to null_x25_address

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 5226a7f43050..5121729b8b63 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -288,7 +288,7 @@ static struct sock *x25_find_listener(struct x25_address *addr,
 	sk_for_each(s, &x25_list)
 		if ((!strcmp(addr->x25_addr,
 			x25_sk(s)->source_addr.x25_addr) ||
-				!strcmp(addr->x25_addr,
+				!strcmp(x25_sk(s)->source_addr.x25_addr,
 					null_x25_address.x25_addr)) &&
 					s->sk_state == TCP_LISTEN) {
 			/*
@@ -688,11 +688,15 @@ static int x25_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		goto out;
 	}
 
-	len = strlen(addr->sx25_addr.x25_addr);
-	for (i = 0; i < len; i++) {
-		if (!isdigit(addr->sx25_addr.x25_addr[i])) {
-			rc = -EINVAL;
-			goto out;
+	/* check for the null_x25_address */
+	if (strcmp(addr->sx25_addr.x25_addr, null_x25_address.x25_addr)) {
+
+		len = strlen(addr->sx25_addr.x25_addr);
+		for (i = 0; i < len; i++) {
+			if (!isdigit(addr->sx25_addr.x25_addr[i])) {
+				rc = -EINVAL;
+				goto out;
+			}
 		}
 	}
 
-- 
2.11.0

