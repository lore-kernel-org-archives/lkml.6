Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4DEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419D62054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq1+rO5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419D62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeKAIF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeKAIFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:05:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D425020823;
        Wed, 31 Oct 2018 23:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027145;
        bh=nPzAxlsCI9yFomFr6wYxP465lWD3iXRwQOLKzvJV+iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tq1+rO5otNiz2m15K+jJ5a1JHo1ZWG6YR6w8Q1VXGLyvfzzwRZli0SdO5nlTHOnNc
         LjaCbTcb4GgU6393SljIWjY91jIqIeJ2WQQH4/StYai7vpQ7C498g19KENJd4fuLHz
         MAZnVY7rJDSyDw2dfL7m4cKqeiyJsDJfinN3noag=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 003/146] net: loopback: clear skb->tstamp before netif_rx()
Date:   Wed, 31 Oct 2018 19:03:18 -0400
Message-Id: <20181031230541.28822-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/loopback.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 30612497643c..d192936b76cf 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -75,6 +75,10 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 	int len;
 
 	skb_tx_timestamp(skb);
+
+	/* do not fool net_timestamp_check() with various clock bases */
+	skb->tstamp = 0;
+
 	skb_orphan(skb);
 
 	/* Before queueing this packet to netif_rx(),
-- 
2.17.1

