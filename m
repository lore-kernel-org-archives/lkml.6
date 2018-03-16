Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELstgCR9hr7QDg437intQILsfKSHifgaHqSkSNyHE5dIMfCFxun2x07wbCqCFgDobnk5w6oV
ARC-Seal: i=1; a=rsa-sha256; t=1521214340; cv=none;
        d=google.com; s=arc-20160816;
        b=Mg5HbO6uOYYQNMCv1Hc1TetNPbpj9CJezAnQH38v83BJIbB59mHixIUT6fnGo0Fzqa
         szrLE2nr0V+428vwoxK+PgmfdUDqc5E6iWoMMhLE7WxnlF4Ka66drbI7tl11yfVQkRrO
         Y+8UD6Efq7MaYkiOHl2SbGej4gpNp6XgaGPsNNnYP976iz7WDqM0pUPNwOkY9l9aPc6W
         IkDQ3sAcxfophp0Tn95kbtf08KZ2mc3EcBBeZDU8CrDE1hyvkyxOvTLa3xkoQQddqw4N
         mQY5RwfsLeh8GARfohZ+zAA35KN/3LqavXPXKRPXcqTynWgQNVxkedrUBcQpX6dKLonh
         TF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7ouNjhqoCzSXQArjlUPp4t52NNJU82baUjdc1rBNHKo=;
        b=sA7tNkVVkgCKoM9SaBCv2U1HbstLmIPqGyfLEGXvDYnbSqZbIYGrN52TF6jochxORk
         3HSUOjR8yRDES1/q+EMyj9EVUh21i30vXV4srNFtlVeOVowM/X9Z0SC/LeFGOM5XWb77
         teA7ZblzRiv7vaLdFKoO6idpBFQ7/f4bb34KQpzxzQJHotAOREiOQxZNl4W+sNBTIAK/
         8k/Nz5Q3a6CdpBDXNlX41yP65NeOkYbTE1b/grrpLWMx/oCnxU3cdaETGpmWt62eQFdB
         /rRbozft6FVhB/sRkngcfV6Xjr2f5VFc4alX/XqByHsZrDyhsA/uSL5pdYvCDsKqLoO5
         BSRA==
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
Subject: [PATCH 4.9 60/86] netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
Date: Fri, 16 Mar 2018 16:23:23 +0100
Message-Id: <20180316152321.434548741@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108478397273655?=
X-GMAIL-MSGID: =?utf-8?q?1595108848363083660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
