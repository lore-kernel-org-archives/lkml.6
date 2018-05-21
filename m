Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqqTQ6lGA9PMJadkJ50MisstNUBWEwBZYhKXsKnTjALG6HRHIsLNmq/hoLAPPn/PaF4CKr9
ARC-Seal: i=1; a=rsa-sha256; t=1526937793; cv=none;
        d=google.com; s=arc-20160816;
        b=O+tBZVPnnb4G63PrZQoXGLS1O8qHeXP04/1IfN6Ym0CQlv++dP2vWJSWVHTCZcwfeo
         YTEViiaVeDK/fk/FXJ7b9iLDjO1S8s1epRdWoH5w6+sFEbAl0oEAWxZfV9fwR2llHLQO
         crV0p/W/0HqzjU7bR8HewHtLRQyGEhlDuQMGzt7B2AY6AsTXGWoUormqqhNeY6ZhkNdZ
         vBg2Dtttwox+WeL6affiecckqW2HrEm0aW3PWFtfHSo+GFpUWQOLolr85yQTxi70RM0J
         x3BgRd21qmraYCk93U0hEWKBtswAiWNQR83velV8WaoaGVCCDHNefzjFRhrkzKW64xpC
         nxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Hcfngx9tZnH1LObmjBzXhmBfL9MFVo3Tjmji5wEhG9c=;
        b=b1glTPMgnML08koT/eTDjVZ/WMti/SVGmvV8ajhC7Xz9GDF7+MfSTZ+Qg/rR0wUtTn
         OYVrN6dvl/Of87q6cAPzY7TFvLtS8sVlYJAXhQO9ixrO0glK0OA3Co41U5m8CMNuloL/
         OFDk/GLMErMTHP6Hf6RplNFs+oUuWOZIYBJ1QDZWgxIwoeKH9iweM1tyb/Z8aDLpSMMx
         sVPeo9XyRNJjKaboOkZXksgn3TuO7w7lCdT55D+C0rtF6nO95oNhvBfvrQWgyK9qXBz6
         /3HFbAPwg22UmDXARuokShibOqXL7mM9au03F171sCwS6Uyj1tK0EXl8yg8ACZFjSvWC
         KqTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=l+QxA2zU;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=l+QxA2zU;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.16 027/110] netfilter: nf_tables: cant fail after linking rule into active rule list
Date: Mon, 21 May 2018 23:11:24 +0200
Message-Id: <20180521210506.224261442@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109783674177294?=
X-GMAIL-MSGID: =?utf-8?q?1601110324250909582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 569ccae68b38654f04b6842b034aa33857f605fe upstream.

rules in nftables a free'd using kfree, but protected by rcu, i.e. we
must wait for a grace period to elapse.

Normal removal patch does this, but nf_tables_newrule() doesn't obey
this rule during error handling.

It calls nft_trans_rule_add() *after* linking rule, and, if that
fails to allocate memory, it unlinks the rule and then kfree() it --
this is unsafe.

Switch order -- first add rule to transaction list, THEN link it
to public list.

Note: nft_trans_rule_add() uses GFP_KERNEL; it will not fail so this
is not a problem in practice (spotted only during code review).

Fixes: 0628b123c96d12 ("netfilter: nfnetlink: add batch support and use it from nf_tables")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |   59 ++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2357,41 +2357,46 @@ static int nf_tables_newrule(struct net
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_REPLACE) {
-		if (nft_is_active_next(net, old_rule)) {
-			trans = nft_trans_rule_add(&ctx, NFT_MSG_DELRULE,
-						   old_rule);
-			if (trans == NULL) {
-				err = -ENOMEM;
-				goto err2;
-			}
-			nft_deactivate_next(net, old_rule);
-			chain->use--;
-			list_add_tail_rcu(&rule->list, &old_rule->list);
-		} else {
+		if (!nft_is_active_next(net, old_rule)) {
 			err = -ENOENT;
 			goto err2;
 		}
-	} else if (nlh->nlmsg_flags & NLM_F_APPEND)
-		if (old_rule)
-			list_add_rcu(&rule->list, &old_rule->list);
-		else
-			list_add_tail_rcu(&rule->list, &chain->rules);
-	else {
-		if (old_rule)
-			list_add_tail_rcu(&rule->list, &old_rule->list);
-		else
-			list_add_rcu(&rule->list, &chain->rules);
-	}
+		trans = nft_trans_rule_add(&ctx, NFT_MSG_DELRULE,
+					   old_rule);
+		if (trans == NULL) {
+			err = -ENOMEM;
+			goto err2;
+		}
+		nft_deactivate_next(net, old_rule);
+		chain->use--;
+
+		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
+			err = -ENOMEM;
+			goto err2;
+		}
 
-	if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
-		err = -ENOMEM;
-		goto err3;
+		list_add_tail_rcu(&rule->list, &old_rule->list);
+	} else {
+		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
+			err = -ENOMEM;
+			goto err2;
+		}
+
+		if (nlh->nlmsg_flags & NLM_F_APPEND) {
+			if (old_rule)
+				list_add_rcu(&rule->list, &old_rule->list);
+			else
+				list_add_tail_rcu(&rule->list, &chain->rules);
+		 } else {
+			if (old_rule)
+				list_add_tail_rcu(&rule->list, &old_rule->list);
+			else
+				list_add_rcu(&rule->list, &chain->rules);
+		}
 	}
 	chain->use++;
 	return 0;
 
-err3:
-	list_del_rcu(&rule->list);
 err2:
 	nf_tables_rule_destroy(&ctx, rule);
 err1:
