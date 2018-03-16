Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsxlhIPhMIL2o8j6xpvheLj5tawG96tTDWW+s7i0Arilrjgqxx3EzGD/JWTF84rDJ2o22zE
ARC-Seal: i=1; a=rsa-sha256; t=1521214120; cv=none;
        d=google.com; s=arc-20160816;
        b=bT15xwTPB4KThv08P9ZfB0N0n+l+Mc5j4LXVYJYFnYghi4kDb/QX/Gux4Eu3CpyEJy
         PaoYUrf4nXkmH4pk7+DQKcIL/HkYXqxtYRc3OndwF42Ow6md2DJLnUHLPI/hxpgQiX4Z
         DG9tCe2M5uPXt42khvkIsC2/x5fTgX9R98/2M62fp3zr63rs6EJcCazz2Kxw2ZyzQLJ1
         6nWjnhiOUZrPt5oc3QaKtoiN4sdquCloFN1gvDB7E1kG7apxrJTeI3WwQNec1sljoGO0
         +1b5p72ubwel5PDcJf4MtQg6wCATT6/Xn3MRav77B258/tMK4nNNHfnf4rmCro91MByt
         D8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gKFM9+4+YwKizCULXJP4r9sK8mTmTrM6msbCjW2h4Mc=;
        b=D0Z9qiIb1SwQkcfkw6PkRqKFaq+lj//y+5qgMFrXfQO2x2hey6ilU5rwVZSs70fn2p
         CdNZxLz+/Rutme5hLzdGXpqmIPYv8V30uhOkCdFVonJH4ADECpovASetIu/DDeME/4QO
         SmWlUO40a7cr5H1sWLZi/VvHQHLgLiY/HSCHVe5/nCBllR01TTQkuIFRF8yfTIVsPCP0
         SUVJ4q8a6SAruzbEWPTud8AzHDEBIFdsN/gK2DYAbh1S62SkUzdKY3FoFM76p104HuAv
         gzSHdOeEAF6Wbco/iQhnUFW5ZySKf1tBeMDtkclmoIBlLfV3Wbh4uqB5lFF92jDbfTnU
         +njA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 40/63] netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
Date: Fri, 16 Mar 2018 16:23:12 +0100
Message-Id: <20180316152304.462922340@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108478397273655?=
X-GMAIL-MSGID: =?utf-8?q?1595108617796431529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit b078556aecd791b0e5cb3a59f4c3a14273b52121 upstream.

l4proto->manip_pkt() can cause reallocation of skb head so pointer
to the ipv6 header must be reloaded.

Reported-and-tested-by: <syzbot+10005f4292fc9cc89de7@syzkaller.appspotmail.com>
Fixes: 58a317f1061c89 ("netfilter: ipv6: add IPv6 NAT support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
+++ b/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
@@ -99,6 +99,10 @@ static bool nf_nat_ipv6_manip_pkt(struct
 	    !l4proto->manip_pkt(skb, &nf_nat_l3proto_ipv6, iphdroff, hdroff,
 				target, maniptype))
 		return false;
+
+	/* must reload, offset might have changed */
+	ipv6h = (void *)skb->data + iphdroff;
+
 manip_addr:
 	if (maniptype == NF_NAT_MANIP_SRC)
 		ipv6h->saddr = target->src.u3.in6;
