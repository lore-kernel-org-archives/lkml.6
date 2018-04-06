Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48tYKHb06BMJ7e2RE+dqxPaZtEWa+9j7/jfAhRPWd+4WM17Ryq8TtnJQNkqPQPENF8TtwPk
ARC-Seal: i=1; a=rsa-sha256; t=1523021657; cv=none;
        d=google.com; s=arc-20160816;
        b=nl+C3KWLWLdwAUX6093BN9RhXb6dCnkYSirrwYhNocv/6/RWIQ6/P358tWwU8lEAlq
         mQgYUSmEEkPrD68tn/ojIdcOI+vXb6fNBlFnH0JuvcuCBTBV5XOO5EKp1gi08xvDO6Nv
         PH6k5EB3TpSDFGyroN49I9s+Dt9CrEiu+gORD+F4LWkhShBr5tJR/zLf4aCymeY0LOSD
         XwOmRSKhmAP9eGDvIIdG3XdXSPEId8DBoc+h/o9JPcYWebMb9tYPayJCVRdgezeDAnU6
         UD1/TD7QIBzumgkOQ4xWsV6jUqhcgkh/3Tcok4FzCgyV4c7QmNxEKCRDd8uydeb0J369
         XNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NHrMAlE0k9tatIecag6cU+eMXTkPsE4bFE0/slfP/Rg=;
        b=vcoXMhT3YoJwb/n76qEThXEJTUP2Avouwu1fDhk2YHBHM2AGZplUSXeg64K9aJqyvx
         Ij5V1iPSBXKB8r5vtyOW8BNN29A7lAziyjW6uoyT2hcJPrnx/LTdoqWfO6UtRjbldexD
         cCyhqRjP8YL/Apgq/enQVbPYkPehNBOxLXuWiv+5r+8B1Vg3CKwRDe/RCZWJdGYPDwAP
         PgovC756xaABuqmbrVqoFgAseZul+G3SWicUjud7tf+yTRInumOoJlJi/+H0tiJ9iTms
         8tsPgr12iH9Oa+JET+cIFG9HjF+Aj4bABWKx1F7ZE5QYN9x9i80bfbT2D4HonGd/4t0P
         l0lg==
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
Subject: [PATCH 4.9 044/102] netfilter: bridge: ebt_among: add more missing match size checks
Date: Fri,  6 Apr 2018 15:23:25 +0200
Message-Id: <20180406084337.802737122@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003597962532229?=
X-GMAIL-MSGID: =?utf-8?q?1597003957741688512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
