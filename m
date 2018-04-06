Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Og4KNgmFeJvV5nmdNzW84ou2oUHEzhPTtvHO7/wjHE7C00y2n3C2VCvrg2A3OhtGrjcyg
ARC-Seal: i=1; a=rsa-sha256; t=1523021915; cv=none;
        d=google.com; s=arc-20160816;
        b=av8ijSML+6jfQ6N6E4Okjo9YeieOAxkTRLkGg+bvopGHr0g9yl8q/HFgmWK7H62l2G
         bNhic7VqY5F8232XoYb2t558POo6U8kJsb614l4VFRSBi4icUIego5LyJouWX1BGINwX
         ErMWoEjt795Q9QDCbTilXVM+9LGel8JTrBaoiobOMRCfZpxXwzE1QviJKMmoa9mYgQei
         +9Z1ov8QMczp1JIpTdTiCRDLjEl6HmAYxbYeioN5plrfWUEugsmyABrsB44iHfEnKPf3
         YS/TJpLkujcFT9ma0TR51TxEZ0oe2ToQG3M65C2qlhTdxjpvEkkYQ0cnrx8RreCmyBs8
         Hkdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wcnaCqnhgDorOj/ID7V4ebe195AcK9Cztn2H5G3bog8=;
        b=NkRZHoYYCnA6yQgj9MKDCz8sBfA0u5Hqf4fp3U7/WW6U9Oo/4bbObblmQG9G6eRVqz
         Dn4IQpatBGaBtdbRODCkG9tj27n1mRcx0DW5ErKTy4RJV2DKn/7pZaoj4nun7GCS+LxH
         yhTjQwz+UUvY2cBDJFMLLq+d6w8M9v/78h//+Vdyuq8EUa5dcbXrT7FOqRoPrR2UypyG
         d7PsWwAds3FcecChZHtlsjv0vyu5ghMT20iSHYwEeHov56hJpUbQ8R9LSCXcLXBt6af+
         tX3fh5RZGrl9O861Xa4tM3+obtbO8zMmBtowfZsEOskEzSe2aow1IaH5k9syR/QG0hb7
         PBAQ==
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
Subject: [PATCH 4.14 30/67] netfilter: bridge: ebt_among: add more missing match size checks
Date: Fri,  6 Apr 2018 15:24:00 +0200
Message-Id: <20180406084345.281062474@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003597962532229?=
X-GMAIL-MSGID: =?utf-8?q?1597004228042385134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
