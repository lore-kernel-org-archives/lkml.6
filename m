Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C456C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315362170B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315362170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeHZK3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:29:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeHZK3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:29:34 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF87D9D2;
        Sun, 26 Aug 2018 06:47:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, AMG Zollner Robert <robert@cloudmedia.eu>,
        David Ahern <dsa@cumulusnetworks.com>,
        Casey Leedom <leedom@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 28/56] cxgb4: when disabling dcb set txq dcb priority to 0
Date:   Sun, 26 Aug 2018 08:44:49 +0200
Message-Id: <20180826064233.743800109@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180826064232.320669119@linuxfoundation.org>
References: <20180826064232.320669119@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ganesh Goudar <ganeshgr@chelsio.com>

[ Upstream commit 5ce36338a30f9814fc4824f9fe6c20cd83d872c7 ]

When we are disabling DCB, store "0" in txq->dcb_prio
since that's used for future TX Work Request "OVLAN_IDX"
values. Setting non zero priority upon disabling DCB
would halt the traffic.

Reported-by: AMG Zollner Robert <robert@cloudmedia.eu>
CC: David Ahern <dsa@cumulusnetworks.com>
Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -529,7 +529,7 @@ static void dcb_tx_queue_prio_enable(str
 				"Can't %s DCB Priority on port %d, TX Queue %d: err=%d\n",
 				enable ? "set" : "unset", pi->port_id, i, -err);
 		else
-			txq->dcb_prio = value;
+			txq->dcb_prio = enable ? value : 0;
 	}
 }
 #endif /* CONFIG_CHELSIO_T4_DCB */


