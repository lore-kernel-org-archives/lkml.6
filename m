Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FBCC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74AB20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74AB20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeK2WJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:09:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:11203 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbeK2WJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:09:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 03:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="93945988"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2018 03:04:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 047A618E; Thu, 29 Nov 2018 13:04:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v5 00/21] lib, rtc: Print rtc_time via %ptR[dt][r]
Date:   Thu, 29 Nov 2018 12:59:37 +0200
Message-Id: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At some point I have noticed too many users of struct rtc_time that
printing its content field by field.

In this series I introduce %ptR[dt][r] specifier to make life a bit
easier.

There are still users of detailed output of the struct rtc_time, but we
can introduce an additional extension for them in the future if needed,
otherwise they might be converted to the proposed output format.

Some of the changes slightly modify the output. In those cases we are on
the safe side since they are pure debug. Nevertheless I tried to leave
numbers to be the same or quite close: in some cases year was printed
+1900, though month was left in the range [0,11] instead of [1,12].

I didn't compile everything there, though I did a basic smoke test on
some x86 hardware. So, I rely on kbuild test robot as well :-)

Most of the users currently are RTC drivers, thus the patch series is
assumed to go via RTC tree.

Cc: Petr Mladek <pmladek@suse.com>

Changelog v5:
- remove leftover from pointer() comment in vsprintf.c
- fix indentation in rtc-proc.c
- fix patch 1 as suggested by Joe and Alexandre
- add Thierry's Ab tag
- update Alexandre's email and Cc to Petr

Changelog v4:
- drop mention of PRINTK_PEXT_TIMEDATE (Joe)
- drop deprecated validation (Alexandre)
- add patch 1 to fix compilation warning (may be applied independently)

Changelog v3:
- no one supported configuration option for new extension, so it's dropped
- amend documentation (Geert)
- optimize flags checking (Geert)
- drop patch against non-existing anymore drivers
  (due to massive architectures removal)
- rebase on top of recent linux-next

Changelog v2:
- split out lib/vsprintf changes to separate series
- build it optionally depending on introduced PRINTK_PEXT_TIMEDATE
- for now support only struct rtc_time
- make an additional letter for different time representations
- make above letter capital to reduce confusion on %ptr vs. %ptR
- drop kdb patch since it's a candidate for time64_t support

Andy Shevchenko (21):
  nvmem: Move nvmem_type_str array to its only user
  lib/vsprintf: Print time and date in human readable format via %pt
  rtc: Switch to use %ptR
  rtc: at91rm9200: Switch to use %ptR
  rtc: at91sam9: Switch to use %ptR
  rtc: m41t80: Switch to use %ptR
  rtc: m48t59: Switch to use %ptR
  rtc: mcp795: Switch to use %ptR
  rtc: pcf50633: Switch to use %ptR
  rtc: pic32: Switch to use %ptR
  rtc: pm8xxx: Switch to use %ptR
  rtc: puv3: Switch to use %ptR
  rtc: rk808: Switch to use %ptR
  rtc: rx6110: Switch to use %ptR
  rtc: rx8025: Switch to use %ptR
  rtc: s3c: Switch to use %ptR
  rtc: s5m: Switch to use %ptR
  rtc: tegra: Switch to use %ptR
  Input: hp_sdc_rtc - Switch to use %ptR
  m68k/mac: Switch to use %ptR
  PM: Switch to use %ptR

 Documentation/core-api/printk-formats.rst |  18 ++++
 arch/m68k/mac/misc.c                      |   8 +-
 drivers/base/power/trace.c                |   4 +-
 drivers/char/rtc.c                        |   7 +-
 drivers/input/misc/hp_sdc_rtc.c           |   8 +-
 drivers/nvmem/core.c                      |   7 ++
 drivers/rtc/hctosys.c                     |   8 +-
 drivers/rtc/interface.c                   |   8 +-
 drivers/rtc/rtc-at91rm9200.c              |  15 +--
 drivers/rtc/rtc-at91sam9.c                |  16 +---
 drivers/rtc/rtc-m41t80.c                  |   6 +-
 drivers/rtc/rtc-m48t59.c                  |   8 +-
 drivers/rtc/rtc-mcp795.c                  |  18 ++--
 drivers/rtc/rtc-pcf50633.c                |   8 +-
 drivers/rtc/rtc-pic32.c                   |  18 +---
 drivers/rtc/rtc-pm8xxx.c                  |  16 +---
 drivers/rtc/rtc-proc.c                    |  36 +------
 drivers/rtc/rtc-puv3.c                    |  18 +---
 drivers/rtc/rtc-rk808.c                   |  20 ++--
 drivers/rtc/rtc-rx6110.c                  |  12 +--
 drivers/rtc/rtc-rx8025.c                  |  19 +---
 drivers/rtc/rtc-s3c.c                     |  20 +---
 drivers/rtc/rtc-s5m.c                     |  27 ++----
 drivers/rtc/rtc-sysfs.c                   |  16 ++--
 drivers/rtc/rtc-tegra.c                   |  30 +-----
 include/linux/nvmem-provider.h            |   7 --
 lib/test_printf.c                         |   6 ++
 lib/vsprintf.c                            | 111 ++++++++++++++++++++++
 28 files changed, 224 insertions(+), 271 deletions(-)

--
2.19.2

