Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ACFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EB12183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864858;
	bh=wkB7OD6CoWHvpd12N6P7BRzMxMCNO8XN1rHieluLRcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rzeF6fShpJJy5yAGylXfCbqgph2CnhXdm2303ssmuVwpyK1WcOP+2rXAlOcr36anq
	 Z/2w4wqu+x+fPJTH2pCW4La6Pn+Mk8WeVDm7oxl2cwAYeoQfTAg4m2LRfHLkF2qp/x
	 4oM9HYbyudcfTMqO19w9RY1krBVSxdTXPmcr9dy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfAGMk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfAGMkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:40:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE092183E;
        Mon,  7 Jan 2019 12:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864852;
        bh=wkB7OD6CoWHvpd12N6P7BRzMxMCNO8XN1rHieluLRcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1dt2hS0wNiE68gNm2rHjttYNVRqMLyLCo4UKFCd71gf5GOjsoUlyqlp/iu2FVQzXs
         Q2wOUVBZkxtbQ2PeGHUm+2x5l9XQCIzJ0/4M49/zZ7PQpg2pqEZ0PE2FlngIqSj/cP
         LxTehhpWi71iADouQ75kvipkF6irvsCrurwF7EHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.20 084/145] clk: sunxi-ng: Use u64 for calculation of NM rate
Date:   Mon,  7 Jan 2019 13:32:01 +0100
Message-Id: <20190107104448.247005486@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Jernej Skrabec <jernej.skrabec@siol.net>

commit 65b6657672388b72822e0367f06d41c1e3ffb5bb upstream.

Allwinner H6 SoC has multiplier N range between 1 and 254. Since parent
rate is 24MHz, intermediate result when calculating final rate easily
overflows 32 bit variable.

Because of that, introduce function for calculating clock rate which
uses 64 bit variable for intermediate result.

Fixes: 6174a1e24b0d ("clk: sunxi-ng: Add N-M-factor clock support")
Fixes: ee28648cb2b4 ("clk: sunxi-ng: Remove the use of rational computations")

CC: <stable@vger.kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/sunxi-ng/ccu_nm.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -19,6 +19,17 @@ struct _ccu_nm {
 	unsigned long	m, min_m, max_m;
 };
 
+static unsigned long ccu_nm_calc_rate(unsigned long parent,
+				      unsigned long n, unsigned long m)
+{
+	u64 rate = parent;
+
+	rate *= n;
+	do_div(rate, m);
+
+	return rate;
+}
+
 static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
 			     struct _ccu_nm *nm)
 {
@@ -28,7 +39,8 @@ static void ccu_nm_find_best(unsigned lo
 
 	for (_n = nm->min_n; _n <= nm->max_n; _n++) {
 		for (_m = nm->min_m; _m <= nm->max_m; _m++) {
-			unsigned long tmp_rate = parent * _n  / _m;
+			unsigned long tmp_rate = ccu_nm_calc_rate(parent,
+								  _n, _m);
 
 			if (tmp_rate > rate)
 				continue;
@@ -100,7 +112,7 @@ static unsigned long ccu_nm_recalc_rate(
 	if (ccu_sdm_helper_is_enabled(&nm->common, &nm->sdm))
 		rate = ccu_sdm_helper_read_rate(&nm->common, &nm->sdm, m, n);
 	else
-		rate = parent_rate * n / m;
+		rate = ccu_nm_calc_rate(parent_rate, n, m);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;
@@ -149,7 +161,7 @@ static long ccu_nm_round_rate(struct clk
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
 	ccu_nm_find_best(*parent_rate, rate, &_nm);
-	rate = *parent_rate * _nm.n / _nm.m;
+	rate = ccu_nm_calc_rate(*parent_rate, _nm.n, _nm.m);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;


