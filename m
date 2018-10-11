Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1174EC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34372098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34372098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJKQJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:09:09 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:35262 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJKQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:09:09 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id m8ir1y0033XaVaC018irBc; Thu, 11 Oct 2018 10:42:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAWYV-0000O7-07; Thu, 11 Oct 2018 10:42:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAWYU-0001Bk-UQ; Thu, 11 Oct 2018 10:42:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/3] lib/vsprintf: Hash legacy clock addresses
Date:   Thu, 11 Oct 2018 10:42:48 +0200
Message-Id: <20181011084249.4520-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181011084249.4520-1-geert+renesas@glider.be>
References: <20181011084249.4520-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms using the Common Clock Framework, "%pC" prints the clock's
name. On legacy platforms, it prints the unhashed clock's address,
potentially leaking sensitive information regarding the kernel layout in
memory.

Avoid this leak by printing the hashed address instead.  To distinguish
between clocks, a 32-bit unique identifier is as good as an actual
pointer value.

Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
v2:
  - Add Reviewed-by.
---
 Documentation/core-api/printk-formats.rst | 5 ++---
 lib/vsprintf.c                            | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 25dc591cb1108790..d39798c2558500d5 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -420,9 +420,8 @@ struct clk
 	%pC	pll1
 	%pCn	pll1
 
-For printing struct clk structures. %pC and %pCn print the name
-(Common Clock Framework) or address (legacy clock framework) of the
-structure.
+For printing struct clk structures. %pC and %pCn print the name of the clock
+(Common Clock Framework) or a unique 32-bit ID (legacy clock framework).
 
 Passed by reference.
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b4e4ab274bde2397..3ea2119b85ac2e4f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1563,7 +1563,7 @@ char *clock(char *buf, char *end, struct clk *clk, struct printf_spec spec,
 #ifdef CONFIG_COMMON_CLK
 		return string(buf, end, __clk_get_name(clk), spec);
 #else
-		return special_hex_number(buf, end, (unsigned long)clk, sizeof(unsigned long));
+		return ptr_to_id(buf, end, clk, spec);
 #endif
 	}
 }
-- 
2.17.1

