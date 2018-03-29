Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48JH+IWeEDMYjcODCtM2eYa4/GJKPNRDhHAfL8IInkqCOXO10KOuH4ZWvgaGeCgQ3ZAUnc/
ARC-Seal: i=1; a=rsa-sha256; t=1522346800; cv=none;
        d=google.com; s=arc-20160816;
        b=ElwaPR1GC9CKSaS5m64/loQY6tptUgymU2Vv6QbwbJvvVTPthqADuMdHG2mk3vq98K
         ijujit5hbHjuQjwY3Xafqb/+0WJV/X0EqGR1TE1O3dutX6EKSN+uQJTbAZT/I8CFRiYH
         TgSza18kHAtFSs9oPdQ1/ddXZEQS3lBOTm3f3zv1b14M+DhdSeT+mzRaQm1FmOBJOsmk
         TAgXaKyx1MQqloiu8T967mJXhkGBQzzefAzKZ56p+Y9Ez/whjgx4iuMn2usWm6uzGKPu
         1ciJa9+it32ZSPi/gALH7kK/+BrTa921aDle8sQRQxk61ONw2iH6ytwx1XS1EJ+p/DSo
         UWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JE5CniyYBK3S6xWi16DAMfkWFg1rOMagbT6Y3tl1GSg=;
        b=H+ckqF5MX9lCkcU6hSTEAD4lhe4IlwkBpbE7zRV1nT93L3FpcjA99WhJixk5ndQH9R
         +AwnUNnGu0Js1J6vlbiKs3pnBbNzHVA7wVJrGtA0yKXF81JflcjMuUymkSPSNJ7spIgN
         c97AVTDZxYA6hBq+dZtB6RY9NpMkAK3XSgBoYeLjbCGwrSqtMWSzJ9i/9DPpVJSOpJGq
         /D1bcim8gAK+6T9a6+9ga/a19UnO+3n0UBl82Y2BvqUP2aXqq61YZPIPOkZFNcATH9v1
         1A/ZIe1tfHpEl2vrUDQgZEsNHhTHVCq6+ZDEnY5BwPnQ+KRqN3ydgCdgd93cMAeHLfW5
         qLkg==
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
Subject: [PATCH 4.9 19/28] skbuff: Fix not waking applications when errors are enqueued
Date: Thu, 29 Mar 2018 20:00:38 +0200
Message-Id: <20180329175735.582981722@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296148190849084?=
X-GMAIL-MSGID: =?utf-8?q?1596296317970732278?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3717,7 +3717,7 @@ int sock_queue_err_skb(struct sock *sk,
 
 	skb_queue_tail(&sk->sk_error_queue, skb);
 	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk);
+		sk->sk_error_report(sk);
 	return 0;
 }
 EXPORT_SYMBOL(sock_queue_err_skb);
