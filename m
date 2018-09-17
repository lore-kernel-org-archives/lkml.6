Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194C3ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D002D2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D002D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeIREj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:39:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbeIREjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:39:25 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B46BE707;
        Mon, 17 Sep 2018 23:09:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 061/158] clk: scmi: Fix the rounding of clock rate
Date:   Tue, 18 Sep 2018 00:41:31 +0200
Message-Id: <20180917211714.059887195@linuxfoundation.org>
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

From: Amit Daniel Kachhap <amit.kachhap@arm.com>

[ Upstream commit 7a8655e19bdb3be43f6a3b4768c9b0928a2585fc ]

This fix rounds the clock rate properly by using quotient and not
remainder in the calculation. This issue was found while testing HDMI
in the Juno platform.

Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-scmi.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -38,7 +38,6 @@ static unsigned long scmi_clk_recalc_rat
 static long scmi_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *parent_rate)
 {
-	int step;
 	u64 fmin, fmax, ftmp;
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
@@ -60,9 +59,9 @@ static long scmi_clk_round_rate(struct c
 
 	ftmp = rate - fmin;
 	ftmp += clk->info->range.step_size - 1; /* to round up */
-	step = do_div(ftmp, clk->info->range.step_size);
+	do_div(ftmp, clk->info->range.step_size);
 
-	return step * clk->info->range.step_size + fmin;
+	return ftmp * clk->info->range.step_size + fmin;
 }
 
 static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,


