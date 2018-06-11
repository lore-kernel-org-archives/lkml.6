Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QaLuB0w2HlufHwAAmS7hNA
	; Mon, 11 Jun 2018 08:44:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8EEC3607E7; Mon, 11 Jun 2018 08:44:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 13B3560385;
	Mon, 11 Jun 2018 08:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13B3560385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932643AbeFKIoj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:44:39 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:41504 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754066AbeFKIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:44:32 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id xLkS1x00i3XaVaC01LkSjr; Mon, 11 Jun 2018 10:44:31 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0006xM-F3; Mon, 11 Jun 2018 10:44:26 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fSIR8-0005OA-DS; Mon, 11 Jun 2018 10:44:26 +0200
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
Subject: [PATCH 0/3] Legacy clock drivers: Normalize clk API
Date: Mon, 11 Jun 2018 10:44:20 +0200
Message-Id: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

When seeing commit bde4975310eb1982 ("net: stmmac: fix build failure due
to missing COMMON_CLK dependency"), I wondered why this dependency is
needed, as all implementations of the clock API should implement all
required functionality, or provide dummies.

It turns out there were still two implementations that lacked the
clk_set_rate() function: Coldfire and AR7.

This series contains three patches:
  - The first two patches add dummies for clk_set_rate(),
    clk_set_rate(), clk_set_parent(), and clk_get_parent() to the
    Coldfire and AR7, like Arnd has done for other legacy clock
    implementations a while ago.
  - The second patch removes the COMMON_CLK dependency from the stmmac
    network drivers again, as it is no longer needed.
    Obviously this patch has a hard dependency on the first two patches.

Thanks!

Geert Uytterhoeven (3):
  m68k: coldfire: Normalize clk API
  MIPS: AR7: Normalize clk API
  [RFC] Revert "net: stmmac: fix build failure due to missing COMMON_CLK
    dependency"

 arch/m68k/coldfire/clk.c                    | 29 +++++++++++++++++++++++++++++
 arch/mips/ar7/clock.c                       | 29 +++++++++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 10 +++++-----
 3 files changed, 63 insertions(+), 5 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
