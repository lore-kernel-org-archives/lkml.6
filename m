Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E66CC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7B220835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7B220835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeJNXMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36391 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728249AbeJNXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:07 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004cW-CK; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000U0-9N; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Neil Horman" <nhorman@tuxdriver.com>,
        "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Xin Long" <lucien.xin@gmail.com>,
        syzbot+cd494c1dd681d4d93ebb@syzkaller.appspotmail.com
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.670958898@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 238/366] sctp: handle two v4 addrs comparison in
 sctp_inet6_cmp_addr
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit d625329b06e46bd20baf9ee40847d11982569204 upstream.

Since sctp ipv6 socket also supports v4 addrs, it's possible to
compare two v4 addrs in pf v6 .cmp_addr, sctp_inet6_cmp_addr.

However after Commit 1071ec9d453a ("sctp: do not check port in
sctp_inet6_cmp_addr"), it no longer calls af1->cmp_addr, which
in this case is sctp_v4_cmp_addr, but calls __sctp_v6_cmp_addr
where it handles them as two v6 addrs. It would cause a out of
bounds crash.

syzbot found this crash when trying to bind two v4 addrs to a
v6 socket.

This patch fixes it by adding the process for two v4 addrs in
sctp_inet6_cmp_addr.

Fixes: 1071ec9d453a ("sctp: do not check port in sctp_inet6_cmp_addr")
Reported-by: syzbot+cd494c1dd681d4d93ebb@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/ipv6.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -840,6 +840,9 @@ static int sctp_inet6_cmp_addr(const uni
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
 
+	if (addr1->sa.sa_family == AF_INET && addr2->sa.sa_family == AF_INET)
+		return addr1->v4.sin_addr.s_addr == addr2->v4.sin_addr.s_addr;
+
 	return __sctp_v6_cmp_addr(addr1, addr2);
 }
 

