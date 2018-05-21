Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrDYL+8DAYChoMepu4qOIAuGgi+Y1GworbdyZjHR6r2wuUKV4aihVUx9FiKBgOyKkQaEoU1
ARC-Seal: i=1; a=rsa-sha256; t=1526937789; cv=none;
        d=google.com; s=arc-20160816;
        b=xu1rjYCyauUt8kScmNwm1p9+a9YCdRvs16U7aC+SpW6a4qw+KobcB1EEDVIMGXOMFf
         JbJyAKaIWGpcTFDZu7iCPv0+sM+w/htc0204UFOFYb2D5+UJQOoMFUmTBAEy2by/nUNt
         zzxV0fd2KmmYSJB4BzwfyOa5QnwHyQFjhEdqNewS9eICz4O66Xj6vXtQpNCs3caUm9oM
         nzH0Zd1yScHmsxFP9pn9YmwWqcU6TMa2K0dqdX5tKpq8EedYh96DpVbn8Lx5N6c1j0M8
         w2clHMkOjthYhFskc0KJF811k+QkGnR36GXE562VseV784LC+2Nnxd3Amy2b5aHUveV7
         bvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=O1xiy+wiWyVYrlb1AOiMja60qOOZsUuc0pgWE5cyBoA=;
        b=ojDSkByCvVh4t+4ZLGG1MUcQraw/gxnbthDVpqHDGXcuvM1hdqGpspRzZqwM/TX67Z
         +golj7Y81eYuO3g1yD8cXCIkrYQnqqvOg9yVej3GQ9SbXQkMYQGV31l0tQAKStN2ls84
         USdFqLUeZoH4rVO35baVFfHM6nq3NbU6f55E/uIFIORXcjm3OWrBcoBkBDCgoY5ujFLQ
         H/kKqpzQkeHWVVFDh+v+mXSMCRP2TgbI1R2eV8InEqdqsQDKyp3TS1u5Q0RVRTu/m6SS
         WZYXH6a94gwlfFakC6FnWXRe/GWAwa3AjVcE/QP8biAMCRkziyyNHklGVlnEgcGUEnMt
         6oHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=D/G00/Ki;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=D/G00/Ki;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.16 026/110] netfilter: nf_tables: free set name in error path
Date: Mon, 21 May 2018 23:11:23 +0200
Message-Id: <20180521210506.148651708@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110019222436527?=
X-GMAIL-MSGID: =?utf-8?q?1601110319655024852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3203,18 +3203,20 @@ static int nf_tables_newset(struct net *
 
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
