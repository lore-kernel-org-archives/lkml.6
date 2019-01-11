Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129EFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA76204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217440;
	bh=0eJNwSgbT75oF7r8W4mOfegbw5ToLidJe62EJhnlNhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=miHGDnyqrzAe7bZqSptZ522GViSgsnOsYhHmqJVBdeH0bdNGqL4Dq/Ya2/Q2liBun
	 MBFuEIbb9KPsV8jQlx4nMp2ONBDLuu/wRoMuiI358yGzMyi9m3+X38EQOlttYsCJsX
	 BabdSgYQa/6XiVrc0qMMn3omN7qmYGXfXsJVfi+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390608AbfAKOhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390590AbfAKOhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB142063F;
        Fri, 11 Jan 2019 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217435;
        bh=0eJNwSgbT75oF7r8W4mOfegbw5ToLidJe62EJhnlNhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9DJKZPpHr8uteRiEsppU1CzrRy7AEADHQ/hxfpzPk++BaRKYqV6uilG9zAuM/yYj
         fr+ualp9cMITQgLyFgY1mdkcpg/LYuLxhKaTbQykJw37S46OgB+mul1aoKyTD3oZCT
         X1P/bx3VjWGa+9ofmpJa8lHl7XEx7vMT7/2bZDH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/148] qed: Fix an error code qed_ll2_start_xmit()
Date:   Fri, 11 Jan 2019 15:13:56 +0100
Message-Id: <20190111131116.586399482@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 14ac9cab2653..2fa1c050a14b 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -2485,6 +2485,7 @@ static int qed_ll2_start_xmit(struct qed_dev *cdev, struct sk_buff *skb,
 		if (unlikely(dma_mapping_error(&cdev->pdev->dev, mapping))) {
 			DP_NOTICE(cdev,
 				  "Unable to map frag - dropping packet\n");
+			rc = -ENOMEM;
 			goto err;
 		}
 
-- 
2.19.1



