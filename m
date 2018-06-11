Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 97kwI202HlsLIAAAmS7hNA
	; Mon, 11 Jun 2018 08:44:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC008607A4; Mon, 11 Jun 2018 08:44:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 671D660385;
	Mon, 11 Jun 2018 08:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 671D660385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbeFKIoj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:44:39 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:46548 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754146AbeFKIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:44:32 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id xLkS1x00V3XaVaC01LkSsv; Mon, 11 Jun 2018 10:44:31 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0006xN-FF; Mon, 11 Jun 2018 10:44:26 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0005OE-E8; Mon, 11 Jun 2018 10:44:26 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] m68k: coldfire: Normalize clk API
Date: Mon, 11 Jun 2018 10:44:21 +0200
Message-Id: <1528706663-20670-2-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coldfire still provides its own variant of the clk API rather than using
the generic COMMON_CLK API.  This generally works, but it causes some
link errors with drivers using the clk_round_rate(), clk_set_rate(),
clk_set_parent(), or clk_get_parent() functions when a platform lacks
those interfaces.

This adds empty stub implementations for each of them, and I don't even
try to do something useful here but instead just print a WARN() message
to make it obvious what is going on if they ever end up being called.

The drivers that call these won't be used on these platforms (otherwise
we'd get a link error today), so the added code is harmless bloat and
will warn about accidental use.

Based on commit bd7fefe1f06ca6cc ("ARM: w90x900: normalize clk API").

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/coldfire/clk.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index 849cd208e2ed99e6..7bc666e482ebe82f 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -129,4 +129,33 @@ unsigned long clk_get_rate(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_rate);
 
+/* dummy functions, should not be called */
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	WARN_ON(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	WARN_ON(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	WARN_ON(clk);
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	WARN_ON(clk);
+	return NULL;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
 /***************************************************************************/
-- 
2.7.4
