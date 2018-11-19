Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1009AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF10720870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZRhcD8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF10720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbeKTC5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731102AbeKTC5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC5C2086A;
        Mon, 19 Nov 2018 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645216;
        bh=4LX1nvowkUY9qgHbcJ8g9bUQmbIaDP0IbtM8k81Cirw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZRhcD8Qkxn45DgBn6btSlby4/CnA5UxTGRpsCAlDVsUStUVzpeS0UUx29d3DqC/M
         F0ArGmaK+4vX68L5LUiKVzRVkJmPrLl/DZnGijy/ctLZeIiF/BrFbw11vi4yGud3i6
         Ac6bv9r5eYgFBFsyazRofDfTcWQ34bK2iaOFcLfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronald Wahl <rwahl@gmx.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.19 081/205] clk: at91: Fix division by zero in PLL recalc_rate()
Date:   Mon, 19 Nov 2018 17:26:28 +0100
Message-Id: <20181119162630.918818995@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Wahl <rwahl@gmx.de>

commit 0f5cb0e6225cae2f029944cb8c74617aab6ddd49 upstream.

Commit a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached MUL
and DIV values") removed a check that prevents a division by zero. This
now causes a stacktrace when booting the kernel on a at91 platform if
the PLL DIV register contains zero. This commit reintroduces this check.

Fixes: a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ronald Wahl <rwahl@gmx.de>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/at91/clk-pll.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -133,6 +133,9 @@ static unsigned long clk_pll_recalc_rate
 {
 	struct clk_pll *pll = to_clk_pll(hw);
 
+	if (!pll->div || !pll->mul)
+		return 0;
+
 	return (parent_rate / pll->div) * (pll->mul + 1);
 }
 


