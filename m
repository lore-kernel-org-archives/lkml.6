Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FC3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FEC222A8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895919;
	bh=GqyHSsxvWGWFrJGZCz1EHIzLuU/dB69TGY0U0BGPW14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pu5N21j/r0dquLUkMVw5mzD0UadOioSUdBwx7fFApwYH4Ozm5IvY9swS9AjP06q0J
	 CFufy9RnPPAB6yuUvr0X/9rGluDj5Pa74jy6RU5avB/y7RoIogoaWdPjd0mxyl2sGF
	 5EUjeReScsF+Vje067JmFltijMBcIHu+56u5YTNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfBKOii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:38:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731705AbfBKOig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C227222A2;
        Mon, 11 Feb 2019 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895916;
        bh=GqyHSsxvWGWFrJGZCz1EHIzLuU/dB69TGY0U0BGPW14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AkFbUT58OBYtcKr7/OLgtBsTzc9PNm/a/6SgNC3Z5GWNgbEVN2QI2+4haR2LesQy2
         szjhbxVaq7jjCsKU4PBWB5zz23/sUw0h6nKAw1nakHDSRXj9cukbNetzC44XqV73hR
         eRJZ10jt+nz/qSa4atMLZfLndGL5OUHcLRjzPYW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lior David <liord@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/313] wil6210: fix memory leak in wil_find_tx_bcast_2
Date:   Mon, 11 Feb 2019 15:14:53 +0100
Message-Id: <20190211141854.055059176@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
index 6a7943e487fb..75c8aa297107 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -1313,6 +1313,8 @@ found:
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



