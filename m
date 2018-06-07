Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tBd9Ht1HGVsBQQAAmS7hNA
	; Thu, 07 Jun 2018 14:58:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AFC7C608C1; Thu,  7 Jun 2018 14:58:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1C0726074D;
	Thu,  7 Jun 2018 14:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C0726074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935549AbeFGO6l (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:58:41 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41197 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932568AbeFGO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:58:35 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbQ-0005Zp-7E; Thu, 07 Jun 2018 15:09:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003Do-E8; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "" <syzbot+fe0b19af568972814355@syzkaller.appspotmail.com>,
        "Florian Westphal" <fw@strlen.de>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.765702542@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 344/410] netfilter: bridge: ebt_among: add missing
 match size checks
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit c4585a2823edf4d1326da44d1524ecbfda26bb37 upstream.

ebt_among is special, it has a dynamic match size and is exempt
from the central size checks.

Therefore it must check that the size of the match structure
provided from userspace is sane by making sure em->match_size
is at least the minimum size of the expected structure.

The module has such a check, but its only done after accessing
a structure that might be out of bounds.

tested with: ebtables -A INPUT ... \
--among-dst fe:fe:fe:fe:fe:fe
--among-dst fe:fe:fe:fe:fe:fe --among-src fe:fe:fe:fe:ff:f,fe:fe:fe:fe:fe:fb,fe:fe:fe:fe:fc:fd,fe:fe:fe:fe:fe:fd,fe:fe:fe:fe:fe:fe
--among-src fe:fe:fe:fe:ff:f,fe:fe:fe:fe:fe:fa,fe:fe:fe:fe:fe:fd,fe:fe:fe:fe:fe:fe,fe:fe:fe:fe:fe:fe

Reported-by: <syzbot+fe0b19af568972814355@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bridge/netfilter/ebt_among.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/net/bridge/netfilter/ebt_among.c
+++ b/net/bridge/netfilter/ebt_among.c
@@ -172,18 +172,35 @@ ebt_among_mt(const struct sk_buff *skb,
 	return true;
 }
 
+static bool poolsize_invalid(const struct ebt_mac_wormhash *w)
+{
+	return w && w->poolsize >= (INT_MAX / sizeof(struct ebt_mac_wormhash_tuple));
+}
+
 static int ebt_among_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct ebt_among_info *info = par->matchinfo;
 	const struct ebt_entry_match *em =
 		container_of(par->matchinfo, const struct ebt_entry_match, data);
-	int expected_length = sizeof(struct ebt_among_info);
+	unsigned int expected_length = sizeof(struct ebt_among_info);
 	const struct ebt_mac_wormhash *wh_dst, *wh_src;
 	int err;
 
+	if (expected_length > em->match_size)
+		return -EINVAL;
+
 	wh_dst = ebt_among_wh_dst(info);
-	wh_src = ebt_among_wh_src(info);
+	if (poolsize_invalid(wh_dst))
+		return -EINVAL;
+
 	expected_length += ebt_mac_wormhash_size(wh_dst);
+	if (expected_length > em->match_size)
+		return -EINVAL;
+
+	wh_src = ebt_among_wh_src(info);
+	if (poolsize_invalid(wh_src))
+		return -EINVAL;
+
 	expected_length += ebt_mac_wormhash_size(wh_src);
 
 	if (em->match_size != EBT_ALIGN(expected_length)) {
