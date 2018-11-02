Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A04C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10922082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xmW7pF2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10922082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbeKCEBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731093AbeKCEBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:45 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C402082D;
        Fri,  2 Nov 2018 18:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184809;
        bh=1pFXRKGR051W5PN7SV70BJt7sJbquhpg/W6nEWGh5HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xmW7pF2DkaIf+K/sQ2C2/S2IO8O0EEDVPjg2XGFB0T6uuEDIAJKjCF7xCpun2g1t0
         WcsUoqTWzGt1HG51hv76jC2QWQn2VHlAnLoxC9XO5cR8h5V/+6xuuhUpT5QoaLu/hP
         17dZ0h3ONNRdbPuxvocjZn6KYdLF4rHszu29+Rl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 100/143] rxrpc: Only take the rwind and mtu values from latest ACK
Date:   Fri,  2 Nov 2018 19:34:45 +0100
Message-Id: <20181102182905.840839952@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 3a501bf0fc1a..ea506a77f3c8 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -806,6 +806,16 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
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
@@ -827,15 +837,6 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
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



