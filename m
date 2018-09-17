Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8ABECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26210214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26210214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbeIRElM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:41:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbeIRElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:41:10 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 607C2707;
        Mon, 17 Sep 2018 23:11:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 093/158] ath9k_hw: fix channel maximum power level test
Date:   Tue, 18 Sep 2018 00:42:03 +0200
Message-Id: <20180917211715.541420036@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 461d8a6bb9879b0e619752d040292e67aa06f1d2 ]

The tx power applied by set_txpower is limited by the CTL (conformance
test limit) entries in the EEPROM. These can change based on the user
configured regulatory domain.
Depending on the EEPROM data this can cause the tx power to become too
limited, if the original regdomain CTLs impose lower limits than the CTLs
of the user configured regdomain.

To fix this issue, set the initial channel limits without any CTL
restrictions and only apply the CTL at run time when setting the channel
and the real tx power.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath9k/hw.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2942,16 +2942,19 @@ void ath9k_hw_apply_txpower(struct ath_h
 	struct ath_regulatory *reg = ath9k_hw_regulatory(ah);
 	struct ieee80211_channel *channel;
 	int chan_pwr, new_pwr;
+	u16 ctl = NO_CTL;
 
 	if (!chan)
 		return;
 
+	if (!test)
+		ctl = ath9k_regd_get_ctl(reg, chan);
+
 	channel = chan->chan;
 	chan_pwr = min_t(int, channel->max_power * 2, MAX_RATE_POWER);
 	new_pwr = min_t(int, chan_pwr, reg->power_limit);
 
-	ah->eep_ops->set_txpower(ah, chan,
-				 ath9k_regd_get_ctl(reg, chan),
+	ah->eep_ops->set_txpower(ah, chan, ctl,
 				 get_antenna_gain(ah, chan), new_pwr, test);
 }
 


