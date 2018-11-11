Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68231C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD2B214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD2B214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeKLGKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53528 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbeKLGKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:14 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt0-0000oO-MU; Sun, 11 Nov 2018 19:59:10 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001YF-Ap; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.727394231@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 141/366] l2tp: clean up stale tunnel or session in
 pppol2tp_connect's error path
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>

commit bda06be2158c7aa7e41b15500c4d3840369c19a6 upstream.

pppol2tp_connect() may create a tunnel or a session. Remove them in
case of error.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -634,6 +634,8 @@ static int pppol2tp_connect(struct socke
 	u32 session_id, peer_session_id;
 	bool drop_refcnt = false;
 	bool drop_tunnel = false;
+	bool new_session = false;
+	bool new_tunnel = false;
 	int ver = 2;
 	int fd;
 
@@ -744,6 +746,7 @@ static int pppol2tp_connect(struct socke
 				goto end;
 			}
 			drop_tunnel = true;
+			new_tunnel = true;
 		}
 	} else {
 		/* Error if we can't find the tunnel */
@@ -817,6 +820,7 @@ static int pppol2tp_connect(struct socke
 			goto end;
 		}
 		drop_refcnt = true;
+		new_session = true;
 	}
 
 	/* Special case: if source & dest session_id == 0x0000, this
@@ -863,6 +867,12 @@ out_no_ppp:
 		  session->name);
 
 end:
+	if (error) {
+		if (new_session)
+			l2tp_session_delete(session);
+		if (new_tunnel)
+			l2tp_tunnel_delete(tunnel);
+	}
 	if (drop_refcnt)
 		l2tp_session_dec_refcount(session);
 	if (drop_tunnel)

