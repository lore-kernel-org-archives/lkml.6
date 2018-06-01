Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeFAJ3J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:29:09 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:60292 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFAJ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:29:07 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] lib/vsprintf: Remove atomic-unsafe support for printk format %pCr
Date: Fri,  1 Jun 2018 11:28:18 +0200
Message-Id: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

"%pCr" formats the current rate of a clock, and calls clk_get_rate().
The latter obtains a mutex, hence it must not be called from atomic
context.  As vsprintf() (and e.g. printk()) must be callable from any
context, it's better to remove support for this (rarely-used) format.

This patch series:
  - Changes all existing users of "%pCr" to print the result of
    clk_get_rate() directly, which is safe as they all do this in task
    context only,
  - Removes support for the "%pCr" printk format.

Note that any remaining out-of-tree users will start seeing the clock's
name printed instead of its rate.

Thanks for your comments!

Geert Uytterhoeven (4):
  clk: renesas: cpg-mssr: Stop using printk format %pCr
  thermal: bcm2835: Stop using printk format %pCr
  serial: sh-sci: Stop using printk format %pCr
  lib/vsprintf: Remove atomic-unsafe support for %pCr

 Documentation/core-api/printk-formats.rst  | 3 +--
 drivers/clk/renesas/renesas-cpg-mssr.c     | 9 +++++----
 drivers/thermal/broadcom/bcm2835_thermal.c | 4 ++--
 drivers/tty/serial/sh-sci.c                | 4 ++--
 lib/vsprintf.c                             | 3 ---
 5 files changed, 10 insertions(+), 13 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
