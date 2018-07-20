Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1656DECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69F820673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gqMMoC3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69F820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbeGTJZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:25:55 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:18157 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbeGTJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:25:54 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w6K8bg69025961;
        Fri, 20 Jul 2018 17:37:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w6K8bg69025961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532075863;
        bh=kZelxrNbnkFsoSoacE5LeX3IuKxIkJo7Gpnk/hgVBCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqMMoC3D+NHJ+1XZU4ln9XWX6GoR8AGDjlsh84VH2NNDOdpnxLyk9BU8Sfgp+tzmD
         Gd+SjXNccsKgYWhbmRBcnRLt1I6WWz92K2wlYnJpW0gYsaKkA9nxxrt7UBPf/qbykB
         cSY3i1lzsKfjKhdEHuDkM8aT4P/dhgNTZAyTu8OUQTSR4cplvd2O1nhttI8lI1x/6k
         8Ev61DM1G1jWQsFGnOsGPLtCZ9pkd2KlOtLkqSZMnNXZ5MzryJSv6Y/AmI5jeapPvC
         NWKKkx63rf6bz2WJE6KAkrmEGjTJzDvYVFcBrBk5Yt3IZwnGD34G8d6QneHFxmgv+e
         Oik8kQUrw0/lQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-clk@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] clk: uniphier: add more USB3 PHY clocks
Date:   Fri, 20 Jul 2018 17:37:36 +0900
Message-Id: <1532075856-1723-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB3 PHY clocks where missing.  Use fixed-factor clocks for those
without gating.

For clarification, prefix clock names with 'ss' or 'hs'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-sys.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index a582446..1c5a998 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -122,6 +122,9 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),			/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	UNIPHIER_CLK_FACTOR("usb30-hsphy0", 16, "upll", 1, 12),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy0", 17, "ref", 1, 1),
+	UNIPHIER_CLK_FACTOR("usb31-ssphy0", 20, "ref", 1, 1),
 	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x2104, 18),
 	UNIPHIER_CLK_GATE("sata1", 29, NULL, 0x2104, 19),
 	UNIPHIER_PRO4_SYS_CLK_AIO(40),
@@ -173,8 +176,11 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
 	/* The document mentions 0x2104 bit 18, but not functional */
-	UNIPHIER_CLK_GATE("usb30-phy", 16, NULL, 0x2104, 19),
-	UNIPHIER_CLK_GATE("usb31-phy", 20, NULL, 0x2104, 20),
+	UNIPHIER_CLK_GATE("usb30-hsphy0", 16, NULL, 0x2104, 19),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy0", 17, "ref", 1, 1),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy1", 18, "ref", 1, 1),
+	UNIPHIER_CLK_GATE("usb31-hsphy0", 20, NULL, 0x2104, 20),
+	UNIPHIER_CLK_FACTOR("usb31-ssphy0", 21, "ref", 1, 1),
 	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x2104, 22),
 	UNIPHIER_PRO5_SYS_CLK_AIO(40),
 	{ /* sentinel */ }
@@ -235,8 +241,10 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	 * We do not use bit 15 here.
 	 */
 	UNIPHIER_CLK_GATE("usb30", 14, NULL, 0x210c, 14),
-	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 12),
-	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 13),
+	UNIPHIER_CLK_GATE("usb30-hsphy0", 16, NULL, 0x210c, 12),
+	UNIPHIER_CLK_GATE("usb30-hsphy1", 17, NULL, 0x210c, 13),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy0", 18, "ref", 1, 1),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy1", 19, "ref", 1, 1),
 	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x210c, 4),
 	UNIPHIER_LD11_SYS_CLK_AIO(40),
 	UNIPHIER_LD11_SYS_CLK_EVEA(41),
@@ -272,11 +280,11 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_GATE("usb30", 12, NULL, 0x210c, 4),	/* =GIO0 */
 	UNIPHIER_CLK_GATE("usb31-0", 13, NULL, 0x210c, 5),	/* =GIO1 */
 	UNIPHIER_CLK_GATE("usb31-1", 14, NULL, 0x210c, 6),	/* =GIO1-1 */
-	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 16),
-	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 18),
-	UNIPHIER_CLK_GATE("usb30-phy2", 18, NULL, 0x210c, 20),
-	UNIPHIER_CLK_GATE("usb31-phy0", 20, NULL, 0x210c, 17),
-	UNIPHIER_CLK_GATE("usb31-phy1", 21, NULL, 0x210c, 19),
+	UNIPHIER_CLK_GATE("usb30-hsphy0", 16, NULL, 0x210c, 16),
+	UNIPHIER_CLK_GATE("usb30-ssphy0", 17, NULL, 0x210c, 18),
+	UNIPHIER_CLK_GATE("usb30-ssphy1", 18, NULL, 0x210c, 20),
+	UNIPHIER_CLK_GATE("usb31-hsphy0", 20, NULL, 0x210c, 17),
+	UNIPHIER_CLK_GATE("usb31-ssphy0", 21, NULL, 0x210c, 19),
 	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x210c, 3),
 	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x210c, 7),
 	UNIPHIER_CLK_GATE("sata1", 29, NULL, 0x210c, 8),
-- 
2.7.4

