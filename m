Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224nz0DOFBVHyGUfAhN8QLbMWml3hOWvLz4VZ5n7a+9PAWMHuowz3G9rpWvZln/sJ5hZ5smb
ARC-Seal: i=1; a=rsa-sha256; t=1518708623; cv=none;
        d=google.com; s=arc-20160816;
        b=fnLjygz8s2WV6b+T2Bj+grTSqSdjCRpQuZSPH0usMBBxrrkhEAHD9Q+97b+XOCMYLG
         xDJYsr6OVr6ekwPEAhLqX21LqhYk/wZaxPmzgCcwHHHxYto74vI/y94F9WcLo8hYLDE2
         PJb2ROS7vSCdJHgiOAqm4miqG2OU/wxVJAFHhzLU7JfrX2cLTOHal1KPco/wgy0sey4w
         BR3n8OznT6qqplDrfatVM5Zg0lZTS4MbI3WwNXvryKGPXdyz/p7MsLvby807yDO1O2NG
         3Y7Cn/8wKMXo0SjgL4LF2ntAvdN4+7dFXn3pCOhiFpnSg8eUVy9CDV2tGzYN40K/MON9
         DhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=n2w4iuSSu32iWRL6fmt9ak8cYbI9V4xrZSeOw6kjmXU=;
        b=l6Tv0F4gZ6rI/CmUb/zT8aTnHf2XX9M9SOFwtMpFPdZs1i+hQHcr7WN4E9s6lHT81o
         op6FTEnwrF2/Z9rK6IAHPpWSZP6uA9F8TAyRJL36wGZfkAN/wDfNSjC4ZWKHtY1JkTwx
         pxpYI4iy4fy+ga8eTjvmJ4jMizUCKlAwVkQkEL79yK/ghgoY+5QdGJGh2trfjaF9rgEg
         w/RHknvwhjD2BiWuEMJ69Ow8Lm3J17n2BnkCKPb+KaaJlXeYHwQY8pRYZEfBkirSvRQ0
         LeEOpCTGaoc2dwQFlRZLUpvhgAZTn3V6A6lQUpv4NMINrKUfDQBvECWjS0SIElLbpTUJ
         J9RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mohamed Ghannam <simo.ghannam@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 018/195] dccp: CVE-2017-8824: use-after-free in DCCP code
Date: Thu, 15 Feb 2018 16:15:09 +0100
Message-Id: <20180215151706.665228900@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480715990046369?=
X-GMAIL-MSGID: =?utf-8?q?1592481413630485383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohamed Ghannam <simo.ghannam@gmail.com>

commit 69c64866ce072dea1d1e59a0d61e0f66c0dffb76 upstream.

Whenever the sock object is in DCCP_CLOSED state,
dccp_disconnect() must free dccps_hc_tx_ccid and
dccps_hc_rx_ccid and set to NULL.

Signed-off-by: Mohamed Ghannam <simo.ghannam@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/dccp/proto.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -259,6 +259,7 @@ int dccp_disconnect(struct sock *sk, int
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct inet_sock *inet = inet_sk(sk);
+	struct dccp_sock *dp = dccp_sk(sk);
 	int err = 0;
 	const int old_state = sk->sk_state;
 
@@ -278,6 +279,10 @@ int dccp_disconnect(struct sock *sk, int
 		sk->sk_err = ECONNRESET;
 
 	dccp_clear_xmit_timers(sk);
+	ccid_hc_rx_delete(dp->dccps_hc_rx_ccid, sk);
+	ccid_hc_tx_delete(dp->dccps_hc_tx_ccid, sk);
+	dp->dccps_hc_rx_ccid = NULL;
+	dp->dccps_hc_tx_ccid = NULL;
 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	__skb_queue_purge(&sk->sk_write_queue);
