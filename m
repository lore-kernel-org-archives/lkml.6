Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9921470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v+QgfIw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB9921470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeJKXKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 284A121470;
        Thu, 11 Oct 2018 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272538;
        bh=sbHlvyiHWC0evWFYOY7IeQJPOUboAA0brsrp7ilZK4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+QgfIw38kQ6yXwLo0fkyXhb6C7p4pQowv0+N8dOvfbXVWoMFHqKG/DFJncVd4RfN
         bJX/RY9gVxiGv/afSLY8WA9U22fPoC4qv1plc6qtTZfL5Dx+7pXOeREvd/TUiNiURf
         4SmiCC+UCkixXcFTw+WrpOSQjbagq9d+NpTH6GHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 24/27] tcp: call tcp_drop() from tcp_data_queue_ofo()
Date:   Thu, 11 Oct 2018 17:35:11 +0200
Message-Id: <20181011152535.191057189@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
References: <20181011152534.014964888@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8541b21e781a22dce52a74fef0b9bed00404a1cd ]

In order to be able to give better diagnostics and detect
malicious traffic, we need to have better sk->sk_drops tracking.

Fixes: 9f5afeae5152 ("tcp: use an RB tree for ooo receive queue")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4445,7 +4445,7 @@ coalesce_done:
 				/* All the bits are present. Drop. */
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPOFOMERGE);
-				__kfree_skb(skb);
+				tcp_drop(sk, skb);
 				skb = NULL;
 				tcp_dsack_set(sk, seq, end_seq);
 				goto add_sack;
@@ -4464,7 +4464,7 @@ coalesce_done:
 						 TCP_SKB_CB(skb1)->end_seq);
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPOFOMERGE);
-				__kfree_skb(skb1);
+				tcp_drop(sk, skb1);
 				goto merge_right;
 			}
 		} else if (tcp_try_coalesce(sk, skb1, skb, &fragstolen)) {


