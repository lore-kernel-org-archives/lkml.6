Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F870ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73E920652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73E920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbeGTN05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:26:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388886AbeGTN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:26:56 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 676DDC83;
        Fri, 20 Jul 2018 12:33:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 57/92] mtd: rawnand: denali_dt: set clk_x_rate to 200 MHz unconditionally
Date:   Fri, 20 Jul 2018 14:14:01 +0200
Message-Id: <20180720121421.200025124@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 3f6e6986045d47f87bd982910821b7ab9758487e upstream.

Since commit 1bb88666775e ("mtd: nand: denali: handle timing parameters
by setup_data_interface()"), denali_dt.c gets the clock rate from the
clock driver.  The driver expects the frequency of the bus interface
clock, whereas the clock driver of SOCFPGA provides the core clock.
Thus, the setup_data_interface() hook calculates timing parameters
based on a wrong frequency.

To make it work without relying on the clock driver, hard-code the clock
frequency, 200MHz.  This is fine for existing DT of UniPhier, and also
fixes the issue of SOCFPGA because both platforms use 200 MHz for the
bus interface clock.

Fixes: 1bb88666775e ("mtd: nand: denali: handle timing parameters by setup_data_interface()")
Cc: linux-stable <stable@vger.kernel.org> #4.14+
Reported-by: Philipp Rosenberger <p.rosenberger@linutronix.de>
Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/denali_dt.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/denali_dt.c
+++ b/drivers/mtd/nand/denali_dt.c
@@ -122,7 +122,11 @@ static int denali_dt_probe(struct platfo
 	if (ret)
 		return ret;
 
-	denali->clk_x_rate = clk_get_rate(dt->clk);
+	/*
+	 * Hardcode the clock rate for the backward compatibility.
+	 * This works for both SOCFPGA and UniPhier.
+	 */
+	denali->clk_x_rate = 200000000;
 
 	ret = denali_init(denali);
 	if (ret)


