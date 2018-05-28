Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936484AbeE1KKX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933629AbeE1KKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:10:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 076/185] netfilter: ebtables: convert BUG_ONs to WARN_ONs
Date: Mon, 28 May 2018 12:01:57 +0200
Message-Id: <20180528100057.221774162@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit fc6a5d0601c5ac1d02f283a46f60b87b2033e5ca ]

All of these conditions are not fatal and should have
been WARN_ONs from the get-go.

Convert them to WARN_ONs and bail out.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/netfilter/ebtables.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1612,7 +1612,8 @@ static int compat_match_to_user(struct e
 	int off = ebt_compat_match_offset(match, m->match_size);
 	compat_uint_t msize = m->match_size - off;
 
-	BUG_ON(off >= m->match_size);
+	if (WARN_ON(off >= m->match_size))
+		return -EINVAL;
 
 	if (copy_to_user(cm->u.name, match->name,
 	    strlen(match->name) + 1) || put_user(msize, &cm->match_size))
@@ -1639,7 +1640,8 @@ static int compat_target_to_user(struct
 	int off = xt_compat_target_offset(target);
 	compat_uint_t tsize = t->target_size - off;
 
-	BUG_ON(off >= t->target_size);
+	if (WARN_ON(off >= t->target_size))
+		return -EINVAL;
 
 	if (copy_to_user(cm->u.name, target->name,
 	    strlen(target->name) + 1) || put_user(tsize, &cm->match_size))
@@ -1867,7 +1869,8 @@ static int ebt_buf_add(struct ebt_entrie
 	if (state->buf_kern_start == NULL)
 		goto count_only;
 
-	BUG_ON(state->buf_kern_offset + sz > state->buf_kern_len);
+	if (WARN_ON(state->buf_kern_offset + sz > state->buf_kern_len))
+		return -EINVAL;
 
 	memcpy(state->buf_kern_start + state->buf_kern_offset, data, sz);
 
@@ -1880,7 +1883,8 @@ static int ebt_buf_add_pad(struct ebt_en
 {
 	char *b = state->buf_kern_start;
 
-	BUG_ON(b && state->buf_kern_offset > state->buf_kern_len);
+	if (WARN_ON(b && state->buf_kern_offset > state->buf_kern_len))
+		return -EINVAL;
 
 	if (b != NULL && sz > 0)
 		memset(b + state->buf_kern_offset, 0, sz);
@@ -1957,8 +1961,10 @@ static int compat_mtw_from_user(struct c
 	pad = XT_ALIGN(size_kern) - size_kern;
 
 	if (pad > 0 && dst) {
-		BUG_ON(state->buf_kern_len <= pad);
-		BUG_ON(state->buf_kern_offset - (match_size + off) + size_kern > state->buf_kern_len - pad);
+		if (WARN_ON(state->buf_kern_len <= pad))
+			return -EINVAL;
+		if (WARN_ON(state->buf_kern_offset - (match_size + off) + size_kern > state->buf_kern_len - pad))
+			return -EINVAL;
 		memset(dst + size_kern, 0, pad);
 	}
 	return off + match_size;
@@ -2009,7 +2015,8 @@ static int ebt_size_mwt(struct compat_eb
 		if (ret < 0)
 			return ret;
 
-		BUG_ON(ret < match32->match_size);
+		if (WARN_ON(ret < match32->match_size))
+			return -EINVAL;
 		growth += ret - match32->match_size;
 		growth += ebt_compat_entry_padsize();
 
@@ -2119,7 +2126,8 @@ static int size_entry_mwt(struct ebt_ent
 
 	startoff = state->buf_user_offset - startoff;
 
-	BUG_ON(*total < startoff);
+	if (WARN_ON(*total < startoff))
+		return -EINVAL;
 	*total -= startoff;
 	return 0;
 }
@@ -2247,7 +2255,8 @@ static int compat_do_replace(struct net
 	state.buf_kern_len = size64;
 
 	ret = compat_copy_entries(entries_tmp, tmp.entries_size, &state);
-	BUG_ON(ret < 0);	/* parses same data again */
+	if (WARN_ON(ret < 0))
+		goto out_unlock;
 
 	vfree(entries_tmp);
 	tmp.entries_size = size64;
