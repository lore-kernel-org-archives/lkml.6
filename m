Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+8J7mQpblT9uQcqBoHukxCb/XJZK1oE8NSMTIe7AKodGYRQ0QLTrIQ8g5pEOj6anr37Enm
ARC-Seal: i=1; a=rsa-sha256; t=1523399619; cv=none;
        d=google.com; s=arc-20160816;
        b=wfsBZhkkV/VZSteKG33pNDMnsSiil52y7O5vbRM1/tOWCkzoI0kME9Q+DE34VF/Zr0
         X6ArIiWGV7Ge/ej2hKQuoFjJsn4nqJkwoceG6HWCSY6DNl2ich5hOyTbPArz7EkZAyXo
         /05nR48jMQybHWnGMWuLCXcKPR418bC6hRR9ltgOVnFeGyqnHG4QUrne99A24AdnYGUQ
         0uC0WVUSpiXUYUcAERkxF2zQyohrdvBpOyp8cgWJf2AYkW7fE8hD1+GCw4Vubuwl80zE
         Y9hRTJiBhuyoRRiGtB3n1U1DmgnQO41ZU458ySHwAFC+9aFwiQkSQmVoTqSfX0aPUhbN
         rQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p5YztYvj5vEeLkPTNfaZu3/AFyve5o6t1udNvy9UWlw=;
        b=oM6PmP4ZLarMtUTA8eLz1GmH/LBE3AVRnH4XPWEPuJxUdB2vi8Gj9R2qVv+4wt3ZZ3
         sIekMPd0j08Q+3a58xZJO+dP37vfkjwOp2RGCj4eQoX2VSQre8QqMAapkp2HPS4OF4yM
         nVYXvaKbHobCB9v3LmoDNPqey7OKeqim7oSqqPC1iYMgcO+xAV11vtvnEwkgaJxnoOaI
         dwzvY5amMrWc7kH8lmmuvQR9v2LqUoALHJzhuHpI4RKDkXm8epr2ux86P12/Y+NTRidB
         URPvWJtKhX2VXZMOrtE7zIUXMCfScoxkzXy4uBrxCv0RSw4X+nIR7LREf4KS9X9asH0D
         lcZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Watson <davejwatson@fb.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 161/168] strparser: Fix sign of err codes
Date: Wed, 11 Apr 2018 00:25:03 +0200
Message-Id: <20180410212807.981844883@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400279954076265?=
X-GMAIL-MSGID: =?utf-8?q?1597400279954076265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Watson <davejwatson@fb.com>


[ Upstream commit cd00edc179863848abab5cc5683de5b7b5f70954 ]

strp_parser_err is called with a negative code everywhere, which then
calls abort_parser with a negative code.  strp_msg_timeout calls
abort_parser directly with a positive code.  Negate ETIMEDOUT
to match signed-ness of other calls.

The default abort_parser callback, strp_abort_strp, sets
sk->sk_err to err.  Also negate the error here so sk_err always
holds a positive value, as the rest of the net code expects.  Currently
a negative sk_err can result in endless loops, or user code that
thinks it actually sent/received err bytes.

Found while testing net/tls_sw recv path.

Fixes: 43a0c6751a322847 ("strparser: Stream parser for messages")
Signed-off-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/strparser/strparser.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -60,7 +60,7 @@ static void strp_abort_strp(struct strpa
 		struct sock *sk = strp->sk;
 
 		/* Report an error on the lower socket */
-		sk->sk_err = err;
+		sk->sk_err = -err;
 		sk->sk_error_report(sk);
 	}
 }
@@ -458,7 +458,7 @@ static void strp_msg_timeout(struct work
 	/* Message assembly timed out */
 	STRP_STATS_INCR(strp->stats.msg_timeouts);
 	strp->cb.lock(strp);
-	strp->cb.abort_parser(strp, ETIMEDOUT);
+	strp->cb.abort_parser(strp, -ETIMEDOUT);
 	strp->cb.unlock(strp);
 }
 
