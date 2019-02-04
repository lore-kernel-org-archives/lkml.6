Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AC4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530FD2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278523;
	bh=QymaL09NQ11iEPf9qszWFPCTVwyzMTdeT3h9Vzzf8Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0QbiAqFqXrC3aNMlR92GO6gqfZv3dNj4SeNcYZ3BcoP8lkB3XgCTSW5NxU9E0ngtK
	 wXmAcoH4RyuRSZWZBBZvSFWV2uj5oIsR0vviB6SL753Fm0T8ef5myKr9QwAb3fFVnf
	 oqtohuovxMYl9qFa/uEAIUZEmPWnFb+KVted1DxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfBDLIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbfBDKla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1312070C;
        Mon,  4 Feb 2019 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276889;
        bh=QymaL09NQ11iEPf9qszWFPCTVwyzMTdeT3h9Vzzf8Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zMFI1NqQCNziu9xe6Mo8Lm9e5YSCdDviiiPtPut6D4qoV/YrtEUXjhMh+vCW07K3g
         jbJ8BWl33TI/4KKSewQOhef9W8rb+mZHZ4wwnnJs6I48T6pztYxCxMuZu3G01EuUQv
         NcvhguZ7yH7BeQkos+oMimIFjhPaozr8ggZL7iME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Wen <jian.w.wen@oracle.com>,
        Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 41/65] l2tp: fix reading optional fields of L2TPv3
Date:   Mon,  4 Feb 2019 11:36:34 +0100
Message-Id: <20190204103617.655799780@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Wen <jian.w.wen@oracle.com>

[ Upstream commit 4522a70db7aa5e77526a4079628578599821b193 ]

Use pskb_may_pull() to make sure the optional fields are in skb linear
parts, so we can safely read them later.

It's easy to reproduce the issue with a net driver that supports paged
skb data. Just create a L2TPv3 over IP tunnel and then generates some
network traffic.
Once reproduced, rx err in /sys/kernel/debug/l2tp/tunnels will increase.

Changes in v4:
1. s/l2tp_v3_pull_opt/l2tp_v3_ensure_opt_in_linear/
2. s/tunnel->version != L2TP_HDR_VER_2/tunnel->version == L2TP_HDR_VER_3/
3. Add 'Fixes' in commit messages.

Changes in v3:
1. To keep consistency, move the code out of l2tp_recv_common.
2. Use "net" instead of "net-next", since this is a bug fix.

Changes in v2:
1. Only fix L2TPv3 to make code simple.
   To fix both L2TPv3 and L2TPv2, we'd better refactor l2tp_recv_common.
   It's complicated to do so.
2. Reloading pointers after pskb_may_pull

Fixes: f7faffa3ff8e ("l2tp: Add L2TPv3 protocol support")
Fixes: 0d76751fad77 ("l2tp: Add L2TPv3 IP encapsulation (no UDP) support")
Fixes: a32e0eec7042 ("l2tp: introduce L2TPv3 IP encapsulation support for IPv6")
Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
Acked-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c |    4 ++++
 net/l2tp/l2tp_core.h |   20 ++++++++++++++++++++
 net/l2tp/l2tp_ip.c   |    3 +++
 net/l2tp/l2tp_ip6.c  |    3 +++
 4 files changed, 30 insertions(+)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -930,6 +930,10 @@ static int l2tp_udp_recv_core(struct l2t
 		goto error;
 	}
 
+	if (tunnel->version == L2TP_HDR_VER_3 &&
+	    l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr))
+		goto error;
+
 	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length, payload_hook);
 
 	return 0;
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -324,6 +324,26 @@ static inline int l2tp_get_l2specific_le
 	}
 }
 
+static inline int l2tp_v3_ensure_opt_in_linear(struct l2tp_session *session, struct sk_buff *skb,
+					       unsigned char **ptr, unsigned char **optr)
+{
+	int opt_len = session->peer_cookie_len + l2tp_get_l2specific_len(session);
+
+	if (opt_len > 0) {
+		int off = *ptr - *optr;
+
+		if (!pskb_may_pull(skb, off + opt_len))
+			return -1;
+
+		if (skb->data != *optr) {
+			*optr = skb->data;
+			*ptr = skb->data + off;
+		}
+	}
+
+	return 0;
+}
+
 #define l2tp_printk(ptr, type, func, fmt, ...)				\
 do {									\
 	if (((ptr)->debug) & (type))					\
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -163,6 +163,9 @@ static int l2tp_ip_recv(struct sk_buff *
 		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, ptr, length);
 	}
 
+	if (l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr))
+		goto discard;
+
 	l2tp_recv_common(session, skb, ptr, optr, 0, skb->len, tunnel->recv_payload_hook);
 
 	return 0;
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -174,6 +174,9 @@ static int l2tp_ip6_recv(struct sk_buff
 		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, ptr, length);
 	}
 
+	if (l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr))
+		goto discard;
+
 	l2tp_recv_common(session, skb, ptr, optr, 0, skb->len,
 			 tunnel->recv_payload_hook);
 	return 0;


