Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrW9BMwJn3SHmwRkMcJb0buwxxcRWuLi2adRYzl7N7g4wJ66/B1vP4pXOj5JFo4mEWNkXmh
ARC-Seal: i=1; a=rsa-sha256; t=1526631665; cv=none;
        d=google.com; s=arc-20160816;
        b=t1QQzaGtmrYmsPT1Jhd1t8uQOo3iKUio+4qjksTt3ox8Cm5SVgkpkqvt/zdtunUOwV
         rNUdiKhHDKEm6ydqeFrpUqgOlq9F1wUz0aIhDtTrMiF7h+tDfSr9d3UL47mB9C2w9TUA
         8JOdAHX2osJDABWU6RTVhkhrBVm4Hep/9vLRPJZfObqAnZmwuowd/JgjsfcnKpSUw+pN
         cgQI+ht5JgWAWPg+q1AcBMiB1ddItqnaUd+ki3h3cRHUXpLZ/VMYew6YHyacOlOaD7DZ
         Ppl0RVgB786VCk+zLyFgWUb9ZfrUItLgwXy9+QK5Jr8a2izbFQzJZ8jZaLa9T2le1+Ch
         ZpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=O96Vy+VUYe7lPoEt5LloU4kRJHYEjAx7JANLEFQPjCQ=;
        b=dCDEIEOpOd0XEK9/Ag2CCU19ZNz6pDvn8STUyfDQ1taoesIj/hGNvJRg9FqQRT86eD
         w2hW7oDjiZM+MJ5cmZ9THV+D8lTGbYHyezPiAjk0RofGGNL72Q3xmbuE81NjeMR0Ji4Z
         DOhbpduIDSFSRHx0Wj12bPEcjVUWiihNO9/1yFQoSxjzd4X9gH8GoWOPoNhTUdVzhkTK
         UIWyA0Tk74HihU+cLIweCLuGH5qNFqdldSXgNFy9TX00LJQQNZ/ABNgTdzuz6qr2zwGA
         7qQ238SAbImQ35sdQ/Xwvvf873Q8NKZ4q1yY8VyQK/yGd3/WwpDUqztNtJCu00o5NQ8x
         tS8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=a9d7aUTR;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=a9d7aUTR;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 23/45] sctp: fix the issue that the cookie-ack with auth cant get processed
Date: Fri, 18 May 2018 10:15:40 +0200
Message-Id: <20180518081531.511535062@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789097237819464?=
X-GMAIL-MSGID: =?utf-8?q?1600789324506937019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit ce402f044e4e432c296f90eaabb8dbe8f3624391 ]

When auth is enabled for cookie-ack chunk, in sctp_inq_pop, sctp
processes auth chunk first, then continues to the next chunk in
this packet if chunk_end + chunk_hdr size < skb_tail_pointer().
Otherwise, it will go to the next packet or discard this chunk.

However, it missed the fact that cookie-ack chunk's size is equal
to chunk_hdr size, which couldn't match that check, and thus this
chunk would not get processed.

This patch fixes it by changing the check to chunk_end + chunk_hdr
size <= skb_tail_pointer().

Fixes: 26b87c788100 ("net: sctp: fix remote memory pressure from excessive queueing")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/inqueue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -217,7 +217,7 @@ new_skb:
 	skb_pull(chunk->skb, sizeof(*ch));
 	chunk->subh.v = NULL; /* Subheader is no longer valid.  */
 
-	if (chunk->chunk_end + sizeof(*ch) < skb_tail_pointer(chunk->skb)) {
+	if (chunk->chunk_end + sizeof(*ch) <= skb_tail_pointer(chunk->skb)) {
 		/* This is not a singleton */
 		chunk->singleton = 0;
 	} else if (chunk->chunk_end > skb_tail_pointer(chunk->skb)) {
