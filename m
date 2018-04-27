Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqQ86V3oNXQqHNUoj98cDDTFTS7daj2TPTrRYcJVj/nNO93YY1osqgMFR0Td1MHmp9SYg0t
ARC-Seal: i=1; a=rsa-sha256; t=1524837920; cv=none;
        d=google.com; s=arc-20160816;
        b=U6bxmzxgJqRKl2EqHBKUG+RotJ/aOXyu4mnzXDdEAd9o5VOqdNZtozXgrW03q4tmnn
         WwjctXjDWGs9mQsYCI6iPyoIVzlM868CBH4pXu+9YT9wpnhDogTtKScqSJ0UhUn7nCaw
         oKXpToedkNl9ad2YSo3aA+qIYfDe1yh6f4YOxXfNnp4GGqXhnLlsc+e+Nr5TwlAX0zmj
         jgzU3I/cty7O0i8gcsn8WonrQvV+/YE1kzNVxqeJqwHg2IllQ003efjE6bt8evyl1Rxr
         q4WtMZaIitnIJ1bZiOgib+JperKIetUyuSh34w86R8t2rqu/8vipUJlO5o5K/G+1AQQU
         r7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=3j7pWtyReiAMCDMQd00YQpMNyFa/aXzixj0t8E0fLG8=;
        b=dIGS0ywnAdiGd7ofymASvXkePItEUkc0jrwI4/9sWCEbCJHzy07gTrw6+x+mm+JErG
         h1B7eXsH5oLfqjIzxW0GfN4EZnFBxvh05OlWunhOKZed8HlekYRQLkGcR08uNLQnj3nW
         C4bHl1RlNpY/zu7AC37Z8fc4Nz6EL7u6XJppVbdnKxVzQOm2xJFo0qEdMJ6cSZwnXfG1
         mJO5Up3cWzJ3NHjmQur+Hv7Ic6wiRLkuMPBV/IYaxMSv+xfjBE7N7gofpWZfmUWbuRBs
         QOrUnJ6HsAAwVm5hCcl5v6YtOj1C9OtM0tv3N8tJnzb8QHVPWtHPUaVH1iGgZWBub2wW
         Xjpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3DD21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Doron Roberts-Kedes <doronrk@fb.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 68/74] strparser: Fix incorrect strp->need_bytes value.
Date: Fri, 27 Apr 2018 15:58:58 +0200
Message-Id: <20180427135712.758259744@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908447487343688?=
X-GMAIL-MSGID: =?utf-8?q?1598908447487343688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doron Roberts-Kedes <doronrk@fb.com>


[ Upstream commit 9d0c75bf6e03d9bf80c55b0f677dc9b982958fd5 ]

strp_data_ready resets strp->need_bytes to 0 if strp_peek_len indicates
that the remainder of the message has been received. However,
do_strp_work does not reset strp->need_bytes to 0. If do_strp_work
completes a partial message, the value of strp->need_bytes will continue
to reflect the needed bytes of the previous message, causing
future invocations of strp_data_ready to return early if
strp->need_bytes is less than strp_peek_len. Resetting strp->need_bytes
to 0 in __strp_recv on handing a full message to the upper layer solves
this problem.

__strp_recv also calculates strp->need_bytes using stm->accum_len before
stm->accum_len has been incremented by cand_len. This can cause
strp->need_bytes to be equal to the full length of the message instead
of the full length minus the accumulated length. This, in turn, causes
strp_data_ready to return early, even when there is sufficient data to
complete the partial message. Incrementing stm->accum_len before using
it to calculate strp->need_bytes solves this problem.

Found while testing net/tls_sw recv path.

Fixes: 43a0c6751a322847 ("strparser: Stream parser for messages")
Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/strparser/strparser.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -285,9 +285,9 @@ static int strp_recv(read_descriptor_t *
 					strp_start_rx_timer(strp);
 				}
 
+				rxm->accum_len += cand_len;
 				strp->rx_need_bytes = rxm->strp.full_len -
 						       rxm->accum_len;
-				rxm->accum_len += cand_len;
 				rxm->early_eaten = cand_len;
 				STRP_STATS_ADD(strp->stats.rx_bytes, cand_len);
 				desc->count = 0; /* Stop reading socket */
@@ -310,6 +310,7 @@ static int strp_recv(read_descriptor_t *
 		/* Hurray, we have a new message! */
 		del_timer(&strp->rx_msg_timer);
 		strp->rx_skb_head = NULL;
+		strp->rx_need_bytes = 0;
 		STRP_STATS_INCR(strp->stats.rx_msgs);
 
 		/* Give skb to upper layer */
@@ -374,9 +375,7 @@ void strp_data_ready(struct strparser *s
 		return;
 
 	if (strp->rx_need_bytes) {
-		if (strp_peek_len(strp) >= strp->rx_need_bytes)
-			strp->rx_need_bytes = 0;
-		else
+		if (strp_peek_len(strp) < strp->rx_need_bytes)
 			return;
 	}
 
