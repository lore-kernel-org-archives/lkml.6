Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49AA3QCULG9E3kaIw1fQp8ajg63bhq3ui+msKVRSQIwgWKw63yelqiV3FQlcLY21bx8UWV+
ARC-Seal: i=1; a=rsa-sha256; t=1523021315; cv=none;
        d=google.com; s=arc-20160816;
        b=kOAPK4OcwAq3JzAhtVEqHMOh0nttD9M/6xSmCAQD3AG8/z3RctIUyx1hdVuLYdAgUw
         +uXanZbsdDNilHT87W0xUsl7sKWTgzUCtZSgKDFj7isPOD/OtVLlyA9NlfYrDbObJBnk
         P5XLYKVv/oV4C6NBtYGdSs1dkJ9rJ9iS6j3rJqTc32ZAoyBqvrDDCP619bMPnlePJBcA
         QcAixOyPeshG+DTHUBquKs4Q29NjKGC6vhfSIVRG/YCNzlZ51yA3KT1XHjznXsboUH3z
         4znGiaJX19dYhi5PwLF6nHENSi0/V0ydFEXnJZlgTcqAR+GWcGyUiv/pG/t0viUCrbqU
         BkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FFmsxfm9IbfvBR4tsiDYzcfguPDOOkcMoGBPkPUcm4k=;
        b=XPwnboX/zyj0MqhlvQKNv1UCj9IUSJBh3063Ouz/wQkCxOvxPxnJqwqp9psztLqm5B
         uPlV9J9jMG6j+XRdKWF/8Nk2ttNrIy+32dUyMPNmdWpydEzf/szRhFLG0re6BE6D1TRc
         3plQjz8UBQVKezjeN7N/KrDn/Rug3HWKWShb8ydG1l2NCIDedEhMHLDp/Li3GoWbT+5b
         4z2arQpQqaYPiV8UiPqpy5neoX/CiPgX+72qaUcbaeT7lu8er1lHA3e5GCaqQD5oxnT+
         DGQ1B5WpqohF3nuiweufij2eYDPYHErSnZbLvh4itVRptyw0YMq21c12XhkyTxNNMWbp
         k9Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+bdabab6f1983a03fc009@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Eric Dumazet <edumazet@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 53/93] netfilter: bridge: ebt_among: add more missing match size checks
Date: Fri,  6 Apr 2018 15:23:22 +0200
Message-Id: <20180406084227.230330044@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003597962532229?=
X-GMAIL-MSGID: =?utf-8?q?1597003597962532229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebt_among.c |   34 ++++++++++++++++++++++++++++++++++
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
