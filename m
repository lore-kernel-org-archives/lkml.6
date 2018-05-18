Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo8mBpPgNIseoXtzu8kUCY4oP9L14Wepk3x0KNcCtQZv9eGXmCbSjS6AXmag1etCmTngYW7
ARC-Seal: i=1; a=rsa-sha256; t=1526631746; cv=none;
        d=google.com; s=arc-20160816;
        b=LkAmHMud1uzkvtSUYWza2xYxFZfG3LPzq/UgJvGTuP427LNnttRcGuLUd1Xc8jDQIY
         YROrcq+eKzh3dNr9PQVI5agepZq2FpBxoVm9qBe2Ibf/MurbE8rI0BOaJ5RDz+R+pKu7
         a0m/owdyikz2q/XCatXCAfq9WKKN9WSilPf9LZUCkbYMbBTi6xUsScnUBLzj55fjJFfL
         rD6J6IoBYIIV+UrOZ/HOU1Xra//vU+syO4IZ6uHG0RnXAYX/3wd5si5P3Fje3CDLfF8L
         veicQe3nJ6GsYr2i35n+IzzL8ahV+j789nDrvpXIKuDSaICQj8C8OjDSLHaI3baVUcR9
         qbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mGaejvg/U43mIo+Wo6Io+X4+lH4k3sqdOoTFFAjhpGE=;
        b=YKRzYta+rw/JU1u97wpWDOh9sd0sykK0IzbyUxC4wjbFS8R4WMXi3cM6AdvDW8cdG4
         fw5ej+JWtU7XWadT67hxqBx7dELp0FreCCiojLmTFuMNF94j2obZFOG/bu2I9DfTnsZ5
         36KDjQ4luAJoFczTkdEIib2BDyvL8OvwZ60KE9PepPbraJ0S33wbWZZope2AJaVBdWd2
         Bks3EcVxKz5uFwArKQ3G5PJ3UvB/C+QuO+CXLQ+wxhZpKSmgy9RhGMIojKFyDUGpH9eZ
         SfdoiglAtYFBPMS2fiwtRkcrhQq7jm9OsqzgiLVCltKw40yMTX5W4uczTIGrz8g9BAS4
         2h2w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sF7L940Y;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sF7L940Y;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 24/33] sctp: fix the issue that the cookie-ack with auth cant get processed
Date: Fri, 18 May 2018 10:16:03 +0200
Message-Id: <20180518081536.056464905@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789097237819464?=
X-GMAIL-MSGID: =?utf-8?q?1600789409787694796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 	skb_pull(chunk->skb, sizeof(sctp_chunkhdr_t));
 	chunk->subh.v = NULL; /* Subheader is no longer valid.  */
 
-	if (chunk->chunk_end + sizeof(sctp_chunkhdr_t) <
+	if (chunk->chunk_end + sizeof(sctp_chunkhdr_t) <=
 	    skb_tail_pointer(chunk->skb)) {
 		/* This is not a singleton */
 		chunk->singleton = 0;
