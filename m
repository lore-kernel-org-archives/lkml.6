Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6DC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EE52084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfAUNym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:54:42 -0500
Received: from shell.v3.sk ([90.176.6.54]:50918 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731543AbfAUNyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:54:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 40C42CBB11;
        Mon, 21 Jan 2019 14:54:37 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NkSIUp1pNOHV; Mon, 21 Jan 2019 14:54:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 31551CBB19;
        Mon, 21 Jan 2019 14:54:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tavC4tvkhBjJ; Mon, 21 Jan 2019 14:54:33 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0ECA9CBB11;
        Mon, 21 Jan 2019 14:54:32 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thaller@redhat.com, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] net/ipv6: lower the level of "link is not ready" messages
Date:   Mon, 21 Jan 2019 14:54:20 +0100
Message-Id: <20190121135419.615989-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This message gets logged far too often for how interesting is it.

Most distributions nowadays configure NetworkManager to use randomly
generated MAC addresses for Wi-Fi network scans. The interfaces end up
being periodically brought down for the address change. When they're
subsequently brought back up, the message is logged, eventually flooding
the log.

Perhaps the message is not all that helpful: it seems to be more
interesting to hear when the addrconf actually start, not when it does
not. Let's lower its level.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 93d5ad2b1a69..ba155841dc15 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3495,8 +3495,8 @@ static int addrconf_notify(struct notifier_block *t=
his, unsigned long event,
=20
 			if (!addrconf_link_ready(dev)) {
 				/* device is not ready yet. */
-				pr_info("ADDRCONF(NETDEV_UP): %s: link is not ready\n",
-					dev->name);
+				pr_debug("ADDRCONF(NETDEV_UP): %s: link is not ready\n",
+					 dev->name);
 				break;
 			}
=20
--=20
2.20.1

