Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF1BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6CD20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6CD20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbeKLGWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:22:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50174 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730278AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000l7-D7; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001ox-0w; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.722520331@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 309/366] l2tp: fix missing refcount drop in
 pppol2tp_tunnel_ioctl()
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

commit f664e37dcc525768280cb94321424a09beb1c992 upstream.

If 'session' is not NULL and is not a PPP pseudo-wire, then we fail to
drop the reference taken by l2tp_session_get().

Fixes: ecd012e45ab5 ("l2tp: filter out non-PPP sessions in pppol2tp_tunnel_ioctl()")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: Also call session->deref in both cases]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1231,15 +1231,22 @@ static int pppol2tp_tunnel_ioctl(struct
 				l2tp_session_get(sock_net(sk), tunnel,
 						 stats.session_id, true);
 
-			if (session && session->pwtype == L2TP_PWTYPE_PPP) {
-				err = pppol2tp_session_ioctl(session, cmd,
-							     arg);
+			if (!session) {
+				err = -EBADR;
+				break;
+			}
+			if (session->pwtype != L2TP_PWTYPE_PPP) {
 				if (session->deref)
 					session->deref(session);
 				l2tp_session_dec_refcount(session);
-			} else {
 				err = -EBADR;
+				break;
 			}
+
+			err = pppol2tp_session_ioctl(session, cmd, arg);
+			if (session->deref)
+				session->deref(session);
+			l2tp_session_dec_refcount(session);
 			break;
 		}
 #ifdef CONFIG_XFRM

