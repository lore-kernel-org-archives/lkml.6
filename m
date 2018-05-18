Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrY+r0FysLGRAz7NWV4plCki9xJNIWO85wbcjVI5HqqxhkV8Z+yP0TITz5NMA1e9y0DcuSA
ARC-Seal: i=1; a=rsa-sha256; t=1526631576; cv=none;
        d=google.com; s=arc-20160816;
        b=UTudPjDTxZlkQjmOgtErBhwPXfHa1RnL3/Mar5svhwjcvs1sHViVLFS4q3VtFoLjzZ
         GvT0Gz3EtVGCPqa8iCG10f98SMrD6reXzerE6rZK87H/gfTTfYcXsFMCuZk7sMWSPcc6
         EuB2CAPf2bCkkZ0/vTbzI53GVABOvO6UcED/c/XvJpmL0Lx0/qCC/ZW7hJBGSxneJar/
         i/0GRZGj9sOFO+cLVdsLsLT1vXvIp07dDUJRnhJnPjflEp9tEtpryY8rS0lDz6rhN7NU
         CPahT4npplzaoqAsl7aXHhVwM75g3ke0c2Ml2Eix9Zku9SmV7lHPwkubTycM3fmCC13Z
         nH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9HOPKo7o6dZk9Aye1oz387Fwi9O5y7FhtagT93n6xH4=;
        b=X+LbcG7nZLJyUsQDZkhMTzcClo3UrU/aVtxLtVs0DIWK39DBQcotCqTDUizzDMHh3y
         2p3x+Q7/HP/N1W3u5NfSF/9oU5Sor8ntqxjdNiYpFonxNc1aihFRu1BoTyWwu9LHbw68
         KPEdgw7IosrQoWzGiqpgGzkA6cm3E0RVOSD8OdiFvkVyrdomsWcKU60wRo4sG8wEGcQ2
         K1Sh8zReCZfahWlkXvCbf3kdia4cP1+liuF00vGULvrPpMVJ8KPnWMD+yotQUkDvaWhM
         jCJypKaBcLvO5QVUCFGQGdlPLmk9p8+R5D4Gv81RKZVNzA8fka3feq9QhoCnH9BQwLtc
         LH/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZXahYXN6;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZXahYXN6;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andre Tomt <andre@tomt.net>,
	Dave Watson <davejwatson@fb.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 16/45] net/tls: Dont recursively call push_record during tls_write_space callbacks
Date: Fri, 18 May 2018 10:15:33 +0200
Message-Id: <20180518081531.155286878@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789176003617426?=
X-GMAIL-MSGID: =?utf-8?q?1600789231662293080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Watson <davejwatson@fb.com>

[ Upstream commit c212d2c7fc4736d49be102fb7a1a545cdc2f1fea ]

It is reported that in some cases, write_space may be called in
do_tcp_sendpages, such that we recursively invoke do_tcp_sendpages again:

[  660.468802]  ? do_tcp_sendpages+0x8d/0x580
[  660.468826]  ? tls_push_sg+0x74/0x130 [tls]
[  660.468852]  ? tls_push_record+0x24a/0x390 [tls]
[  660.468880]  ? tls_write_space+0x6a/0x80 [tls]
...

tls_push_sg already does a loop over all sending sg's, so ignore
any tls_write_space notifications until we are done sending.
We then have to call the previous write_space to wake up
poll() waiters after we are done with the send loop.

Reported-by: Andre Tomt <andre@tomt.net>
Signed-off-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tls.h  |    1 +
 net/tls/tls_main.c |    7 +++++++
 2 files changed, 8 insertions(+)

--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -98,6 +98,7 @@ struct tls_context {
 	struct scatterlist *partially_sent_record;
 	u16 partially_sent_offset;
 	unsigned long flags;
+	bool in_tcp_sendpages;
 
 	u16 pending_open_record_frags;
 	int (*push_pending_record)(struct sock *sk, int flags);
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -87,6 +87,7 @@ int tls_push_sg(struct sock *sk,
 	size = sg->length - offset;
 	offset += sg->offset;
 
+	ctx->in_tcp_sendpages = true;
 	while (1) {
 		if (sg_is_last(sg))
 			sendpage_flags = flags;
@@ -121,6 +122,8 @@ retry:
 	}
 
 	clear_bit(TLS_PENDING_CLOSED_RECORD, &ctx->flags);
+	ctx->in_tcp_sendpages = false;
+	ctx->sk_write_space(sk);
 
 	return 0;
 }
@@ -190,6 +193,10 @@ static void tls_write_space(struct sock
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
 
+	/* We are already sending pages, ignore notification */
+	if (ctx->in_tcp_sendpages)
+		return;
+
 	if (!sk->sk_write_pending && tls_is_pending_closed_record(ctx)) {
 		gfp_t sk_allocation = sk->sk_allocation;
 		int rc;
