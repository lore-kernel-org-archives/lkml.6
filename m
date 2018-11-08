Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75F9C0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD1920818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK9fL9kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD1920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbeKIH4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:56:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730842AbeKIHn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:59 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2174F208A3;
        Thu,  8 Nov 2018 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714789;
        bh=cqBgP0TgN7JeNkg+bJy543kWk4WewN1x/T5u3ykPSvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KK9fL9kPpYeerkMCbDPQTb3e3KaVEz1o/zg1v/8L+YH9D3c2Ml9KQEsYdB0XyhJUt
         UftiLpXI8JRl/UBMZYp7cVrDalR/T2JSwCEAw1KVrAo251GOEJIDGvUTz14TzZsr7I
         Zgf3/UMSgEOmnxEYwQITiG2xJ18gAhue3MY8Y9Kw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 128/171] rxrpc: Only take the rwind and mtu values from latest ACK
Date:   Thu,  8 Nov 2018 13:51:38 -0800
Message-Id: <20181108215136.519695957@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 298bc15b2079c324e82d0a6fda39c3d762af7282 ]

Move the out-of-order and duplicate ACK packet check to before the call to
rxrpc_input_ackinfo() so that the receive window size and MTU size are only
checked in the latest ACK packet and don't regress.

Fixes: 248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/input.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 7bfde4737cb3..a4380e182e6c 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -808,6 +808,16 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 				  rxrpc_propose_ack_respond_to_ack);
 	}
 
+	/* Discard any out-of-order or duplicate ACKs. */
+	if (before_eq(sp->hdr.serial, call->acks_latest)) {
+		_debug("discard ACK %d <= %d",
+		       sp->hdr.serial, call->acks_latest);
+		return;
+	}
+	call->acks_latest_ts = skb->tstamp;
+	call->acks_latest = sp->hdr.serial;
+
+	/* Parse rwind and mtu sizes if provided. */
 	ioffset = offset + nr_acks + 3;
 	if (skb->len >= ioffset + sizeof(buf.info)) {
 		if (skb_copy_bits(skb, ioffset, &buf.info, sizeof(buf.info)) < 0)
@@ -829,15 +839,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 		return;
 	}
 
-	/* Discard any out-of-order or duplicate ACKs. */
-	if (before_eq(sp->hdr.serial, call->acks_latest)) {
-		_debug("discard ACK %d <= %d",
-		       sp->hdr.serial, call->acks_latest);
-		return;
-	}
-	call->acks_latest_ts = skb->tstamp;
-	call->acks_latest = sp->hdr.serial;
-
 	if (before(hard_ack, call->tx_hard_ack) ||
 	    after(hard_ack, call->tx_top))
 		return rxrpc_proto_abort("AKW", call, 0);
-- 
2.17.1



