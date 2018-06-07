Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uCWdETU+GVseSQAAmS7hNA
	; Thu, 07 Jun 2018 14:16:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 35D29608B8; Thu,  7 Jun 2018 14:16:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6EDDC6063F;
	Thu,  7 Jun 2018 14:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EDDC6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeFGOQS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:16:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39583 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932919AbeFGOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:15 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0005Zs-La; Thu, 07 Jun 2018 15:09:13 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003Dx-Ez; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Florian Westphal" <fw@strlen.de>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "" <syzbot+bdabab6f1983a03fc009@syzkaller.appspotmail.com>,
        "Eric Dumazet" <edumazet@google.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.913164794@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 345/410] netfilter: bridge: ebt_among: add more
 missing match size checks
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

commit c8d70a700a5b486bfa8e5a7d33d805389f6e59f9 upstream.

ebt_among is special, it has a dynamic match size and is exempt
from the central size checks.

commit c4585a2823edf ("bridge: ebt_among: add missing match size checks")
added validation for pool size, but missed fact that the macros
ebt_among_wh_src/dst can already return out-of-bound result because
they do not check value of wh_src/dst_ofs (an offset) vs. the size
of the match that userspace gave to us.

v2:
check that offset has correct alignment.
Paolo Abeni points out that we should also check that src/dst
wormhash arrays do not overlap, and src + length lines up with
start of dst (or vice versa).
v3: compact wormhash_sizes_valid() part

NB: Fixes tag is intentionally wrong, this bug exists from day
one when match was added for 2.6 kernel. Tag is there so stable
maintainers will notice this one too.

Tested with same rules from the earlier patch.

Fixes: c4585a2823edf ("bridge: ebt_among: add missing match size checks")
Reported-by: <syzbot+bdabab6f1983a03fc009@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bridge/netfilter/ebt_among.c | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

--- a/net/bridge/netfilter/ebt_among.c
+++ b/net/bridge/netfilter/ebt_among.c
@@ -177,6 +177,28 @@ static bool poolsize_invalid(const struc
 	return w && w->poolsize >= (INT_MAX / sizeof(struct ebt_mac_wormhash_tuple));
 }
 
+static bool wormhash_offset_invalid(int off, unsigned int len)
+{
+	if (off == 0) /* not present */
+		return false;
+
+	if (off < (int)sizeof(struct ebt_among_info) ||
+	    off % __alignof__(struct ebt_mac_wormhash))
+		return true;
+
+	off += sizeof(struct ebt_mac_wormhash);
+
+	return off > len;
+}
+
+static bool wormhash_sizes_valid(const struct ebt_mac_wormhash *wh, int a, int b)
+{
+	if (a == 0)
+		a = sizeof(struct ebt_among_info);
+
+	return ebt_mac_wormhash_size(wh) + a == b;
+}
+
 static int ebt_among_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct ebt_among_info *info = par->matchinfo;
@@ -189,6 +211,10 @@ static int ebt_among_mt_check(const stru
 	if (expected_length > em->match_size)
 		return -EINVAL;
 
+	if (wormhash_offset_invalid(info->wh_dst_ofs, em->match_size) ||
+	    wormhash_offset_invalid(info->wh_src_ofs, em->match_size))
+		return -EINVAL;
+
 	wh_dst = ebt_among_wh_dst(info);
 	if (poolsize_invalid(wh_dst))
 		return -EINVAL;
@@ -201,6 +227,14 @@ static int ebt_among_mt_check(const stru
 	if (poolsize_invalid(wh_src))
 		return -EINVAL;
 
+	if (info->wh_src_ofs < info->wh_dst_ofs) {
+		if (!wormhash_sizes_valid(wh_src, info->wh_src_ofs, info->wh_dst_ofs))
+			return -EINVAL;
+	} else {
+		if (!wormhash_sizes_valid(wh_dst, info->wh_dst_ofs, info->wh_src_ofs))
+			return -EINVAL;
+	}
+
 	expected_length += ebt_mac_wormhash_size(wh_src);
 
 	if (em->match_size != EBT_ALIGN(expected_length)) {
