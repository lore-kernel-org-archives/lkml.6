Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtkQdfRutZIxB64bKTTBQwUguhsLGkfQsM2JjdcJjPLDUCGMpmnNoamcaHunzpgi1FaT8ZT
ARC-Seal: i=1; a=rsa-sha256; t=1520451708; cv=none;
        d=google.com; s=arc-20160816;
        b=P6+vFDvc22fhU+Wg763GCV5O9060RaVNSkUOGdJa54BrYaKwpe3jTEI0aKu5U4pZCK
         rQXMMzRgSZRtcvyDHHmwl1OhmtLuKEAYNlTcdFGtIW1F1XUc02weR5MZB/ZrfpAOi8Ly
         OPH6o3SnHXz4VdsW0pTh9vNfUB9jC4eLT33fFlcf3zas/lUgCaxCeQ3ppBseZvBaKdMs
         zmvbmw2kMCEYyWYTnKB7owIWc5UFSKZyoa1bB7uh0uhsihMI3KWsupvYxO4FOqsF4fqu
         io1pgo6Ja0zBQ4hwGob9Yu4I/6qQMpF6wvTxsa+IEQximwq/5IOtV02ha9GcENOCHY3W
         H5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sPm1EIT6AA9p1OMqJwZB/GUWCZfililMgVwDg2C05Yo=;
        b=u/rd+TCC5VAle5LJaGYHZs4wO7aNJx5qBC7+EIOLaGTRuKSYXjogQL5zhveiur1ybW
         61CVBdPXAbjMjxm9r0bRK7Qvsdq0I9+x1Q1Vp2B+GYUUf4jbUqwr+TmH9SJX0C/oDGSa
         bVEfwTPzTVDm9hUeSKp9IirINeFs1+X0O6xoHkC8hQDYGP00Xl8St+sSWXxdv2C8kqoF
         QzHzFgQEdkXVmnQNMAnns3orb1RU48aHCBGOHbvZ5Z0xABh8ckeFEso+Mtnm90PLl9tk
         3EX4XZRwwsS+KG6xESRjkwaVPeQSMTgB811k4RKYHxgUmvl3UHEKxtgTkK9Acul5bQZa
         kUyA==
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
Subject: [PATCH 4.15 062/122] net_sched: gen_estimator: fix broken estimators based on percpu stats
Date: Wed,  7 Mar 2018 11:37:54 -0800
Message-Id: <20180307191738.271816350@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309170264925770?=
X-GMAIL-MSGID: =?utf-8?q?1594309170264925770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
