Return-Path: <kernel-hardening-return-12481-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELumxLoMaKGd1lpTYAl36wh2KKVoeO4A0uN8JtygUqTItzZb0vzSIlcO2SCUfPYSHTiKwygC
ARC-Seal: i=1; a=rsa-sha256; t=1520896614; cv=none;
        d=google.com; s=arc-20160816;
        b=LIvnUltdVUnBw96Xq0Xmxb7RhbYZm9EfwREuepbvS1oLmDmEBk3DJCr6CnJjCsdacm
         zXsgn95O4hMbOid3HSe0scEGnZi/XJhA4rksUL7HGU70MRqzQwrU6q300jPGoCgJPXYb
         U6hme0L++p0haz51/gruZPIsVBIQDymA9FACBYS0x8Ud6wXJ9hWB0kudwrnGAQk0tmIq
         m0yKOggSVZFtKz8hTFqkbAjvbvDx1PhnIlDQcyv2lJz912KCl1Aqm/2GLurtui+cpX2X
         PyTMZEffxoPuae78752l0nZD4fMo1jU/7Yp2NvovW97VoMOaoVnrbyvvljMOD7vRsHO5
         FOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Lm+i3Sec4jyGmNMjmYuFo1mr+GiziO7V8zD2PJyFvlw=;
        b=zssEs00URP/e7E4PcckCEektIRuc+uQX7QPW1JXUnuYYg8aStfw6LueaJGt0M7Yrqy
         dXMc7NXBDOjU2TJzfFmkTEfRsT4fw6wsnFLjTwqJAbujDr3BERlnsv3tJOMtJVTEdQeF
         glPiGCo4Z8ccDmY8lDqva1vtQBcJC+X5lO1nfWoSU6dfvj92PoQo+UK54NBIsaku429p
         Au3Jsc9QnAV0FPse/V19F9anBJwyUTXEsGoYDn+WDTrziMsCAmrhPDx58H6hL1wCO4IX
         b2vDFWTLqsDxShJy398BKIKirLmodEhVVbEjASu/GpAdrVWSnuJr945QA2a0AxuS5aTX
         Mi8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12481-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12481-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12481-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12481-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 18:14:42 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] netfilter: cttimeout: remove VLA usage
Message-ID: <20180312231442.GA22071@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1evWeS-0041Qd-4P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:45314
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594775688476268511?=
X-GMAIL-MSGID: =?utf-8?q?1594775688476268511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLA and replace it
with dynamic memory allocation.

>From a security viewpoint, the use of Variable Length Arrays can be
a vector for stack overflow attacks. Also, in general, as the code
evolves it is easy to lose track of how big a VLA can get. Thus, we
can end up having segfaults that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/netfilter/nfnetlink_cttimeout.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 6819300..dcd7bd3 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -51,19 +51,27 @@ ctnl_timeout_parse_policy(void *timeouts,
 			  const struct nf_conntrack_l4proto *l4proto,
 			  struct net *net, const struct nlattr *attr)
 {
+	struct nlattr **tb;
 	int ret = 0;
 
-	if (likely(l4proto->ctnl_timeout.nlattr_to_obj)) {
-		struct nlattr *tb[l4proto->ctnl_timeout.nlattr_max+1];
+	if (!l4proto->ctnl_timeout.nlattr_to_obj)
+		return 0;
 
-		ret = nla_parse_nested(tb, l4proto->ctnl_timeout.nlattr_max,
-				       attr, l4proto->ctnl_timeout.nla_policy,
-				       NULL);
-		if (ret < 0)
-			return ret;
+	tb = kcalloc(l4proto->ctnl_timeout.nlattr_max + 1, sizeof(*tb),
+		     GFP_KERNEL);
 
-		ret = l4proto->ctnl_timeout.nlattr_to_obj(tb, net, timeouts);
-	}
+	if (!tb)
+		return -ENOMEM;
+
+	ret = nla_parse_nested(tb, l4proto->ctnl_timeout.nlattr_max, attr,
+			       l4proto->ctnl_timeout.nla_policy, NULL);
+	if (ret < 0)
+		goto err;
+
+	ret = l4proto->ctnl_timeout.nlattr_to_obj(tb, net, timeouts);
+
+err:
+	kfree(tb);
 	return ret;
 }
 
-- 
2.7.4
