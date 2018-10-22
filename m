Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F24ECDE47
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8C920853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI/58QSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8C920853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbeJVSjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbeJVSjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:39:42 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9742087D;
        Mon, 22 Oct 2018 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203707;
        bh=zpkhgtrraYpvW6xJa3yobM4YrndWYVBvp7uwbxy8cKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MI/58QSmQtaUE00y2ETAxYvaoYtU+Rsr/+476A46GGyG3ZuR2ebIXGzFCKJh7fEey
         yPwfJ37O7fkMru8XBgAXEHpcV0FO9J7TvgHzbVJO0ax1bcHFL53agy9tS91txe9qvC
         zI6VDdDjye4jP5CvgrcoBd9LhKHM/JpxoEFMvB0g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 6/9] rxrpc: Only take the rwind and mtu values from latest ACK
Date:   Mon, 22 Oct 2018 06:21:30 -0400
Message-Id: <20181022102133.41222-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022102133.41222-1-sashal@kernel.org>
References: <20181022102133.41222-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

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

