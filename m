Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652B5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33957208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33957208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbeK0TsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:48:10 -0500
Received: from ms.tdt.de ([195.243.126.94]:57616 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729598AbeK0TsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:48:09 -0500
Received: from localhost.localdomain (unknown [10.2.3.20])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 0545721C2B;
        Tue, 27 Nov 2018 08:50:58 +0000 (UTC)
From:   Martin Schiller <ms@dev.tdt.de>
To:     andrew.hendry@gmail.com, davem@davemloft.net
Cc:     stephen@networkplumber.org, joe@perches.com,
        anto.cardace@gmail.com, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 3/3] net/x25: handle call collisions
Date:   Tue, 27 Nov 2018 09:50:29 +0100
Message-Id: <20181127085029.9589-3-ms@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181127085029.9589-1-ms@dev.tdt.de>
References: <20181127085029.9589-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a session in X25_STATE_1 (Awaiting Call Accept) receives a call
request, the session will be closed (x25_disconnect), cause=0x01
(Number Busy) and diag=0x48 (Call Collision) will be set and a clear
request will be send.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/x25_in.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index 3c12cae32001..afb26221d8a8 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -142,6 +142,15 @@ static int x25_state1_machine(struct sock *sk, struct sk_buff *skb, int frametyp
 			sk->sk_state_change(sk);
 		break;
 	}
+	case X25_CALL_REQUEST:
+		/* call collision */
+		x25->causediag.cause      = 0x01;
+		x25->causediag.diagnostic = 0x48;
+
+		x25_write_internal(sk, X25_CLEAR_REQUEST);
+		x25_disconnect(sk, EISCONN, 0x01, 0x48);
+		break;
+
 	case X25_CLEAR_REQUEST:
 		if (!pskb_may_pull(skb, X25_STD_MIN_LEN + 2))
 			goto out_clear;
-- 
2.11.0

