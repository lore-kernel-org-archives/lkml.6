Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D27BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6C3214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF5e+11b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6C3214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbeKVFnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbeKVFnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D5B214DB;
        Wed, 21 Nov 2018 19:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827265;
        bh=fWpQ211I+5IlXBzPIeQCZPOv5HqDDuL94gySSsfAZ3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MF5e+11byRYH+H5+Tr29z4pZSzu6/OHu5NPDtOZKq6GQviSBLhZ+q5OVoyIvQIV1m
         Sq49DgSf1J6UijT+tL6wF7g/VJteW4rPpdAgAzhT+tvn3cjD22e/5Y0XDn0xT588iX
         VufPZpoles0hlZhlumdnWekR+3SVxaLWwU3pe+rw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stephen Mallon <stephen.mallon@sydney.edu.au>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 09/42] tcp: Fix SOF_TIMESTAMPING_RX_HARDWARE to use the latest timestamp during TCP coalescing
Date:   Wed, 21 Nov 2018 20:05:45 +0100
Message-Id: <20181121183148.369751058@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
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

From: Stephen Mallon <stephen.mallon@sydney.edu.au>

[ Upstream commit cadf9df27e7cf40e390e060a1c71bb86ecde798b ]

During tcp coalescing ensure that the skb hardware timestamp refers to the
highest sequence number data.
Previously only the software timestamp was updated during coalescing.

Signed-off-by: Stephen Mallon <stephen.mallon@sydney.edu.au>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4371,6 +4371,7 @@ static bool tcp_try_coalesce(struct sock
 	if (TCP_SKB_CB(from)->has_rxtstamp) {
 		TCP_SKB_CB(to)->has_rxtstamp = true;
 		to->tstamp = from->tstamp;
+		skb_hwtstamps(to)->hwtstamp = skb_hwtstamps(from)->hwtstamp;
 	}
 
 	return true;


