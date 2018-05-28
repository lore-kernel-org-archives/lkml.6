Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161098AbeE1Kpe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937187AbeE1Kp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 071/496] ARM: OMAP1: clock: Fix debugfs_create_*() usage
Date: Mon, 28 May 2018 11:57:36 +0200
Message-Id: <20180528100322.775227675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 8cbbf1745dcde7ba7e423dc70619d223de90fd43 ]

When exposing data access through debugfs, the correct
debugfs_create_*() functions must be used, depending on data type.

Remove all casts from data pointers passed to debugfs_create_*()
functions, as such casts prevent the compiler from flagging bugs.

Correct all wrong usage:
  - clk.rate is unsigned long, not u32,
  - clk.flags is u8, not u32, which exposed the successive
    clk.rate_offset and clk.src_offset fields.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap1/clock.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -1011,17 +1011,17 @@ static int clk_debugfs_register_one(stru
 		return -ENOMEM;
 	c->dent = d;
 
-	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, (u8 *)&c->usecount);
+	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, &c->usecount);
 	if (!d) {
 		err = -ENOMEM;
 		goto err_out;
 	}
-	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
+	d = debugfs_create_ulong("rate", S_IRUGO, c->dent, &c->rate);
 	if (!d) {
 		err = -ENOMEM;
 		goto err_out;
 	}
-	d = debugfs_create_x32("flags", S_IRUGO, c->dent, (u32 *)&c->flags);
+	d = debugfs_create_x8("flags", S_IRUGO, c->dent, &c->flags);
 	if (!d) {
 		err = -ENOMEM;
 		goto err_out;
