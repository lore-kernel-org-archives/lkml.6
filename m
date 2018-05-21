Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpCFQ3I1IZKx6S5io2nZndueQZOnnltX4jcaj6tDBVMEGBYUSFJZQ3Q//Fl/szokkg7oXqL
ARC-Seal: i=1; a=rsa-sha256; t=1526937506; cv=none;
        d=google.com; s=arc-20160816;
        b=jmAxZ8eu63f3sN3de/ZyU/JdEbFNyGjhji5bBYsJbO9qyCxsNiqhR0p1MkrS6hRKLP
         3/bM1YSHcHkj2O0sQXJb3m7TiPAXTmd199P4YfzdljCgNnb8nZEurHd7hy7yw5A4kjnA
         +TM/izLqVG/SFXDsLl+DhydkkzBpttx8ZYHG0Ua37My6MSrjvrBrjRX7vL6Jm12DvvQl
         IfOtZ04a1Ucl3hWPWaZJDEXoREzh0DgKzC1qjlMNcBGLU2rIa6ToVlm+xGJzPWPd4+B6
         tXu8lsn5uWqR+pRvqXez1R9FwHTZJpig4RmWbby3ge/SIxHyvA3sWm7TZ5dT58mqJ7ot
         ok8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BPjLCp+KEbytnAPW2sJYV3JpAt7pq6TV1wwKPOoTbjQ=;
        b=FHsA76htiJJKJ60J4INq0jKHjXNNI0y6JFh1WLIdU671KP/3weY7bez2PtLg0T08PV
         1Q9oeO6uB/Y3towyyB1WqcWkM2238Arqcxwg1W3Cx+bZoxUQ27JWkEihBAGZvEVnqa00
         0/acbSNtIhFErdzlLVyzEr6wVqINc1MJ2EQxrZ9yswlsJLVS4xdx29YWeV35BpW3Yl3/
         gWvcNxUBjV0t7QyjCYnCqMq87ydofpXxdSXBebt1o5CP4L51k2lmHoTdKYbtRwXwQmus
         +sLnYSHGFVqNq3JP2UANwSsV+m6QDyfWe4z+LHx7Kw60VlhZRIc7M0+ic1HqymVDHR0G
         i69Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VKSXUXh1;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VKSXUXh1;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 19/95] netfilter: nf_tables: cant fail after linking rule into active rule list
Date: Mon, 21 May 2018 23:11:09 +0200
Message-Id: <20180521210451.704026996@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109783674177294?=
X-GMAIL-MSGID: =?utf-8?q?1601110022528555118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2344,41 +2344,46 @@ static int nf_tables_newrule(struct net
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
