Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeE3LiK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:38:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60763 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752154AbeE3LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:01 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "" <syzbot+bdabab6f1983a03fc009@syzkaller.appspotmail.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.366131008@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 126/153] netfilter: bridge: ebt_among: add more
 missing match size checks
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
