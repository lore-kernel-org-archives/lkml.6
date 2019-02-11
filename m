Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAAFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E8220700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901573;
	bh=kPq9RmFpsouLies7BiScocOt/BTu0f9ohICoxVIMuTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MK1muTguhTpmn+jGqFAW/l3iMRhwuyS76FbX/5+5E2IVAoNsfiemsKAA3qAeubU+Z
	 VYAbAEpIgnBFEJCBP5fTh/vBf/ImkEl3DSrZMS3JSrdStSdr6dg5lVQsT7URyH8Y9d
	 VrLlJi1uAxQTdrdkWjTkbNstdurk5WUHXpXJ6vBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfBKOWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbfBKOWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F50220838;
        Mon, 11 Feb 2019 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894962;
        bh=kPq9RmFpsouLies7BiScocOt/BTu0f9ohICoxVIMuTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1FM2+am8Xji4L5t+uP2BZQMrx6iibDmxTheMAUimlHyNJHDE9tcp2NXrVC4w1cK7/
         wsh0Cz8CZxzXDhZlRjB3XmV56dWMSKzVBUHF7K0NF+ar8QVFslwuBl8stuxrXkoz+t
         034aELnKgVpZvGI2CJsWNq0UNm+U6A/ArJ6bxtPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lior David <liord@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 016/352] wil6210: fix memory leak in wil_find_tx_bcast_2
Date:   Mon, 11 Feb 2019 15:14:03 +0100
Message-Id: <20190211141847.412358794@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 664497400c89a4d40aee51bcf48bbd2e4dc71104 ]

A successful call to wil_tx_ring takes skb reference so
it will only be freed in wil_tx_complete. Consume the skb
in wil_find_tx_bcast_2 to prevent memory leak.

Signed-off-by: Lior David <liord@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index cc5f263cc965..005c4ba9e823 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -1403,6 +1403,8 @@ found:
 			wil_dbg_txrx(wil, "BCAST DUP -> ring %d\n", i);
 			wil_set_da_for_vring(wil, skb2, i);
 			wil_tx_ring(wil, vif, v2, skb2);
+			/* successful call to wil_tx_ring takes skb2 ref */
+			dev_kfree_skb_any(skb2);
 		} else {
 			wil_err(wil, "skb_copy failed\n");
 		}
-- 
2.19.1



