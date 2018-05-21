Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo5qWYSnQHyrfEte3nRSBE2yGiwe8tePbqGjN2ha7C5qYkyGMIxj+6a6BCc0wHObjBP/gL2
ARC-Seal: i=1; a=rsa-sha256; t=1526937503; cv=none;
        d=google.com; s=arc-20160816;
        b=KbmESNGUIV/iF6G3rNqHrNiwSUS5AjfUH7+3bBghBG70TLIKnN4sEVHHlWnmC/83Tf
         oPLcYYgUufTj3EaDDpwm5PG5kmQNHb/ltpv4pObik70/plKb18eO8LWlWKqO56uGDpBU
         VvCIF9rJnOxyY98TFHOFnGfqk1N4BkgGgTa0Ta6gWMmeRKs5U7FKfPiTbt9OmUVxm+dO
         UyN9add7emHMgg9WZzlK64pGLUapIJr71cS/q/zFB8YUUfv/InRrEc1zXqMDYIHpfjxl
         m04e5poA5YIjfJMskMHjkHilKkwtVKc6ndiMgCmMuh8L3zCayXEUDtxczJgkmXs9sWhy
         1xiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=GZKAq/hndF6gqPdnzD53WxO2e3RX8i3O/sx+w6hW0WU=;
        b=paw/1QSdtSOi/5Jg/Rr/Dlk2iqV+ZXF/bLM31nxNdV8bIa8HsIpCGLG/XMQEQUxtdf
         jBWZaPpVVRI6AXOisGywZDo8EDMWqSLG+0VQNjFuJLAauJH7c8VFOXC833IXTOwrvikN
         RPn0wDg4MItznVmJTtGLQ/RrUyGZ4mzg3j93rEQT1dl1auaafwd+g6uSan4o3p8ULlx2
         AjftQPj3OFZ8Ap4pI+dlD3LTEeNfZKHL+oUFqpy8qwnUwulpIe8lXOjocFQbd3I5BCH6
         8q/1cL4ZwOo4yCqGeuqsppbSkWZOdLJ48p3C+iFFvyGzgcR7/7ENvHaj6B3ViJ55J/kI
         AdBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xAWUyerD;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xAWUyerD;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 18/95] netfilter: nf_tables: free set name in error path
Date: Mon, 21 May 2018 23:11:08 +0200
Message-Id: <20180521210451.516296789@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110019222436527?=
X-GMAIL-MSGID: =?utf-8?q?1601110019222436527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 2f6adf481527c8ab8033c601f55bfb5b3712b2ac upstream.

set->name must be free'd here in case ops->init fails.

Fixes: 387454901bd6 ("netfilter: nf_tables: Allow set names of up to 255 chars")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_api.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3196,18 +3196,20 @@ static int nf_tables_newset(struct net *
 
 	err = ops->init(set, &desc, nla);
 	if (err < 0)
-		goto err2;
+		goto err3;
 
 	err = nft_trans_set_add(&ctx, NFT_MSG_NEWSET, set);
 	if (err < 0)
-		goto err3;
+		goto err4;
 
 	list_add_tail_rcu(&set->list, &table->sets);
 	table->use++;
 	return 0;
 
-err3:
+err4:
 	ops->destroy(set);
+err3:
+	kfree(set->name);
 err2:
 	kvfree(set);
 err1:
