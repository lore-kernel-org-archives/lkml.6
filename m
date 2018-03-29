Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fdgsa6JHQKLrgzEyWX+lbk2vqyAkOoZmWp0p2I36CWSizb88lelQFWBDEI2Xcxx0gWW7v
ARC-Seal: i=1; a=rsa-sha256; t=1522346637; cv=none;
        d=google.com; s=arc-20160816;
        b=ramAFjXj2ZbqjXv5JJYUDzJtOvx/USvMY++2flHthERyOOe3y9Z1D/2AI0/X6iNpxH
         /fsdIeSGPki7zvkGp9S7Jn21jBSEoNGcoKSio77xQ/czxdnmR+XzvPuKb/vzj2b21crm
         U0+7hYqbEWs0jfpBJsZRuvnahsyg2ARLMwWJ4rGdOvsSAP4tGBR/GkhhQUKXSbrXvtQm
         zQB4ZcKv25Fuuyhm5E0hTD3N+1LL1zfrBNEYBUFUN57RiyC1V7Rz9BfzbYKtIgPyoszh
         sCCtJA0G+xKvOj+NomC3RIrlliqh8nCr/wAU7Cja4j6GP7ghD69n9mvLLh2VGoDeyFvn
         ID6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ngVM8jCHkPWCZ6a4IHIMXxAO0h630w+n0cJBneMxVvI=;
        b=0ZVNItoUEE1I3Gpu7pJ1BSIE6jkk+5N808IcThvLGEr54sxpyzekXlGIEJKK017YzU
         gxq14IGaZ+ZQ7pMVpT6OaCCmuAd7srv5grUFD8rx78ojIyAbT/EZVuzLPBzNiyBLyKhR
         Ll5wbUAa51sm8uR/+oo6pmHyTDUdwAqsLq4f7iatmMVFzZfeoushWigxOF2F66Nagh+2
         8ap6EJBbDDN5f00RmB3VOXHda6ogAPGNmM/TSVrkZhmY//zXWC8DSm+HwlXxEOhTFoqs
         OlW29EWPCHyl3ZBk0WVXkYaTjk1pwdIDsTFbXo23lMgBQjDpPKPVAE16GU9dgiFCLAma
         P9EA==
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
Subject: [PATCH 4.15 46/47] skbuff: Fix not waking applications when errors are enqueued
Date: Thu, 29 Mar 2018 20:00:27 +0200
Message-Id: <20180329175733.378608317@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296148190849084?=
X-GMAIL-MSGID: =?utf-8?q?1596296148190849084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4173,7 +4173,7 @@ int sock_queue_err_skb(struct sock *sk,
 
 	skb_queue_tail(&sk->sk_error_queue, skb);
 	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk);
+		sk->sk_error_report(sk);
 	return 0;
 }
 EXPORT_SYMBOL(sock_queue_err_skb);
