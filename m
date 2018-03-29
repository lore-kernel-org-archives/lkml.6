Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+BrPBWQlKURypECzEGndh13TUjEL8K6Ms0SeXo49U5zESUKYvH4jzcoHvowfxDDi157xPq
ARC-Seal: i=1; a=rsa-sha256; t=1522346716; cv=none;
        d=google.com; s=arc-20160816;
        b=sa4iRJYKh2wNk5l0srot0Zy0ghvCQqP81A8OGBxJnocPdtcezCTMowvoRIE4FcSezv
         iduUjFtH+4CKkSaLlOdqduP6BT80YQ9RSilmjSU+OBtGX+C3DvqTyVZsaG5IL71+z1ib
         394nqgDfjQzSa+QdRK7YUGk0fWtEPDG9drbPmN7sxnlnjZ94/mMJ51Bn0a4xZyJRl25P
         YLaP/bzmOkMstCaZlx5XXA8AybrdNJM+a4aSR6sF+5Vqv9cINqLN11GBRjl4pEukFTBC
         Hsorxw9eQs25Ef6ZN/XiYZCa1fyLcLFOiwae0SfHgiVCywFbiA1cSPucxlUCpRit9gmm
         2VLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+I0y7Gxw9gPhTCIJO5AKwsxSkaFitWJDE0oQtz2Ip6E=;
        b=ZSVgCo9hma3mPrWl85i5pgjdUsrCo76nC8VIqht8juC4NaNojs6//Y8Rso5aRzBE2f
         v7A7o/8sjr0mgsYdndjVBoSr6xWKy3dhS3Z2fdKoYw+hmjTuvW4fSr5SoWRpfmnl5jyP
         s0PNwcnHjl+UYfl8by98FRAh1yf/f8EkecIoCu07SP05JifEkt+J9j2NcOH8rQIBoLLo
         7sfXK6Ojxh3wWLKmSLvXVkuVq2zhLGrqftCaqBFZb5kF9bsIBb2uljstOCxu6HftkN9V
         sBTSCe0adxfNzZHVPjV62rMHraIEcr+FuOt5l4wCyv3tZ+CLccfr35vL8oVBpj307B/l
         NCAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Randy E. Witt" <randy.e.witt@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 33/43] skbuff: Fix not waking applications when errors are enqueued
Date: Thu, 29 Mar 2018 20:00:28 +0200
Message-Id: <20180329175733.626168276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296148190849084?=
X-GMAIL-MSGID: =?utf-8?q?1596296230725221873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>


[ Upstream commit 6e5d58fdc9bedd0255a8781b258f10bbdc63e975 ]

When errors are enqueued to the error queue via sock_queue_err_skb()
function, it is possible that the waiting application is not notified.

Calling 'sk->sk_data_ready()' would not notify applications that
selected only POLLERR events in poll() (for example).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Randy E. Witt <randy.e.witt@intel.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4171,7 +4171,7 @@ int sock_queue_err_skb(struct sock *sk,
 
 	skb_queue_tail(&sk->sk_error_queue, skb);
 	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk);
+		sk->sk_error_report(sk);
 	return 0;
 }
 EXPORT_SYMBOL(sock_queue_err_skb);
