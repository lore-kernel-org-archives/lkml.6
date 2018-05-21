Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp61GJgwM/1e0ZbfKH+Fam2Hq2ZlLwky2/SKA+wnabPc1jtq9i6zQcfNRgIkNBm37ZftBDz
ARC-Seal: i=1; a=rsa-sha256; t=1526937277; cv=none;
        d=google.com; s=arc-20160816;
        b=YhzRtKcdTq+eLCDOsimZYGUjpWuG+5bHQpMf4TIBPbOBrktIm08DwctNqXCOKLoAEb
         re7Pu+3wQ35D0pynR4OM2Ykm3Jjef26CRO9ORORYMTWfM7Hw3By6ro/jAmE9NdXK6wia
         ITbBSWSQ1Lca+PqlvOqkbCIKxpZ0eFNHmkj6QFrxeyC+vSy82mNrml+yerN7I/g8N4ml
         F/KnWH0rPEHFrf3yGVmGlFCH04HUz5d1A3T7ZJ2Gp7sM6aHAJUm4ayZOFV8UObatiMVS
         5d2XxuF8XTHk5Ebk1pQzH84nrXsbxiKj4mbFtqFhGhoL5avO2xi9LWKrvnvU4cm+VPY3
         k4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3Ln2sHbgXhp5tfeneySHkF1T2sJy9YHl2nRquasMJ8E=;
        b=hAYDWWQb2uRL5uC7gxg6HK4EYYUDXw3HyAfP9XfPn+LcQjnN3Bc+O5Edgfuk4bw22T
         TDDfzp1tsa8LseY0rFg1P58vXGFoIu75fr8wcPkoCea/7M2XBF8aHvMZaecZhM4jAJ4h
         lsoxvVZRHgHrVhCg0lFAWa5/KzUs74y2+U/Nw/1I9aboG28OSVAihz01+AOCTlhejq9a
         Oh1a0juuOltMpXJonR+dJFoZnzI7mvTHJ1HqIRIN5s6/UQni4o7Pk/MO96w/0H93WCZL
         PQPqJRkApShXCu8A7dx9cMljV1bpX4mF3hZ24YiItp+iVNlcVGDMBxDiz7DfChfNmf78
         e+xA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=X5zalsrn;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=X5zalsrn;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.9 16/87] netfilter: nf_tables: cant fail after linking rule into active rule list
Date: Mon, 21 May 2018 23:10:52 +0200
Message-Id: <20180521210421.799286872@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109783674177294?=
X-GMAIL-MSGID: =?utf-8?q?1601109783674177294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2200,41 +2200,46 @@ static int nf_tables_newrule(struct net
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
