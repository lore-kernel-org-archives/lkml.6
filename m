Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt832FwCrggg0UBDRVIrIHSkYkOxmBzD16L3vZWD3MLLgo1G/ouJ4ruCwLDzg7fsoeH4tDi
ARC-Seal: i=1; a=rsa-sha256; t=1519981274; cv=none;
        d=google.com; s=arc-20160816;
        b=kwO3xiPSXV+DiGKkEDlhuRhzI0YqTEURzk3QctC2SQ7wKPeL1Ff/a3tr2ZGVc7iSBQ
         Pk7yU1av4VIpkNyVfPb0DjKWQYPeuSXOm9vWB8REAVlq1AoG6ViZOoeSsImJo60shXsf
         Pnr4QBBTLUpyq7c6Fdw2Wh/rv3E0NpKybAmz/Gry2yC07xsJ5pJtAKPaxtO8ZlDk6Fml
         ervwxlbBRpCh+oc9eLnrKda0n2y4JaydVrnPJlC1y0SRz7c6deZDucxqy01W5q8T3IFQ
         N0UZJ8ZM9cgs2rkUORVAbbk78S3RNnaJRbmur2BtokE8dvExUag2n+VyFHhtsHQxSAiM
         LlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3leDQ3Sit1NjG1arLx7irKQWaengBSdZoAyueY/nR9Y=;
        b=E1QA0tDz/SY3ShxKR5vkBFNqniUp+HmHfGEIzGxFDexdScj9rQap6oQSjBxuaY9v9A
         Qg+MCHz6PqpL73NGzU31ORfccWDncda8LeEv8uLv1IxnkQOrqxfMefdVlaW1ilAkV8+2
         JyEkIWwYVzLFiDTS6Ro1Ycsxa3ZjGjHrOdiSgHZIVpdCY+nygGAjQnkyN//4it8s21Af
         C9anmYZmYYWqWpiqYhwzWeXllFvS+buFypbhft9TdR+kdWmp0lsxm7tSzuCDtYxSjcHj
         lD1wIukOyRR5+IynAMEmkA/vyS4BOXzvB+LMYdOtf/ve56BY6R59RBmdgSvGez3BeUej
         /m0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Phil Sutter <phil@nwl.cc>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 043/115] netfilter: nf_tables: fix chain filter in nf_tables_dump_rules()
Date: Fri,  2 Mar 2018 09:50:46 +0100
Message-Id: <20180302084505.625953337@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815884516559529?=
X-GMAIL-MSGID: =?utf-8?q?1593815884516559529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>


[ Upstream commit 24c0df82ef7919e4d10cf2e4e65d368eb2e8ea21 ]

ctx->chain may be null now that we have very large object names,
so we cannot check for ctx->chain[0] here.

Fixes: b7263e071aba7 ("netfilter: nf_tables: Allow table names of up to 255 chars")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2072,7 +2072,7 @@ static int nf_tables_dump_rules(struct s
 				continue;
 
 			list_for_each_entry_rcu(chain, &table->chains, list) {
-				if (ctx && ctx->chain[0] &&
+				if (ctx && ctx->chain &&
 				    strcmp(ctx->chain, chain->name) != 0)
 					continue;
 
