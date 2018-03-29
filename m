Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/d/mt3L1PpRU1/fWkosESpHVqNqrR0PHomBzunKU1QvfQqIIp67NjKc7PO/8drpRjxNEvx
ARC-Seal: i=1; a=rsa-sha256; t=1522346862; cv=none;
        d=google.com; s=arc-20160816;
        b=Nm5kcwwMb5ePiNZSqayKpLJ/mST9eYzIRsmaoT55MIoWARHKCLNVm7XN+vVrspnAI+
         1PIEZaFU3G2ipKHCdVQ4rjaP7GPyjvIcwO43EFFbAfZt8cLEAO2B4tOu7f9sLOEA9zzk
         KRRGm9siJXRo8ZwLr3XU7HCrX11/aKAhUXqzVQleGCK3c+hqN+xOWmB3btpS1Oe/n0Uh
         Cfe75UMlDjK0PfVigdypsXvX/MvCHdStwsJxYnKFZn/TJXpUcCPtlG0H59iHZsexhTZd
         daLBGVVbydirHHssLMXUwdMlE1FNyuKDLSE3SkRv6dBT1fj6uK24VvjFGBDVyyQ2kJrY
         WPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jcs4rCUg+NsYk/UgwzrkMuCQ0S+gcM2CxIX72jVlLUQ=;
        b=BkAjjhuIyQp/9yJKwe0LiWNJP+00Xjz/CY7V+UTIbh89kxS/hqKYOQfkA4i0h1JmGK
         0LKyv6nVC/Ma9JdM8ttPJXqb2RFaf+b6p/pdMiWXUa3lqTdSB9fTwlcHuQwKsJJbwi1x
         70Fy4eQQyDPg7JrPLYDD+EDvsnc7Ut3riPBY2OrvCs/dtZd8as2KN/CyD8voTBIbsPBV
         t5jm5hKetr6fwAwwVhUH/+ketqaC58duP4J+lE+jutzYSLJrXivztP/5yuoCULn/93wq
         /sUnLejwfBRjCjYj7QQuV40TxuXb0t5OsgEUXUytcN+8GRFzIxwRXNMNsPev/MTofnUv
         lrlQ==
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
Subject: [PATCH 4.4 12/20] skbuff: Fix not waking applications when errors are enqueued
Date: Thu, 29 Mar 2018 20:00:48 +0200
Message-Id: <20180329175742.402912487@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296148190849084?=
X-GMAIL-MSGID: =?utf-8?q?1596296383318406854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3571,7 +3571,7 @@ int sock_queue_err_skb(struct sock *sk,
 
 	skb_queue_tail(&sk->sk_error_queue, skb);
 	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk);
+		sk->sk_error_report(sk);
 	return 0;
 }
 EXPORT_SYMBOL(sock_queue_err_skb);
