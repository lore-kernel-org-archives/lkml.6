Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD6C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5936320779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5936320779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeICVLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeICVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:29 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0B3ECEE;
        Mon,  3 Sep 2018 16:50:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 16/56] net: caif: Add a missing rcu_read_unlock() in caif_flow_cb
Date:   Mon,  3 Sep 2018 18:49:06 +0200
Message-Id: <20180903164924.915241287@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
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

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 64119e05f7b31e83e2555f6782e6cdc8f81c63f4 ]

Add a missing rcu_read_unlock in the error path

Fixes: c95567c80352 ("caif: added check for potential null return")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/caif/caif_dev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/caif/caif_dev.c
+++ b/net/caif/caif_dev.c
@@ -131,8 +131,10 @@ static void caif_flow_cb(struct sk_buff
 	caifd = caif_get(skb->dev);
 
 	WARN_ON(caifd == NULL);
-	if (caifd == NULL)
+	if (!caifd) {
+		rcu_read_unlock();
 		return;
+	}
 
 	caifd_hold(caifd);
 	rcu_read_unlock();


