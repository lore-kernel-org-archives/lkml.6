Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD25AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949632147D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFCiysMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949632147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbeKZV41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbeKZV4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 071422089F;
        Mon, 26 Nov 2018 11:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230160;
        bh=xrgzj9pWgvvuolV+HxMmbnbJZYYNGBxm2NxgEf3mGug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFCiysMjXKwNQ5xekcGVSPgHPk3mJsRg5jkNX6jAKw8h58wXJgX3s+2aTeJTIfWjG
         LYwwrg0N5yRLW79epRbnKujGyC2vrBtXrZxKCwF0ASjqMmYFnoMLA3+2KaugLD7NrI
         QTJBfas1hpGY7GqpvjDNXhT2ro22VKXO8IqnGyKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/118] clk: renesas: r9a06g032: Fix UART34567 clock rate
Date:   Mon, 26 Nov 2018 11:50:24 +0100
Message-Id: <20181126105101.032597707@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
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

[ Upstream commit ee02950d53eee0d4c7f1c08a35272b77d24b9459 ]

The clock for UARTs 0 through 2 is UART012, the clock for UARTs 3 through
7 is UART34567.
For UART012, we stop the clock driver from changing the clock rate. This
is because the Synopsys UART driver simply sets the reference clock to 16x
the baud rate, but doesn't check if the actual rate is within the required
tolerance. The RZ/N1 clock divider can't provide this (we have to rely on
the UART's internal divider to set the correct clock rate), so you end up
with a clock rate that is way off what you wanted.

In addition, since the clock is shared between multiple UARTs, you don't
want the driver trying to change the clock rate as it may affect the other
UARTs (which may not have been configured yet, so you don't know what baud
rate they will use). Normally, the clock rate is set early on before Linux
to some very high rate that supports all of the clock rates you want.

This change stops the UART34567 clock rate from changing for the same
reasons.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Fixes: 4c3d88526eba2143 ("clk: renesas: Renesas R9A06G032 clock driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index a0b6ecdc63dd..6d2b56891559 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -539,7 +539,8 @@ r9a06g032_div_round_rate(struct clk_hw *hw,
 	 * several uarts attached to this divider, and changing this impacts
 	 * everyone.
 	 */
-	if (clk->index == R9A06G032_DIV_UART) {
+	if (clk->index == R9A06G032_DIV_UART ||
+	    clk->index == R9A06G032_DIV_P2_PG) {
 		pr_devel("%s div uart hack!\n", __func__);
 		return clk_get_rate(hw->clk);
 	}
-- 
2.17.1



