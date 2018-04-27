Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpiDQpAOs1zcgvYGWfPkkg5nlmB0I5q7stmHw4E6lPyI1X8yTf8ZC+uZnfs1d60+8VO1bh0
ARC-Seal: i=1; a=rsa-sha256; t=1524838025; cv=none;
        d=google.com; s=arc-20160816;
        b=ekduHALFUhMMDsOWaxvL6FFLklcSGUTd8fOHSC0nr7iVUwFCZLcDY8DbIiZSes8U6G
         juIPnARnUlxMjz48U0qXWnIuP+3ODzchLhtxVnypX4eJDPLHO/jPbh0q4iPMJuWD0ZA7
         OlwvkYkNs8zsIqyWTVQPAbDi4DszaBEYEP1B1paYRv8fuqLUwxmzlAEtaQHfK4x61qSL
         hngEIROdhRUsHsX12ItHeohUR75HkvX6cqpeGOiw5o/kuXyECntRfzsJJLtiz3n5idS5
         oHV1/9EDPOCSt07DdLV35aZ4sumaBYjOBrJJAd55ghh1f2nNrZ0zGm7k6b/b9cCc16bi
         t3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=UmNL3NsVCLNksA/Z2Q60H+1HzSQZ+ZxsCjwWaUkCb98=;
        b=pWdTRStRBG4wTirH9dNsy8E56ZLeiuGLZpxFAc4qjBNM85z1aVDe6crecYTJSvSuPw
         3VHHR4FFwPOxIVhNWyF1bBYOeLM9u1yboSqdBu5nmfuFGpTQGMrgPv+aFQNiB1D+3fV9
         2aSVzoeizLHI+PpGEuyyv0ALZFUBkXxkpJdHHRBuCkEH6843tnj9GbnfO5X1tE5dZYTB
         s/FAxJiTvVDBGH6rcNsRCiF458ff6Cq0LLiI/v2x1wbHWPFA4tVR5fOPCfjw9NA/ouQ8
         BeAxD+HxO6qf7U9maGubmxF6gZISFHIJxw2kF8nFfZ6GAkY/1pAlBGGsTWZcYgvY8fFT
         QttA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C8C218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Doron Roberts-Kedes <doronrk@fb.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 31/80] strparser: Fix incorrect strp->need_bytes value.
Date: Fri, 27 Apr 2018 15:58:24 +0200
Message-Id: <20180427135734.560740670@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908447487343688?=
X-GMAIL-MSGID: =?utf-8?q?1598908557206090876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -296,9 +296,9 @@ static int __strp_recv(read_descriptor_t
 					strp_start_timer(strp, timeo);
 				}
 
+				stm->accum_len += cand_len;
 				strp->need_bytes = stm->strp.full_len -
 						       stm->accum_len;
-				stm->accum_len += cand_len;
 				stm->early_eaten = cand_len;
 				STRP_STATS_ADD(strp->stats.bytes, cand_len);
 				desc->count = 0; /* Stop reading socket */
@@ -321,6 +321,7 @@ static int __strp_recv(read_descriptor_t
 		/* Hurray, we have a new message! */
 		cancel_delayed_work(&strp->msg_timer_work);
 		strp->skb_head = NULL;
+		strp->need_bytes = 0;
 		STRP_STATS_INCR(strp->stats.msgs);
 
 		/* Give skb to upper layer */
@@ -410,9 +411,7 @@ void strp_data_ready(struct strparser *s
 		return;
 
 	if (strp->need_bytes) {
-		if (strp_peek_len(strp) >= strp->need_bytes)
-			strp->need_bytes = 0;
-		else
+		if (strp_peek_len(strp) < strp->need_bytes)
 			return;
 	}
 
