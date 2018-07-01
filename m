Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3140C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B0125238
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B0125238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030341AbeGAQaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:30:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030294AbeGAQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:30:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6ECF0AD8;
        Sun,  1 Jul 2018 16:30:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4.14 023/157] lib/vsprintf: Remove atomic-unsafe support for %pCr
Date:   Sun,  1 Jul 2018 18:21:35 +0200
Message-Id: <20180701160853.418396263@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 666902e42fd8344b923c02dc5b0f37948ff4f225 upstream.

"%pCr" formats the current rate of a clock, and calls clk_get_rate().
The latter obtains a mutex, hence it must not be called from atomic
context.

Remove support for this rarely-used format, as vsprintf() (and e.g.
printk()) must be callable from any context.

Any remaining out-of-tree users will start seeing the clock's name
printed instead of its rate.

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Fixes: 900cca2944254edd ("lib/vsprintf: add %pC{,n,r} format specifiers for clocks")
Link: http://lkml.kernel.org/r/1527845302-12159-5-git-send-email-geert+renesas@glider.be
To: Jia-Ju Bai <baijiaju1990@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Eduardo Valentin <edubezval@gmail.com>
To: Eric Anholt <eric@anholt.net>
To: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable@vger.kernel.org # 4.1+
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/printk-formats.txt |    3 +--
 lib/vsprintf.c                   |    3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -397,11 +397,10 @@ struct clk
 
 	%pC	pll1
 	%pCn	pll1
-	%pCr	1560000000
 
 For printing struct clk structures. ``%pC`` and ``%pCn`` print the name
 (Common Clock Framework) or address (legacy clock framework) of the
-structure; ``%pCr`` prints the current clock rate.
+structure.
 
 Passed by reference.
 
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1392,9 +1392,6 @@ char *clock(char *buf, char *end, struct
 		return string(buf, end, NULL, spec);
 
 	switch (fmt[1]) {
-	case 'r':
-		return number(buf, end, clk_get_rate(clk), spec);
-
 	case 'n':
 	default:
 #ifdef CONFIG_COMMON_CLK


