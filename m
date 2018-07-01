Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38028C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FD524F37
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FD524F37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeGAQy0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:54:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932924AbeGAQpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:45:23 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E8EDA73;
        Sun,  1 Jul 2018 16:45:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 4.17 147/220] clk: meson: meson8b: mark fclk_div2 gate clocks as CLK_IS_CRITICAL
Date:   Sun,  1 Jul 2018 18:22:51 +0200
Message-Id: <20180701160914.456473521@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit 72e1f2302040398dafb64bbb93abdde78c1f2267 upstream.

Until commit 05f814402d6174 ("clk: meson: add fdiv clock gates") we
relied on the bootloader to enable the fclk_div clock gates. It turns
out that our clock tree is incomplete at least on Meson8b (tested with
an Odroid-C1, which uses an RGMII PHY) because after the mentioned
commit Ethernet is not working anymore (no RX/TX activity can be seen).
At the same time Ethernet was still working on Meson8m2 with a RMII PHY.

Testing has shown that as soon as "fclk_div2" is disabled Ethernet stops
working on Odroid-C1. Unfortunately it's currently not clear what the
Ethernet controller IP block uses the fclk_div2 clock for. Mark the
clock as CLK_IS_CRITICAL to keep it enabled (as it's already enabled by
most bootloaders by default, which is why we didn't notice it before).

Fixes: 05f814402d6174 ("clk: meson: add fdiv clock gates")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/meson/meson8b.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -246,6 +246,13 @@ static struct clk_regmap meson8b_fclk_di
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "fclk_div2_div" },
 		.num_parents = 1,
+		/*
+		 * FIXME: Ethernet with a RGMII PHYs is not working if
+		 * fclk_div2 is disabled. it is currently unclear why this
+		 * is. keep it enabled until the Ethernet driver knows how
+		 * to manage this clock.
+		 */
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 


