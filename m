Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvAeBQNIznqOfAe6smfN2L5rLkKK6mH4jizTXz39cljwRoNiX06i/8wb8LLbZnpJg2kkNJN
ARC-Seal: i=1; a=rsa-sha256; t=1520955341; cv=none;
        d=google.com; s=arc-20160816;
        b=uHpzgqqKTfzyd9Xhsaop3wInGTTQC6s8wbgzujLD71kYHBfw1pyAVIP36PBUOrvceU
         THd1kExyjAunWX0MoJQQRXm59h1iycLSGGoKFRbC/ZNGoKK1M8lq6orGbMJG00kA7kzu
         0rFxegETqPZ7jGvkNA0FzmckDftAKI3a79+H07DHFWKcPlmWBunSEhyzbhWqgRRtqnN2
         5fqrm1fhHjxO1Jua+o2HJTzw3aTDZt0i0YpnxQ2NVViOSJI4hUVgZzNCt1GeuajZTqVE
         n2HmcUmR5OAclb5aveGstSIsjbSodDkS4RzChIK4bhh/sOXoIqDj/kN20IxJjTV8daN5
         RNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=prqEHuvt5fhh+6KuRgcbg4JbKm0yVYSMJ5TNckrW7DM=;
        b=si13CzjabowjwxDusAAvhIGZMaAt1GzZFJ1Tc2HrBO/wlcoE06+Obzh2paEvnWCYCj
         YJzPR38FMo8dKN8h20uGgKDzmh5kGLSM//B5NzZJqL1rn2gE8XQQP2PWvXtxHIQZRAxI
         50FhC5WI5GWj2RemQWYmGZkkYH7sVMAkKi81D2eVIrHILGzl64eiktcTMRZx65GYal29
         XtS9exdLpTckD8g0PWsGjRoFj6xigQvKrDAYorjtOym2Dl4Iwx4v8RE/sJ4ctMk7jQ4A
         G2h27KOUISBu0nE83rt9V+b8DN+I/w/HwPnaBxNlWivlFfKQDb9UiMVTpyvGOnELOi3J
         ymqQ==
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
Subject: [PATCH 4.14 017/140] netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
Date: Tue, 13 Mar 2018 16:23:40 +0100
Message-Id: <20180313152459.265210480@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837097451945704?=
X-GMAIL-MSGID: =?utf-8?q?1594837268074296959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
