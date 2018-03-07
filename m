Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtBQ53YuyPnOfMaoXd3AOId7SUdQ/LVWuNrq6A45z2InXtLHUHcLUU5JE9S2v7fFVRox5LB
ARC-Seal: i=1; a=rsa-sha256; t=1520452065; cv=none;
        d=google.com; s=arc-20160816;
        b=QJ4A5T7Cld2LeXMJuNrAPgHd0divL+FLJVujrZEchqJTgb4xAAcQBrCzFyq9fPCZaD
         VTYNsWi+uMtD7mfnCrPdsUzf4/C72v8THuPX2b2W3+7aTiA3YOrKxJBCNk88wLcj423k
         cWS/rTORx1bYmR90eD2sfaKO1DJYKCg782sZTtDq0I3heP0f+yWgAJXD7dNwaBB8xH3f
         z0hvdzfaMjA9P2RcEE30zGdNyW/tBdxyc6fijsT7nrR/d7qtnMEod3nt1sCgg3zyWdbz
         6E8mb+axYuVDaoSHfaT/RMxOgg4s2DuM3Kq2WrK1yS/loP69AboxZ4L1jg8IBdTe4I18
         aS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YwwZasVEXn9iyo6h5+sWllpdFb/dHS0aq2MQH8xyuCc=;
        b=CHVcCxTSjnZbihbYr9xeFPft+pBP/T0GA4xHS7cRBSGeb/Tf3ySQlqPwt0sjZHHi7E
         6/D+P+tTQZOiOS30uzBvXBE5GkiaHBbY7JxBlkjMZdvOJAZdrVqZmKJNEgxRU3I7swmM
         9P/OstXC5rRGbgvTZjpyFPJuB/1CVUcLSl/0kdFWPer9M4IeV0gYmUU8BtjNV4i24K+l
         mm3T+V2qCFp7y3ImIa22mPcKCt3VtEYBhN2n7aesyya6muBLH7QuY2FbV1+tW/qsSSR2
         WY0SZpFpcQ54DJ8/ndM/NeXlra17WycYcwP7OAEmEt8CBnV1/RJZf2KCCD4ZuWDeo523
         vsmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 057/110] net_sched: gen_estimator: fix broken estimators based on percpu stats
Date: Wed,  7 Mar 2018 11:38:40 -0800
Message-Id: <20180307191046.925051357@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309170264925770?=
X-GMAIL-MSGID: =?utf-8?q?1594309545125486296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit a5f7add332b4ea6d4b9480971b3b0f5e66466ae9 ]

pfifo_fast got percpu stats lately, uncovering a bug I introduced last
year in linux-4.10.

I missed the fact that we have to clear our temporary storage
before calling __gnet_stats_copy_basic() in the case of percpu stats.

Without this fix, rate estimators (tc qd replace dev xxx root est 1sec
4sec pfifo_fast) are utterly broken.

Fixes: 1c0d32fde5bd ("net_sched: gen_estimator: complete rewrite of rate estimators")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/gen_estimator.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -66,6 +66,7 @@ struct net_rate_estimator {
 static void est_fetch_counters(struct net_rate_estimator *e,
 			       struct gnet_stats_basic_packed *b)
 {
+	memset(b, 0, sizeof(*b));
 	if (e->stats_lock)
 		spin_lock(e->stats_lock);
 
