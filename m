Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuRVq2oA/fYtAxZK5cGozmbI8GMNDF6whQw5vSgAy7CeHih1bfZKs96QAa4iqo3QpL0XNv9
ARC-Seal: i=1; a=rsa-sha256; t=1520955178; cv=none;
        d=google.com; s=arc-20160816;
        b=0cxwE4WIgWnWUbGKj3EfEMwYMI+mVbrnM2ju3vs0zRLj3rjb7GvIxkWuipw/gRuNtN
         HUw5Xda3qC/P6BgB80YjEZ1EIMcZtHg1N7JZoDBSEh/QynXGN1TrsdB6m0zTLC9R4LER
         t7s27qPzHHlHbo0m0FOTKf4t3ng7aDh8u9n2ibPcHH1vqR+yOS2HO6cDbOh35/5JaSyA
         cc8EANQrkeHZ7Y5k0Kjdbwnv28IewG3W/ZIIBOvitLbGdfu4olOBsr0MgM/+WFQc3YQ0
         GHTd3NDqt5sVw6edhuKI/+x2rcRk4VDJ3krbFwBq573/UJPaT43iLkcXhuEv28EigzUU
         3clQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S2XJiGkkXOqirTvmYY92cCUJ5kdBB2Cu5a45EDEaQ0s=;
        b=qD55fCgbJk7ypmtY7kS4B5J5G9d1YXGXAc3pugXL+rPDEAVCro6ZeqbXHwVi6P5QbB
         ISQ3xZ8mKwVC+H2hQIHi6iirKz9kd0tRbFLHyeth/dv/u2YfMfSfSZOGjEg39O8nvbIV
         imNP2N4qMjMzAkdroJWfAYhbKHCFs0/tad4WsJeY4rpmd8AM/MKLCBkE2RKkjASztSnt
         g7yeOdimhmjdalImYCxXEpLau+A/pVo0v3vP9LBn6ieRfLrXhXj2yW926kv5tkhOl/4O
         XSaeov0+JAmqBz4v/J619OVD36k9ib8SO32d0pCosJEmJpj3Sv/h6eCbp1aqADm6CNc+
         KgfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.15 116/146] netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
Date: Tue, 13 Mar 2018 16:24:43 +0100
Message-Id: <20180313152329.316873638@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837097451945704?=
X-GMAIL-MSGID: =?utf-8?q?1594837097451945704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
