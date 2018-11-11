Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B61C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8E12080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8E12080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbeKLF45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52128 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbeKLF44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:56 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt1-0000lM-IF; Sun, 11 Nov 2018 19:59:11 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001Y0-6f; Sun, 11 Nov 2018 19:58:36 +0000
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
Message-ID: <lsq.1541965745.26439323@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 138/366] l2tp: fix pseudo-wire type for sessions
 created by pppol2tp_connect()
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

commit 90904ff5f958a215cc3d26f957a46e80fa178470 upstream.

Define cfg.pw_type so that the new session is created with its .pwtype
field properly set (L2TP_PWTYPE_PPP).

Not setting the pseudo-wire type had several annoying effects:

  * Invalid value returned in the L2TP_ATTR_PW_TYPE attribute when
    dumping sessions with the netlink API.

  * Impossibility to delete the session using the netlink API (because
    l2tp_nl_cmd_session_delete() gets the deletion callback function
    from an array indexed by the session's pseudo-wire type).

Also, there are several cases where we should check a session's
pseudo-wire type. For example, pppol2tp_connect() should refuse to
connect a session that is not PPPoL2TP, but that requires the session's
.pwtype field to be properly set.

Fixes: f7faffa3ff8e ("l2tp: Add L2TPv3 protocol support")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/l2tp/l2tp_ppp.c | 1 +
 1 file changed, 1 insertion(+)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -780,6 +780,7 @@ static int pppol2tp_connect(struct socke
 		/* Default MTU must allow space for UDP/L2TP/PPP headers */
 		cfg.mtu = 1500 - PPPOL2TP_HEADER_OVERHEAD;
 		cfg.mru = cfg.mtu;
+		cfg.pw_type = L2TP_PWTYPE_PPP;
 
 		session = l2tp_session_create(sizeof(struct pppol2tp_session),
 					      tunnel, session_id,

