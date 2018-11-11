Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D62C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090BB2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="obhXpFUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090BB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbeKLKHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:07:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbeKLIRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:04 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7271214F1;
        Sun, 11 Nov 2018 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975228;
        bh=p7l974Tids2d34jb7NqHoOxbM0u3o4Ch6oIBVWrKQig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obhXpFULvFBtQtnhX1ZxdYEdkVxExCgzMWNsEbPCcQ89RQTl5AtQHoq/XcoiUs47V
         1eIAigMbthgOoaoJ+rjUcOkH0laCzAcchSRF5boSNenZnJa6ewPqeLwCjrPoufFLTb
         UZ/NxtNslXfbD5hO5fyYAMvczlfjzxcvQmokMyN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/361] net: loopback: clear skb->tstamp before netif_rx()
Date:   Sun, 11 Nov 2018 14:16:36 -0800
Message-Id: <20181111221626.882767669@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4c16128b6271e70c8743178e90cccee147858503 ]

At least UDP / TCP stacks can now cook skbs with a tstamp using
MONOTONIC base (or arbitrary values with SCM_TXTIME)

Since loopback driver does not call (directly or indirectly)
skb_scrub_packet(), we need to clear skb->tstamp so that
net_timestamp_check() can eventually resample the time,
using ktime_get_real().

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/loopback.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -75,6 +75,10 @@ static netdev_tx_t loopback_xmit(struct
 	int len;
 
 	skb_tx_timestamp(skb);
+
+	/* do not fool net_timestamp_check() with various clock bases */
+	skb->tstamp = 0;
+
 	skb_orphan(skb);
 
 	/* Before queueing this packet to netif_rx(),


