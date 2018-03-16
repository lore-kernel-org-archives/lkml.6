Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuKOvy6YCSh1IpZT/8rY/2ygC5m31qlm5bcKAPTnqInkvne1zoFBJFLicYK6mMRWbunaB/U
ARC-Seal: i=1; a=rsa-sha256; t=1521214188; cv=none;
        d=google.com; s=arc-20160816;
        b=HKbS6kKSsWZOeA74DETz0Lnh4XjFAYX20cm4ZcEJMpyuaoC11Sjumuxxhx3XsuGlTQ
         VYIO6oI91tQBiFUPhpuEjidWrjncOqgM2/bqsR8mINoxJl0IbQ8W2gXlevNjPLNZHMjC
         k2ZaBsx5WiTjzd8xHYIGxDB+ZFpFTs2pd4QYBabR24biHLCiLtdyxY1mzAfV8GvOxgcj
         bJAha8W7Y1de2O9Su3VlDhnGFBvElpAvl85nbRNbA0XL2JG+DLpRLG6tQwTRaTMa0sCR
         Kekm9UkrxsPziYqX6fD8jvw/tW8pk/rkvRLfXxn6pploNrKdSd0VI6ikYhc+RsnWd4rc
         F89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6YUoOEBoMijOs9U7XvH+mwvwjXguUmfCsc2GlShbGZA=;
        b=JD65wb0fAGOle0SE7GFbiau9azQrwkbQ4c5RTxGlpcmpGADQ1L376S7Ijfbvi5UF4X
         L0lybU/4WtWspLAV0qf50BQ+HlrHG86+62ZVNJua2PmAesN2V+T2Yv5L+uMDjvDuROdk
         F5pHd5BWh/y1uWy/gW3zh5xyG1qKuhvOEm3RH9FxP1xeGKeRIUpbifvUvUrPqP1hX5ip
         TsQuGxnUhuIEs3PI91+2AVDMh1TPBYwtwdLJKvt13Xm5iEiYftfdQKryRip2+WADG4ec
         3FHf1kI0F3mjuZYUHaviStjuqadoePuKsE5Yc3ulIBOGmyGIq3mc/BwbEIunMghWK1M8
         zrSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+fe0b19af568972814355@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 39/63] netfilter: bridge: ebt_among: add missing match size checks
Date: Fri, 16 Mar 2018 16:23:11 +0100
Message-Id: <20180316152304.411245630@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108474793291533?=
X-GMAIL-MSGID: =?utf-8?q?1595108689467122790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
