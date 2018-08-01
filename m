Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADEDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E2020862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E2020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407768AbeHATY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:24:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436559AbeHATSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AF45AF13;
        Wed,  1 Aug 2018 16:55:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 056/336] clk-si544: Properly round requested frequency to nearest match
Date:   Wed,  1 Aug 2018 18:46:31 +0200
Message-Id: <20180801165031.218891845@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Looijmans <mike.looijmans@topic.nl>

[ Upstream commit 4d3f36c5e9ca0f947eed71660239c529c501141a ]

The si544 driver had a rounding problem that using the result of clk_round_rate
may set the clock to yet another rate, for example:
clk_round_rate(195000000) = 194999999
clk_round_rate(194999999) = 194999998

Clients would expect that after clk_set_rate(clk, freq2=clk_round_rate(clk, freq)) the
chip will be running at exactly freq2.

The problem was in the calculation of the feedback divider, it was always rounded
down instead of to the nearest possible VCO value.

After this change, the following holds true for any supported frequency:
actual_freq = clk_round_rate(clk, freq);
clk_set_rate(clk, actual_freq);
clk_round_rate(clk, actual_freq) == actual_freq && clk_get_rate(clk) == actual_freq

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Fixes: 953cc3e81170 ("clk: Add driver for the si544 clock generator chip")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-si544.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/clk-si544.c
+++ b/drivers/clk/clk-si544.c
@@ -207,6 +207,7 @@ static int si544_calc_muldiv(struct clk_
 
 	/* And the fractional bits using the remainder */
 	vco = (u64)tmp << 32;
+	vco += FXO / 2; /* Round to nearest multiple */
 	do_div(vco, FXO);
 	settings->fb_div_frac = vco;
 


