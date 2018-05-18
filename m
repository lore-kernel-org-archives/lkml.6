Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpz3X59zKx7wWrKtYTGv4D+0yybG406YnmpIOaLuowjxAXRkWZ219oE8mW2dPgZ1rTW6dzJ
ARC-Seal: i=1; a=rsa-sha256; t=1526631523; cv=none;
        d=google.com; s=arc-20160816;
        b=Bef0S/bleqeX8G2hKErZgDHTG9NDtzFT3ul6WuYkbldTCl/okXjP2HZUN7YyWOyDM2
         bn9Z9wTSannb8/4HBvi90SBCsRv+xPAMkcQLRfPKaTwTTUNQN/fzwl5uTu13+N5OrSMO
         +FxC2FpzKlRFfMM86eZFK0GGt4Jg6BCndWhiQnuIqPNmOcl5mb7TCSYzcAYgfPCqtQK9
         /tvqwDFAP3db5lgvj4N+H7aydATHMPRksFFpIyGGPIg08L++IQahdY6+DBxtCOaILK1a
         k7/5Q350hu5K50W/HQP+YWO58i7Sx5QmHW4B8AVJS+n5ZTm51nIKnLRGHVnLz2sm7InH
         y/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lxEL0baKnaUC4heL8P9cK7+gr22A53cupAL5EeQIoik=;
        b=z5IW6i7K4GjlLzLcaWfymDuru6OOIVDUrNTbn23XB2Owi9EUsrAaqSK7FmdYzjPTLn
         VzzIh6vmn35al5QUCKF74iriAoxdCfXe5lMDuOfRSwVjNyjBRiB0Z5cIQuAgjPcpfyEH
         CuDW7+774Zt4uwycPo/YX0yZHaEG/ZWWLeTcdMxGgbgjl8lhKgfPOXBeaDPNi3VKxp7h
         PNR4jp8zyGtfEFQCILyQBxFUbWHHDKpHyVvifBalnw3uHN494IyRDrB1aCGPTPA/mgR9
         bW+iZDYVZY5HoWrY05CqCVyOKR0GmQJHulcj2tpRhgLQkE9Emm7vVgmhx3sl4nyBdQnG
         CG8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=o7HQVTst;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=o7HQVTst;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andre Tomt <andre@tomt.net>,
	Dave Watson <davejwatson@fb.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 17/55] net/tls: Dont recursively call push_record during tls_write_space callbacks
Date: Fri, 18 May 2018 10:15:13 +0200
Message-Id: <20180518081458.311598151@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789176003617426?=
X-GMAIL-MSGID: =?utf-8?q?1600789176003617426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -102,6 +102,7 @@ struct tls_context {
 	struct scatterlist *partially_sent_record;
 	u16 partially_sent_offset;
 	unsigned long flags;
+	bool in_tcp_sendpages;
 
 	u16 pending_open_record_frags;
 	int (*push_pending_record)(struct sock *sk, int flags);
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -107,6 +107,7 @@ int tls_push_sg(struct sock *sk,
 	size = sg->length - offset;
 	offset += sg->offset;
 
+	ctx->in_tcp_sendpages = true;
 	while (1) {
 		if (sg_is_last(sg))
 			sendpage_flags = flags;
@@ -141,6 +142,8 @@ retry:
 	}
 
 	clear_bit(TLS_PENDING_CLOSED_RECORD, &ctx->flags);
+	ctx->in_tcp_sendpages = false;
+	ctx->sk_write_space(sk);
 
 	return 0;
 }
@@ -210,6 +213,10 @@ static void tls_write_space(struct sock
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
 
+	/* We are already sending pages, ignore notification */
+	if (ctx->in_tcp_sendpages)
+		return;
+
 	if (!sk->sk_write_pending && tls_is_pending_closed_record(ctx)) {
 		gfp_t sk_allocation = sk->sk_allocation;
 		int rc;
