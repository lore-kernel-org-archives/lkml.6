Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvaAHPiBOgzaYJ5Il0NH5MBJ/j4cqKFzkHFe4WHSDfJRAItUi7rQQVSMSAMP4D0GjQl9JB1
ARC-Seal: i=1; a=rsa-sha256; t=1519981310; cv=none;
        d=google.com; s=arc-20160816;
        b=qydW6Ts0bR45DFAY17jA37Uo2SAyNa+DB9OfReHNhWEgn8FUmsKEYPpwiUA1R4hXua
         xb9Sc3fQhurwiM+TsMSo9p/V2D3zse1Dizg1JopxAM2xLqAC3TWy9YJ1RoQ73tXndQe7
         KuIy3PdmE65G/qMfWisCaN7QECfBTPIwuXj87DxoA/e/y4RJU0iDGEcNLEYkR3Kf1Z8n
         RpuxeBUrSa/kljGxLAo5SmDmiUo9OftjUN+EpHl+5t0wcWdZ1pP/+ROoWwFKL1TkQBF7
         gCiOorB8aMnUo9zMSj+5y36WnOuyNK7SCoYUqw+j+ejumzctjBja77zBUqHrbcGR1K5m
         BCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IWDif7+Q8c3m+1av4+Vp2EVusF9w0e0P+AhCK20d5N8=;
        b=tVtsxcxs2g29WZQLD1jDjrjLFLQPqMsTSS0czvz/Fhpk7FE1XD4OVnLaowH07h4XJT
         v/F7csmxOHxZCySza8YdsjDFpYHCNcYJWqp7GqyJGO/TYzUB5Zn32AI3j2yU/t7OL4z4
         diOJGRmzIBbrjf2eciVtEt5ZBP07B4RD19XWxZ34ktrjy1Gn2rp6AvGGpqKK1TPhCX6J
         KEIhaQFeGTIlhPrC8qldU368uy8sCfK3YwlQEfrcE/adDSP/DOkQ7qk2kiSPOXF5rR0f
         hQ/XyXwJyOdLNV0HYm/9g0dbL9uoBTiRVB53de1SKHP4nytMaFmrYOtEdDjwXNp4JKVD
         r/og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ofer Heifetz <oferh@marvell.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 053/115] crypto: inside-secure - free requests even if their handling failed
Date: Fri,  2 Mar 2018 09:50:56 +0100
Message-Id: <20180302084506.025583264@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815922138519680?=
X-GMAIL-MSGID: =?utf-8?q?1593815922138519680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Antoine Ténart" <antoine.tenart@free-electrons.com>


[ Upstream commit 0a02dcca126280595950f3ea809f77c9cb0a235c ]

This patch frees the request private data even if its handling failed,
as it would never be freed otherwise.

Fixes: 1b44c5a60c13 ("crypto: inside-secure - add SafeXcel EIP197 crypto engine driver")
Suggested-by: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -607,6 +607,7 @@ static inline void safexcel_handle_resul
 		ndesc = ctx->handle_result(priv, ring, sreq->req,
 					   &should_complete, &ret);
 		if (ndesc < 0) {
+			kfree(sreq);
 			dev_err(priv->dev, "failed to handle result (%d)", ndesc);
 			return;
 		}
