Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7F7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BC52082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BC52082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbeKNDQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:16:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:10689 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbeKNDQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:16:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:17:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="104048217"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Nov 2018 09:17:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B09ED103; Tue, 13 Nov 2018 19:17:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 00/20] lib, rtc: Print rtc_time via %ptR[dt][rv]
Date:   Tue, 13 Nov 2018 19:17:09 +0200
Message-Id: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At some point I have noticed too many users of struct rtc_time that
printing its content field by field.

In this series I introduce %ptR[dt][rv] specifier to make life a bit
easier.

There are still users of detailed output of the struct rtc_time, but we
can introduce an additional extension for them in the future if needed,
otherwise they might be converted to the proposed output format.

Some of the changes slightly modify the output. In those cases we are on
the safe side since they are pure debug. Nevertheless I tried to leave
numbers to be the same or quite close: in some cases year is printed +
1900, though month is left in the range [0,11] instead of [1,12].

I didn't compile everything there, though I did a basic smoke test on
some x86 hardware. So, I rely on kbuild test robot as well :-)

Most of the users currently are RTC drivers, thus the patch series is
assumed to go via RTC tree.

The patch series depends on earlier send clean up of lib/vsprintf [1].

[1]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1612716.html

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

Andy Shevchenko (20):
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
  mk68/mac: Switch to use %ptR
  PM: Switch to use %ptR

 Documentation/core-api/printk-formats.rst |  20 ++++
 arch/m68k/mac/misc.c                      |   8 +-
 drivers/base/power/trace.c                |   4 +-
 drivers/char/rtc.c                        |   7 +-
 drivers/input/misc/hp_sdc_rtc.c           |   8 +-
 drivers/rtc/hctosys.c                     |   8 +-
 drivers/rtc/interface.c                   |   8 +-
 drivers/rtc/rtc-at91rm9200.c              |  15 +--
 drivers/rtc/rtc-at91sam9.c                |  16 +--
 drivers/rtc/rtc-m41t80.c                  |   6 +-
 drivers/rtc/rtc-m48t59.c                  |   8 +-
 drivers/rtc/rtc-mcp795.c                  |  18 +--
 drivers/rtc/rtc-pcf50633.c                |   8 +-
 drivers/rtc/rtc-pic32.c                   |  18 +--
 drivers/rtc/rtc-pm8xxx.c                  |  16 +--
 drivers/rtc/rtc-proc.c                    |  36 +-----
 drivers/rtc/rtc-puv3.c                    |  18 +--
 drivers/rtc/rtc-rk808.c                   |  20 +---
 drivers/rtc/rtc-rx6110.c                  |  12 +-
 drivers/rtc/rtc-rx8025.c                  |  19 +--
 drivers/rtc/rtc-s3c.c                     |  20 +---
 drivers/rtc/rtc-s5m.c                     |  27 +----
 drivers/rtc/rtc-sysfs.c                   |  16 +--
 drivers/rtc/rtc-tegra.c                   |  30 +----
 lib/test_printf.c                         |   6 +
 lib/vsprintf.c                            | 140 ++++++++++++++++++++++
 26 files changed, 248 insertions(+), 264 deletions(-)

-- 
2.19.1

