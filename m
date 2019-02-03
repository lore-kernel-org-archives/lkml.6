Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2460C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35692177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfBCOUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55252 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729247AbfBCOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:02 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIcq-00064S-Q4; Sun, 03 Feb 2019 14:20:00 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9U-0006qA-Og; Sun, 03 Feb 2019 14:49:40 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "yujuan.qi" <yujuan.qi@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul Moore" <paul@paul-moore.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.853320914@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 038/305] Cipso: cipso_v4_optptr enter infinite loop
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "yujuan.qi" <yujuan.qi@mediatek.com>

commit 40413955ee265a5e42f710940ec78f5450d49149 upstream.

in for(),if((optlen > 0) && (optptr[1] == 0)), enter infinite loop.

Test: receive a packet which the ip length > 20 and the first byte of ip option is 0, produce this issue

Signed-off-by: yujuan.qi <yujuan.qi@mediatek.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/cipso_ipv4.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1606,9 +1606,17 @@ unsigned char *cipso_v4_optptr(const str
 	int taglen;
 
 	for (optlen = iph->ihl*4 - sizeof(struct iphdr); optlen > 0; ) {
-		if (optptr[0] == IPOPT_CIPSO)
+		switch (optptr[0]) {
+		case IPOPT_CIPSO:
 			return optptr;
-		taglen = optptr[1];
+		case IPOPT_END:
+			return NULL;
+		case IPOPT_NOOP:
+			taglen = 1;
+			break;
+		default:
+			taglen = optptr[1];
+		}
 		optlen -= taglen;
 		optptr += taglen;
 	}

