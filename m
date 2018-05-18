Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr5jjHnWQOm+BjYJjuD/tpMYUv5mB3JfTf23Fs+SV2AMjh1qCIgzE8H5+SjM8QF5IxfdHvy
ARC-Seal: i=1; a=rsa-sha256; t=1526631447; cv=none;
        d=google.com; s=arc-20160816;
        b=YzRAIV+omx3QaBpCuUGujvYIM0re80obFDR4Wq5KqshPvY0Jo1z1JsYMSy21aJT5Q4
         Z4WABgTqBMfj6cH9B5LtZxtGKaUEknRco3ea97Gy7lbrRUuWV9DoVEFxmglBSREqzf5v
         yqZAA+C+N4rdgg/A5vFpcyj1JCHRG4+2kaVoDWYseSl0pJOke30Sy7UmoGKKh4ege6P5
         kLAixvYavgOomtApbILmxsKqfAJC6tSWCk5If05WZ1gswoWrjoA+4qhsb1dIJeTG8vM6
         JLKXHuzYqeE0DB2ltDF+Du6V1gLiVVfkuNj/yGwDTx99C0vE31tK9KbWYYgKHq4+z2ZL
         eg4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=SftyBSJd5ZCYA/Bkb7KwkOX1ivtlnGHBDRvSn9Y0ONs=;
        b=xK36+7xRHXf7lHz0kz0RvuFXu2k8d2laNrEttktwQF/lkU7g4TRhxuwcTYfxpsPBA5
         WGyWgydRnAC2B35sj26A8OxcAcrA+l89pZc1bcORNPpdDLOnTnPOFbmeNeKhK316qoNc
         I2SX/jy3Ym90k+C2prmlRCMOi0OwJ/js5X7PpO3AWHUMhLjrZL/WToHeAA35y82dTTnK
         oxRNfay8dWiy7P+Z/vhclTMAdba53or+X54GFGorO+1SCKPrBtFDE8U02nnaeXh3TFfj
         d2QEwGG+qJjB0HMP+NfUnsHTNeoQABuLX68DWPwJZ7pvav6B3SyaAitLV3qjIOZBPK9C
         2XJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IKhwRwmQ;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IKhwRwmQ;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 24/55] sctp: fix the issue that the cookie-ack with auth cant get processed
Date: Fri, 18 May 2018 10:15:20 +0200
Message-Id: <20180518081458.656369961@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789097237819464?=
X-GMAIL-MSGID: =?utf-8?q?1600789097237819464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
