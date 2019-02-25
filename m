Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4153AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A3E217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130533;
	bh=hUOn7S/OGdg2RRriQOWkt81G2gAoxdTSJ5z7NT7ME9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ivNfTCejQo62X3omoVL+Xr6RxQ2ufsyuKGr8d2aT+e2NMiTyuR0VimS8iAFCai2eu
	 UfcaNR1CPySTdtiMtVmAZV9FnU09CDG+IoiWOSZs96WfANAeBdNN/PFmhU4OBxef2w
	 t4DR8pbu/ntTZanmdQQxm7wlnyS58WZ0D9BU4cm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfBYVfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732977AbfBYVf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:35:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8776217F5;
        Mon, 25 Feb 2019 21:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130527;
        bh=hUOn7S/OGdg2RRriQOWkt81G2gAoxdTSJ5z7NT7ME9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=US/E7ijauLYKgZoG6zgaM2hm8+LOgnXQg77u70yywhQv9d0PwbcSvbFVHPZjOnxrV
         n4Oy2NEsWD/gNKGdvE+svhstJCs9mKGEKqkQLOgPc6TQVUeAsmzDVh9kTFXeAnYzPX
         IAAYJGtgGPizau7RDghwKRKkLXVXeRqZ+iBr20qQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.20 150/183] clk: at91: fix at91sam9x5 peripheral clock number
Date:   Mon, 25 Feb 2019 22:12:03 +0100
Message-Id: <20190225195120.284923383@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 1b328a2e095a009518ebac05e937cc0fc242fede upstream.

nck() looks at the last id in an array and unfortunately,
at91sam9x35_periphck has a sentinel, hence the id is 0 and the calculated
number of peripheral clocks is 1 instead of a maximum of 31.

Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: <stable@vger.kernel.org> # v4.20+
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/at91/at91sam9x5.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/clk/at91/at91sam9x5.c
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -144,8 +144,7 @@ static void __init at91sam9x5_pmc_setup(
 		return;
 
 	at91sam9x5_pmc = pmc_data_allocate(PMC_MAIN + 1,
-					   nck(at91sam9x5_systemck),
-					   nck(at91sam9x35_periphck), 0);
+					   nck(at91sam9x5_systemck), 31, 0);
 	if (!at91sam9x5_pmc)
 		return;
 


