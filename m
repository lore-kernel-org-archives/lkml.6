Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtlYBHVzSI985w7h620WsGNgd6ujrcQXbQfmfhAJW8IhbAFs3DtcUTP9PtXV4QSAlORNU1A
ARC-Seal: i=1; a=rsa-sha256; t=1520955176; cv=none;
        d=google.com; s=arc-20160816;
        b=em3mqK/FvJ0D8l8XcBo9hUKHzVx9eg54XxTkxNd3/JgBadTpR2SXebipELUasgKrXw
         fsAL9fL3YRvU9hwsQFkc1/hL28k02J45/hnkH3EGzschwktplXO6Xem1iJZw3kThcVjg
         6vROWw1RB8WXix0fomL/JAj+z6C5D0aRRWfnPZqe78lQlJ3IQxuFf+HtrFhygwePxio0
         pZbX3v37dE+uu4h2C/TQAFiBALP01wr+eWTnRJHONYGKZyq68O7UbvFQkhKWedzB0zq6
         0DiieE0SB7I+QVBdkiJe8h3IAtxCcDJMTu8pnBLQs2DCJLnUxuoC2vrA7fmwEVFg6DOZ
         J+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7amyJLc+X9oABqncWddgiciWta9pZPHOiwjkkpr/iTE=;
        b=LYtRrxY5OjUWvC4Rw8h2ncK50sbzvOJn8jYogO2cjEJqedDSVTCicP5ruKF0TAzyg1
         M6IoslOWThGcNI4OfhIICzKmvPZg605vMkIjQpiQDRbdK5edDETC8aj4SuC2uhJqODML
         86lX9/w9p0Y6rBJ15zQrbgJq+7XH8IQ/KAVEN+L1e8Tro7r/zYA9Z6nn4ef7DvCQi6L7
         Hcw6tmXucqqvP7l2Yag5S22b+xNEjKSbAqq8Du5J51DYxnii2ItBfDvldV9RcJ/ffKoh
         DknVrmek51e9V7j6ApDkQJTr9+O+Ft7PNQYjZzFPHOBrn0RxjZzloL8B/4qAYZsV4HXI
         JdTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+fe0b19af568972814355@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.15 115/146] netfilter: bridge: ebt_among: add missing match size checks
Date: Tue, 13 Mar 2018 16:24:42 +0100
Message-Id: <20180313152329.256652776@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837094668923489?=
X-GMAIL-MSGID: =?utf-8?q?1594837094668923489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebt_among.c |   21 +++++++++++++++++++--
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
