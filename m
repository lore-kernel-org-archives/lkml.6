Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E8FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262802063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217106;
	bh=hQhJHOvAN59+XacpcSVUkQc0UJOjiFkpeH6A1X1qIaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DoTLj6yA1rwx6k+v6vBwYQA3OPjkc4TmI0ayzfiEM4vJXg6pPQtw9kNBLQKJrGPP4
	 oJB256gWbish2m40D6PjwDPAM+g3qzHmASmEtj4LnSkyAdmICn0eqqXdf+6teo7Mue
	 V15O5S6ZMM0SZMOvRbYwCLRe48KOg+5FvR0MBhGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbfAKObp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732419AbfAKObm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355C72063F;
        Fri, 11 Jan 2019 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217101;
        bh=hQhJHOvAN59+XacpcSVUkQc0UJOjiFkpeH6A1X1qIaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSxpn3aEfAswVAekuDvf6OdhqeBSxLqJML1+uHiUVmPPvyx64OXNYdcJUYaW8jfMf
         jJ2LT2MbF4J3/uQ2erB78YST2jmIA3xRKIM4Pj0y9TIQzz8+PG+nAoqK7RHyR9V7Be
         VPRmOO4vo2WtTbChHdS624YK6DSZAnuwze2UXyY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 042/105] qed: Fix an error code qed_ll2_start_xmit()
Date:   Fri, 11 Jan 2019 15:14:13 +0100
Message-Id: <20190111131106.657435621@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f07d4276892d97671e880190ff195a288b2d8d92 ]

We accidentally deleted the code to set "rc = -ENOMEM;" and this patch
adds it back.

Fixes: d2201a21598a ("qed: No need for LL2 frags indication")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index 5f52f14761a3..b73bcbeb5f27 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -2351,6 +2351,7 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb)
 		if (unlikely(dma_mapping_error(&cdev->pdev->dev, mapping))) {
 			DP_NOTICE(cdev,
 				  "Unable to map frag - dropping packet\n");
+			rc = -ENOMEM;
 			goto err;
 		}
 
-- 
2.19.1



