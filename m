Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsmmqiPzCRlsvl8faSyF75hru5vZQS6gmXmvKl2cgNKv77jB7os4ZH1UikwjETK7w3ETAO9
ARC-Seal: i=1; a=rsa-sha256; t=1519412242; cv=none;
        d=google.com; s=arc-20160816;
        b=FsFKoE3l6MUGUqQEOh97cM7VTCwU2lWeD2sx9tdsLigd3Wu/yGVblXFlEZVCrm+7Lw
         C8YMsLwysSX/vcfwJMmB+NqMiXEo9CWgD+wKZ3jjziIMwLoXr8iq6OfmwnJzBpLeLHpx
         gU8b3dc0OtLymteBB2wR44foejE4lYeh450LlgFRquZ8yTcsSdJkAQKxFP9exDCg8sJd
         0RQ8EtDq4W4eaRAOCaxB4MmOTJYBzGmIMFtj2lY2LrFJjcB7jyDTwCafkYwpXkzelhnz
         KK9AXBFYa7FwuL6sOpEcRiQqp40pNBUg9GvQVHmGwRn0Lj2sPOcCo1jSeS7qW204hbM4
         E4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gj8ov2eCxDHkZimj6p2+Q0h4ARE7MW/wcrJyHG0vqeI=;
        b=gHKqsmt4ngVF1JN14m4NkqDI0cruTpJdIac00j8c5Xq9rEGGoSObX3EvFGecmHocgQ
         WzxtBg6XNNPCpTIfrv8dT21XDDZxwOb+TacaIp6mo6PsrebrjR3rebLj0gXJIXv4vLNi
         +kqEFKGensrEqmW6153ufIqGdDd3TJ1ajZHS91txJhJg1sqMvb4KupDygx3nK5vQMvH0
         0r9cRZ+oPjEd2kRtqWc30iZ1Wsa6bcWdEFSKHZr9dE7BRlOyDbN8718ktwbAhXKGXEtT
         ab1Gkwun77taXY2D+Vme8N4/Kqu9Piy9UnxQNIJICplcF0cG7ieDHmLi4Go+wjovvYqp
         fugA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.15 14/45] netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{match|target}
Date: Fri, 23 Feb 2018 19:28:53 +0100
Message-Id: <20180223170717.611089900@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217537889132709?=
X-GMAIL-MSGID: =?utf-8?q?1593219211556132883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit da17c73b6eb74aad3c3c0654394635675b623b3e upstream.

It looks like syzbot found its way into netfilter territory.

Issue here is that @name comes from user space and might
not be null terminated.

Out-of-bound reads happen, KASAN is not happy.

v2 added similar fix for xt_request_find_target(),
as Florian advised.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -209,6 +209,9 @@ xt_request_find_match(uint8_t nfproto, c
 {
 	struct xt_match *match;
 
+	if (strnlen(name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)
+		return ERR_PTR(-EINVAL);
+
 	match = xt_find_match(nfproto, name, revision);
 	if (IS_ERR(match)) {
 		request_module("%st_%s", xt_prefix[nfproto], name);
@@ -251,6 +254,9 @@ struct xt_target *xt_request_find_target
 {
 	struct xt_target *target;
 
+	if (strnlen(name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)
+		return ERR_PTR(-EINVAL);
+
 	target = xt_find_target(af, name, revision);
 	if (IS_ERR(target)) {
 		request_module("%st_%s", xt_prefix[af], name);
